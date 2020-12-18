package com.dealight.json;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.dealight.domain.SugRequestDTO;
import com.dealight.handler.RestTemplateResponseErrorHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;

import lombok.extern.log4j.Log4j;

@Log4j
public class JSONTest {

	@Test
	public void callMessageJson() throws UnsupportedEncodingException {
		
		Map<String, Object> map = new HashMap<>();

		map.put("object_type", "feed");
		
		Map<String, Object> content = new HashMap<>();
		
		content.put("title", "����Ʈ ����");
		content.put("description","�Ƹ޸�ī��, ��, ����");
		content.put("image_url", "http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg");
		content.put("image_width", 640);
		content.put("image_height",640);
		
		Map<String, Object> link = new HashMap<>();
		
		link.put("web_url", "http://www.daum.net");
		link.put("mobile_web_url", "http://m.daum.net");
		link.put("android_execution_params", "contentId=100");
		link.put("ios_execution_params", "contentId=100");
		
		content.put("link", link);
		
		map.put("content", content);
		
		Map<String, Object> social = new HashMap<>();
		
		social.put("like_count", 100);
		social.put("comment_count", 200);
		social.put("shared_count", 300);
		social.put("view_count", 400);
		social.put("subscriber_count", 500);
		
		map.put("social", social);
		
		List<Map> buttons = new ArrayList();
		
		Map<String, Object> button1 = new HashMap<>();
		
		button1.put("title", "������ �̵�");
		
		Map<String, Object> link2 = new HashMap<>();
		
		link2.put("web_url", "http://www.daum.net");
		link2.put("mobile_web_url", "http://m.daum.net");
		
		button1.put("link", link2);
		
		buttons.add(button1);
		
		Map<String, Object> button2 = new HashMap<>();
		
		button2.put("title", "������ �̵�");
		
		Map<String, Object> link3 = new HashMap<>();
		
		link3.put("android_execution_params", "contentId=100");
		link3.put("ios_execution_params", "contentId=100");
		
		button2.put("link", link3);
		
		buttons.add(button2);
		
		map.put("buttons", buttons);
		
		System.out.println(map);
		
		Gson gson = new Gson();
		String result =  gson.toJson(map);
		
		System.out.println(result);
		
		String url = "https://kapi.kakao.com/v2/api/talk/memo/default/send";

		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.queryParam("template_object", result)
				.build();
		
		
		System.out.println(uri.toString());
		System.out.println(uri.toUri());

		url = url +"?template_object="+ URLEncoder.encode(result, StandardCharsets.UTF_8.toString());
		System.out.println(url);
		System.out.println(MediaType.APPLICATION_JSON_UTF8_VALUE);
		
	}
	
	
	@Test
	public void resttest1() throws UnsupportedEncodingException {
		
		String access_token = "7uQ7kIOqzz1A7n48_ITNflvoWnEp9xQVX1CoeQopcBQAAAF16AQ6Mg";
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
		
		// 1. RestTemplat ????
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		// 2. ????? ????????.
		HttpHeaders header = new HttpHeaders();
		
		// 2-1. content-type?? ????????.
		//header.setContentType(MediaType.APPLICATION_JSON);
		header.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		//header.set("Content-Type","application/x-www-form-urlencoded; charset=utf-8");
		
		// 2-2. accept ????? ????????.
		header.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		
		// 2-3. Authorization ?? ?????????.
		String authHeader = "Bearer " + access_token;
		
		header.set("Authorization", authHeader);
		
		// 3. request body parameter?? ???????.
		
		// 3-1. json?? ???¸? ???? map?? ????????.
		//String requestJson = "template_object={\"object_type\":\"feed\",\"content\":{\"title\":\"????? ????\",\"description\": \"???????, ??, ????\",\"image_url\":\"http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg\",\"image_width\":640,\"image_height\": 640,\"link\":{\"web_url\": \"http://www.daum.net\",\"mobile_web_url\": \"http://m.daum.net\",\"android_execution_params\": \"contentId=100\",\"ios_execution_params\": \"contentId=100\"}},\"social\": {\"like_count\": 100,\"comment_count\": 200,\"shared_count\": 300,\"view_count\": 400,\"subscriber_count\": 500},\"buttons\": [{\"title\": \"?????? ???\",\"link\": {\"web_url\": \"http://www.daum.net\",\"mobile_web_url\": \"http://m.daum.net\"}},{\"title\": \"?????? ???\",\"link\": {\"android_execution_params\": \"contentId=100\",\"ios_execution_params\": \"contentId=100\"}}]}";
		
		
		Map<String, Object> map = new HashMap<>();

		map.put("object_type", "feed");
		
		Map<String, Object> content = new HashMap<>();
		
		content.put("title", "????? ????");
		content.put("description","???????, ??, ????");
		content.put("image_url", "http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg");
		content.put("image_width", "640");
		content.put("image_height","640");
		
		Map<String, Object> link = new HashMap<>();
		
		link.put("web_url", "http://www.daum.net");
		link.put("mobile_web_url", "http://m.daum.net");
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
		
		button1.put("title", "?????? ???");
		
		Map<String, Object> link2 = new HashMap<>();
		
		link2.put("web_url", "http://www.daum.net");
		link2.put("mobile_web_url", "http://m.daum.net");
		
		button1.put("link", link2);
		
		buttons.add(button1);
		
		Map<String, Object> button2 = new HashMap<>();
		
		button2.put("title", "?????? ???");
		
		Map<String, Object> link3 = new HashMap<>();
		
		link3.put("android_execution_params", "contentId=100");
		link3.put("ios_execution_params", "contentId=100");
		
		button2.put("link", link3);
		
		buttons.add(button2);
		
		map.put("buttons", buttons);
		
		Gson gson = new Gson();
		
		String requestJson =  gson.toJson(map);
		
		// 4. map?? header?? ????????.
       HttpEntity<String> entity = new HttpEntity<>(requestJson,header);
	
		String url = "https://kapi.kakao.com/v2/api/talk/memo/default/send";
    	   //String url = "https://httpbin.org/post";
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.queryParam("template_object", requestJson)
				.build();
		
		RequestEntity<String> rq = new RequestEntity<>(header, HttpMethod.POST, uri.toUri());
		
		ResponseEntity<Map> resultMap = restTemplate.exchange(rq,  Map.class); 
		
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
		 
		 log.info(jsonInString);

	
	}
	
	@Test
	public void webSocketJsonTest2() {
		
		Gson gson = new Gson();
		
		Map<String,Object> map = new HashMap<>();
		
		map.put("cmd", "wait");
		map.put("sendUser","kjuioq");
		map.put("storeId",123);
		map.put("waitId",100);
		
		String result = gson.toJson(map);
		
		log.info("result...................... : "+result);
		
	}
	
	@Test
	public void receiveMessageJsonTest() {
		
		String text = "{\"sendUser\":\"kjuioq\",\"waitId\":\"100\",\"cmd\":\"wait\",\"storeId\":\"123\"}";
		
		log.info(text);
		
		Gson gson = new Gson();
		
		HashMap<String,Object> map = gson.fromJson(text, HashMap.class);
		
		log.info(map);
		log.info(map.size());
		
		String result = gson.toJson(map);
		
		log.info(result);
		
	}
	
	@Test
	public void depthJsonReceivceTest1() {
		
		SugRequestDTO dto = new SugRequestDTO();
		
		dto.setStoreId(1L);
		dto.setLmtPnum(30);
		dto.setStartTm("13:00");
		dto.setEndTm("14:00");
		dto.setHtdlName("안녕?");
		
		TextMessage message = new TextMessage("{\"sendUser\":\"-1\",\"htdlId\":\"-1\",\"cmd\":\"htdl\",\"storeId\":\""+dto.getStoreId()+"\",\"htdlDto\":{\"htdlName\":\""+dto.getHtdlName()+"\",\"startTm\":\""+dto.getStartTm()+"\",\"endTm\":\""+dto.getEndTm()+"\",\"lmtPnum\":\""+dto.getLmtPnum()+"\"}}");
		
		String jsonStr = message.getPayload();
		
		log.info("json str : "+ jsonStr);
		
		Gson gson = new Gson();
		
		HashMap<String,Object> map = gson.fromJson(jsonStr, HashMap.class);
		
		log.info("map : "+map);
		
		log.info("dto type : "+map.get("htdlDto").getClass());
		Map<String,String> dtoMap = (LinkedTreeMap<String, String>) map.get("htdlDto");
				
		log.info("htdl name id : "+dtoMap.get("htdlName"));
	}
}
