package com.dealight.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.dealight.domain.SugRequestDTO;
import com.dealight.domain.UserVO;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;

import lombok.extern.log4j.Log4j;

@Log4j
public class ManageSocketHandler extends TextWebSocketHandler {
	
	// 싱글톤
	private static ManageSocketHandler handler;
	private ManageSocketHandler() {
		handler = this;
	};
	
	public static ManageSocketHandler getInstance() {
		return handler;
	}
	
	@Autowired
	UserService userService;
	
	@Autowired
	StoreService storeService;
	
	// 현재 접속해 있는 Socket의 세션을 List로 보관
	List<WebSocketSession> sessions = new ArrayList<>();
	
	// 유저의 아이디를 담을 맵을 생성한다.
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	
	public Map<String, WebSocketSession> getUserSessions() {
		return userSessions;
	}

	// connection이 연결되었을 때, 
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		log.info("afterConnectionEstablished : " + session);
		
		// 접속되는 유저들을 sessions에 추가한다.
		sessions.add(session);
		
		String senderId = getId(session);
		userSessions.put(senderId, session);
		
		log.info("userSession map........................."+userSessions);
		
	}
	
	// 어떤 메시지를 보냈을 때,
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.info("handleTextMessage : " + session + ":" + message);
		String senderId = "";
		// 참고로 로그인한 사용자는 HTTP Session에 정보가 있다.
		try {
			senderId = getId(session);			
		} catch(NullPointerException ne) {
			ne.printStackTrace();
			log.info("web socket null exception error catch.........................");
			return;
		}
		
		log.info("senderId : " + senderId);
		
		// JSON으로 보내면 가장 좋지만 일단 String으로 구현해보자.
		// protocol : cmd,요청자,매장아이디,웨이팅아이디/예약아이디 (ex : wait,sendUser,storeUser,waitId/rsvdId/htdlId)
		// cmd는 reply 말고도 다른 기능을 구현할 때  달라질 수 있다.
		String jsonStr = message.getPayload();
		
		Gson gson = new Gson();
		
		HashMap<String,Object> map = gson.fromJson(jsonStr, HashMap.class);
		
		log.info("senderId : " + senderId + " : " + map);
		
		if(map != null) {
			log.info("map.............." + map);
			// out of index 예외 처리, 
			if(map != null && map.size() >= 4) {
				String cmd = (String) map.get("cmd");
				String sendUser = (String) map.get("sendUser");
				Long storeId = Long.parseLong((String) map.get("storeId"));
				String waitIdStr = (String) map.get("waitId");
				String rsvdIdStr = (String) map.get("rsvdId");
				String htdlIdStr = (String) map.get("htdlId");
				Map<String,String> dtoMap = (LinkedTreeMap<String, String>) map.get("htdlDto");
				
				// 핫딜 제안 dto 로직 추가
				//String htdlDto = (String) map.get("dto");
				
				String msg = "";
				
				Long waitId = null;
				Long rsvdId = null;
				Long htdlId = null;
				
				if(waitIdStr != null) {
					waitId = Long.parseLong(waitIdStr);
					msg = "<a href='/dealight/waiting/" + waitId + "' target='_blank'>" +waitId+ "번 웨이팅</a>이 등록되었습니다.";
				}
				else if(rsvdIdStr != null) {
					rsvdId = Long.parseLong(rsvdIdStr);
					msg = rsvdId + "번 예약이 등록되었습니다.";
				}
				else if(htdlIdStr != null) {
					htdlId = Long.parseLong(htdlIdStr);
					msg = "새로운 핫딜 제안이 도착했습니다.";
				}
				
				log.info("strs exception ========================");
				log.info("cmd : " + cmd);
				log.info("sendUser : " + sendUser);
				log.info("storeId : " + storeId);
				log.info("waitId : " + waitId);
				log.info("rsvdId : " + rsvdId);
				
				String storeUserId = storeService.findByStoreIdWithBStore(storeId).getBstore().getBuserId(); 
				
				// 현재 로그인 되어있는 세션 에서 넘겨진 boardWriter 아이디를 갖고 있는 세션을 찾는다. 있으면 메시지를 보낸다.
				WebSocketSession storeUserSession = userSessions.get(storeUserId);
				
				log.info("userSession : " + userSessions );
				
				log.info("storeUserSession : " + storeUserSession);
				
				if("wait".equals(cmd) && storeUserSession != null) {
					TextMessage tmpMsg = new TextMessage("{\"sendUser\" : \""+sendUser+"\", \"msg\":\""+msg+"\","
							+ "\"storeId\" : \""+storeId+"\", \"cmd\":\""+cmd+"\", \"waitId\":\""+waitId+"\"}");
					log.info("send message ========================");
					log.info("tmpMsg : " + tmpMsg);
					
					storeUserSession.sendMessage(tmpMsg);
				} else if ("rsvd".equals(cmd) && storeUserSession != null) {
					TextMessage tmpMsg = new TextMessage("{\"sendUser\" : \""+sendUser+"\", \"msg\":\""+msg+"\","
							+ "\"storeId\" : \""+storeId+"\", \"cmd\":\""+cmd+"\", \"rsvdId\":\""+rsvdId+"\"}");
						log.info("send message ========================");
						log.info("tmpMsg : " + tmpMsg);
						
						storeUserSession.sendMessage(tmpMsg);
				} else if ("htdl".equals(cmd) && storeUserSession != null) {
					TextMessage tmpMsg = new TextMessage("{\"sendUser\" : \""+sendUser+"\", \"msg\":\""+msg+"\","
							+ "\"storeId\" : \""+storeId+"\", \"cmd\":\""+cmd+"\", \"htdlId\":\""+htdlId+"\","
							+ "\"htdlDto\":{\"name\":\""+dtoMap.get("htdlName")+"\",\"startTm\":\""+dtoMap.get("startTm")+"\",\"endTm\":\""+dtoMap.get("endTm")+"\",\"lmtPnum\":\""+dtoMap.get("lmtPnum")+"\"}}");
					
						log.info("send message ========================");
						log.info("tmpMsg : " + tmpMsg);
						log.info("dto : " + dtoMap);
						
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
		
	}

	// connection이 close되었을 때,
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed : " + session + ":" + status);
		
		String senderId = getId(session);
		sessions.remove(session);
		userSessions.remove(senderId);
	}
	
	
	// 위의 3가지 메서드가 기본적으로 필요하다.
	
}
