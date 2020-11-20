package com.dealight.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.dealight.domain.WaitVO;
import com.dealight.handler.RestTemplateResponseErrorHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CallServiceImpl implements CallService {
	
	/*
	 * īī�� �޽��� API�� REST API ����� ������ ������ ����ȴ�. 
	 * 
	 * 0. īī�� �����ڿ� ������ �� �� REST API KEY, redirect URI�� �����Ѵ�.
	 * 1. �ΰ� �ڵ带 �޾ƾ� �Ѵ�. GET ������� REST API key�� redirect URI�� ���� code�� �޾ƿ���.
	 * 1-1. **��ũ�� ���� ��������.
	 * 1-2. localhost:8080/oauth�� ���� a��ũ�� ����.
	 * 1-3. �׷��� �޾ƿ� url�� code�� ��������
	 * 1-4. **�ΰ��ڵ�� ������ ������ ������ ��ȿ�ϴ�. ������ �����ϸ� �ٽ� �߱޹޾ƾ� �Ѵ�.
	 * 2. �ΰ� �ڵ带 ���� �׼��� ��ū�� �߱޹޾ƾ� �Ѵ�.
	 * 2-1. code�� get ��� (/token?code={})���� �ѱ���
	 * 2-2. POST Ÿ���� ��� ���� ��Ʈ���� Ȱ���ϴ°��� ���Ҽ� �ִ�.
	 * 2-3. https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id={RESTŰ}&redirect_uri={�����̷�Ʈ URI}&code={�ڵ�}
	 * 2-4. JSONŸ������ access_token�� ��ȯ���� �� �ִ�.
	 * 3. ������ ��ū�� Ȱ���ؼ� �޽����� �ִ´�.
	 * 3-1. ��ū�� get ������� uri
	 * 3-2. https://kapi.kakao.com/v2/api/talk/memo/default/send?template_object={�޽��� JSON}
	 * 3-3. ����� Authorization : Bearer + access_token
	 * 3-4. 200 ok�� ������ �޽��� ���޵� ��
	 * 
	 * 
	 * ������
	 * 
	 * > oauth�� �ڵ����� �޾Ƽ� ������ �� �ִ� ����� ã�ƺ���. -> �ϴ� URI�� Ȯ���ϰ� �ڵ带 ���� �Է��ؼ� ��ū �޴� ���
	 * > �׼��� ��ū�� �޾� �����ϴ� ��� -> POST�� json�� ������ JSON���� ��ū�� �޴´�. 
	 * > �޽����� �߼��ϴ� ����� ã�ƺ���. -> ��ū�� �Բ� �޽��� ������ ������ �����. JSON���� ������ ����� ã�ƺ���.
	 * > �޽����� �ۼ��ؼ� �߼��غ��� -> TEST
	 * -- ������ �޽��� ������ �Ϸ�
	 * > ������ �������� -> ������ ����
	 * > ģ�� ��� �������� api -> ģ�� ��� ����
	 * > ģ������ �޽��� ������ -> �޽��������� ����
	 * > �Ϸ�!
	 * 
	 * ***����� HTTP method ������ ���� https�� �����ߴ��� Ȯ������. http�� �����ؾ��Ѵ�.
	 * 
	 * 
	 * 
	 */
	
	
	@Override
	public String getAuth() {
		
		
		
		// 1. RestTemplat ����
		RestTemplate restTemplate = new RestTemplate();	
		
		String url = "https://kauth.kakao.com/oauth/authorize?client_id=dba6ebc24e85989c7afde75bd48c5746&redirect_uri=https://localhost:8080/oauth&response_type=code";
		
		UriComponents uri = UriComponentsBuilder.fromHttpUrl(url).build();
		
		// ��ũ�� ���� �޾ƿ��� ��
		// ���� �ڵ� O67g7f5UQRDFIrAfiMwe3mxQTgX1_905Safvjt2_WSbjfqL4v3hflGR9xLGMQSkAS4_W5wo9dVoAAAF11gJ1Kw
		
		// �� ������ �ڵ�� API�� ȣ���Ͽ� MAPŸ������ ���޹޴´�.
		String strResult = restTemplate.getForObject(url, String.class);

       return strResult;

	}

	@Override
	public HashMap<String, Object> getToken(String code) {
		
		log.info("get token.................");
		
		log.info("code......................."+code);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 String restKey = "dba6ebc24e85989c7afde75bd48c5746";
		 String redirectURI = "http://localhost:8080/oauth";
		 
		 try {
		
		// 1. RestTemplat ����
		RestTemplate restTemplate = new RestTemplate();	
		
		// 1-1. error �ڵ鷯�� ������ش�.
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		
		// 2. ����� ������ش�.
		HttpHeaders header = new HttpHeaders();
		
		// 2-1. content-type�� ������ش�.
		header.setContentType(MediaType.APPLICATION_JSON);
		
		// 3. request body parameter�� �����Ѵ�.
		
		// 3-1. json�� ���¸� ���� map�� ������ش�.
		// *****************��ū�� ���� ���� ���� ��Ʈ������ �־��.
//		Map<String, Object> map = new HashMap<>();
//
//		map.put("grant_type", "authorization_code");
//		map.put("client_id", "dba6ebc24e85989c7afde75bd48c5746");
//		map.put("redirect_uri", "http://localhost:8080");
//		map.put("code", "O67g7f5UQRDFIrAfiMwe3mxQTgX1_905Safvjt2_WSbjfqL4v3hflGR9xLGMQSkAS4_W5wo9dVoAAAF11gJ1Kw");
		
		// 4. map�� header�� �߰����ش�.
//       HttpEntity<Map<String, Object>> entity = new HttpEntity<>(map,header);
	
		String url = "https://kauth.kakao.com/oauth/token";
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				.queryParam("grant_type", "authorization_code")
				.queryParam("client_id", restKey)
				.queryParam("redirect_uri", redirectURI)
				.queryParam("code", code)
				.build();
				
		log.info(uri.toString());
		
		// �� ������ �ڵ�� API�� ȣ���Ͽ� MAPŸ������ ���޹޴´�.
		ResponseEntity<Map> resultMap = restTemplate.postForEntity(uri.toString(), header, Map.class);
		
		
		
		log.info(resultMap);
		
		
		result.put("statusCode", resultMap.getStatusCodeValue()); //http status code�� Ȯ��
       result.put("header", resultMap.getHeaders()); //��� ���� Ȯ��
       result.put("body", resultMap.getBody()); //���� ������ ���� Ȯ��
		
       //�����͸� ����� ���� �޾Ҵ��� Ȯ�� string���·� �Ľ�����
       ObjectMapper mapper = new ObjectMapper();
       jsonInString = mapper.writeValueAsString(resultMap.getBody());
       
		} catch (Exception e) {
           result.put("statusCode", "999");
           result.put("body"  , "excpetion����");
           System.out.println(e.toString());
       }

       return result;
	}
	
public String sendMessage(String access_token) {
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		 String jsonInString = "";
		 try {
		
		// 1. RestTemplat ����
		RestTemplate restTemplate = new RestTemplate();	
		
		RestTemplateResponseErrorHandler errorHandler = new RestTemplateResponseErrorHandler();
		
		restTemplate.setErrorHandler(errorHandler);
		
		// 2. ����� ������ش�.
		HttpHeaders header = new HttpHeaders();
		
		// 2-1. content-type�� ������ش�.
		header.setContentType(MediaType.APPLICATION_JSON);
		
		// 2-2. accept ����� ������ش�.
	//	header.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		
		// 2-3. Authorization �� �������ش�.
		String authHeader = "Bearer " + access_token;
		
		header.set("Authorization", authHeader);
		
		// 3. request body parameter�� �����Ѵ�.
		
		// 3-1. json�� ���¸� ���� map�� ������ش�.
		//String requestJson = "template_object={\"object_type\":\"feed\",\"content\":{\"title\":\"����Ʈ ����\",\"description\": \"�Ƹ޸�ī��, ��, ����\",\"image_url\":\"http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg\",\"image_width\":640,\"image_height\": 640,\"link\":{\"web_url\": \"http://www.daum.net\",\"mobile_web_url\": \"http://m.daum.net\",\"android_execution_params\": \"contentId=100\",\"ios_execution_params\": \"contentId=100\"}},\"social\": {\"like_count\": 100,\"comment_count\": 200,\"shared_count\": 300,\"view_count\": 400,\"subscriber_count\": 500},\"buttons\": [{\"title\": \"������ �̵�\",\"link\": {\"web_url\": \"http://www.daum.net\",\"mobile_web_url\": \"http://m.daum.net\"}},{\"title\": \"������ �̵�\",\"link\": {\"android_execution_params\": \"contentId=100\",\"ios_execution_params\": \"contentId=100\"}}]}";
		
		
		Map<String, Object> map = new HashMap<>();

		map.put("object_type", "feed");
		
		Map<String, Object> content = new HashMap<>();
		
		content.put("title", "����Ʈ ����");
		content.put("description","�Ƹ޸�ī��, ��, ����");
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
		
		Gson gson = new Gson();
		
		String requestJson =  gson.toJson(map);
		
		// 4. map�� header�� �߰����ش�.
        HttpEntity<String> entity = new HttpEntity<>(requestJson,header);
	
		String url = "https://kapi.kakao.com/v2/api/talk/memo/default/send";
		
		
		UriComponents uri = UriComponentsBuilder.fromUriString(url)
				//.queryParam("template_object", requestJson)
				.queryParam("template_object", requestJson)
				.build();
		
		// �� ������ �ڵ�� API�� ȣ���Ͽ� MAPŸ������ ���޹޴´�.
		ResponseEntity<Map> resultMap = restTemplate.postForEntity(uri.toUri(), header, Map.class);
		
		result.put("statusCode", resultMap.getStatusCodeValue()); //http status code�� Ȯ��
        result.put("header", resultMap.getHeaders()); //��� ���� Ȯ��
        result.put("body", resultMap.getBody()); //���� ������ ���� Ȯ��
		
        //�����͸� ����� ���� �޾Ҵ��� Ȯ�� string���·� �Ľ�����
        ObjectMapper mapper = new ObjectMapper();
        jsonInString = mapper.writeValueAsString(resultMap.getBody());
        
		} catch (Exception e) {
            result.put("statusCode", "999");
            result.put("body"  , "excpetion����");
            System.out.println(e.toString());
        }
 
        return jsonInString;
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
	
	@Override
	public String getProfile() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
