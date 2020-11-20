package com.dealight.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/*")
@AllArgsConstructor
public class MainController {

	@GetMapping("/main")
	public void getMain() {
		
	}
}
