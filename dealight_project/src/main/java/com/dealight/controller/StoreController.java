package com.dealight.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.LikeVO;
import com.dealight.domain.RevwPageDTO;
import com.dealight.domain.UserVO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.service.HtdlService;
import com.dealight.service.LikeService;
import com.dealight.service.RevwService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Controller
@Log4j
@RequestMapping("/dealight/*")
@AllArgsConstructor
public class StoreController {

	private StoreService service;
	
	private UserService userService;
	private LikeService likeService;
	private WaitService waitService;
	private HtdlService htdlService;
	private StoreService storeService;
	private RevwService revwService;
	
	//핫딜 상세(스토어)
	@GetMapping(value = "/store/htdl/get/{htdlId}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<HtdlVO> getStoreHtdl(@PathVariable Long htdlId) {
		log.info("get...");
		log.info("=========================htdlId: " + htdlId);
		HtdlVO dealVO = (htdlService.readActStoreHtdlList(htdlId)).get(0);
		return new ResponseEntity<>(dealVO, HttpStatus.OK);
	}
	@GetMapping(value = "/revws/pages/{storeId}/{page}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<RevwPageDTO> getRevw(@PathVariable("storeId") Long storeId, @PathVariable("page") int page) {
		log.info("....get Revw");
		Criteria cri = new Criteria(page, 5);
		RevwPageDTO dto = new RevwPageDTO(revwService.getCountByStoreId(storeId), revwService.getRevwListWithPagingByStoreId(storeId, cri));
		return new ResponseEntity<>( dto, HttpStatus.OK);
	}
	
	@GetMapping("/store/{storeId}")
	public String store(HttpSession session, @PathVariable("storeId") long storeId, Long htdlId, Model model) {
		// store타입을 체크 한다 n일경우 n 스토어를 보여줌 b일 경우 b를 보여줌
		
			
			model.addAttribute("store", service.bstore(storeId));
//			model.addAttribute("revws", service.revws(storeId,cri));
			log.info("=========================htdlId: " + htdlId);
			if(htdlId != null) {
//				HtdlVO dealVO = htdlService.readHtdlDtls(htdlId);
//				log.info("==============request htdlId : " + dealVO);
				model.addAttribute("htdlId", htdlId);
			}
			
			//하드코딩
			String userId = (String)session.getAttribute("userId");
			boolean isLike = false;
			if(userId !=null && likeService.findByUserIdAndStoreId(userId, storeId)!=null) {
				isLike = true;
			}
			
			model.addAttribute("like", isLike);
			
			if(userId != null)
				model.addAttribute("userId", userId);
			
			return "/dealight/store/bstore";

	}

	
	@PostMapping("/store/wait")
	public String regWait(HttpSession session,int pnum, Long storeId, RedirectAttributes rttr) {
		
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
		if(waitId == -1) {
			rttr.addFlashAttribute("result", "fail");
			
			return "redirect:/dealight/store/"+storeId;
		}
		

    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
    	Map<String, WebSocketSession> map = handler.getUserSessions();
    	// 매장의 소켓으로 메시지를 보낸다.
    	WebSocketSession ws = map.get(storeService.getBStore(storeId).getBuserId());
    	if(ws != null) {
    		TextMessage message = new TextMessage("{\"sendUser\":\""+userId+"\",\"waitId\":\""+waitId+"\",\"cmd\":\"wait\",\"storeId\":\""+storeId+"\"}");
    		try {
				handler.handleMessage(ws, message);
			} catch (Exception e) {
				
				log.warn("web socket error...............");
				e.printStackTrace();
			}
    	}
    	
    	rttr.addFlashAttribute("result", "success");
    	
    	return "redirect:/dealight/store/"+storeId;
	}

}
