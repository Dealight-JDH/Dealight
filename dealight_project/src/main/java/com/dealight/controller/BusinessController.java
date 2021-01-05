package com.dealight.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.BUserVO;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlMenuDTO;
import com.dealight.domain.HtdlRequestDTO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdRequestDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.UserWithRsvdDTO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.service.BizAuthService;
import com.dealight.service.CallService;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
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
	
	private UserService userService;
	
	private BizAuthService bizAuthService;
	
	// 파일 저장 경로를 지정한다.
	final static private String ROOT_FOLDER = "C:\\dealgiht\\rds\\";
	
	
	//메뉴 사진첨부파일 매장평가 사업자테이블에 태그 메뉴 옵션이 들어가야한다.
	//DTO에 대한이해가 피요하고 많아지는 객체들을 쪼갤수있는 방법을 생각하자.
	@PostMapping("/register")
	@Transactional
	public String register(StoreVO store, BStoreVO bStore, StoreLocVO loc, StoreEvalVO eval,Long brSeq,RedirectAttributes rttr) {
		
		
		log.info("store................"+store);
		log.info("bstore................." + bStore);
		log.info("loc................." + loc);
		log.info("store eval................." + eval);
		// log.info("imgs............." + imgs);
		
		bStore.setRepImg(bStore.getRepImg());
		store.setBstore(bStore);
		store.setLoc(loc);
		store.setEval(eval);
		
		log.info("register: " + store);
		
		sService.register(store);
		//bizAuthService.updateStusCdToB(brSeq);
		
		Long storeId = store.getStoreId();
		
		log.info("before insert rsvd avail store id : " + storeId);
		// 1개의 rsvd avail 테이블 row를 추가하는 메서드 작성
		rsvdService.registerRsvdAvail(storeId);
		
		//rsvdService.initRsvdAvail();
		
		//지금 나의 생각 입력한 값들이 잘 저장되나 보고싶다.
		//결국 저장된 정보를 볼수있는 페이지는 뭐가잇을까??
		//수정페이지에서 정보를 볼 수있고 정보도 고칠수 있지 
		//그러면 수정페이지를 가지고있어야겠네
		rttr.addFlashAttribute("regResult", store.getStoreId()+"번 매장이 등록되었습니다.");
		return "redirect:/dealight/business/";
	}
	
	@GetMapping("/register")
	public void register(Model model, Long brSeq) {
		
		if(brSeq != null) {
			BUserVO buser = bizAuthService.read(brSeq);
			log.info("store register get .......................");
			log.info("buser : "+ buser);
			
			String storeName = buser.getStoreNm();
			String storeTelno = buser.getStoreTelno();
			
			model.addAttribute("storeName", storeName);
			model.addAttribute("storeTelno", storeTelno);
			model.addAttribute("brSeq", brSeq);
		}
	
	}
	
	/*
	 * 밑으로
	 *****[김동인] 
	 * 
	 * 
	 */
	
	// 해당 유저의 매장 리스트를 보여준다.
	@GetMapping("/")
	public String list(Model model,HttpSession session,String code,HttpServletResponse response,HttpServletRequest request) {
		
		log.info("code : " + code);
		
		boolean isMsgAval = false;
		
		Cookie[] cookies1 = request.getCookies();
		for(Cookie cookie : cookies1) {
			if(cookie.getName().equals("access_token") && !cookie.getValue().equals("") && cookie.getValue() != null)
				isMsgAval = true;
		}
		model.addAttribute("isMsgAval", isMsgAval);
		
		if(code != null) {
			HashMap<String, Object> result = callService.getToken(code);
			LinkedHashMap<String, String> lm = (LinkedHashMap) result.get("body");
			String accessToken = lm.get("access_token");
			Cookie cookie = new Cookie("access_token", accessToken);
			response.addCookie(cookie);
		}
		
		boolean isSnsLogin = false;
		
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("accessToken"))
				isSnsLogin = true;
		}
		

		log.info("business store list..");
		
		// 임시로 'aaaa'이라는 아이디의 매장을 보여준다.
		//session.setAttribute("userId", "aaaa");
		String userId = (String) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		log.info(".........................................userId : "+userId);
		
		List<StoreVO> list = storeService.getStoreListByUserId(userId);
		
		
		// 현재 심사 대기중인 사업자등록번호
		List<BUserVO> comBuserList = storeService.comBrListByUserId(userId);

		List<BUserVO> buserList = new ArrayList();
		
		for(BUserVO buser : comBuserList)
			if(buser.getStoreId() == null)
				buserList.add(buser);
		
		log.info(".................................buser list : " + buserList);
		
		log.info("list............................."+list);
		// 현재 웨이팅, 현재 예약 상태를 가져온다.
		// ***쿼리가 너무 많이 생긴다.
		// 반정규화 고려
		list.stream().forEach((store)->{
			long id = store.getStoreId(); 	
			
			store.setBstore(storeService.getBStore(id));
			store.setCurWaitNum(waitService.curStoreWaitList(id, "W").size());
			store.setCurRsvdNum(rsvdService.readTodayCurRsvdList(id).size());
		});
		
		
		model.addAttribute("storeList", list);
		model.addAttribute("buserList", buserList);
		model.addAttribute("code",code);
		model.addAttribute("isSnsLogin",isSnsLogin);
		
		return "/dealight/business/list";
	}
	
	
	// 해당 매장의 관리 화면을 보여준다.
	// 대부분의 로직이 REST FUL 방식으로 변경(Board Controller로 대체되었다.)
	@GetMapping("/manage")
	public String manage(Model model, Long storeId,HttpServletRequest request, String code) {
		
		log.info("business manage..");
		
		String accessToken = "";
		
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("access_token"))
				accessToken = cookie.getValue();
		}
		
		log.info("accessToken : "+accessToken);
		
		
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");
		
		
		if(!"".equals(accessToken)) {
			
			HashMap<String, Object> profile = callService.getProfile(accessToken);
			
			log.info("Users info............:"+profile);
			HashMap<String, Object> frList = callService.getUsersList();
			
			log.info("Users list............:"+frList);

			HashMap<String, Object> talkProfile = callService.getTalkProfile(accessToken);
			
			log.info("talkProfile................"+talkProfile);
			
			// 종우 컴퓨터로 옮기면서 바꿔야 함
			String restKey = "dba6ebc24e85989c7afde75bd48c5746";
			String redirectURI = "http://localhost:8181/business/manage";
			
			HashMap<String, Object> allow= callService.getAllow();
			
			log.info(allow);
			
			HashMap<String, Object> talkFriendsList = callService.getTalkFriendsList(accessToken);
			
			log.info("talkFriendsList................"+talkFriendsList);
			
			talkFriendsList = (LinkedHashMap<String, Object>) talkFriendsList.get("body");
			
			log.info("talkFriendsList2..........."+talkFriendsList);
			
			log.info("talkFriendsList2 class..........."+talkFriendsList.getClass());
			
			//log.info("talkFriendsList3..........."+talkFriendsList.get("elements").getClass());
			
			try {
				List list = (ArrayList) talkFriendsList.get("elements");
				
				log.info("talkFriendsList3..........."+list.get(0).getClass());
				
				LinkedHashMap map = (LinkedHashMap) list.get(0);
				
				log.info(map.get("uuid"));
				
				
				model.addAttribute("uuid",map.get("uuid"));
				
			} catch (NullPointerException e) {
				e.printStackTrace();
				model.addAttribute("uuid","uuid 오류");
			}
			
			model.addAttribute("accessToken",accessToken);
			
		}
		
		 

		// 오늘 예약한 사용자의 사용자 정보와 예약 정보를 가져온다.
		List<UserWithRsvdDTO> todayRsvdUserList = rsvdService.userListTodayRsvd(storeId);
		
		model.addAttribute("store",storeService.findByStoreIdWithBStore(storeId));
		model.addAttribute("userId",userId);
		model.addAttribute("storeId", storeId);
		model.addAttribute("todayRsvdUserList", todayRsvdUserList);
		
		return "/dealight/business/manage/manage";
	}
		
		@GetMapping("/test")
		public String test(HttpSession session,Model model) {
			
			String userId = (String) session.getAttribute("userId");
			
			model.addAttribute("userId", userId);
			
			ManageSocketHandler handler = ManageSocketHandler.getInstance();
	    	Map<String, WebSocketSession> map = handler.getUserSessions();
	    	
	    	model.addAttribute("map",map);
			
			
			return "/dealight/business/test";
		}
		
		@PostMapping("/test/rsvd")
		public String test(HttpSession session,RsvdRequestDTO dto) {
			
			// 임시로 'kjuioq'의 아이디를 로그인한다.
			String userId = (String) session.getAttribute("userId");
			
			log.info("register rsvd......................");
			
			UserVO user = userService.get(userId);
			
			log.info("register rsvd...................... user : " + user);
			
			List<RsvdDtlsVO> rsvdDtlsList = new ArrayList<>();
			
			RsvdVO rsvd = dto.toEntity();
			
			RsvdDtlsVO dtls = new RsvdDtlsVO();
			dtls.setMenuNm("돈까스");
			dtls.setMenuPrc(7000);
			dtls.setMenuTotQty(3);
			
			rsvdDtlsList.add(dtls);
			
			rsvd.setUserId(userId);
			rsvd.setRevwStus(0);
			rsvd.setStusCd("C");
			rsvd.setRsvdDtlsList(rsvdDtlsList);
			
			log.info("before rsvd.........................."+rsvd);
			
			// rsvd 예약 가능한지 체크
			
			rsvdService.register(rsvd, rsvd.getRsvdDtlsList());
			boolean resultComplete = rsvdService.complete(rsvd.getRsvdId());
			boolean resultAvail = rsvdService.completeUpdateAvail(rsvd.getStoreId(), dto.getTime(), rsvd.getPnum());
			
			log.info("resultComplete : " + resultComplete);
			log.info("resultAvail : " + resultAvail);
			
			log.info("after rsvd.........................."+rsvd);
			
			Long storeId = rsvd.getStoreId();
			Long rsvdId = rsvd.getRsvdId();
			
	    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
	    	Map<String, WebSocketSession> map = handler.getUserSessions();
	    	WebSocketSession ws = map.get(storeService.getBStore(storeId).getBuserId());
	    	if(ws != null) {
	    		TextMessage message = new TextMessage("{\"sendUser\":\""+userId+"\",\"rsvdId\":\""+rsvdId+"\",\"cmd\":\"rsvd\",\"storeId\":\""+storeId+"\"}");
	    		try {
					handler.handleMessage(ws, message);
				} catch (Exception e) {
					
					log.warn("web socket error...............");
					e.printStackTrace();
				}
	    	}
			
			
			return "redirect:/dealight/business/test";
		}
		
		@PostMapping("/test/htdl")
		public String regHtdl(HttpSession session,Long storeId, String startTm, String endTm, String htdlName) {
			
			log.info("htdl socket.......................................");
			
			String userId = (String) session.getAttribute("userId");
			
			ManageSocketHandler handler = ManageSocketHandler.getInstance();
	    	Map<String, WebSocketSession> map = handler.getUserSessions();
	    	WebSocketSession ws = map.get(userId);
	    	if(ws != null) {
	    		TextMessage message = new TextMessage("{\"sendUser\":\""+"dealight"+"\",\"htdlId\":\""+"0"+"\",\"cmd\":\"htdl\",\"storeId\":\""+storeId+"\"}");
	    		try {
					handler.handleMessage(ws, message);
				} catch (Exception e) {
					
					log.warn("web socket error...............");
					e.printStackTrace();
				}
	    	}
			
			
			return "redirect:/dealight/business/test";
		}
}
