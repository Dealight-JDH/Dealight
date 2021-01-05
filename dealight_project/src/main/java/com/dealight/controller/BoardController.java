package com.dealight.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlMenuDTO;
import com.dealight.domain.HtdlRequestDTO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.RsvdRsltDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.WaitVO;
import com.dealight.service.HtdlService;
import com.dealight.service.HtdlTimeCheckService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
/*
 * 
 *****[김동인] 
 * ***

 * 
 */
@RestController
@Log4j
@RequestMapping("/dealight/business/manage/*")
@AllArgsConstructor
public class BoardController {

	private StoreService storeService;

	private RsvdService rsvdService;

	private HtdlService htdlService;

	private WaitService waitService;

	private UserService userService;
	
	private HtdlTimeCheckService htdlChckService;
	

	// storeId로 store with bstore 객체를 가져온다.
	@GetMapping(value = "/board/store/{storeId}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})	
	public ResponseEntity<StoreVO> getStore(@PathVariable("storeId") long storeId) {

		log.info("get store...........");
		
		if(storeId < 0)
			return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);

		return new ResponseEntity<>(storeService.findByStoreIdWithBStore(storeId), HttpStatus.OK);
	}

	// storeId로 해당 매장의 웨이팅 리스트를 가져온다.
	@GetMapping(value = "/board/waiting/{storeId}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})	
	public ResponseEntity<List<WaitVO>> getWaitList(@PathVariable("storeId") long storeId) {

		// 현재 웨이팅 상태인 '매장'의 '웨이팅 리스트'를 가져온다.
		List<WaitVO> waitList = waitService.curStoreWaitList(storeId, "W");
		
		log.info("get wait list........... : " + waitList);

		return new ResponseEntity<>(waitList, HttpStatus.OK);
	}

	// storeId로 해당 매장의 오늘 '예약중인' 예약 리스트를 가져온다.
	@GetMapping(value = "/board/reservation/{storeId}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<List<RsvdVO>> getRsvdList(@PathVariable("storeId") long storeId) {

		log.info("get rsvd list...........");
		
		// '현재 매장'의 오늘 '예약'중인 '예약 리스트'를 가져온다. 
		List<RsvdVO> rsvdList = rsvdService.readTodayCurRsvdList(storeId);

		return new ResponseEntity<>(rsvdList, HttpStatus.OK);
	}

	// storeId로 해당 매장의 '오늘' 예약 맵(시간대별)을 가져온다..
	@GetMapping(value = "/board/reservation/map/{storeId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<HashMap<String, List<Long>>> getTodayRsvdMap(@PathVariable("storeId") long storeId) {

		List<RsvdVO> list = rsvdService.readTodayCurAndLastRsvdList(storeId);
		
		log.info("get today cur rsvd list.............................." + list);
		
		HashMap<String, List<Long>> map = rsvdService.getRsvdByTimeMap(list);

		log.info("get today rsvd map...................................." + map);

		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@GetMapping(value = "/board/reservation/stusmap/{storeId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<HashMap<String,String>> getTodayRsvdStus(@PathVariable("storeId") Long storeId) {
		
		HashMap<String,String> map = rsvdService.getTodayRsvdStusByTime(storeId);
		
		return new ResponseEntity<>(map,HttpStatus.OK);
	}

	// storeId로 바로 다음 예약 리스트를 가져온다.
	@GetMapping(value = "/board/reservation/next/{storeId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<RsvdVO> getNextRsvd(@PathVariable("storeId") long storeId) {

		log.info("get next rsvd..........");

		List<RsvdVO> list = rsvdService.readTodayCurRsvdList(storeId);

		HashMap<String, List<Long>> map = rsvdService.getRsvdByTimeMap(list);

		return new ResponseEntity<>(rsvdService.read(rsvdService.readNextRsvdId(map)), HttpStatus.OK);
	}


	// waitId로 웨이팅 상태를 '취소'로 변경한다.
	@PutMapping(value = "/board/waiting/cancel/{waitId}", 
			consumes = "application/json",
			produces = {
					MediaType.TEXT_PLAIN_VALUE
	})
	public ResponseEntity<String> putCancelWaiting(@PathVariable("waitId") long waitId) {

		log.info("put cancel waiting...........");

		return waitService.cancelWaiting(waitId)
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// waitId로 웨이팅 상태를 '패널티'로 변경한다.
	@PutMapping(value = "/board/waiting/noshow/{waitId}", 
			consumes = "application/json",
			produces = {
					MediaType.TEXT_PLAIN_VALUE
	})
	public ResponseEntity<String> putNoshowWaiting(@PathVariable("waitId") long waitId) {

		log.info("put noshow waiting...........");

		return waitService.panaltyWaiting(waitId)
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// waitId로 웨이팅 상태를 '입장'으로 변경한다.
	@PutMapping(value = "/board/waiting/enter/{waitId}", 
			consumes = "application/json",
			produces = {
					MediaType.TEXT_PLAIN_VALUE
	})
	public ResponseEntity<String> putEnterWaiting(@PathVariable("waitId") long waitId) {

		log.info("put enter waiting...........");

		return waitService.enterWaiting(waitId)
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// waitId로 오프라인 웨이팅을 등록한다.
	@PostMapping(value="/board/waiting/new",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> registerOffWait(@Valid @RequestBody WaitVO wait) {

		log.info("register wait.............");

		log.info("WaitingVO ............" + wait);
		
		SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		
		wait.setWaitRegTm(formater.format(new Date()));
		
		Long waitNo = waitService.registerOffWaiting(wait);

		log.info("wait no................" + waitNo);

		return waitNo > 0
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	// storeId와 seatStusColor로 해당 매장의 seat stus를 변경한다.
	@PutMapping(value = "/board/seat/{storeId}/{seatStusColor}", 
	consumes = "application/json",
	produces = {
			MediaType.TEXT_PLAIN_VALUE
	})
	public ResponseEntity<String> changeSeatStus(@PathVariable("storeId") Long storeId,@PathVariable("seatStusColor")String seatStusColor) {
		
		return storeService.changeSeatStus(storeId, seatStusColor)
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
	
	// storeId로 해당 매장의 예약 결과 DTO를 반환한다.
	// 예약 결과 DTO는 금일 예약 인원, 금일 예약 수, 금일 인기 메뉴를 반환한다.
	@GetMapping(value = "/board/reservation/rslt/{storeId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<RsvdRsltDTO> getRsvdRslt(@PathVariable("storeId") Long storeId) {
		
		List<RsvdVO> rsvdList = rsvdService.readTodayCurRsvdList(storeId);
		
		int totTodayRsvd = rsvdService.totalTodayRsvd(rsvdList);
		int totTodayRsvdPnum = rsvdService.totalTodayRsvdPnum(rsvdList);
		HashMap<String,Integer> todayFavMenuMap = rsvdService.todayFavMenu(storeId);
		
		RsvdRsltDTO dto = new RsvdRsltDTO().builder()
				.totalTodayRsvd(totTodayRsvd)
				.totalTodayRsvdPnum(totTodayRsvdPnum)
				.todayFavMenuMap(todayFavMenuMap)
				.build();
		
		log.info("rsvd rslt dto..............................................."+dto);
				
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	// 예약 시간의 데이터 형식을 맞춘다.
	@GetMapping(value="board/reservation/rslt/{storeId}/list", produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<RsvdVO>> getLastWeekRsvd(@PathVariable("storeId") long storeId){
		
		// 지난 7일의 예약 리스트를 가져온다.
		List<RsvdVO> rsvdList = rsvdService.findLastWeekRsvd(storeId);
		
		String pattern = "yyyy/MM/dd";
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		
		// 예약 등록 날짜의 포맷을 설정해준다.
		rsvdList.stream().forEach((rsvd) -> {
			rsvd.setStrRegDate(simpleDateFormat.format(rsvd.getRegdate()));
		});
		
		log.info("last week rsvd list............" + rsvdList);
		
		return new ResponseEntity<>(rsvdList,HttpStatus.OK);
		
	}
	
	// 지난 7일 웨이팅 리스트를 가져온다. 
	@GetMapping(value="board/waiting/rslt/{storeId}/list", produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<WaitVO>> getLastWeekWait(@PathVariable("storeId") Long storeId){
		
		// 지난 7일의 예약 리스트를 가져온다.
		List<WaitVO> waitList = waitService.findLastWeekRsvdListByStoreId(storeId);
		
		// 예약 등록 날짜의 포맷을 설정해준다.
		waitList.stream().forEach((wait) -> {
			wait.setStrWaitRegTm(wait.getWaitRegTm().substring(0,10));
		});
		
		log.info("last week rsvd list............" + waitList);
		
		return new ResponseEntity<>(waitList,HttpStatus.OK);
	}
	
	// rsvdId로 예약 객체와 예약 상세 객체를 가져온다.
	@GetMapping(value = "/board/reservation/dtls/{rsvdId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<RsvdVO> getRsvdDtls(@PathVariable("rsvdId") Long rsvdId) {
		
		log.info("get rsvd dtls..................");
		
		return new ResponseEntity<>(rsvdService.findRsvdByRsvdIdWithDtls(rsvdId), HttpStatus.OK);
	}
	
	// 해당 유저의 매장 내역 리스트를 보여준다. 
	@GetMapping(value = "/board/reservation/list/{storeId}/{userId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<List<RsvdVO>> getRsvdList(@PathVariable("storeId") long storeId, @PathVariable("userId") String userId) {
		
		log.info("get user rsvd list....................");		
		
		List<RsvdVO> rsvdList = userService.getRsvdListStoreUser(storeId, userId);
		
		rsvdList = rsvdList.stream().sorted((r1,r2) -> (int) (r2.getRegdate().getTime() - r1.getRegdate().getTime())).collect(Collectors.toList());
		
		return new ResponseEntity<>(rsvdList, HttpStatus.OK);
		//return new ResponseEntity<>(userService.getRsvdListStoreUser(storeId, userId), HttpStatus.OK);
	}	
	
	// 해당 매장의 메뉴 리스트를 보여준다. 
	@GetMapping(value = "/board/menus/{storeId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<List<MenuVO>> getMenuList(@PathVariable("storeId") Long storeId) {
		
		log.info("get store menu list....................");		
		
		List<MenuVO> menuList = storeService.findMenuByStoreId(storeId);
		
		return new ResponseEntity<>(menuList, HttpStatus.OK);
		//return new ResponseEntity<>(userService.getRsvdListStoreUser(storeId, userId), HttpStatus.OK);
	}
	
	
	// waitId로 오프라인 웨이팅을 등록한다.
	@PostMapping(value="/board/htdl/new",
			produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> registerHtdl(Long storeId, @Valid HtdlRequestDTO requestDto,
			BindingResult bindingResult, RedirectAttributes rttr) {
		
	if(bindingResult.hasErrors()) {
		//유효성 검사
		List<ObjectError> errorList = bindingResult.getAllErrors();
        for (ObjectError error : errorList)
            log.info("=====error: " + error.getDefaultMessage());
        
        rttr.addFlashAttribute("msg", "필수 항목을 입력해 주세요");
        
        //return "redirect:/dealight/hotdeal/register?storeId="+storeId;
	}
	
	//핫딜 상세vo list
	List<HtdlDtlsVO> dtlsList = new ArrayList<>();
	
	log.info("request dto : " + requestDto);

	HtdlVO vo = requestDto.toEntity();
	vo.setStoreId(storeId);
	log.info("=====================HtdlVO: " + vo);
	
	//String[] menu = requestDto.getMenu();
	List<HtdlMenuDTO> menuList = requestDto.getMenu();
	log.info("=================menuDTO "+ menuList);
	//log.info("=============================vo: " + vo);
	//요청 리스트 생성
	
	for(int i=0; i< menuList.size(); i++) {
		//log.info("======================menu: "+ Arrays.toString(menu));
//		MenuDTO menuDto = service.findPriceByName(storeId, menu[i].trim());
		
		//log.info("======================menuDto: "+ menuDto);
//		HtdlDtlsVO dtlsVO = HtdlDtlsVO.builder()
//								.menuName(menuDto.getName())
//								.menuPrice(menuDto.getPrice()).build();
		HtdlMenuDTO menuDto = menuList.get(i);
		
		if(menuDto.getName() != null && menuDto.getPrice() != null) {				
			HtdlDtlsVO dtlsVO = HtdlDtlsVO.builder()
					.menuName(menuDto.getName().trim())
					.menuPrice(menuDto.getPrice()).build();
			
			log.info("===================dtlsVO: " + dtlsVO);
			dtlsList.add(dtlsVO);
		}
	}
	
	htdlService.register(vo, dtlsList);
	htdlChckService.addHtdl(vo);
	
	//rttr.addFlashAttribute("result", vo.getHtdlId());
	
		return vo.getHtdlId()> 0
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
		
	// 메시지를 보낸다.
//	@PostMapping(value = "/board/message/send/ 
//			produces = {
//					MediaType.APPLICATION_JSON_UTF8_VALUE,
//					MediaType.APPLICATION_XML_VALUE
//	})
//	public ResponseEntity<List<RsvdVO>> getMessage(@PathVariable("storeId") long storeId, @PathVariable("userId") String userId) {
//		
//		log.info("get user rsvd list....................");		
//		
//		List<RsvdVO> rsvdList = userService.getRsvdListStoreUser(storeId, userId);
//		
//		rsvdList = rsvdList.stream().sorted((r1,r2) -> (int) (r2.getRegDate().getTime() - r1.getRegDate().getTime())).collect(Collectors.toList());
//		
//		return new ResponseEntity<>(rsvdList, HttpStatus.OK);
//		//return new ResponseEntity<>(userService.getRsvdListStoreUser(storeId, userId), HttpStatus.OK);
//	}

	// 수정 전
	//	@GetMapping(value = "/board/hotdeal/{storeId}", produces = {
	//			MediaType.APPLICATION_JSON_UTF8_VALUE,
	//			MediaType.APPLICATION_XML_VALUE
	//	})
	//	public ResponseEntity<WaitingVO> getNextWait(@PathVariable("storeId") long storeId) {
	//		
	//		log.info("get store...........");
	//		
	//		return new ResponseEntity<>(storeService.findByStoreIdWithBStore(storeId), HttpStatus.OK);
	//	}
}
