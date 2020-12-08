package com.dealight.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwPageDTO;
import com.dealight.service.RevwService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//다울
@RequestMapping("/revws/*")
@RestController
@AllArgsConstructor
@Log4j
public class StoreRevwController {
	private RevwService revwService;

	/*
	@GetMapping(value="/pages/{storeId}/{page}",
			produces= {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
	public ResponseEntity<RevwPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("storeId") Long storeId ){
		
		Criteria cri = new Criteria(page,4);
		log.info("getList revw list"+ storeId);
		log.info("cri: "+cri);
		
		return new ResponseEntity<>(revwService.getRevwListWithPagingByStoreId(storeId, cri), HttpStatus.OK);
	}
	*/
}
