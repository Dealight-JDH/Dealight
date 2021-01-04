package com.dealight.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.RestTemplateResponseErrorHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인]
 *
 * 카카오 메시지 보내기
 * 
 * 1. Oauth
 * 2. token
 * 3. 내 profile 가져오기
 * 4. 친구 목록 가져오기
 * 5. 친구 동의 받기
 * 6. 메시지 보내기
 * 
 */

@Service
@Log4j
public class CallServiceImpl implements CallService {
	
	@Autowired
	StoreService storeService;     
	
	//public static final String URL = "http://3.34.175.123:8181";
	public static final String URL = "http://localhost:8181";
	
	// 사용자 인가를 가져온다.
	@Override
	public String getAuth() {
		
		RestTemplate restTemplate = new RestTemplate();	
		
		String url = "https://kauth.kakao.com/oauth/authorize?client_id=dba6ebc24e85989c7afde75bd48c5746&redirect_uri="+URL+"/business/manage&response_type=code";
		
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(url).build();
		
		String strResult = restTemplate.getForObject(url, String.class);

       return strResult;

	}

	// 토큰을 가져온다.
	@Override
	public HashMap<String, Object> getToken(String code) {
		
		log.info("get token.................");
		
		log.info("code......................."+code);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 String restKey = "dba6ebc24e85989c7afde75bd48c5746";
		 String redirectURI = URL+"/dealight/business/";
		 
		 try {
		
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		HttpHeaders header = new HttpHeaders();
		
		header.setContentType(MediaType.APPLICATION_JSON);
		
		String url = "https://kauth.kakao.com/oauth/token";
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.queryParam("grant_type", "authorization_code")
				.queryParam("client_id", restKey)
				.queryParam("redirect_uri", redirectURI)
				.queryParam("code", code)
				.build();
				
		log.info(uri.toString());
		
		ResponseEntity<Map> resultMap = restTemplate.postForEntity(uri.toString(), header, Map.class);
		
		log.info(resultMap);
		
		result.put("statusCode", resultMap.getStatusCodeValue()); //http status code?? ???
       result.put("header", resultMap.getHeaders()); //??? ???? ???
       result.put("body", resultMap.getBody()); //???? ?????? ???? ???
		
       ObjectMapper mapper = new ObjectMapper();
       jsonInString = mapper.writeValueAsString(resultMap.getBody());
       
		} catch (Exception e) {
           result.put("statusCode", "999");
           result.put("body"  , "excpetion????");
           System.out.println(e.toString());
       }

       return result;
	}
	
	// '나에게' 메시지를 보낸다.
	public String sendMessage(String access_token, String title, String description, String web_url) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
		
		// 1. RestTemplat 생성
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		// 2. 헤더 생성
		HttpHeaders header = new HttpHeaders();
		
		// 2-1. content-type 설정
		//header.setContentType(MediaType.APPLICATION_JSON);
		header.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		//header.set("Content-Type","application/x-www-form-urlencoded; charset=utf-8");
		
		// 2-2. accept 설정
		header.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		
		// 2-3. Authorization 설정
		String authHeader = "Bearer " + access_token;
		
		header.set("Authorization", authHeader);
		
		// 3.메시지를 담을 객체 생성(HashMap으로 작성)
		Map<String, Object> map = new HashMap<>();

		map.put("object_type", "feed");
		
		Map<String, Object> content = new HashMap<>();
		
		content.put("title", title);
		content.put("description",description);
		content.put("image_url", "http://dh.aks.ac.kr/Edu/wiki/images/9/91/%ED%8C%A8%ED%8A%B8%EC%99%80.jpg");
		content.put("image_width", "640");
		content.put("image_height","640");
		
		Map<String, Object> link = new HashMap<>();
		
		link.put("web_url", web_url);
		link.put("mobile_web_url", web_url);
		link.put("android_execution_params", "contentId=100");
		link.put("ios_execution_params", "contentId=100");
		
		content.put("link", link);
		
		map.put("content", content);
		
		Map<String, Object> social = new HashMap<>();
		
		social.put("like_count", "100");
		social.put("comment_count", "200");
		social.put("shared_count", "300");
		social.put("view_count", "400");
		social.put("subscriber_count", "500");
		
		map.put("social", social);
		
		List<Map> buttons = new ArrayList();
		
		Map<String, Object> button1 = new HashMap<>();
		
		button1.put("title", "웹으로 보기");
		
		Map<String, Object> link2 = new HashMap<>();
		
		link2.put("web_url", web_url);
		link2.put("mobile_web_url", web_url);
		
		button1.put("link", link2);
		
		buttons.add(button1);
		
		Map<String, Object> button2 = new HashMap<>();
		
		button2.put("title", "앱으로 보기");
		
		Map<String, Object> link3 = new HashMap<>();
		
		link3.put("android_execution_params", "contentId=100");
		link3.put("ios_execution_params", "contentId=100");
		
		button2.put("link", link3);
		
		buttons.add(button2);
		
		map.put("buttons", buttons);
		
		// 3-1. 작성한 객체를 Json String타입으로 변환
		Gson gson = new Gson();
		
		String requestJson =  gson.toJson(map);
		
		// 4. Request Entity를 생성
        HttpEntity<String> entity = new HttpEntity<>(requestJson,header);
	
		String url = "https://kapi.kakao.com/v2/api/talk/memo/default/send";
		
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.queryParam("template_object", requestJson)
				.build();
		
		RequestEntity<String> rq = new RequestEntity<>(header, HttpMethod.POST, uri.toUri());
		
		ResponseEntity<Map> resultMap = restTemplate.exchange(rq,  Map.class);
		
		//ResponseEntity<Map> resultMap = restTemplate.postForEntity(uri.toUri(), header, Map.class);
		
		result.put("statusCode", resultMap.getStatusCodeValue());
        result.put("header", resultMap.getHeaders());
        result.put("body", resultMap.getBody());
		
        ObjectMapper mapper = new ObjectMapper();
        jsonInString = mapper.writeValueAsString(resultMap.getBody());
        
		} catch (Exception e) {
            result.put("statusCode", "999");
            result.put("body"  , "excpetion????");
            System.out.println(e.toString());
        }
 
        return jsonInString;
	}

	// 사용자 정보를 가져온다.
	@Override
	public HashMap<String, Object> getProfile(String access_token) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
		
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		String authHeader = "Bearer " + access_token;
		
		header.set("Authorization", authHeader);
		
		String url = "https://kapi.kakao.com/v2/user/me";
		
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.build();
		
		HttpEntity entity = new HttpEntity(header);
		
		ResponseEntity<Map> resultMap= restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
		
		result.put("statusCode", resultMap.getStatusCodeValue());
        result.put("header", resultMap.getHeaders());
        result.put("body", resultMap.getBody());
		
        ObjectMapper mapper = new ObjectMapper();
        jsonInString = mapper.writeValueAsString(resultMap.getBody());
        
		} catch (Exception e) {
            result.put("statusCode", "999");
            result.put("body"  , "excpetion????");
            System.out.println(e.toString());
        }
 
        return result;
	}
	
	// 사용자 리스트를 가져온다.
	@Override
	public HashMap<String, Object> getUsersList() {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
		
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		String authHeader = "KakaoAK " + "047b1c1dfc9d0565ff6e8c3866f30429";
		
		header.set("Authorization", authHeader);
		
		String url = "https://kapi.kakao.com/v1/user/ids";
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.build();
		
		HttpEntity entity = new HttpEntity(header);
		
		ResponseEntity<Map> resultMap= restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
		
		result.put("statusCode", resultMap.getStatusCodeValue()); 
       result.put("header", resultMap.getHeaders());
       result.put("body", resultMap.getBody()); 
		
       ObjectMapper mapper = new ObjectMapper();
       jsonInString = mapper.writeValueAsString(resultMap.getBody());
       
		} catch (Exception e) {
           result.put("statusCode", "999");
           result.put("body"  , "excpetion????");
           System.out.println(e.toString());
       }

       return result;
	}
	
	@Override
	public int callAllList(List<WaitVO> curStoreWaitList) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public boolean call(long waitingId) {
		// TODO Auto-generated method stub
		return false;
	}

	// 카카오톡 프로필 가져오기
	@Override
	public HashMap<String, Object> getTalkProfile(String access_token) {

		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
		
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		String authHeader = "Bearer " + access_token;
		
		header.set("Authorization", authHeader);
		
		String url = "https://kapi.kakao.com/v1/api/talk/profile";
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.build();
		
		HttpEntity entity = new HttpEntity(header);
		
		ResponseEntity<Map> resultMap= restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
		
		result.put("statusCode", resultMap.getStatusCodeValue()); 
      result.put("header", resultMap.getHeaders());
      result.put("body", resultMap.getBody()); 
		
      ObjectMapper mapper = new ObjectMapper();
      jsonInString = mapper.writeValueAsString(resultMap.getBody());
      
		} catch (Exception e) {
          result.put("statusCode", "999");
          result.put("body"  , "excpetion????");
          System.out.println(e.toString());
      }

      return result;
	}
	
	// 동의 가져오기
	@Override
	public HashMap<String, Object> getAllow() {
		log.info("get allow.................");
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 String restKey = "dba6ebc24e85989c7afde75bd48c5746";
		 String redirectURI = URL+"/business/manage";
		 
		 try {
		
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		HttpHeaders header = new HttpHeaders();
		
		header.setContentType(MediaType.APPLICATION_JSON);
		
		String url = "https://kauth.kakao.com/oauth/token/authorize";
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.queryParam("response_type", "code")
				.queryParam("client_id", restKey)
				.queryParam("redirect_uri", redirectURI)
				.queryParam("scope", "friends")
				.build();
				
		log.info(uri.toString());
		
		HttpEntity entity = new HttpEntity(header);
		
		ResponseEntity<Map> resultMap= restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
		
		log.info(resultMap);
		
		result.put("statusCode", resultMap.getStatusCodeValue());
       result.put("header", resultMap.getHeaders()); 
       result.put("body", resultMap.getBody());
		
       ObjectMapper mapper = new ObjectMapper();
       jsonInString = mapper.writeValueAsString(resultMap.getBody());
       
		} catch (Exception e) {
           result.put("statusCode", "999");
           result.put("body"  , "excpetion????");
           System.out.println(e.toString());
       }

       return result;
	}

	
	// 진짜 친구 가져오려면 권한 요청 필요
	// 그 전에는 애플리케이션 팀 멤버만 가능
	@Override
	public HashMap<String, Object> getTalkFriendsList(String access_token) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
		
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		String authHeader = "Bearer " + access_token;
		
		header.set("Authorization", authHeader);
		
		String url = "https://kapi.kakao.com/v1/api/talk/friends";
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.build();
		
		HttpEntity entity = new HttpEntity(header);
		
		ResponseEntity<Map> resultMap= restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
		
		result.put("statusCode", resultMap.getStatusCodeValue()); 
     result.put("header", resultMap.getHeaders());
     result.put("body", resultMap.getBody()); 
		
     ObjectMapper mapper = new ObjectMapper();
     jsonInString = mapper.writeValueAsString(resultMap.getBody());
     
		} catch (Exception e) {
         result.put("statusCode", "999");
         result.put("body"  , "excpetion????");
         System.out.println(e.toString());
     }

     return result;
	}

	// 친구한테 메시지 보내기
	@Override
	public String sendFrMessage(String access_token, String title, String description, String web_url, String uuid,Long storeId) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
			 
			 log.info("title : "+title);
			 log.info("access_token : "+access_token);
			 log.info("description : "+description);
			 web_url = URL + web_url;
			 
			 log.info("web_url : "+web_url);
			 log.info("uuid : "+uuid);
		
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		
		header.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		
		String authHeader = "Bearer " + access_token;
		
		header.set("Authorization", authHeader);
		
		Map<String, Object> map = new HashMap<>();

		map.put("object_type", "feed");
		
		Map<String, Object> content = new HashMap<>();
		
		content.put("title", title);
		content.put("description",description);
		content.put("image_url", "https://i.esdrop.com/d/NfpcDPJkbX.png");
		content.put("image_width", "640");
		content.put("image_height","640");
		
		Map<String, Object> link = new HashMap<>();
		
		link.put("web_url", web_url);
		link.put("mobile_web_url", web_url);
		link.put("android_execution_params", "contentId=100");
		link.put("ios_execution_params", "contentId=100");
		
		content.put("link", link);
		
		map.put("content", content);
		
		Map<String, Object> social = new HashMap<>();
		
		StoreEvalVO eval = storeService.getEval(storeId);
		
		social.put("like_count", eval.getLikeTotNum());
		social.put("comment_count", eval.getRevwTotNum());
		//social.put("shared_count", "300");
		//social.put("view_count", "400");
		//social.put("subscriber_count", "500");
		
		map.put("social", social);
		
		List<Map> buttons = new ArrayList();
		
		Map<String, Object> button1 = new HashMap<>();
		
		button1.put("title", "웹으로 보기");
		
		Map<String, Object> link2 = new HashMap<>();
		
		link2.put("web_url", web_url);
		link2.put("mobile_web_url", web_url);
		
		button1.put("link", link2);
		
		buttons.add(button1);
		
		Map<String, Object> button2 = new HashMap<>();
		
		button2.put("title", "앱으로 보기");
		
		Map<String, Object> link3 = new HashMap<>();
		
		link3.put("android_execution_params", "contentId=100");
		link3.put("ios_execution_params", "contentId=100");
		
		button2.put("link", link3);
		
		buttons.add(button2);
		
		map.put("buttons", buttons);
		
		Gson gson = new Gson();
		
		String requestJson =  gson.toJson(map);
		
       HttpEntity<String> entity = new HttpEntity<>(requestJson,header);
	
		String url = "https://kapi.kakao.com/v1/api/talk/friends/message/default/send";
		
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.queryParam("receiver_uuids", "[\""+uuid+"\"]")
				.queryParam("template_object", requestJson)
				.build();
		
		RequestEntity<String> rq = new RequestEntity<>(header, HttpMethod.POST, uri.toUri());
		
		ResponseEntity<Map> resultMap = restTemplate.exchange(rq,  Map.class);
		
		result.put("statusCode", resultMap.getStatusCodeValue()); 
       result.put("header", resultMap.getHeaders()); 
       result.put("body", resultMap.getBody()); 
		
       ObjectMapper mapper = new ObjectMapper();
       jsonInString = mapper.writeValueAsString(resultMap.getBody());
       
		} catch (Exception e) {
           result.put("statusCode", "999");
           result.put("body"  , "excpetion????");
           System.out.println(e.toString());
       }

       return jsonInString;
	}

	
	
}
