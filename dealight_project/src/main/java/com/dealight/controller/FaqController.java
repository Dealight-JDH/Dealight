package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
import com.dealight.service.FaqService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/custservice/*")
@AllArgsConstructor
public class FaqController {

	private FaqService fService;
	
	//==========================FAQ
	@GetMapping("/")
	public String FaqList(Criteria cri, Model model) {
		log.info("==================FaqList==================");
		
		if(cri == null || cri.getPageNum()<1)
			cri = new Criteria(1, 10);
		
		int total = fService.getTotal(cri);
		
		log.info("Total count : " + total);
		
		
		model.addAttribute("list", fService.getList(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, total));
		
		return "dealight/custservice/faqlist";
	}
	
	@GetMapping("/getfaq")
	public void getFAQ(@RequestParam("faqId") long faqId, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("================get FAQ==================");
		log.info("faqId : "+ faqId);
		log.info("Criteria : " +cri);
		
		model.addAttribute("faq", fService.get(faqId));
	}
	
	
	
	
	
}
