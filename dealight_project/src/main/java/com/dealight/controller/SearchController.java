package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
import com.dealight.service.SearchService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/search/*")
@AllArgsConstructor
public class SearchController {

	private SearchService sService;
	
	
	@GetMapping("/")
	public String list(Criteria cri, Model model) {
		
		log.info("Criteria:" + cri +";");
		
		model.addAttribute("pageMaker", cri);
		
		return "/search/list";
	}
}
