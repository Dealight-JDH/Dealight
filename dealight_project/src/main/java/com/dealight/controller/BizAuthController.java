package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.BUserVO;
import com.dealight.service.BizAuthService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/bizAuth/*")
@AllArgsConstructor
public class BizAuthController {

	private BizAuthService service;
	
	@PostMapping("/register")
	public String brnoRegister(BUserVO buser, RedirectAttributes rttr) {
		
		log.info("buser : " + buser);
		
		service.register(buser);
		
		rttr.addAttribute("brSeq", buser.getBrSeq());
		
		return "redirect:/dealight/mypage/bizAuth/list";
	}
	
	@GetMapping("/list")
	public void list(Model model) {
		
		log.info("list");
		
		model.addAttribute("list", service.getList());
		
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("brSeq")long brSeq, Model model) {
		
		log.info("get by brSeq : " + brSeq);
		
		model.addAttribute("buser", service.read(brSeq));
		
	}
	
//	@PostMapping("/modify")
//	public String
	
}
