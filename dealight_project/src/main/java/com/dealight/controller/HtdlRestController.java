package com.dealight.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dealight.domain.HtdlCriteria;
import com.dealight.domain.HtdlPageDTO;
import com.dealight.domain.HtdlSearchDTO;
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
	
	
	@GetMapping(value="/get/search/{stusCd}/{page}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_FORM_URLENCODED_VALUE
	})
	public ResponseEntity<HtdlPageDTO> searchHtdl(@PathVariable String stusCd, @PathVariable int page,
			HtdlSearchDTO requestDto, BindingResult bindingResult) {
		if(bindingResult.hasErrors()) {
			
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String sysdate = format.format(date);
		
		log.info("htdl search...");
		
		log.info("=====================search request: " + requestDto);
		
		HtdlCriteria hCri = new HtdlCriteria(page, 9);
		hCri.setKeyword(requestDto.getRegion());
		hCri.setStartTm(sysdate+" "+ requestDto.getStartTm());
		hCri.setEndTm(sysdate+" " + requestDto.getEndTm());
//		hCri.setStartTm("2020/11/27 "+requestDto.getStartTm());
//		hCri.setEndTm("2020/11/27 "+requestDto.getEndTm());
		log.info("===========requestDto get startTm: " + requestDto.getStartTm());
		log.info("===========requestDto get endTm: " + requestDto.getEndTm());
		
		return new ResponseEntity<>(service.getListPage(stusCd, hCri), HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/main/{stusCd}/{page}", produces = {
			MediaType.APPLICATION_JSON_UTF8_VALUE,
			MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<HtdlPageDTO> main(@PathVariable String stusCd, @PathVariable int page) {
		
		//상태에 따른 핫딜 리스트 필터
//		List<HtdlVO> filterList = service.getList().stream()
//				.filter(htdl -> htdl.getStusCd().equals(stusCd))
//				.collect(Collectors.toList());
		
//		log.info("==========================hotdeal: " + filterList);

		HtdlCriteria hCri = new HtdlCriteria(page, 9);
//		int total = service.getTotal(stusCd, hCri);
//		List<HtdlVO> lists = service.getList(stusCd, hCri);
		
		log.info("hCri: " + hCri);
		return new ResponseEntity<>(service.getListPage(stusCd, hCri), HttpStatus.OK);
	}
	
	
	//핫딜 상태 체크
	@GetMapping(value="/get/stuscd/{htdlId}", produces = {
			MediaType.TEXT_PLAIN_VALUE
	})
	public ResponseEntity<String> getStusCd(@PathVariable Long htdlId) {
		
		log.info("htdlId......: " + htdlId);
		log.info("get stusCd by htdlId....");
		return new ResponseEntity<String>(service.getStusCdById(htdlId), HttpStatus.OK);
	}
	

	//핫딜 상세
//	@GetMapping(value = "/get/{htdlId}", produces = {
//			MediaType.APPLICATION_JSON_UTF8_VALUE,
//			MediaType.APPLICATION_XML_VALUE
//	})
//	public ResponseEntity<HtdlVO> get(@PathVariable Long htdlId) {
//		log.info("get...");
//		
//		return new ResponseEntity(service.read(htdlId), HttpStatus.OK);
//		
//	}
	
	
//	@GetMapping(value = "/get/{storeId}", produces = {
//			MediaType.APPLICATION_JSON_UTF8_VALUE,
//			MediaType.APPLICATION_XML_VALUE
//	})
//	public HttpEntity<HtdlVO> getByStoreId(@PathVariable Long storeId) {
//		log.info("get...");
//		
//		return new ResponseEntity(service.readActStoreHtdlList(storeId), HttpStatus.OK);
//		
//	}

}
