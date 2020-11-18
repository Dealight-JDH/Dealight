package com.dealight.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.RevwImgVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.RevwVO;
import com.dealight.service.RevwService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/review/*")
@AllArgsConstructor
public class RevwController {

	private RevwService service;

	@GetMapping("/written-list")
	public void getWrittenList(@Param("userId") String userId, RevwVO revw, Model model) {
		log.info("USERID: " + userId + "@@");
		model.addAttribute("userId", userId);

		log.info("COUNT REVW...");
		model.addAttribute("countRevw", service.countRevw(userId));

		log.info("COUNT STORE...");
		model.addAttribute("countStore", service.countStore(userId));

		log.info("WRITTEN LIST... ");
		model.addAttribute("written", service.getWrittenList(userId));
	}

	@GetMapping("/writable-list")
	public void getWritableList(String userId, Model model) {
		log.info("WRITABLE LIST");
		log.info("USERID: " + userId + "@@");

		model.addAttribute("userId", userId);
		model.addAttribute("rsvdList", service.getWritableListByRsvd(userId));
		model.addAttribute("waitList", service.getWritableListByWait(userId));
	}

	@PostMapping("/writable-list")
	public String getWritableList(@RequestParam("userId") String userId, RevwVO revw, RevwImgVO img) {

		log.info("REGISTER REVW: " + revw + "@@");
		log.info("REGISTER REVW IMG: " + img + "@@");

		return "redirect:/dealight/mypage/review/register?userId=" + userId;
	}

	@GetMapping("/register/rsvd")
	public void getWritableItemByRsvd(@Param("userId") String userId, @Param("rsvdId") Long rsvdId, Model model) {
		log.info("USERID: " + userId + "@@");
		log.info("RSVDID: " + rsvdId + "@@");

		model.addAttribute("rsvd", service.getWritableItemByRsvd(userId, rsvdId));
		System.out.println(model);
	}

	@PostMapping("/register/rsvd")
	public String registerRevwByRsvd(String userId, Long rsvdId, String imgUrl,
			RevwVO revw, RevwImgVO img, RedirectAttributes rttr) {

		service.getWritableItemByRsvd(userId, rsvdId);

		if(!img.getImgUrl().equals("")) {
			service.registerRevw(revw);
			service.registerRevwImg(img);

			log.info("REGISTER RSVD REVW");
			log.info("USERID: " + userId + "@@");
			log.info("RSVDID: " + rsvdId + "@@");
			log.info("REVW: " + revw + "@@");

		} else {
			service.registerRevw(revw);

			log.info("REGISTER RSVD REVW");
			log.info("USERID: " + userId + "@@");
			log.info("RSVDID: " + rsvdId + "@@");
			log.info("REVW: " + revw + "@@");
			log.info("IMG: " + img + "@@");
		}

		System.out.println(service.updateRsvdRevwStus(userId, rsvdId));
		rttr.addFlashAttribute("result", revw.getRevwId());
		return "redirect:/dealight/mypage/review/writable-list?userId=" + userId;
	}

	@GetMapping("/register/wait")
	public void getWritableItemByWait(@Param("userId") String userId, @Param("waitId") Long waitId, Model model) {
		log.info("USERID: " + userId + "@@");
		log.info("WAITID: " + waitId + "@@");

		model.addAttribute("wait", service.getWritableItemByWait(userId, waitId));
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
		return "redirect:/dealight/mypage/review/writable-list?userId=" + userId;
	}
}
