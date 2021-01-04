package com.dealight.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.dealight.domain.KakaoPayApprovalVO;
import com.dealight.domain.KakaoPayReadyVO;
import com.dealight.domain.PymtVO;
import com.dealight.domain.RsvdMenuDTO;
import com.dealight.domain.RsvdRequestDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

//jongwoo

@Service
@RequiredArgsConstructor
@Log4j
public class KakaoService {

	
	public static final String HOST = "https://kapi.kakao.com";
	public static final String ADMINKEY = "41b5e82a25d9b62cb31484ccfab285b5";
	public static final String URL = "http://localhost:8181";
	//public static final String URL = "http://3.34.175.123:8181";
	private final RsvdService rsvdService;
	private final PymtService pymtService;
	private KakaoPayReadyVO kakaoPayReadyVO; //결제 준비 
	private KakaoPayApprovalVO kakaoPayApprovalVO; //결제 승인
	
	private Long rsvdId;
	private int totAmt;
	
	//결제 준비
	public String kakaoPayReady(Long rsvdId, String userId, List<RsvdMenuDTO> lists, RsvdRequestDTO requestDto) {
		
		this.rsvdId = rsvdId;
		this.totAmt = requestDto.getTotAmt();
		
		RestTemplate restTemplate = new RestTemplate();
		
		String menu = lists.stream().map(dto -> dto.getName()).collect(Collectors.joining(", "));
		
		log.info("====================test menu:" + menu);
		
		//요청 헤더
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Authorization", "KakaoAK "+ ADMINKEY);
        headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+";charset=UTF-8");
        

        UriComponentsBuilder builder = UriComponentsBuilder.fromPath(URL+"/dealight/reservation/kakaoPaySuccess")
												        .queryParam("userId", userId)
												        .queryParam("rsvdId", rsvdId)
												        .queryParam("storeId", requestDto.getStoreId())
												        .queryParam("htdlId", requestDto.getHtdlId())
												        .queryParam("time", requestDto.getTime())
												        .queryParam("pnum", requestDto.getPnum());
        
        //요청 바디
        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("cid","TC0ONETIME");

        params.add("partner_order_id", String.valueOf(rsvdId));
        params.add("partner_user_id", userId);
        params.add("item_name", menu);
        params.add("quantity", String.valueOf(requestDto.getTotQty()));
        params.add("total_amount", String.valueOf(totAmt));
        params.add("tax_free_amount","0");
        params.add("approval_url", builder.toUriString());
        params.add("cancel_url",URL+"/dealight/reservation/kakaoPayCancel?rsvdId="+rsvdId+"&storeId="+requestDto.getStoreId());
        params.add("fail_url",URL+"/dealight/reservation/kakaoPaySuccessFail");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
        
        try {
        	//결제 준비 
        	kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST+"/v1/payment/ready"), body, KakaoPayReadyVO.class);
        	
        	//시간 포맷
        	Date created_at = setDateFormat(kakaoPayReadyVO.getCreated_at());
        	kakaoPayReadyVO.setCreated_at(created_at);
        	
        	log.info("kakaoPay ready...."+ kakaoPayReadyVO);
        	//log.info("kakaoPay ready...===== getNext_redirect_pc_url: " + kakaoPayReadyVO.getNext_redirect_pc_url());
        	
        	log.info("============================created_at: " + kakaoPayReadyVO.getCreated_at());
        	//결제 테이블 등록
        	PymtVO pymtVO = createPymtEntity(requestDto, rsvdId, created_at);
        	log.info("=============================PymtVO: "+ pymtVO);
        	pymtService.register(pymtVO);
        	
        	return kakaoPayReadyVO.getNext_redirect_pc_url();
        }catch (RestClientException e){
            e.printStackTrace();
        } catch(URISyntaxException e) {
            e.printStackTrace();
        }
		return "/dealight/dealight";
	}
	
	
	//결제 승인
	public KakaoPayApprovalVO kakaoPayInfo(String userId, String pg_token){
        log.info("==========kakaoPay info======");
        
        RestTemplate restTemplate = new RestTemplate();
        
        //TODO: 요청 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK "+ ADMINKEY);
        headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+";charset=UTF-8");

        //TODO: 요청 바디
        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("cid","TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id",String.valueOf(this.rsvdId));
        params.add("partner_user_id", userId);
        params.add("pg_token", pg_token);
        params.add("total_amount", String.valueOf(this.totAmt));

        HttpEntity<MultiValueMap<String,String>> body = new HttpEntity<>(params, headers);

        try{
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST+"/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            Date created_at = setDateFormat(kakaoPayApprovalVO.getCreated_at());
            Date approved_at = setDateFormat(kakaoPayApprovalVO.getApproved_at());
            
            kakaoPayApprovalVO.setCreated_at(created_at);
            kakaoPayApprovalVO.setApproved_at(approved_at);
            
            //예약 테이블 결제 승인번호 등록
            rsvdService.registerTid(kakaoPayApprovalVO.getTid(), rsvdId);
            
//            log.info("approval create Date : " + new Date(cal.getTimeInMillis()));
//            kakaoPayApprovalVO.setCreated_at(new Date(cal.getTimeInMillis()));
            

            log.info("kakaoPayApprovalVO: "+ kakaoPayApprovalVO);
            this.rsvdId = 0l;
            this.totAmt = 0;
            return kakaoPayApprovalVO;
        }catch(RestClientException e){
            e.printStackTrace();
        } catch(URISyntaxException e) {
            e.printStackTrace();
        }

        return null;

    }
	
	//결제 vo 생성
	private PymtVO createPymtEntity(RsvdRequestDTO requestDto, Long rsvdId, Date createdAt) {
		
		return PymtVO.builder()
					.rsvdId(rsvdId)
					.userId(requestDto.getUserId())
					.tamt(requestDto.getTotAmt())
					.stusCd("R")
					.regDate(createdAt)
					.build();
	}
	
	//한국시간에 맞추기
	private Date setDateFormat(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
        cal.add(Calendar.HOUR_OF_DAY, -9);
        return new Date(cal.getTimeInMillis());
	}
	
}
