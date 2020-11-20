package com.dealight.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
import com.dealight.service.SearchService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//현중
@RequestMapping("/list")
@RestController
@Log4j
@AllArgsConstructor
public class ListController {

	private SearchService service;
	
	@GetMapping(value = "/",
			produces = {
						 MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<PageDTO> getList(int pageNum, int amount, double distance, double lat, double lng, String sortType, String sortPriority, boolean openStore){
		Criteria cri = new Criteria(pageNum, amount, distance, lat, lng, sortType, sortPriority, openStore);
		log.info("Critria:"+cri);
		return new ResponseEntity<PageDTO>(service.getListstore(cri), HttpStatus.OK);
	}
	
	
}
