package com.dealight.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.google.gson.Gson;

public class JSONTest {

	@Test
	public void json() throws UnsupportedEncodingException {
		
		Map<String, Object> map = new HashMap<>();

		map.put("object_type", "feed");
		
		Map<String, Object> content = new HashMap<>();
		
		content.put("title", "디저트 사진");
		content.put("description","아메리카노, 빵, 케익");
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
		
		button1.put("title", "웹으로 이동");
		
		Map<String, Object> link2 = new HashMap<>();
		
		link2.put("web_url", "http://www.daum.net");
		link2.put("mobile_web_url", "http://m.daum.net");
		
		button1.put("link", link2);
		
		buttons.add(button1);
		
		Map<String, Object> button2 = new HashMap<>();
		
		button2.put("title", "앱으로 이동");
		
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
		
	}
	
}
