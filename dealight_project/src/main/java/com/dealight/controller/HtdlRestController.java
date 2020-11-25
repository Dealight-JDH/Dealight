package com.dealight.controller;

import java.util.List;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dealight.domain.HtdlCriteria;
import com.dealight.domain.HtdlPageDTO;
import com.dealight.domain.HtdlVO;
import com.dealight.service.HtdlService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

//jongwoo

@RestController
@Log4j
@RequiredArgsConstructor
@RequestMapping("/dealight/hotdeal/*")
public class HtdlRestController {
	
	private final HtdlService service;
	
	
	@GetMapping(value = "/main/{stusCd}/{page}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public HttpEntity<List<HtdlVO>> main(@PathVariable String stusCd, @PathVariable int page) {
		
		//상태에 따른 핫딜 리스트 필터
//		List<HtdlVO> filterList = service.getList().stream()
//				.filter(htdl -> htdl.getStusCd().equals(stusCd))
//				.collect(Collectors.toList());
		
//		log.info("==========================hotdeal: " + filterList);

		HtdlCriteria hCri = new HtdlCriteria(page, 9);
//		int total = service.getTotal(stusCd, hCri);
//		List<HtdlVO> lists = service.getList(stusCd, hCri);
		
		log.info("hCri: " + hCri);
		return new ResponseEntity(service.getListPage(stusCd, hCri), HttpStatus.OK);
	}
	

	//핫딜 상세
	@GetMapping(value = "/get/{htdlId}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public HttpEntity<HtdlVO> get(@PathVariable Long htdlId) {
		log.info("get...");
		
		return new ResponseEntity(service.read(htdlId), HttpStatus.OK);
		
	}
}
