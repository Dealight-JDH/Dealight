package com.dealight.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.SearchDTO;
import com.dealight.service.HtdlService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

//현중
@Controller
@Log4j
@RequestMapping("/dealight/*")
@AllArgsConstructor
public class SearchController {

	private HtdlService hService;
	
	@GetMapping("/search")
	public String list(SearchDTO search, Model model) {
		
		//searchDTO 유효성검사를 해줘야한다.
		
		log.info("SearchDTO:" + search +";");
		
		model.addAttribute("search", search);
		
		
		return "dealight/search/map";
	}
	
	@GetMapping("/dealight")
	public void getHtdl(Model model) {
		
		model.addAttribute("htdl", hService.readMainHtdlList());
	}
}
