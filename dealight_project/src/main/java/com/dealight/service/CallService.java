package com.dealight.service;

import java.util.HashMap;
import java.util.List;

import com.dealight.domain.WaitVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface CallService {

	// 카카오 api의 인가코드를 받는다.
	String getAuth();
	
	// 액세스 토큰을 발급 받는다.
	HashMap<String, Object> getToken(String code);
	
	// User Profile을 받는다.
	HashMap<String, Object> getProfile(String access_token);
	
	// User Profile List를 받는다.
	HashMap<String, Object> getUsersList();
	
	// 카카오톡 프로필을 받는다.
	HashMap<String, Object> getTalkProfile(String access_token);
	
	// 카카오 친구 리스트를 받는다.
	HashMap<String, Object> getTalkFriendsList(String access_token);
	
	// 사용자에게 3자 동의를 받는다.
	HashMap<String, Object> getAllow();
	
	// 본인에게 메시지를 보낸다.
	String sendMessage(String access_token, String title, String description, String web_url);
	
	// 친구에게 메시지를 보낸다.
	String sendFrMessage(String access_token, String title, String description, String web_url,String uuid,Long storeId);
	
	
	// 미구현
	boolean call(long waitingId);
	
	int callAllList(List<WaitVO> curStoreWaitList);

}
