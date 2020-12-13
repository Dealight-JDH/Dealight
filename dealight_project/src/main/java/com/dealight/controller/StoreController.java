package com.dealight.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//다울
@Controller
@Log4j
@RequestMapping("/dealight/*")
@AllArgsConstructor
public class StoreController {

	private StoreService service;
	
	private UserService userService;
	
	private WaitService waitService;
	private HtdlService htdlService;
	private RsvdService rsvdService;

	
	//핫딜 상세(스토어)
	@GetMapping(value = "/store/htdl/get/{htdlId}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<HtdlVO> getStoreHtdl(@PathVariable Long htdlId) {
		log.info("get...");
		HtdlVO dealVO = htdlService.readHtdlDtls(htdlId);
		return new ResponseEntity<>(dealVO, HttpStatus.OK);
	}
	
	
	@GetMapping("/store")
	public String store(HttpSession session, Long storeId, Long htdlId, Criteria cri,String clsCd, Model model) {
		// store타입을 체크 한다 n일경우 n 스토어를 보여줌 b일 경우 b를 보여줌
		
		//다울 nstore check
		if (clsCd.equalsIgnoreCase("B")) {
			log.info("bstore: " + storeId);
			
			model.addAttribute("store", service.bstore(storeId));
			//model.addAttribute("revws", service.revws(storeId,cri));
			log.info("=========================htdlId: " + htdlId);
			if(htdlId != null) {
//				HtdlVO dealVO = htdlService.readHtdlDtls(htdlId);
//				log.info("==============request htdlId : " + dealVO);
				model.addAttribute("htdlId", htdlId);
			}
			
			String userId = (String)session.getAttribute("userId");
			
			if(userId != null)
				model.addAttribute("userId", userId);
			
			return "/dealight/store/bstore";
		} else {
			log.info("nstore: " + storeId);
			model.addAttribute("store", service.nstore(storeId));
			return "/dealight/store/nstore";
		}

	}

	
	@PostMapping("/store/rsvd")
	public String regRsvd(Model model, HttpSession session, RsvdVO rsvd) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");
		
		log.info("register rsvd......................");
		
		UserVO user = userService.get(userId);
		
		log.info("register rsvd...................... user : " + user);
		
		SimpleDateFormat fomater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		
		List<RsvdDtlsVO> rsvdDtlsList = new ArrayList<>();
		
		RsvdDtlsVO dtls = new RsvdDtlsVO();
		dtls.setMenuNm("돈까스");
		dtls.setMenuPrc(7000);
		dtls.setMenuTotQty(3);
		
		rsvdDtlsList.add(dtls);
		
		rsvd.setUserId(userId);
		rsvd.setRevwStus(0);
		rsvd.setTime(fomater.format(new Date()));
		rsvd.setStusCd("C");
		rsvd.setRsvdDtlsList(rsvdDtlsList);
		
		log.info("before rsvd.........................."+rsvd);
		
		rsvdService.register(rsvd, rsvd.getRsvdDtlsList());
		
		log.info("after rsvd.........................."+rsvd);
		
		Long storeId = rsvd.getStoreId();
		Long rsvdId = rsvd.getRsvdId();
		
    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
    	Map<String, WebSocketSession> map = handler.getUserSessions();
    	WebSocketSession ws = map.get("kjuioq");
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
	
	@PostMapping("/store/wait")
	public String regWait(Model model, HttpSession session,int pnum, Long storeId) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");
		
		log.info("register wait......................");
		
		UserVO user = userService.get(userId);
		
		log.info("register wait...................... user : " + user);
		
		SimpleDateFormat fomater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		WaitVO wait = new WaitVO().builder()
				.userId(userId)
				.storeId(storeId)
				.waitPnum(pnum)
				.custNm(user.getName())
				.custTelno(user.getTelno())
				.waitStusCd("W")
				.waitRegTm(fomater.format(new Date()))
				.build();
		
		log.info("register wait...................... before wait : " + wait);
		
		Long waitId = waitService.registerOnWaiting(wait);
		
		log.info("register wait...................... after wait : " + wait);
		log.info("register wait...................... after wait id: " + waitId);

    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
    	Map<String, WebSocketSession> map = handler.getUserSessions();
    	WebSocketSession ws = map.get("kjuioq");
    	if(ws != null) {
    		TextMessage message = new TextMessage("{\"sendUser\":\""+userId+"\",\"waitId\":\""+waitId+"\",\"cmd\":\"wait\",\"storeId\":\""+storeId+"\"}");
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
