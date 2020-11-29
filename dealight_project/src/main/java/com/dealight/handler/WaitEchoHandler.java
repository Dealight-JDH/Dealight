package com.dealight.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.dealight.domain.UserVO;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;

import lombok.extern.log4j.Log4j;


@Log4j
public class WaitEchoHandler extends TextWebSocketHandler {
	
	@Autowired
	UserService userService;
	
	@Autowired
	StoreService storeService;
	
	// 현재 접속해 있는 Socket의 세션을 List로 보관
	List<WebSocketSession> sessions = new ArrayList<>();
	
	// 유저의 아이디를 담을 맵을 생성한다.
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	
	// session이 우리에게 들어온다.
	
	// connection이 연결되었을 때, 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		log.info("afterConnectionEstablished : " + session);
		
		// 접속되는 유저들을 sessions에 추가한다.
		sessions.add(session);
		
		String senderId = getId(session);
		userSessions.put(senderId, session);
		
		log.info("userSession map........................."+userSessions);
		
		/*
		String senderId = getId(session);
		userSessions.put(senderId, session);
		
		 */
	}
	
	// 어떤 메시지를 보냈을 때,
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("handleTextMessage : " + session + ":" + message);
		
		// 참고로 로그인한 사용자는 HTTP Session에 정보가 있다.
		String senderId = getId(session);
		
		log.info("senderId : " + senderId);
		
		/*
		String senderId = getId(session);
		*/
		// broadcasting sockket에 접속한 모든 인원에게 메시지를 날린다.
		// payload로 보내야 한다.
		// 모든 유저에게 보내는 메시지는 일단 주석처리한다.
		/*
		for (WebSocketSession sess : sessions) {
			sess.sendMessage(new TextMessage(senderId + ":" + message.getPayload()));
		}
		*/
		
		// JSON으로 보내면 가장 좋지만 일단 String으로 구현해보자.
		// protocol : cmd,댓글작성자,게시글작성,bno (ex : wait,sendUser,storeUser,waitId)
		// cmd는 reply 말고도 다른 기능을 구현할 때 달라질 수 있다.
		String msg = message.getPayload();
		
		log.info("senderId : " + senderId + " : " + msg);
		
		if(!StringUtils.isEmpty(msg)) {
			String[] strs = message.getPayload().split(",");
			
			log.info("strs.............." + strs);
			// out of index 예외 처리, 
			if(strs != null && strs.length == 4) {
				String cmd = strs[0];
				String sendUser = strs[1];
				String storeId = strs[2];
				String waitId = strs[3];
				
				log.info("strs exception ========================");
				log.info("cmd : " + cmd);
				log.info("sendUser : " + sendUser);
				log.info("storeId : " + storeId);
				log.info("waitId : " + waitId);
				
				String storeUserId = storeService.findByStoreIdWithBStore(Long.parseLong(storeId)).getBstore().getBuserId(); 
				
				// 현재 로그인 되어있는 세션 에서 넘겨진 boardWriter 아이디를 갖고 있는 세션을 찾는다. 있으면 메시지를 보낸다.
				WebSocketSession storeUserSession = userSessions.get(storeUserId);
				
				log.info("userSession : " + userSessions );
				
				log.info("storeUserSession : " + storeUserSession);
				
				if("wait".equals(cmd) && storeUserSession != null) {
					TextMessage tmpMsg = new TextMessage(sendUser + "님이" + 
						"<a href='/dealight/business/waiting/" + waitId + ">" +waitId+ "번</a> 웨이팅이 등록되었습니다!");
					log.info("send message ========================");
					log.info("tmpMsg : " + tmpMsg);
					
					storeUserSession.sendMessage(tmpMsg);
				}
			}
		}
	}

	// 로그인을 했으면 로그인한 아이디를 주고, 로그인을 하지 않았으면 소켓의 id를 반환한다.
	private String getId(WebSocketSession session) {
		// http session에 있는 값을 전부 map으로 저장한다.
		Map<String, Object> httpSession = session.getAttributes();
		
		String userId = (String) httpSession.get("userId");
		
		UserVO loginUser = userService.get(userId);
		
		if(null == loginUser)
			return session.getId();
		else
			return loginUser.getUserId();

		
		// 스프링 시큐리티와 연관이 있는듯 하다. 로그인 상태인 session을 가져온다.
		/*
		 * 
		UserVO loginUser = (UserVO) httpSession.get(SessionNames.LOGIN);
		if(null == loginUser)
			return session.getId();
		else
			return loginUser.getUid();
		return null;
		*/
	}

	// connection이 close되었을 때,
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed : " + session + ":" + status);
	}
	
	
	// 위의 3가지 메서드가 기본적으로 필요하다.

}
