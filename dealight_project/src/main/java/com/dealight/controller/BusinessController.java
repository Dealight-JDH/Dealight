package com.dealight.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserWithRsvdDTO;
import com.dealight.domain.WaitVO;
import com.dealight.service.CallService;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//현중 동인이형이랑 회의필요
@Controller
@Log4j
@RequestMapping("/dealight/business/*")
@AllArgsConstructor
public class BusinessController {

	private StoreService sService;
	
	private StoreService storeService;
	
	private RsvdService rsvdService;
	
	private WaitService waitService;
	
	private HtdlService htdlService;
	
	private CallService callService;
	
	
	//메뉴 사진첨부파일 매장평가 사업자테이블에 태그 메뉴 옵션이 들어가야한다.
	//DTO에 대한이해가 피요하고 많아지는 객체들을 쪼갤수있는 방법을 생각하자.
	@PostMapping("/register")
	public String register(StoreVO store, BStoreVO bStore, StoreLocVO loc, StoreEvalVO eval, RedirectAttributes rttr) {
		store.setBstore(bStore);
		store.setLoc(loc);
		//테스트용 지워야함
		store.setEval(eval);
		
		log.info("register: " + store);
		
		sService.register(store);
		
		//지금 나의 생각 입력한 값들이 잘 저장되나 보고싶다.
		//결국 저장된 정보를 볼수있는 페이지는 뭐가잇을까??
		//수정페이지에서 정보를 볼 수있고 정보도 고칠수 있지 
		//그러면 수정페이지를 가지고있어야겠네
		//
		rttr.addFlashAttribute("result", store.getStoreId());
		return "redirect:/dealight/business/";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	/*
	 * 밑으로
	 *****[김동인] 
	 * 
	 * 
	 */
	
	// 해당 유저의 매장 리스트를 보여준다.
	@GetMapping("")
	public String list(Model model,HttpServletRequest request) {
		
		log.info("business store list..");
		
		
		HttpSession session = request.getSession();
		
		// 임시로 'lim'이라는 아이디의 매장을 보여준다.
		session.setAttribute("userId", "lim");
		
		String userId = (String) session.getAttribute("userId");
		
		model.addAttribute("userId", userId);
		
		List<StoreVO> list = storeService.getStoreListByUserId(userId);
		
		// 현재 웨이팅, 현재 예약 상태를 가져온다.
		// ***쿼리가 너무 많이 생긴다.
		list.stream().forEach((store)->{
			long id = store.getStoreId();
			store.setCurWaitNum(waitService.curStoreWaitList(id, "W").size());
			store.setCurRsvdNum(rsvdService.readTodayCurRsvdList(id).size());
		});
		
		model.addAttribute("storeList", list);
		
		return "/dealight/business/list";
	}
	
	
	// 해당 매장의 관리 화면을 보여준다.
	// 대부분의 로직이 REST FUL 방식으로 변경(Board Controller로 대체되었다.)
	@GetMapping("/manage")
	public String manage(Model model, long storeId,HttpServletRequest request, String code) {
		
		log.info("business manage..");
		
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");

		// 오늘 예약한 사용자의 사용자 정보와 예약 정보를 가져온다.
		List<UserWithRsvdDTO> todayRsvdUserList = rsvdService.userListTodayRsvd(storeId);
		
		model.addAttribute("storeId", storeId);
		model.addAttribute("todayRsvdUserList", todayRsvdUserList);
		
		return "/dealight/business/manage/manage";
	}

		// 웨이팅의 상세 정보(번호표)를 볼 수 있다.
		@GetMapping("/waiting/{waitId}")
		public String waiting(Model model, @PathVariable("waitId") long waitId) {
			
			log.info("business waiting detail..");
			
			WaitVO wait = waitService.read(waitId);
			
			log.info(wait);
			
			// 현재 예약 상태인 웨이팅 리스트를 가져온다.
			List<WaitVO> curStoreWaitiList = waitService.curStoreWaitList(wait.getStoreId(), "W");
			
			// 현재 웨이팅의 순서를 찾아온다.
			int order = waitService.calWatingOrder(curStoreWaitiList, wait.getWaitId());
			
			// 현재 웨이팅 순서와 시간('임의의 시간인 15분')을 계산한다.
			int waitTime = waitService.calWaitingTime(curStoreWaitiList, wait.getWaitId(), 15);
			
			model.addAttribute("wait",wait);
			model.addAttribute("order",order);
			model.addAttribute("waitTime", waitTime);
			
			return "/dealight/business/manage/waiting/waiting";
		}
}
