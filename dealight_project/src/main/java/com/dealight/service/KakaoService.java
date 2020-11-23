package com.dealight.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.dealight.domain.KakaoPayApprovalVO;
import com.dealight.domain.KakaoPayReadyVO;
import com.dealight.domain.RsvdMenuDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

//jongwoo

@Service
@RequiredArgsConstructor
@Log4j
public class KakaoService {

	
	public static final String HOST = "https://kapi.kakao.com";
	public static final String ADMINKEY = "41b5e82a25d9b62cb31484ccfab285b5";
	
	private KakaoPayReadyVO kakaoPayReadyVO; //결제 준비 
	private KakaoPayApprovalVO kakaoPayApprovalVO; //결제 승인
	
	Long rsvdId = 0l;
	int totAmt = 0;
	
	//결제 준비
	public String kakaoPayReady(Long rsvdId, List<RsvdMenuDTO> lists, int totAmt, int totQty ) {
		this.rsvdId = rsvdId;
		this.totAmt = totAmt;
		RestTemplate restTemplate = new RestTemplate();
		
		String menu = lists.stream().map(dto -> dto.getName()).collect(Collectors.joining(", "));
		String qty = lists.stream().map(dto -> dto.getQty().toString()).collect(Collectors.joining(", "));
		
		log.info("====================test menu:" + menu);
		log.info("====================test menu:" + qty);
		
		
		//요청 헤더
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Authorization", "KakaoAK "+ ADMINKEY);
        headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+";charset=UTF-8");
        
        //요청 바디
        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("cid","TC0ONETIME");

        params.add("partner_order_id", String.valueOf(rsvdId));
        params.add("partner_user_id","whddn528");
        params.add("item_name",menu);
        params.add("quantity", String.valueOf(totQty));
        params.add("total_amount", String.valueOf(totAmt));
        params.add("tax_free_amount","0");
        params.add("approval_url","http://localhost:8181/dealight/reservation/kakaoPaySuccess");
        params.add("cancel_url","http://localhost:8181/dealight/reservation/kakaoPayCancel");
        params.add("fail_url","http://localhost:8181/dealight/reservation/kakaoPaySuccessFail");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<>(params, headers);
        
        try {
        	
        	kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST+"/v1/payment/ready"), body, KakaoPayReadyVO.class);
        	
        	log.info("kakaoPay ready...."+ kakaoPayReadyVO);
        	//log.info("kakaoPay ready...===== getNext_redirect_pc_url: " + kakaoPayReadyVO.getNext_redirect_pc_url());
        	
        	return kakaoPayReadyVO.getNext_redirect_pc_url();
        }catch (RestClientException e){
            e.printStackTrace();
        } catch(URISyntaxException e) {
            e.printStackTrace();
        }
		return "/";
	}
	
	
	//결제 승인
	public KakaoPayApprovalVO kakaoPayInfo(String pg_token){
        log.info("==========kakaoPay info======");

        RestTemplate restTemplate = new RestTemplate();
        //todo: 요청 헤더
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK "+ ADMINKEY);
        headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+";charset=UTF-8");

        //todo: 요청 바디
        MultiValueMap<String,String> params = new LinkedMultiValueMap<>();
        params.add("cid","TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id",String.valueOf(this.rsvdId));
        params.add("partner_user_id","whddn528");
        params.add("pg_token", pg_token);
        params.add("total_amount", String.valueOf(this.totAmt));

        HttpEntity<MultiValueMap<String,String>> body = new HttpEntity<>(params, headers);

        try{
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST+"/v1/payment/approve"), body, KakaoPayApprovalVO.class);

            log.info("kakaoPayApprovalVO: "+ kakaoPayApprovalVO);
            return kakaoPayApprovalVO;
        }catch(RestClientException e){
            e.printStackTrace();
        } catch(URISyntaxException e) {
            e.printStackTrace();
        }

        return null;

    }
	
}
