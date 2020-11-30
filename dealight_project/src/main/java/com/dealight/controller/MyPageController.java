package com.dealight.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.UserVO;
import com.dealight.service.RevwService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/*")
public class MyPageController {

	@Autowired
	UserService userService;
	
	@Autowired
	StoreService storeService;
	
	@Autowired
	RsvdService rsvdService;
	
	@Autowired
	WaitService waitService;
	
	@Autowired
	RevwService revwService;
	
	/*
	 * 마이페이지 로직 순서
	 * 1. 각 컨트롤러 메서드별로 필요한 vo,mapper,service를 수집한다.
	 * 2. 모든 mapper와 service를 test를 거쳐 순서대로 구성한다.
	 * 3. 페이징 처리를 로직을 구성한다.
	 * 4. view에 성공적으로 데이터를 뿌린다.
	 * 5. view 화면에 공통부분을 구현한다.
	 * 6. view 화면에 레이아웃을 구성한다.
	 * 7. review 로직으로 넘어간다.
	 * 8. 로그인 관련 로직을 결합시킨다. 
	 * 
	 * 
	 */
	
	//마이페이지 예약내역
	@GetMapping("/reservation")
	public String reservation(Model model, HttpSession session) {
		
		String userId = (String) session.getAttribute("userId");
		
		
		// 1.회원의 예약 리스트를 가져온다.
		// rsvdMapper/xml의 findRsvdListByUserId 필요
		// rsvdService의 findRsvdListByUserId 필요
		// 예약 상세를 조인해서 가져오는것이 좋을 듯하다. (메뉴명과 메뉴 사진 필요)
		
		// 2.페이징 처리가 필요하다.
		// 책을 복습해야 한다.
		
		// 3. store with store loc를 모달로 보여준다.
		// rest 방식으로 json으로 모달로 보여주자.
		
		// 4. 리뷰도 모달로 보여주자.
		// 4-1.store 정보를 보여줘야 한다.
		// 4-2. 별점으로 평점을 주는 로직을 구현한다.
		// 4-3. 리뷰 text 입력 창을 만든다.
		// 4-4. 다중 사진 첨부 로직을 구현한다.
		
		// 5. 예약 숫자 count 로직을 구현한다.
		// rsvdService getRsvdCntByUserId
		// rsvdmapper/xml getRsvdCntByUserId
		// COUNT(*)
		
		// 예약상세를 json으로 가져오는 방식은 일단 대기하자. 굳이 json으로 안뿌리고 화면에 뿌려놓아도 될 듯하다.
		// 예약 상세를 가져온다.
		// Requestbody 형식으로 json으로 반환하는 컨트롤러가 필요하다.
		// rsvdService.findRsvdByRsvdIdWithDtls(rsvdId)

		return "/dealight/mypage/reservation";
	}
	
	@GetMapping("/wait")
	public String wait(Model model, HttpSession session) {
		
		String userId = (String) session.getAttribute("userId");
		
		
		
		// 1. 웨이팅 리스트를 그대로 보여주면 될 듯하다.
		// waitService findWaitListByUserId
		// waitMapper/xml findWaitListByUserId
		
		// 2. 웨이팅, 패널티 카운트를 가져온다.
		// waitService getWaitCnt stuscd = "W" cnt 계산
		// waitService getWaitCnt stuscd = "E" cnt 계산
		// waitService getWaitCnt stuscd = "P" cnt 계산
		
		// 3. 현재 웨이팅 정보를 가져온다.
		// list -> wait stus cd = "w" wait
		// 3-1. wait.storeId로 menu와 review를 가져온다
		// storeService.findMenuByStoreId(storeId);
		// revwService.getRevwByStoreId(revwId)
		
		
		return "/dealight/mypage/wait";
	}
	
	// 리뷰에 관련된 로직은 리뷰 Controller에서 관리한다.
	// 리뷰는 REST FUL 방식으로 작성하면 좋을  듯 하다.
	
	@GetMapping("/like")
	public String like(Model model, HttpSession session) {
		
		String userId = (String) session.getAttribute("userId");
		
		// 찜 목록은 Grid 형식으로 보여준다.
		// 1. userId로 Like List를 가져온다.
		// store 정보를 보여준다.
		// 클릭하면 store 상세를 볼 수 있도록 구성한다.
		// 현재 핫딜 여부를 보여준다.
		
		// 2. 페이징 처리를 한다.
		
		// 3. 좋아요 취소 로직을 구현한다. 
		// 비동기 방식으로 구현한다.
		
		// 이외 로직은 축소한다.
		
		return "/dealight/mypage/like";
	}
	
	@GetMapping("/modify")
	public String modify(Model model, HttpSession session) {
		
		String userId = (String) session.getAttribute("userId");
		
		// 1. 기존 회원 정보를 가져온다.
		UserVO user = userService.get(userId);
		
		
		
		model.addAttribute("user",user);

		
		return "/dealight/mypage/modify";
	}
	
	@GetMapping("/notice")
	public String notice() {
		
		// 필요없는 페이지 같다. 삭제 요망
		
		return "/dealight/mypage/notice";
	}
	

}
