package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@GetMapping("/usermanage/brnomanage")
	public String bizAuthList(Model model) {
		
		log.info("bizAuthList");
		
		model.addAttribute("list", service.getBUserList());
		
		return "/dealight/admin/usermanage/brnomanage/list";
	}
	
	
}
