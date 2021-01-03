package com.dealight.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.HtdlVO;
import com.dealight.domain.KakaoPayApprovalVO;
import com.dealight.domain.PymtVO;
import com.dealight.domain.RsvdAvailVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdMenuDTO;
import com.dealight.domain.RsvdMenuDTOList;
import com.dealight.domain.RsvdRequestDTO;
import com.dealight.domain.RsvdRequestInfoDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.service.HtdlService;
import com.dealight.service.KakaoService;
import com.dealight.service.PymtService;
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
	private final PymtService pymtService;
	private final HtdlService htdlService;
	private final StoreService service;
	
		

	
	@RequestMapping(value ="/htdlcheck/{userId}/{htdlId}", method = RequestMethod.GET,
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody ResponseEntity<Boolean>htdlCheck(@PathVariable String userId, @PathVariable Long htdlId){
		
		log.info("========userId  : " + userId );
		log.info("========htdlId  : " + htdlId );
		boolean checked = rsvdService.checkExistHtdl(userId, htdlId);
		log.info("hotdeal rsvd checked : " + checked);

		return new ResponseEntity<Boolean>(!checked, HttpStatus.OK);
	}
	
	@GetMapping(value = "/rsvdavailcheck/{storeId}/{time}/{pnum}")
	public @ResponseBody ResponseEntity<Boolean> rsvdAvailCheck(
			@PathVariable Long storeId ,@PathVariable String time, @PathVariable Integer pnum){
		
		//해당 매장의 예약가능 여부
		RsvdAvailVO rsvdAvailVO = rsvdService.getRsvdAvailByStoreId(storeId);
		log.info("=======================================rsvdvailcheck");
		boolean checked = rsvdService.isRsvdAvailChecked(rsvdAvailVO, time, pnum);
//		return new ResponseEntity<Boolean>(body, status);
		return new ResponseEntity<Boolean>(checked, HttpStatus.OK);
	}
	
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
		StoreVO store = service.findByStoreIdWithBStore(requestInfo.getStoreId());
		log.info("store..........vo : " + store.getStoreNm()+ " store.....rep img : " + store.getBstore().getRepImg());
	    model.addAttribute("userId", auth.getName());
	    model.addAttribute("htdlId", requestInfo.getHtdlId());
	    model.addAttribute("store", store);
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
    	log.info("=========================requestDto : "  + requestDto);
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

			if(isRsvdMenuCheck(lists.get(i))) {
				//메뉴 수량 파라미터...
				RsvdDtlsVO dtlsVO = RsvdDtlsVO.builder()
						.menuNm(lists.get(i).getName())
						.menuPrc(lists.get(i).getPrice())
						.menuTotQty(requestDto.getMenu().get(i).getQty()).build();
				dtlsList.add(dtlsVO);
			}
		}
    	
    	rsvdService.register(vo, dtlsList);
    	Long rsvdId = rsvdService.getRsvdId();
    	
        log.info("kakao pay.....");
        return "redirect:" + kakaoService.kakaoPayReady(rsvdId, vo.getUserId(), lists, requestDto);
    }
    

    @GetMapping("/kakaoPaySuccess")
    public void kakaoPaySuccess(RsvdRequestDTO requestDto, Long rsvdId,  String pg_token, Model model){
        log.info("paySuccess......");
        log.info("kakaoPay pg_token: "+ pg_token);
        
        //카카오 페이 승인 vo
        KakaoPayApprovalVO kakaoPayApprovalVO =  kakaoService.kakaoPayInfo(requestDto.getUserId(), pg_token);
        if("MONEY".equals(kakaoPayApprovalVO.getPayment_method_type())) {
        	kakaoPayApprovalVO.setPayment_method_type("카카오 페이");
        }
        //카카오 결제 성공시 예약 상태 업데이트
        //String userId = auth.getName();
        rsvdService.complete(rsvdId);
        
        //예약 가능 여부 차감
        rsvdService.completeUpdateAvail(requestDto.getStoreId(), requestDto.getTime(), requestDto.getPnum());
        
        //핫딜이 존재하는 경우
        //핫딜 현재인원 + 1
        /*요청 request를 통해 진행되야됨*/
        //RsvdVO vo = rsvdService.readRsvdVO(rsvdId);
        //
        log.info("===============pay success: htdlId: " + requestDto.getHtdlId());
        if(requestDto.getHtdlId() != null) {
        	//핫딜 vo를 가져온다
        	HtdlVO hotdeal = htdlService.readHtdl(requestDto.getHtdlId());
        	log.info("=========hotdeal : "+ hotdeal);
        	//현재인원 증가(한 계정당 1개 구매)
        	int curPnum = hotdeal.getCurPnum() + 1;
        	hotdeal.setCurPnum(curPnum);
        	htdlService.curPnumModify(hotdeal);
        	//핫딜 구매 체크는 매장 상세에서 ajax..
        	
        	
        }
                
        //결제 상태 업데이트 (상태, 결제수단, 결제 승인번호, 결제 승인 시간)
        PymtVO successVO = pymtService.getByRsvdId(rsvdId);
        successVO.setStusCd("C");
        successVO.setMtd(kakaoPayApprovalVO.getPayment_method_type());
        successVO.setAprvNo(kakaoPayApprovalVO.getTid());
        successVO.setApprovedAt(kakaoPayApprovalVO.getApproved_at());
        
        pymtService.modify(successVO);
        
        /* web socket 추가*/
        log.info("web socket rsvd handle");
    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
    	Map<String, WebSocketSession> map = handler.getUserSessions();
    	log.info("socket map................ : " + map);
    	log.info("request dto : "+requestDto);
    	
    	WebSocketSession ws = map.get(service.getBStore(requestDto.getStoreId()).getBuserId());
    	// 'aaaa' -> 'aaaa' 
    	log.info("socket user id ................ : " + requestDto.getUserId());
    	log.info("socket ws................ : " + ws);
    	if(ws != null) {
    		log.info("sucess web socket...........");
    		TextMessage message = new TextMessage("{\"sendUser\":\""+requestDto.getUserId()+"\",\"rsvdId\":\""+rsvdId+"\",\"cmd\":\"rsvd\",\"storeId\":\""+requestDto.getStoreId()+"\"}");
    		try {
				handler.handleMessage(ws, message);
			} catch (Exception e) {
				
				log.warn("web socket error...............");
				e.printStackTrace();
			}
    	}
        
        /* */
        model.addAttribute("kakaoPayInfo", kakaoPayApprovalVO);
        model.addAttribute("rsvdId", rsvdId);
        model.addAttribute("userId", requestDto.getUserId());
        model.addAttribute("storeId", requestDto.getStoreId());
    }
    
    @GetMapping("/kakaoPayCancel")
    public void kakaoPayCancel(Long rsvdId, Long storeId, Model model) {
    	log.info("payCancel...");
    	
    	PymtVO cancelVO = pymtService.getByRsvdId(rsvdId);
    	log.info("=========cancel pymtVO: " + cancelVO);
    	cancelVO.setStusCd("W");
    	//결제 취소 상태 업데이트
    	pymtService.stusCdModify(cancelVO);
    	model.addAttribute("storeId", storeId);
//    	Long rsvdId = rsvdService.getRsvdId();
//    	rsvdService.cancel(rsvdId);
    }
    
    @GetMapping("/kakaoPaySuccessFail")
    public void kakaoPaySuccessFail(Long rsvdId) {
    	log.info("pay Success Fail...");
    	PymtVO failVO = pymtService.getByRsvdId(rsvdId);
    	failVO.setStusCd("F");
    	
    	//결제 실패 상태 업데이트
    	pymtService.stusCdModify(failVO);
    	
    }
    
    private boolean isRsvdMenuCheck(RsvdMenuDTO rsvdDto) {
    	return rsvdDto.getName() != null && rsvdDto.getPrice() != null;
    }
}
