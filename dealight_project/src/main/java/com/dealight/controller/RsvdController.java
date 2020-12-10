package com.dealight.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdMenuDTO;
import com.dealight.domain.RsvdMenuDTOList;
import com.dealight.domain.RsvdRequestDTO;
import com.dealight.domain.RsvdRequestInfoDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.service.KakaoService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

//jongwoo

@Controller
@Log4j
@RequestMapping("/dealight/reservation/*")
@RequiredArgsConstructor
public class RsvdController {

	private final KakaoService kakaoService;
	private final RsvdService rsvdService;
	private final StoreService service;
	
	@GetMapping("/rsvdForm")
	public void getReservation(Long storeId, Model model) {
		
		log.info("rsvdForm menu...");
		log.info("======" + rsvdService.getMenuList(storeId));
		
		model.addAttribute("storeId", storeId);
		model.addAttribute("menus", rsvdService.getMenuList(storeId));
		
	}
	
	@GetMapping("/")
	public void reservation(Authentication auth, Model model, @Valid RsvdMenuDTOList rsvdMenuList, @Valid RsvdRequestInfoDTO requestInfo) {
		//로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
//	    UserVO user = (UserVO)session.getAttribute("user");
//	    if(user == null) {
//	    	model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
//	    	model.addAttribute("storeId",storeId);
//	    	
//	    }else {
//		model.addAttribute("store", service.bstore(storeId));
//		model.addAttribute("rsvdMenuList", rsvdMenuList); 
//		model.addAttribute("pnum", pnum); 
//		model.addAttribute("time", time);
//		log.info(rsvdMenuList);
//		}
		
		
		
	    model.addAttribute("userId", auth.getName());
	    model.addAttribute("store", service.bstore(requestInfo.getStoreId()));
		model.addAttribute("rsvdMenuList", rsvdMenuList); 
		model.addAttribute("pnum", requestInfo.getPnum()); 
		model.addAttribute("time", requestInfo.getTime());
		
		log.info(rsvdMenuList);
		log.info(requestInfo);
	
	    //return "/dealight/reservation";
	    
	}
	
	
	//카카오 페이 테스트
	@GetMapping("/kakaoPay")
    public void getkakaoPay(@Valid RsvdRequestDTO requestDto, BindingResult bindingResult, Model model){

    	if(bindingResult.hasErrors()) {
			//유효성 검사
			List<ObjectError> errorList = bindingResult.getAllErrors();
	        for (ObjectError error : errorList)
	            log.info("=====error: " + error.getDefaultMessage());
		}
		log.info("============requestDTO : "+ requestDto);
		
		model.addAttribute("requestDto", requestDto);
    }
	
    @PostMapping("/kakaoPay")
    public String kakaoPay(@Valid RsvdRequestDTO requestDto, BindingResult bindingResult){
    	
    	log.info("====================kakao rsvdForm: " + requestDto);
    	if(bindingResult.hasErrors()) {
			//유효성 검사
			List<ObjectError> errorList = bindingResult.getAllErrors();
	        for (ObjectError error : errorList)
	            log.info("=====error: " + error.getDefaultMessage());
	        
		}
    	
    	//결제 요청 시 예약 등록
    	RsvdVO vo = requestDto.toEntity();
    	
		//예약 상세vo list
		List<RsvdDtlsVO> dtlsList = new ArrayList<>();
    	
//		String[] menu = requestDto.getMenu();
//		int[] qty = requestDto.getQty();
		
		List<RsvdMenuDTO> lists = requestDto.getMenu();
		log.info("=============lists : "+ lists);
		//요청 리스트 생성
		for(int i=0; i< lists.size(); i++) {
			//log.info("======================menu: "+ Arrays.toString(menu));
//			MenuDTO menuDto = rsvdService.findPriceByName(vo.getStoreId(), menu[i].trim());
			
			//log.info("======================menuDto: "+ menuDto);

			if(lists.get(i).getName() != null && lists.get(i).getPrice() != null) {
				
				//메뉴 수량 파라미터...
				RsvdDtlsVO dtlsVO = RsvdDtlsVO.builder()
						.menuNm(lists.get(i).getName())
						.menuPrc(lists.get(i).getPrice())
						.menuTotQty(requestDto.getTotQty()).build();
				dtlsList.add(dtlsVO);
			}
		}
    	
    	rsvdService.register(vo, dtlsList);
    	Long rsvdId = rsvdService.getRsvdId();

        log.info("kakao pay.....");
        return "redirect:" + kakaoService.kakaoPayReady(rsvdId, vo.getUserId(), lists, requestDto.getTotAmt(), requestDto.getTotQty());
    }

    @GetMapping("/kakaoPaySuccess")
    public void kakaoPaySuccess(String userId, Long rsvdId, String pg_token, Model model){
        log.info("paySuccess......");
        log.info("kakaoPay pg_token: "+ pg_token);
        
        
        //카카오 결제 성공시 예약 상태 업데이트
        //String userId = auth.getName();
        
        rsvdService.complete(rsvdId);
        
        //핫딜이 존재하는 경우
        //핫딜 마감인원 - 이용인원
        
        //예약 가능 여부 차감
        
        model.addAttribute("info", kakaoService.kakaoPayInfo(userId, pg_token));
    }
    
    @GetMapping("/kakaoPayCancel")
    public void kakaoPayCancel() {
    	log.info("payCancel...");
//    	Long rsvdId = rsvdService.getRsvdId();
//    	rsvdService.cancel(rsvdId);
    }
}
