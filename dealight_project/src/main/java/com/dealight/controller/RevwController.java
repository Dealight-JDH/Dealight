package com.dealight.controller;
import javax.servlet.http.HttpSession;

// 수빈
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.UserVO;
import com.dealight.service.RevwService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/review/*")
@AllArgsConstructor
public class RevwController {

	private RevwService service;

	@GetMapping("/writable-list")
	public void getWritableList(HttpSession session, Model model) {
		//로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
	    UserVO user = (UserVO)session.getAttribute("user");
	    if(user == null) {
	       model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
	    } else {
	    	log.info("WRITABLE LIST");
	    	model.addAttribute("userId", user.getUserId());
	    	model.addAttribute("rsvdList", service.getWritableListByRsvd(user.getUserId()));
	    	model.addAttribute("waitList", service.getWritableListByWait(user.getUserId()));
	    }
	}

	@GetMapping("/written-list")
	public void getWrittenList(HttpSession session, RevwVO revw, Model model) {
		//로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
	    UserVO user = (UserVO)session.getAttribute("user");
	    if(user == null) {
	       model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
	    }
		
		log.info("COUNT REVW...");
		model.addAttribute("countRevw", service.countRevw(user.getUserId()));

		log.info("COUNT STORE...");
		model.addAttribute("countStore", service.countStore(user.getUserId()));

		log.info("WRITTEN LIST... ");
		model.addAttribute("written", service.getWrittenList(user.getUserId()));
	}

	@GetMapping("/register/rsvd")
	public void getWritableItemByRsvd(HttpSession session, @Param("rsvdId") Long rsvdId, Model model) {
//		로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
	    UserVO user = (UserVO)session.getAttribute("user");
	    if(user == null) {
	       model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
	    }
	    
		log.info("RSVDID: " + rsvdId + "@@");
		log.info("UPLOAD REVW IMG");

		model.addAttribute("rsvd", service.getWritableItemByRsvd(user.getUserId(), rsvdId));
		System.out.println(model);
	}

	@PostMapping("/register/rsvd")
	public String registerRevwByRsvd(String userId, Long rsvdId, String imgUrl,
			RevwVO revw, RevwImgVO img, RedirectAttributes rttr, MultipartFile[] uploadRevwImg, Model model) {

		service.getWritableItemByRsvd(userId, rsvdId);

		// 이미지 첨부는 선택적으로 가능하게 변경해야 함
		/* if(!img.getImgUrl().equals("")) { */
			service.registerRevw(revw);
			service.registerRevwImg(img); 

			log.info("REGISTER RSVD REVW");
			log.info("USERID: " + userId + "@@");
			log.info("RSVDID: " + rsvdId + "@@");
			log.info("REVW: " + revw + "@@");
			log.info("IMG: " + img + "@@");
		
		System.out.println(service.updateRsvdRevwStus(userId, rsvdId));
		rttr.addFlashAttribute("result", revw.getRevwId());
		return "redirect:/dealight/mypage/review/writable-list";
	}
	
//	@PostMapping("/uploadRevwImgAction")
//	public void uploadRevwImgPost(MultipartFile[] uploadRevwImg, Model model) {
//		for(MultipartFile multipartRevwImg : uploadRevwImg) {
//			log.info("-----------------------------");
//			log.info("UPLOAD REVW IMG NAME: " + multipartRevwImg.getOriginalFilename());
//			log.info("UPLOAD REVW IMG SIZE: " + multipartRevwImg.getSize());
//		}
//	}
	
	@GetMapping("/register/wait")
	public void getWritableItemByWait(HttpSession session, Long waitId, Model model) {
		//로그인 성공 후 세션에 저장된 user 정보를 꺼내와서 user정보를 불러옴
	    UserVO user = (UserVO)session.getAttribute("user");
	    if(user == null) {
	       model.addAttribute("msg", "로그인이 필요한 페이지 입니다.");
	    } else {
	    	log.info("WAITID: " + waitId + "@@");
	    	model.addAttribute("wait", service.getWritableItemByWait(user.getUserId(), waitId));
	    }
	}

	@PostMapping("/register/wait")
	public String registerRevwByWait(String userId, Long waitId, String imgUrl,
			RevwVO revw, RevwImgVO img, RedirectAttributes rttr) {

		if(!img.getImgUrl().equals("")) {
			service.registerRevw(revw);
			service.registerRevwImg(img);

			log.info("REGISTER WAIT REVW");
			log.info("USERID: " + userId + "@@");
			log.info("WAITID: " + waitId + "@@");
			log.info("REVW: " + revw + "@@");

		} else {
			service.registerRevw(revw);

			log.info("REGISTER WAIT REVW");
			log.info("USERID: " + userId + "@@");
			log.info("WAITID: " + waitId + "@@");
			log.info("REVW: " + revw + "@@");
			log.info("IMG: " + img + "@@");
		}

		System.out.println(service.updateWaitRevwStus(userId, waitId));
		rttr.addFlashAttribute("result", revw.getWaitId());
		return "redirect:/dealight/mypage/review/writable-list";
	}
}
