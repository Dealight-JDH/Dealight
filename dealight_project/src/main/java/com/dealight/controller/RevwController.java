package com.dealight.controller;
import java.util.List;

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

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.RsvdWithWaitDTO;
import com.dealight.domain.WaitVO;
import com.dealight.service.RevwService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/review/*")
@AllArgsConstructor
public class RevwController {

	private RevwService revwService;

	@GetMapping("/")
	public String getWritableList(HttpSession session, Model model,Criteria cri) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");

		if(cri.getPageNum() == 0)
			cri = new Criteria(1,5);
		
		List<RsvdWithWaitDTO> dtoList = revwService.getWritableListWithPagingByUserId(userId, cri);
		int writableRsvd = revwService.countWritableRsvd(userId);
		int writableWait = revwService.countWritableWait(userId);
		int total = writableRsvd + writableWait;
		
		log.info("dtoList..................... : "+dtoList);
		
		model.addAttribute("userId", userId);
		model.addAttribute("dtoList",dtoList);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
		model.addAttribute("writableRsvd",writableRsvd);
		model.addAttribute("writableWait",writableWait);
		
		return "/dealight/mypage/review/writable-list";
	}

	@GetMapping("/written-list")
	public void getWrittenList(HttpSession session, Model model) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		session.setAttribute("userId", "kjuioq");
	    String userId = (String) session.getAttribute("userId");
	    
	    int countRevw = revwService.countRevw(userId);
	    int countRsvd = revwService.countRsvd(userId);
	    int countWait = revwService.countWait(userId);
	    int countTotal = revwService.countTotal(userId);
	    
	    List<RevwVO> writtenList = revwService.getWrittenList(userId);
		
		model.addAttribute("countRevw", countRevw);
		model.addAttribute("countStore", countRsvd);
		model.addAttribute("countWait", countWait);
		model.addAttribute("countTotal", countTotal);
		model.addAttribute("writtenList", writtenList);
	}

	// 예약 리뷰 작성 페이지
	@GetMapping("/register/rsvd")
	public void getWritableItemByRsvd(HttpSession session, @Param("rsvdId") Long rsvdId, Model model) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		session.setAttribute("userId", "kjuioq");
	    String userId = (String) session.getAttribute("userId");
	    
		log.info("RSVDID: " + rsvdId + "@@");
		log.info("UPLOAD REVW IMG");

		//model.addAttribute("rsvd", revwService.getWritableItemByRsvd(userId, rsvdId));
		System.out.println(model);
	}

	// 리뷰 register 로직
	@PostMapping("/register/rsvd")
	public String registerRevwByRsvd(String userId, Long rsvdId, String imgUrl,
		RevwVO revw, RevwImgVO img, RedirectAttributes rttr, MultipartFile[] uploadRevwImg, Model model) {

			//revwService.getWritableItemByRsvd(userId, rsvdId);

			//revwService.registerRevw(revw);
			//revwService.registerRevwImg(img);  

			log.info("REGISTER RSVD REVW");
			log.info("USERID: " + userId + "@@");
			log.info("RSVDID: " + rsvdId + "@@");
			log.info("REVW: " + revw + "@@");
			log.info("IMG: " + img + "@@");
		
		//System.out.println(revwService.updateRsvdRevwStus(userId, rsvdId));
		rttr.addFlashAttribute("result", revw.getRevwId());
		return "redirect:/dealight/mypage/review/writable-list";
	}
}
