package com.dealight.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dealight.domain.StoreVO;
import com.dealight.domain.WaitVO;
import com.dealight.service.CallService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인] 
 * 
 */


/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CallService callService;
	
	@Autowired
	private WaitService waitService;
	
	@Autowired
	private StoreService storeService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		String userId = (String) session.getAttribute("userId");
		
		log.info(".................................user id : "+userId);
		
		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("userId", userId);
		
		
		
		return "home";
	}
	
	// 카카오 api 인가 코드를 받는다.
	@RequestMapping(value="/oauth", method = RequestMethod.GET)
	public String getOauth(Model model, String code, Long storeId, Long waitId) {
		
		log.info("rest template get oauth..........................");
		
		String restKey = "dba6ebc24e85989c7afde75bd48c5746";
		String redirectURI = "http://localhost:8080/oauth";
		
		model.addAttribute("restKey",restKey);
		model.addAttribute("redirectURI",redirectURI);
		model.addAttribute("code",code);
		model.addAttribute("storeId",storeId);
		model.addAttribute("waitId",waitId);
		
		return "oauth";
	}
	
	// 카카오 api token을 받는다.
	@RequestMapping(value="/token", method = RequestMethod.GET)
	public String getToken(Model model, String code, Long storeId, Long waitId) {
		
		log.info("rest template get token..........................");
		
		log.info(code);
		
		HashMap<String, Object> result = callService.getToken(code);
		LinkedHashMap<String, String> lm = (LinkedHashMap) result.get("body");
		String access_token = lm.get("access_token");
		
		log.info("access............: "+result);
		
		HashMap<String, Object> profile = callService.getProfile(access_token);
		
		log.info("Users info............:"+profile);
		
		HashMap<String, Object> frList = callService.getUsersList();
		
		log.info("Users list............:"+frList);
		
		HashMap<String, Object> talkProfile = callService.getTalkProfile(access_token);
		
		log.info("talkProfile................"+talkProfile);
		
		String restKey = "dba6ebc24e85989c7afde75bd48c5746";
		String redirectURI = "http://localhost:8080/token";
		
		HashMap<String, Object> allow= callService.getAllow();
		
		log.info(allow);
		
		HashMap<String, Object> talkFriendsList = callService.getTalkFriendsList(access_token);

		log.info("talkFriendsList................"+talkFriendsList);
		
		talkFriendsList = (LinkedHashMap<String, Object>) talkFriendsList.get("body");
		
		log.info("talkFriendsList2..........."+talkFriendsList);
		
		log.info("talkFriendsList2 class..........."+talkFriendsList.getClass());
		
		log.info("talkFriendsList3..........."+talkFriendsList.get("elements").getClass());

		List list = (ArrayList) talkFriendsList.get("elements");
		
		log.info("talkFriendsList3..........."+list.get(0).getClass());
		
		LinkedHashMap map = (LinkedHashMap) list.get(0);
		
		log.info(map.get("uuid"));
		
		//List<HashMap<String, Object>> elements = (List<HashMap<String, Object>>) talkFriendsList.get("elements");
		
		//String requestUuid = (String) elements.get(0).get("uuid");
		
		
		model.addAttribute("result", result);
		model.addAttribute("access_token",access_token);
		model.addAttribute("profile",profile);
		model.addAttribute("frList",frList);
		model.addAttribute("talkProfile",talkProfile);
		model.addAttribute("restKey",restKey);
		model.addAttribute("redirectURI",redirectURI);
		model.addAttribute("allow",allow);
		model.addAttribute("talkFriendsList",talkFriendsList);
		model.addAttribute("storeId",storeId);
		model.addAttribute("waitId",waitId);
		model.addAttribute("first",map);
		model.addAttribute("requestUuid",map.get("uuid"));

		return "token";
	}
	
	// 카카오 api 메시지 보내기의 결과를 확인한다.
	@RequestMapping(value="/message", method = RequestMethod.GET)
	public String frmessage(Model model, String access_token, String title, String description, String web_url, String code,Long storeId) {
		
		log.info("rest template test..........................");
		
		log.info("accesss token : "+access_token+"\ntitle : "+title+"\ndescription : "+description+"\nweb_url : "+web_url);
		
		String result = callService.sendMessage(access_token,title,description,web_url);
		
		model.addAttribute("result", result);

		return "message";
	}
	
	// 친구(uuid)에 메시지를 보낸다.
	@RequestMapping(value="/message/friends", method = RequestMethod.GET)
	public String test(Model model, String access_token, String title, String description, String web_url, String uuid, Long storeId, Long waitId) {
		
		log.info("rest template test..........................");
		
		log.info("accesss token : "+access_token+"\ntitle : "+title+"\ndescription : "+description+"\nweb_url : "+web_url+"\nuuid : "+uuid+"\nwaitId : "+waitId);
		
		String result = callService.sendFrMessage(access_token,title,description,web_url,uuid);
		
		model.addAttribute("result", result);
		model.addAttribute("storeId",storeId);

		return "message";
	}
	
	// 웨이팅의 상세 정보(번호표)를 볼 수 있다.
			@GetMapping("/dealight/waiting/{waitId}")
			public String waiting(Model model, @PathVariable("waitId") long waitId) {
				
				log.info("business waiting detail..");
				
				WaitVO wait = waitService.read(waitId);
				
				wait.setWaitRegTm(wait.getWaitRegTm().split(" ")[1].substring(0,5));
				
				log.info(wait);
				
				// 현재 예약 상태인 웨이팅 리스트를 가져온다.
				List<WaitVO> curStoreWaitiList = waitService.curStoreWaitList(wait.getStoreId(), "W");
				
				// 현재 웨이팅의 순서를 찾아온다.
				int order = waitService.calWatingOrder(curStoreWaitiList, wait.getWaitId());
				
				// 현재 웨이팅 순서와 시간('임의의 시간인 15분')을 계산한다.
				int waitTime = waitService.calWaitingTime(curStoreWaitiList, wait.getWaitId(), 15);
				
				// 해당 매장의 위치정보를 가져온다.
				StoreVO store = storeService.findStoreWithBStoreAndLocByStoreId(wait.getStoreId());
				
				model.addAttribute("wait",wait);
				model.addAttribute("order",order);
				model.addAttribute("waitTime", waitTime);
				model.addAttribute("store",store);
				
				return "/dealight/business/manage/waiting/waiting";
			}
			
	
}
