package com.dealight.controller;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.AuthVO;
import com.dealight.domain.SnsVO;
import com.dealight.domain.UserVO;
import com.dealight.service.SnsService;
import com.dealight.service.UserService;
import com.dealight.sns.KakaoLoginService;
import com.dealight.sns.NaverLoginService;
import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequiredArgsConstructor
public class LoginController {

	private final NaverLoginService naverService;
	private final KakaoLoginService kakaService;
	private final SnsService service;
	private final UserService userService;
	
	private final BCryptPasswordEncoder encoder;
	// 로그인 첫 화면 요청 메소드
	@GetMapping("/dealight/login")
	public void loginInput(String error, Model model, HttpServletRequest request, HttpSession session) {
		String referrer = request.getHeader("Referer");

		request.getSession().setAttribute("prevPage", referrer);

		// 네이버아이디로 인증 URL
		String naverAuthUrl = naverService.getAuthorizationUrl(session);
		// 카카오 아디이 인증 URL
		String kakaoAuthUrl = kakaService.getAuthorizationBaseUrl();

		log.info("네이버:" + naverAuthUrl);
		log.info("kakao : " + kakaoAuthUrl);
		// 네이버
		model.addAttribute("naver_url", naverAuthUrl);
		// 카카오
		model.addAttribute("kakao_url", kakaoAuthUrl);

		if (error != null) {
			model.addAttribute("error", "로그인에 실패하였습니다.");

		}
	}

	@RequestMapping(value = "/kakao/oauth", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(String code, HttpSession session, RedirectAttributes rttr, HttpServletResponse response) throws Exception {

		log.info("kakao code: " + code);

		String accessToken = kakaService.getAccessToken(code);
		
		Cookie tokenCookie = new Cookie("accessToken", accessToken);
		
		tokenCookie.setMaxAge(60 * 60 * 6);
		tokenCookie.setPath("/");
		response.addCookie(tokenCookie);
		

		log.info("============" + accessToken);
		// KakaoUser userInfo = kakaoApi.getKakaoUserInfo(accessToken);
		String userInfo = kakaService.getKakaoUserInfo(accessToken);
		log.info("-----------kakao user : " + userInfo);
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(userInfo);

		SnsVO kakaoVO = kakaService.getKakaoVO(jsonObj);

		if(kakaoVO.getGender().equalsIgnoreCase("female"))
			kakaoVO.setGender("W");
		else
			kakaoVO.setGender("M");
		
		UserVO user = UserVO.builder().userId(kakaoVO.getUserId())
		.name(kakaoVO.getNickName())
		.pwd(encoder.encode(kakaoVO.getId()))
		.email(kakaoVO.getUserId()+kakaoVO.getId())
		.telno("01077578648")
		.brdt(kakaoVO.getBirthday())
		.sex(kakaoVO.getGender())
		.photoSrc(kakaoVO.getProfileImg())
		.snsLginYn("Y")
		.snsNum(Long.valueOf(kakaoVO.getId()))
		.build();
		
		AuthVO authVO = AuthVO.builder()
				.userId(user.getUserId())
				.auth("ROLE_USER").build();
		//log.info("============" + user);
		
		if (userService.get(kakaoVO.getUserId()) == null) {
			userService.register(user, authVO);
		}
		
		rttr.addFlashAttribute("user", user);
		rttr.addFlashAttribute("pwd", kakaoVO.getId());
		// session.setAttribute("snsUser", kakaoVO);
		// return "/dealight/dealight";
		return "redirect:/dealight/snslogin";
	}

	@GetMapping("/dealight/snslogin")
	public void snsLogin(@ModelAttribute SnsVO user) {
		
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/auth/naver/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,RedirectAttributes rttr)
			throws IOException, ParseException {
		log.info("callback....");
		OAuth2AccessToken oauthToken;
		oauthToken = naverService.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.
		String apiResult = naverService.getUserProfile(oauthToken);

		// 2.String형식인 apiResult를 json형태로 바꾼다
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(apiResult);

		// 3. 데이터 파싱
		// response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱

		SnsVO naverVO = naverService.getNaverVO(response_obj);
		
		UserVO user = UserVO.builder().userId(naverVO.getUserId())
				.name(naverVO.getName())
				.pwd(encoder.encode(String.valueOf(naverVO.getId())))
				.email(naverVO.getUserId()+naverVO.getId())
				.brdt(naverVO.getBirthday())
				.telno("01077578648")
				.sex(naverVO.getGender())
				.photoSrc(naverVO.getProfileImg())
				.snsLginYn("Y")
				.snsNum(Long.valueOf(naverVO.getId()))
				.build();
		
		AuthVO authVO = AuthVO.builder()
				.userId(user.getUserId())
				.auth("ROLE_USER").build();
		
		log.info("=============" + naverVO);
		if (userService.get(naverVO.getUserId()) == null) {
			userService.register(user, authVO);
		}
		
		rttr.addFlashAttribute("user", user);
		rttr.addFlashAttribute("pwd", naverVO.getId());
//        log.info("name :" + name);
//        log.info("nickname :"+ nickname);
		log.info("=====" + apiResult);
		// model.addAttribute("result", apiResult);

		/* 네이버 로그인 성공 페이지 View 호출 */
		return "redirect:/dealight/snslogin";
	}

}
