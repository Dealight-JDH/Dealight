package com.dealight.controller;



import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.Email;
import com.dealight.domain.UserVO;
import com.dealight.service.MailService;
import com.dealight.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/*")
@AllArgsConstructor
public class UserController {
	
	private MailService mailService;
	private Email e_mail;
	
	private UserService service;
	
	
	//회원가입전 이메일 인증받는 페이지
	@GetMapping("/email/email")
	public void email() {}
	
	//회원가입 인증번호 이메일전송
	@RequestMapping(value = "/email/email",  method= RequestMethod.POST)
	public String email(String email, RedirectAttributes rttr) throws IOException {
		
        
		Random random = new Random();
		String authNum = random.nextInt(999999)+111111 + ""; //인증번호 생성
		
		e_mail.setTitle("Dealight 회원가입 인증 메일입니다.");
        e_mail.setContent(
        		//줄바꿈
        		System.getProperty("line.separator") +
        		"안녕하세요 Dealight 입니다." +
        		System.getProperty("line.separator")+
        		"회원가입 인증 번호는 "+ authNum+"입니다."+
        		System.getProperty("line.separator")+
        		"인증번호를 홈페이지에 입력하여 주세요."
        		);
        e_mail.setTo(email);
        mailService.send(e_mail);
		
       rttr.addFlashAttribute("authNum", authNum);
       rttr.addFlashAttribute("email", email);
        System.out.println("인증번호 : "+authNum);
		return "redirect:/dealight/email/authEmail";
	} 
	
	//인증번호 입력 페이지
	@GetMapping("/email/authEmail")
	public void authEmail() {}

	//이메일인증
	@PostMapping("/email/auth")
	public String auth(String num, String authNum,  String email, RedirectAttributes rttr, HttpServletResponse response) throws IOException {
        
		//인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함
		//만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을 입력할 필요가 없게
		rttr.addFlashAttribute("email", email);
		rttr.addFlashAttribute("authNum", authNum);
		rttr.addFlashAttribute("num", num);
        
        if (num.equals(authNum)) {
            
            return "redirect:/dealight/register";
            
        }else {
            
            return "redirect:/dealight/email/email";
        }    
    
    }

	
	//아이디 찾기 페이지
	@GetMapping("/email/findId")
	public void findId() {}
	
	//아이디 찾기, 이메일과 일치하는 아이디들을 메일로 전송
	@RequestMapping( value = "/email/sendId", method= RequestMethod.POST)
	@ResponseBody
	public boolean sendId(String email,   RedirectAttributes rttr) throws Exception {
		
		System.out.println("email:"+email);
        //입력한 이메일에 해당하는 id정보를 가져온다
        List<String> list= service.getId(email);
        System.out.println("list:"+list);
        //현재 아이디를 가져오는데 성공했다면
        if(list.isEmpty() || list == null) {
        	return  false;
        }else {
        	
        	e_mail.setTitle("Dealight 아이디 찾기 메일입니다.");
            e_mail.setContent("고객님의 아이디는 "+list+" 입니다.");
            e_mail.setTo(email);
            mailService.send(e_mail);
            return true;
          }
        }
	
	
	//비밀번호 찾기 페이지
	@GetMapping("/email/findPwd")
	public void findPwd() {}
	
	//비밀번호 찾기 ->임시비밀번호 생성
	@RequestMapping( value = "/email/sendpwd", method= RequestMethod.POST)
	@ResponseBody
	public boolean sendpwd(UserVO user,   RedirectAttributes rttr) throws Exception {
        //현재비밀번호를 가져온다
        String pwd=service.getPwd(user);
        //임시비밀번호를 발급한다.(특수문자  X)
        System.out.println(pwd);
        //현재 비밀번호를 가져오는데 성공했다면
        if(pwd!=null) {
        	//비밀번호를 임시비밀번호로 변경한다.
        	String tmpPwd = UUID.randomUUID().toString().replace("-", "");
        	tmpPwd = tmpPwd.substring(0,12);
        	System.out.println("임시비밀번호:"+tmpPwd);
        	user.setPwd(tmpPwd);
        	
        	service.changePwd(user);
        	
        	e_mail.setTitle(user.getUserId()+"님 비밀번호 찾기 메일입니다.");
            e_mail.setContent("임시 비밀번호는 "+tmpPwd+" 입니다.");
            e_mail.setTo(user.getEmail());
            mailService.send(e_mail);
            return true;
        }
        return  false;
    }
	

	//main page 불러오기
	@GetMapping("/dealight")
	public void dealight() {}
	
	//모든 회원리스트 불러오기(관리자용)
	@GetMapping("/list")
	public void list(Model model) {
		
		log.info("list");
		
		model.addAttribute("list", service.getList());
	}
	
	//회원 등록은 post방식이지만 화면에서 입력 받아야 하므로 get 방식으로 입력페이지를 볼 수 있게 한다.
			@GetMapping("/register")
			public void register() {
				
			}
	
	// 회원가입 
	@PostMapping("/register")
	public String register(UserVO user, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr){
		log.info("register: " + user);
		
		service.register(user);
		//세션이나 쿠키사용하자!
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		
		return "redirect:/dealight/mypage/userinfo";
	}
	
		
		//회원가입후 회원 정보 출력
		@GetMapping("/mypage/userinfo")
		public void userinfo() {}
	
	//중복확인 버튼 처리
	//메소드에서 리턴되는 값은 View 를 통해서 출력되지 않고 HTTP Response Body 에 직접 쓰여지게 된다.
	@RequestMapping(value = "/overlapCheck", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public int overlapCheck(@RequestParam("userId") String userId) {
		System.out.println("userId:"+userId);
		int cnt = 0;
		cnt = service.checkId(userId);
		System.out.println("cnt:"+cnt);
		return cnt;
	}
	
	
	
	// 회원정보 불러오기
	@GetMapping("/get")
	public void get(@RequestParam("userId") String userId, Model model) {
		
		log.info("/get");
		model.addAttribute("user", service.get(userId));
	}
	
	// 회원정보 수정
	@PostMapping("/mypage/modify")
	public void modify(UserVO user, Model model) {
		log.info("modify: "+user);
		//(이름[닉네임], 비밀번호, 이메일, 전화번호, sns연동 만 변경
		service.modify(user);
		//프로필 사진 수정
		service.modifyPhoto(user);
		
		model.addAttribute("user", service.get(user.getUserId()));
		}
	
	//회원정보수정 보여주기
		@GetMapping("/mypage/modify")
		public void modify(HttpSession session, Model model) throws IOException {
			//로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
			UserVO user = (UserVO)session.getAttribute("user");
				if(user == null) {
					model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
				}else {
				model.addAttribute("user", service.get(user.getUserId()));
				}
		}

	
	//회원탈퇴
	@PostMapping("/mypage/remove")
	@ResponseBody
	public boolean remove(@RequestParam("userId") String userId, RedirectAttributes rttr ) {
		log.info("remove...."+userId);
		//삭제 되면 true / 삭제 실패 false
		return service.remove(userId);
			
	}
	
	@GetMapping("/login")
	public void login() {}
	
	// 로그인action 로그인이 메인페이지의 모달창으로 있으므로 메인페이지와 매핑해줌
	@PostMapping("/dealight")
	public String login(UserVO user, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr){
		log.info("login!!!!!!!");
		String msg ="";
		String saveId = request.getParameter("saveId"); //id저장 체크박스
		HttpSession session = request.getSession();
		//입력받은 id정보가 db상의 정보와 일치하는 것이 있는지 조회후 담는다
		UserVO result = service.login(user.getUserId());
		Cookie cookie = new Cookie("id", user.getUserId());
		
		//입력한 id, pw가 일치한다면 세션에 user정보를 저장
		if(result != null) {
			if(user.getUserId().equals(result.getUserId()) && user.getPwd().equals(result.getPwd())) {
				session.setAttribute("user", user);
				//id저장 체크박스가 체크되어 있다면 쿠키 저장
				if(saveId != null) {
					response.addCookie(cookie);
				//id저장 체크박스의 체크가 풀려있다면 쿠키 삭제
				}else
					cookie.setMaxAge(0); // 쿠키의 유효시간을 0으로 변경(쿠키삭제)
					response.addCookie(cookie); //쿠키를 응답에 포함시킨다.      

			}else if(user.getPwd().equals("") || !(user.getPwd().equals(result.getUserId()))) {
					msg = "비밀번호를 다시 입력하여 주십시오";
				}
			
			//일치하지 않는다면 로그인 실패 메세지
		}else {
			msg = "입력하신 아이디는 없는 회원입니다.";
		}
		rttr.addFlashAttribute("msg", msg);
//		rttr.addFlashAttribute("sc", sc);
		return "redirect:/dealight/dealight";
	}
	
	
	//마이페이지 예약내역 보여주기 로그인 상태일때만!
	@GetMapping("/mypage/reservation")
	public void reservation(HttpSession session, Model model) throws IOException {
		//로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
		UserVO user = (UserVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
		}
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, RedirectAttributes rttr ) {
		HttpSession session = request.getSession();
		session.invalidate();  
		return "redirect:/dealight/dealight";
	}
	
	
	
	
	
}