package com.dealight.controller;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.AuthVO;
import com.dealight.domain.Email;
import com.dealight.domain.UserRequestDTO;
import com.dealight.domain.UserVO;
import com.dealight.service.MailService;
import com.dealight.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

//jongwoo
@Controller
@Log4j
@RequestMapping("/dealight/*")
@RequiredArgsConstructor
public class UserController {

	private final MailService mailService;
//	private final NaverLoginService naverService;
//	private final KakaoLoginService kakaService;
	private final UserService service;
	private final Email e_mail;
	private final BCryptPasswordEncoder encoder;

//	// 회원가입전 이메일 인증받는 페이지
//	@GetMapping("/prove/authemail")
//	public void email() {
//	}

	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);

		model.addAttribute("msg", "Access Denied");
	}

//	//로그인 첫 화면 요청 메소드
//    @GetMapping("/login")
//    public void loginInput(String error,  Model model, HttpServletRequest request, HttpSession session) {
//    	String referrer = request.getHeader("Referer");
//
//    	request.getSession().setAttribute("prevPage", referrer);
//        
//        // 네이버아이디로 인증 URL
//        String naverAuthUrl = naverService.getAuthorizationUrl(session);
//        // 카카오 아디이 인증 URL
//        String kakaoAuthUrl = kakaService.getAuthorizationBaseUrl();
//        
//        log.info("네이버:" + naverAuthUrl);
//        log.info("kakao : " + kakaoAuthUrl);
//        //네이버 
//        model.addAttribute("naver_url", naverAuthUrl);
//        //카카오
//        model.addAttribute("kakao_url", kakaoAuthUrl);
//        
//        if(error != null) {
//        	model.addAttribute("error", "로그인에 실패하였습니다.");
//        	
//        }
//    }

	// kakao auth
//  	 @RequestMapping(value="/oauth", method= {RequestMethod.GET, RequestMethod.POST})
//  	 public String login(String code) throws Exception {
//  	     
//  	     log.info("kakao code: " + code);
//  	     
//  	     String accessToken = kakaService.getAccessToken(code);
//  	     
//  	     log.info("============" + accessToken);
//  	     //KakaoUser userInfo = kakaoApi.getKakaoUserInfo(accessToken);
//  	     JSONObject userInfo = kakaService.getKakaoUserInfo(accessToken);
//  	     log.info("-----------kakao user : " + userInfo);
//  	     
//  	     return "/dealight/dealight";
//  	 }
//  	 
//  	//네이버 로그인 성공시 callback호출 메소드
//     @RequestMapping(value = "/auth/naver/callback", method = { RequestMethod.GET, RequestMethod.POST })
//     public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
//             throws IOException, ParseException {
//         log.info("callback....");
//         OAuth2AccessToken oauthToken;
//         oauthToken = naverService.getAccessToken(session, code, state);
//         //로그인 사용자 정보를 읽어온다.
//         String apiResult = naverService.getUserProfile(oauthToken);
//         
//         //2.String형식인 apiResult를 json형태로 바꾼다
//         JSONParser parser = new JSONParser();
//         JSONObject jsonObj = (JSONObject) parser.parse(apiResult);;
//         
//         //3. 데이터 파싱
//         //response 파싱
//         JSONObject response_obj = (JSONObject)jsonObj.get("response");
//         //response의 nickname값 파싱
//         String nickname = String.valueOf(response_obj.get("nickname"));
//         String name = String.valueOf(response_obj.get("name"));
//         log.info("name :" + name);
//         log.info("nickname :"+ nickname);
//
//         log.info("====="+ apiResult);
//         model.addAttribute("result", apiResult);
//  
//         /* 네이버 로그인 성공 페이지 View 호출 */
//         return "/dealight/dealight";
//     }

//    @PostMapping("/login")
//    public void login() {
//    	
//    }
//    

//	// 회원가입 인증번호 이메일전송
//	@RequestMapping(value = "/prove/authemail", method = RequestMethod.POST)
//	public  String email(String email, RedirectAttributes rttr) throws IOException {
//
//		Random random = new Random();
//		String authNum = random.nextInt(999999) + 111111 + ""; // 인증번호 생성
//
//		e_mail.setTitle("Dealight 회원가입 인증 메일입니다.");
//		e_mail.setContent(
//				// 줄바꿈
//				System.getProperty("line.separator") + "안녕하세요 Dealight 입니다." + System.getProperty("line.separator")
//						+ "회원가입 인증 번호는 " + authNum + "입니다." + System.getProperty("line.separator")
//						+ "인증번호를 홈페이지에 입력하여 주세요.");
//		e_mail.setTo(email);
//		mailService.send(e_mail);
//
//		rttr.addFlashAttribute("authNum", authNum);
//		rttr.addFlashAttribute("email", email);
//		log.info("==============인증번호===========" + authNum);
//		return "redirect:/dealight/prove/authnum";
//	}
	
	// 회원가입 인증번호 이메일전송
		@RequestMapping(value = "/prove/authemail", method = RequestMethod.POST
				,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public @ResponseBody ResponseEntity<String> email(@RequestBody String email) throws IOException, ParseException {
	
			Random random = new Random();
			String authNum = random.nextInt(999999) + 111111 + ""; // 인증번호 생성
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(email);
			JSONObject jsonObj = (JSONObject) obj;

			String emailValue = String.valueOf(jsonObj.get("email"));
			
			log.info("email===========: " + emailValue);
//			log.info("email===========: " + email);
			e_mail.setTitle("Dealight 회원가입 인증 메일입니다.");
			e_mail.setContent(
					// 줄바꿈
					System.getProperty("line.separator") + "안녕하세요 Dealight 입니다." + System.getProperty("line.separator")
							+ "회원가입 인증 번호는 " + authNum + "입니다." + System.getProperty("line.separator")
							+ "인증번호를 홈페이지에 입력하여 주세요.");
			e_mail.setTo(emailValue);
//			e_mail.setTo(email);
			mailService.send(e_mail);
	
//			rttr.addFlashAttribute("authNum", authNum);
//			rttr.addFlashAttribute("email", email);
			log.info("==============인증번호===========" + authNum);
			return new ResponseEntity<String>(authNum, HttpStatus.OK);
		}

//	// 인증번호 입력 페이지
//	@GetMapping("/prove/authnum")
//	public void authEmail() {
//	}

//	// 이메일인증
//	@PostMapping("/prove/auth")
//	public String auth(String num, String authNum, String email, RedirectAttributes rttr)
//			throws IOException {
//
//		// 인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함
//		// 만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을 입력할 필요가 없게
//		rttr.addFlashAttribute("email", email);
//		rttr.addFlashAttribute("authNum", authNum);
//		rttr.addFlashAttribute("num", num);
//
//		if (num.equals(authNum)) {
//			return "redirect:/dealight/register";
//		}
//
//		return "redirect:/dealight/prove/authemail";
//	}

	// 아이디 찾기 페이지
	@GetMapping("/findid")
	public void findid() {
	}

	// 아이디 찾기, 이메일과 일치하는 아이디들을 메일로 전송
	@RequestMapping(value = "/prove/sendId", method = RequestMethod.POST)
	@ResponseBody
	public boolean sendId(String email, RedirectAttributes rttr) throws Exception {

		System.out.println("email:" + email);
		// 입력한 이메일에 해당하는 id정보를 가져온다
		List<String> list = service.getId(email);
		System.out.println("list:" + list);
		// 현재 아이디를 가져오는데 성공했다면
		if (list.isEmpty() || list == null) {
			return false;
		} else {

			e_mail.setTitle("Dealight 아이디 찾기 메일입니다.");
			e_mail.setContent("고객님의 아이디는 " + list + " 입니다.");
			e_mail.setTo(email);
			mailService.send(e_mail);
			return true;
		}
	}

	// 비밀번호 찾기 페이지
	@GetMapping("/findpwd")
	public void findpwd() {
	}

	// 비밀번호 찾기 ->임시비밀번호 생성
	@RequestMapping(value = "/prove/sendpwd", method = RequestMethod.POST)
	@ResponseBody
	public boolean sendpwd(UserVO user, RedirectAttributes rttr) throws Exception {
		// 현재비밀번호를 가져온다
		String pwd = service.getPwd(user);
		// 임시비밀번호를 발급한다.(특수문자 X)
		System.out.println(pwd);
		// 현재 비밀번호를 가져오는데 성공했다면
		if (pwd != null) {
			// 비밀번호를 임시비밀번호로 변경한다.
			String tmpPwd = UUID.randomUUID().toString().replace("-", "");
			tmpPwd = tmpPwd.substring(0, 12);
			System.out.println("임시비밀번호:" + tmpPwd);
			user.setPwd(encoder.encode(tmpPwd));

			service.changePwd(user);

			e_mail.setTitle(user.getUserId() + "님 비밀번호 찾기 메일입니다.");
			e_mail.setContent("임시 비밀번호는 " + tmpPwd + " 입니다.");
			e_mail.setTo(user.getEmail());
			mailService.send(e_mail);
			return true;
		}
		return false;
	}


	// 모든 회원리스트 불러오기(관리자용)
	@GetMapping("/list")
	public void list(Model model) {

		log.info("list");

		model.addAttribute("list", service.getList());
	}

	// 회원 가입 전 개인정보 이용 동의 페이지
	@GetMapping("/policies")
	public void policies() {
	}

	@GetMapping("/register")
	public void register() {

	}

	// 회원가입
	@PostMapping("/register")
	public String register(@Valid UserRequestDTO requestUser , BindingResult result, HttpServletRequest request,
			 RedirectAttributes rttr) {
		log.info("register: " + requestUser);

		if (result.hasErrors()) {
			List<ObjectError> list = result.getAllErrors();
			for (ObjectError error : list) {
				System.out.println(error.getDefaultMessage());
			}
			rttr.addFlashAttribute("result", "필수 항목을 입력해 주세요");
		//register.jsp로 리턴해도 이메일 인증 다시 받아야함...생각해보자
			return "dealight/register";
		}
		
		UserVO user = requestUser.toEntity();
		user.setTelno("01077578648");
		//권한 부여
		AuthVO auth = AuthVO.builder().userId(user.getUserId()).auth("ROLE_USER").build();
		//암호화
		user.setPwd(encoder.encode(user.getPwd()));
		
		service.register(user, auth);

		return "redirect:/dealight/login";
	}

	// 회원가입후 회원 정보 출력
	@GetMapping("/mypage/userinfo")
	public void userinfo() {
	}

	// 중복확인 버튼 처리
	// 메소드에서 리턴되는 값은 View 를 통해서 출력되지 않고 HTTP Response Body 에 직접 쓰여지게 된다.
	@RequestMapping(value = "/overlapCheck", method = { RequestMethod.GET, RequestMethod.POST}
				,produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public @ResponseBody ResponseEntity<Integer> overlapCheck(String userId) {
		System.out.println("userId:" + userId);
		int cnt = 0;
		cnt = service.checkId(userId);
		System.out.println("cnt:" + cnt);
		return new ResponseEntity<Integer>(cnt, HttpStatus.OK);
	}

	// 회원정보 불러오기
	@GetMapping("/get")
	public void get(@RequestParam("userId") String userId, Model model) {

		log.info("/get");
		model.addAttribute("user", service.get(userId));
	}

	/*
	 * 진행예정 //비밀번호 변경
	 * 
	 * @GetMapping("/mypage/changepwd") public void changepwd(HttpSession session,
	 * Model model) {
	 * 
	 * //로그인된 정보를 가져온다 UserVO user = (UserVO)session.getAttribute("user");
	 * 
	 * //로그인이 되어 있지 않다면 접근불가 if(user == null) { model.addAttribute("msg",
	 * "로그인이 필요한 페이지 입니다."); } }
	 * 
	 * 
	 * @RequestMapping( value = "/mypage/changepwd", method= RequestMethod.POST)
	 * public boolean changepwd(String pwd, String changepwd, HttpSession session )
	 * { UserVO user = (UserVO)session.getAttribute("user"); //로그인된 회원의 비밀번호와 입력한 현재
	 * 비밀번호가 일치한다면 비밀번호 변경 if(user.getPwd().equals(pwd)) { user.setPwd(changepwd);
	 * System.out.println("user:"+user); return service.changePwd(user); } return
	 * false; }
	 * 
	 */

	// 회원정보 수정
	@PostMapping("/mypage/modify")
	public String modify(@Valid UserRequestDTO requestUser, Model model, RedirectAttributes rttr) {
		log.info("modify: " + requestUser);
		// (이름[닉네임], 이메일, 전화번호, sns연동 만 변경
		UserVO user = requestUser.toEntity();
		service.modify(user);
		// 프로필 사진 수정
		//service.modifyPhoto(user);

		rttr.addFlashAttribute("result", "회원 정보 수정이 완료되었습니다.");
		model.addAttribute("user", service.get(user.getUserId()));
		return "redirect:/dealight/mypage/get";
	}

	// 회원정보수정 보여주기
	@GetMapping({"/mypage/get", "/mypage/modify"})
	public void modify(HttpSession session, Model model) throws IOException {
		// 로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
//		UserVO user = (UserVO) session.getAttribute("user");
//		if (user == null) {
//			model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
//		} else {
//			model.addAttribute("user", service.get(user.getUserId()));
//		}
		String userId = (String) session.getAttribute("userId") ;
		if(userId != null) {
			
			model.addAttribute("user", service.get(userId));
		}
	}

	// 회원탈퇴
//	@PostMapping("/mypage/remove")
//	@ResponseBody
//	public boolean remove(@RequestParam("userId") String userId, RedirectAttributes rttr) {
//		log.info("remove...." + userId);
//		// 삭제 되면 true / 삭제 실패 false
//		return service.remove(userId);
//
//	}
	
	@PostMapping("/mypage/remove")
	public String remove(String userId, HttpSession session, RedirectAttributes rttr) {
		
		log.info("user.... withdraw");
		log.info("////................userId: " + userId);
		
		if(service.remove(userId)) {
			session.invalidate();
			rttr.addFlashAttribute("result", "회원 탈퇴에 성공하였습니다.");
			return "redirect:/dealight/dealight";
		}
		
		rttr.addFlashAttribute("result", "회원 탈퇴에 실패하였습니다.");
		return "/dealight/mypage/modify";
		
	}

//	// 로그인action 로그인이 메인페이지의 모달창으로 있으므로 메인페이지와 매핑해줌
//	@PostMapping("/dealight")
//	public String login(UserVO user, HttpServletRequest request, HttpServletResponse response,
//			RedirectAttributes rttr) {
//		log.info("login!!!!!!!");
//		String msg = "";
//		String saveId = request.getParameter("saveId"); // id저장 체크박스
//		HttpSession session = request.getSession();
//		// 입력받은 id정보가 db상의 정보와 일치하는 것이 있는지 조회후 담는다
//		UserVO result = service.login(user.getUserId());
//		Cookie cookie = new Cookie("id", user.getUserId());
//
//		// 입력한 id, pw가 일치한다면 세션에 user정보를 저장
//		if (result != null) {
//			if (user.getUserId().equals(result.getUserId()) && user.getPwd().equals(result.getPwd())) {
//				session.setAttribute("user", user);
//				// id저장 체크박스가 체크되어 있다면 쿠키 저장
//				if (saveId != null) {
//					response.addCookie(cookie);
//					// id저장 체크박스의 체크가 풀려있다면 쿠키 삭제
//				} else
//					cookie.setMaxAge(0); // 쿠키의 유효시간을 0으로 변경(쿠키삭제)
//				response.addCookie(cookie); // 쿠키를 응답에 포함시킨다.
//
//			} else if (user.getPwd().equals("") || !(user.getPwd().equals(result.getUserId()))) {
//				msg = "비밀번호를 다시 입력하여 주십시오";
//			}
//
//			// 일치하지 않는다면 로그인 실패 메세지
//		} else {
//			msg = "입력하신 아이디는 없는 회원입니다.";
//		}
//		rttr.addFlashAttribute("msg", msg);
//		return "redirect:/dealight/dealight";
//	}


	// 로그아웃
	@PostMapping("/logout")
	public void logout() {
		
//		log.info("logout....................................");
//
//		Cookie[] cookies = request.getCookies();
//		
//		for(Cookie cookie : cookies) {
//			if("accessToken".equals(cookie.getName())) {
//				log.info("logout cookie: " + cookie.getValue());
//				cookie.setMaxAge(0);
//				reponse.addCookie(cookie);
//			}
//		}
		
//		log.info("logout..........................");
//		if(tokenCookie != null) {
//			log.info("==========log out accessToken: " + tokenCookie);
//			tokenCookie.setMaxAge(0);
//			tokenCookie.setPath("/");
//			reponse.addCookie(tokenCookie);
//			
//		}
		
//		HttpSession session = request.getSession();
//		session.invalidate();

		// return "redirect:/dealight/dealight";
	}

}