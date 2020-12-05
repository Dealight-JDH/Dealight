package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.BUserVO;
import com.dealight.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/admin/*")
@AllArgsConstructor
public class AdminController {

	private AdminService service;

	@GetMapping("/main")
	public void adminMain() {
	}

	@GetMapping("/brnomanage")
	public String bizAuthList(Model model) {

		log.info("bizAuthList");

		model.addAttribute("list", service.getBUserList());

		return "/dealight/admin/brnomanage/list";
	}
	
	@GetMapping("/brnomanage/register")
	public void register() {
		
	}
	
	@PostMapping("/brnomanage/register")
	public String register(BUserVO buser, RedirectAttributes rttr) {
		log.info("register :" + buser);
		
		service.registerBUser(buser);
		
		rttr.addFlashAttribute("result", buser.getBrSeq());
		
		return "redirect:/dealight/admin/brnomanamge";
	}
	

	@GetMapping({ "/brnomanage/get", "/brnomanage/modify" })
	public void get(@RequestParam("brSeq") long brSeq, Model model) {

		log.info("get by brSeq : " + brSeq);

		model.addAttribute("buser", service.readBUser(brSeq));
	}

	@PostMapping("/brnomanage/modify")
	public String modify(BUserVO buser, RedirectAttributes rttr) {
		
		log.info("modify : " + buser);
		
		if(service.modifyBUser(buser)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/admin/brnomanage";
	}
	
	@PostMapping("/brnomanage/remove")
	public String delete(@RequestParam("brSeq") long brSeq, RedirectAttributes rttr) {
		
		log.info("remove by brSeq : " +brSeq);
		
		if(service.deleteBUser(brSeq)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/admin/brnomanage";
	}
	
}
