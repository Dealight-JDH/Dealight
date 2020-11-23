package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.Criteria;
import com.dealight.domain.RsvdMenuDTOList;
import com.dealight.service.StoreService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//다울
@Controller
@Log4j
@RequestMapping("/dealight/*")
@AllArgsConstructor
public class StoreController {

	private StoreService service;

	@GetMapping("/store")
	public String store(Long storeId,Criteria cri,Model model,String clsCd) {
		// store타입을 체크 한다 n일경우 n 스토어를 보여줌 b일 경우 b를 보여줌
		
		//다울 nstore check
		if (clsCd.equalsIgnoreCase("B")) {
			log.info("bstore: " + storeId);
			model.addAttribute("store", service.bstore(storeId));
			//model.addAttribute("revws", service.revws(storeId,cri));
			return "/dealight/store/bstore";
		} else {
			log.info("nstore: " + storeId);
			model.addAttribute("store", service.nstore(storeId));
			return "/dealight/store/nstore";
		}

	}

	@PostMapping("/reservation")
	public void reservation(Model model, RsvdMenuDTOList rsvdMenuList, String pnum, String time, Long storeId) {
		model.addAttribute("store", service.bstore(storeId));
		model.addAttribute("rsvdMenuList", rsvdMenuList); 
		model.addAttribute("pnum", pnum); 
		model.addAttribute("time", time);
		log.info(rsvdMenuList);
	
	}
	
	@PostMapping("/waiting")
	public void waiting(Model model, String pnum, Long storeId) {
		model.addAttribute("store", service.bstore(storeId));
		model.addAttribute("pnum", pnum); 
	}

}
