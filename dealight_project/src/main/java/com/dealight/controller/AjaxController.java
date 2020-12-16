package com.dealight.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
import com.dealight.service.LikeService;
import com.dealight.service.SearchService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//현중
@RequestMapping("/dealight/*")
@RestController
@Log4j
@AllArgsConstructor
public class AjaxController {

	private SearchService sService;
	private LikeService likeService;
	
	@GetMapping(value = "/getlist",
			produces = {
						 MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<PageDTO> getList(int pageNum, int amount, double distance, double lat, double lng, String sortType, String sortPriority, boolean openStore){
		
		Criteria cri = new Criteria(pageNum, amount, distance, lat, lng, sortType, sortPriority, openStore);

		log.info("Critria:"+cri);
		
		if(cri.getSortType().equals("D") || cri.getSortType() == null) {
			
			return new ResponseEntity<PageDTO>(sService.getListDistStore(cri), HttpStatus.OK);
		}
		
		return new ResponseEntity<PageDTO>(sService.getListstore(cri), HttpStatus.OK);
	}
	
	@PostMapping(value = "/mypage/like/add/{userId}/{storeId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<Boolean> pickLike(@PathVariable("userId")String userId, @PathVariable("storeId") Long storeId){

		log.info("like add.........................");
		log.info("user id : " + userId);
		log.info("store id : " + storeId);
		
		likeService.pick(userId,storeId);
		
		return new ResponseEntity<>(true, HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/mypage/like/remove/{userId}/{storeId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<Boolean> removeLike(@PathVariable("userId")String userId, @PathVariable("storeId") Long storeId){

		return  new ResponseEntity<>(likeService.cancel(userId, storeId), HttpStatus.OK);
	}
	
}
