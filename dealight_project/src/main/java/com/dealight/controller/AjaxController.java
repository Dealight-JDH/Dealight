package com.dealight.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.dealight.domain.LikeListDTO;
import com.dealight.domain.LikeVO;
import com.dealight.domain.MainStoreJoinVO;
import com.dealight.domain.PageDTO;
import com.dealight.domain.RsvdAvailVO;
import com.dealight.domain.WaitVO;
import com.dealight.service.LikeService;
import com.dealight.service.RsvdService;
import com.dealight.service.SearchService;
import com.dealight.service.WaitService;

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
	private WaitService waitService;
	private RsvdService rsvdService;
	
	@GetMapping(value = "/getlist",
			produces = {
						 MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<PageDTO> getList(int pageNum, int amount, double distance, double lat, double lng, String sortType, String sortPriority, boolean openStore, String userId){
		
		Criteria cri = new Criteria(pageNum, amount, distance, lat, lng, sortType, sortPriority, openStore);

		log.info("Critria:"+cri);
		
//		if(cri.getSortType().equals("D") || cri.getSortType() == null) {
//			
//			return new ResponseEntity<PageDTO>(sService.getListDistStore(cri), HttpStatus.OK);
//		}
		PageDTO dto = sService.getListstore(cri);
		//하드코딩
		if(userId != null) {
			List<MainStoreJoinVO> storeList = dto.getStoreList();
			List<LikeVO> like = likeService.findListByUserId(userId);
			
			for (MainStoreJoinVO store : storeList) {
				long storeId = store.getStoreId();
				for (LikeVO likeVO : like) {
					if(storeId == likeVO.getStoreId()) {
						store.setLike(true);
					}//if
				}//for
			}//for
			dto.setStoreList(storeList);
		}
		return new ResponseEntity<PageDTO>(dto, HttpStatus.OK);
	}
	
	@GetMapping(value = "/mypage/like/{pageNum}/{amount}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<LikeListDTO> getLikeList(HttpSession session,@PathVariable("pageNum") int pageNum, @PathVariable("amount") int amount){

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");

		LikeListDTO dto = new LikeListDTO();
		Criteria cri = new Criteria(pageNum, amount);
		int total = likeService.getLikeTotalByUserId(userId, cri);

		//dto.setLikeList(likeService.findListWithPagingByUserId(userId, cri));
		dto.setTotal(total);
		dto.setPageMaker(new PageDTO(cri,total));

		return  new ResponseEntity<>(dto, HttpStatus.OK);
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
	
	@GetMapping(value = "/isCurWait/{userId}",produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<WaitVO> isCurWait(@PathVariable("userId")String userId) {
		
		return new ResponseEntity<>(waitService.getCurWaitByUserId(userId),HttpStatus.OK);
	}
	
	@GetMapping(value = "/waitcnt/{storeId}",produces= MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<Integer> waitCnt(@PathVariable("storeId")long storeId) {
		
		return new ResponseEntity<>(sService.getStoreWaitCnt(storeId),HttpStatus.OK);
	}
	
	@GetMapping(value = "/rsvdavailcheck/{storeId}/{time}/{pnum}")
	public @ResponseBody ResponseEntity<Boolean> rsvdAvailCheck(
			@PathVariable Long storeId ,@PathVariable String time, @PathVariable Integer pnum){
		
		//해당 매장의 예약가능 여부
		RsvdAvailVO rsvdAvailVO = rsvdService.getRsvdAvailByStoreId(storeId);
		log.info("=======================================rsvdvailcheck");
		boolean checked = rsvdService.isRsvdAvailChecked(rsvdAvailVO, time, pnum);
//		return new ResponseEntity<Boolean>(body, status);
		return new ResponseEntity<Boolean>(checked, HttpStatus.OK);
	}
}
