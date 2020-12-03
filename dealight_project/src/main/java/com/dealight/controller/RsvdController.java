package com.dealight.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdMenuDTO;
import com.dealight.domain.RsvdRequestDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.service.KakaoService;
import com.dealight.service.RsvdService;

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
	
	@GetMapping("/rsvdForm")
	public void getReservation(Long storeId, Model model) {
		
		log.info("rsvdForm menu...");
		log.info("======" + rsvdService.getMenuList(storeId));
		
		model.addAttribute("storeId", storeId);
		model.addAttribute("menus", rsvdService.getMenuList(storeId));
		
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
    	vo.setUserId("whddn528");
    	vo.setStusCd("P");
    	vo.setRevwStus(0L);
    	
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
        return "redirect:" + kakaoService.kakaoPayReady(rsvdId, lists, requestDto.getTotAmt(), requestDto.getTotQty());
    }

    @GetMapping("/kakaoPaySuccess")
    public void kakaoPaySuccess(String pg_token, Model model){
        log.info("paySuccess......");
        log.info("kakaoPay pg_token: "+ pg_token);
        
        model.addAttribute("info", kakaoService.kakaoPayInfo(pg_token));
    }
    
    @GetMapping("/kakaoPayCancel")
    public void kakaoPayCancel() {
    	log.info("payCancel...");
//    	Long rsvdId = rsvdService.getRsvdId();
//    	rsvdService.cancel(rsvdId);
    }
}
