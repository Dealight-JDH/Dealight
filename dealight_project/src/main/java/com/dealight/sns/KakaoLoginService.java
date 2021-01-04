package com.dealight.sns;

import java.net.URI;
import java.util.Date;

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

import com.dealight.domain.SnsVO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class KakaoLoginService {

	private static final String HOST = "https://kapi.kakao.com";
	private static final String AUTH_URL = "https://kauth.kakao.com/oauth/authorize";
	private static final String TOKEN_URL = "https://kauth.kakao.com/oauth/token";
	private static final String RESTAPIKEY = "40f9415c7987e838d4df2df5dfbb7183";
	private static final String REDIRECTURI = "http://localhost:8181/kakao/oauth";
	//private static final String REDIRECTURI = "http://3.34.175.123:8181/kakao/oauth";
	
	
	//카카오 vo
	public SnsVO getKakaoVO(JSONObject response) {
		
		String id = String.valueOf(response.get("id"));
 	    JSONObject kakaoAccount = (JSONObject)response.get("kakao_account");
		JSONObject profile = (JSONObject)kakaoAccount.get("profile");
		String nickName = String.valueOf(profile.get("nickname"));
		String profileImg = String.valueOf(profile.get("profile_image"));
		String email = String.valueOf(kakaoAccount.get("email"));
		String age = String.valueOf(kakaoAccount.get("age_range"));
		String gender = String.valueOf(kakaoAccount.get("gender"));
		String phoneNumber = String.valueOf(kakaoAccount.get("phone_number"));
		String birthday = String.valueOf(kakaoAccount.get("birthday"));
		
		
		SnsVO kakaoVO = SnsVO.builder()
							.userId(email)
							.id(id)
							.nickName(nickName)
							.profileImg(profileImg)
							.age(age).gender(gender)
							.phoneNumber(phoneNumber)
							.birthday(birthday)
							.build();
		
		log.info("========kakao info" + nickName+ ", " + profileImg+", "+email);
		log.info("======================" + kakaoAccount.toJSONString());
		
		return kakaoVO;
	}
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
    public String getKakaoUserInfo(String token) {
    	
    	RestTemplate restTemplate = new RestTemplate();
    	HttpHeaders headers = new HttpHeaders();
    	
    	headers.add("Authorization", "bearer " + token);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE+";charset=UTF-8");
        
        HttpEntity<?> restRequest = new HttpEntity<>(headers);
        try {
        	
        	JSONObject apiResult = restTemplate.exchange(new URI(HOST+"/v2/user/me"), HttpMethod.GET, restRequest, JSONObject.class).getBody();
        	return apiResult.toJSONString();	
        	//log.info("========json Object : " + apiResult.toString());
        	//return restTemplate.exchange(new URI(HOST+"/v2/user/me"), HttpMethod.GET, restRequest, KakaoUser.class).getBody();
//        	log.info("user info: " + userJson);
//        	return userJson;
        }catch(Exception e) {
        	e.printStackTrace();
        }
    	return "";
    }
}
