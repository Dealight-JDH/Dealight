package com.dealight.sns;

import java.net.URI;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class KakaoLoginService {

	private static final String HOST = "https://kapi.kakao.com";
	private static final String AUTH_URL = "https://kauth.kakao.com/oauth/authorize";
	private static final String TOKEN_URL = "https://kauth.kakao.com/oauth/token";
	private static final String RESTAPIKEY = "40f9415c7987e838d4df2df5dfbb7183";
	private static final String REDIRECTURI = "http://localhost:8181/oauth";
	
	//카카오 인가 요청
	public String getAuthorizationBaseUrl() {

		return AUTH_URL+"?client_id="+RESTAPIKEY+"&redirect_uri="+REDIRECTURI+"&response_type=code";
	}
	
	// 카카오 로그인 access_token 리턴
    public String getAccessToken(String code) throws Exception {

    		String accessToken = "";

        	RestTemplate restTemplate = new RestTemplate();
        	
        	HttpHeaders headers = new HttpHeaders();
        	
        	MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
        	parameters.set("grant_type", "authorization_code");
        	parameters.set("client_id", RESTAPIKEY);
        	parameters.set("redirect_uri", REDIRECTURI);
        	parameters.set("code", code);
        	
        	HttpEntity<MultiValueMap<String, String>> restRequest = new HttpEntity<>(parameters, headers);
        	try {
        		
        		ResponseEntity<JSONObject> apiResponse = restTemplate.postForEntity(new URI(TOKEN_URL), restRequest, JSONObject.class);
        		JSONObject responseBody = apiResponse.getBody();
        		accessToken = String.valueOf(responseBody.get("access_token"));
        	}catch(Exception e) {
        		e.printStackTrace();
        	}
        
        return accessToken;
    }
    
    //카카오 사용자 정보
    public JSONObject getKakaoUserInfo(String token) {
    	
    	RestTemplate restTemplate = new RestTemplate();
    	HttpHeaders headers = new HttpHeaders();
    	
    	headers.add("Authorization", "bearer " + token);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+";charset=UTF-8");
        
        HttpEntity<?> restRequest = new HttpEntity<>(headers);
        try {
        	
        	JSONObject apiResult = restTemplate.exchange(new URI(HOST+"/v2/user/me"), HttpMethod.GET, restRequest, JSONObject.class).getBody();
        	return apiResult;
        	//log.info("========json Object : " + apiResult.toString());
        	//return restTemplate.exchange(new URI(HOST+"/v2/user/me"), HttpMethod.GET, restRequest, KakaoUser.class).getBody();
//        	log.info("user info: " + userJson);
//        	return userJson;
        }catch(Exception e) {
        	e.printStackTrace();
        }
    	return null;
    }
}
