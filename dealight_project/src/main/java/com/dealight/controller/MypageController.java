package com.dealight.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.LikeListDTO;
import com.dealight.domain.LikeVO;
import com.dealight.domain.PageDTO;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.WaitVO;
import com.dealight.service.LikeService;
import com.dealight.service.RevwService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/*")
public class MypageController {


	@Autowired
	UserService userService;

	@Autowired
	StoreService storeService;

	@Autowired
	RsvdService rsvdService;

	@Autowired
	WaitService waitService;

	@Autowired
	RevwService revwService;

	@Autowired
	LikeService likeService;

	/*
	 * 마이페이지 로직 순서
	 * 1. 각 컨트롤러 메서드별로 필요한 vo,mapper,service를 수집한다.
	 * 2. 모든 mapper와 service를 test를 거쳐 순서대로 구성한다.
	 * 3. 페이징 처리를 로직을 구성한다.
	 * 4. view에 성공적으로 데이터를 뿌린다.
	 * 5. view 화면에 공통부분을 구현한다.
	 * 6. view 화면에 레이아웃을 구성한다.
	 * 7. review 로직으로 넘어간다.
	 * 8. 로그인 관련 로직을 결합시킨다. 
	 * 
	 */

	//마이페이지 예약내역
	@GetMapping({"/reservation","/" })
	public String reservation(Model model, HttpSession session, Criteria cri) {

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");

		if(cri.getPageNum() == 0)
			cri = new Criteria(1,5);

		
		List<RsvdVO> rsvdList = rsvdService.findRsvdListWithPagingAndDtlsByUserId(userId, cri);

		// rsvd 메뉴 이름 저장
		// 너무 로직이 복잡하다. 추후에 변경 요망
		rsvdList.stream().forEach(rsvd -> {
			String tmpNm = rsvd.getRsvdDtlsList().get(rsvd.getRsvdDtlsList().size() -1).getMenuNm();
			rsvd.getRsvdDtlsList().stream().forEach(dtls -> {
				dtls.setMenuNm(dtls.getMenuNm() + ", ");
			});
			rsvd.getRsvdDtlsList().get(rsvd.getRsvdDtlsList().size() -1).setMenuNm(tmpNm);
			
			// 변경 필요
			rsvd.setStoreRepImg(storeService.getBStore(rsvd.getStoreId()).getRepImg());
		});

		int last = rsvdService.getRsvdLastCount(userId, cri);
		int curCnt = rsvdService.getRsvdCompleteCount(userId, cri);
		int total = last + curCnt;

		model.addAttribute("userId",userId);
		model.addAttribute("rsvdList",rsvdList);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
		model.addAttribute("last",last);
		model.addAttribute("curCnt",curCnt);
		model.addAttribute("total",total);

		return "/dealight/mypage/reservation";
	}


	// 3. store with store loc를 모달로 보여준다.
	// rest 방식으로 json으로 모달로 보여주자.
	@GetMapping(value = "/reservation/store/{userId}/{storeId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<StoreVO> storeWithLoc(@PathVariable("userId") String userId, @PathVariable("storeId") Long storeId){
		
		StoreVO store = storeService.findStoreWithBStoreAndLocByStoreId(storeId);
		
		store.setEval(storeService.getEval(storeId));
		
		LikeVO like = likeService.findByUserIdAndStoreId(userId, storeId);
		
		if(like != null)
			store.setLike(true);
		store.isLike();

		return  new ResponseEntity<>(store, HttpStatus.OK);
	}

	@GetMapping(value = "/reservation/review", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<StoreVO> getReview(Long storeId){

		return  new ResponseEntity<>(storeService.findStoreWithLocByStoreId(storeId), HttpStatus.OK);
	}

	@GetMapping(value = "/review/rsvd/{rsvdId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<RevwVO> getRevwByRsvdId(HttpSession session,@PathVariable("rsvdId") Long rsvdId){

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");
		
		log.info("rsvd id .................. : " + rsvdId);
		
		RevwVO revw = revwService.findRevwWtihImgsByRsvdId(rsvdId);
		
		log.info("revw ...................... : " + revw);

		return  new ResponseEntity<>(revw, HttpStatus.OK);
	} 
	
	@GetMapping("/wait")
	public String wait(Model model, HttpSession session, Criteria cri) {

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");

		if(cri.getPageNum() == 0)
			cri = new Criteria(1,5);

		List<WaitVO> waitList = waitService.findWaitListWithPagingByUserId(userId, cri);
		waitList.stream().forEach(wait -> {
			BStoreVO store = storeService.getBStore(wait.getStoreId());
			wait.setStoreRepImg(store.getRepImg());
		});

		int curWaitCnt = waitService.getCurWaitCnt(userId, cri);
		int enterCnt = waitService.getEnterWaitCnt(userId, cri);
		int panaltyCnt = waitService.getPanaltyWaitCnt(userId, cri);
		int total = curWaitCnt + enterCnt + panaltyCnt;

		WaitVO curWait = waitService.getCurWaitByUserId(userId);

		model.addAttribute("userId",userId);
		model.addAttribute("waitList",waitList);
		model.addAttribute("curWaitCnt",curWaitCnt);
		model.addAttribute("enterCnt",enterCnt);
		model.addAttribute("panaltyCnt",panaltyCnt);
		model.addAttribute("total",total);
		model.addAttribute("curWait",curWait);
		model.addAttribute("pageMaker",new PageDTO(cri,total));


		return "/dealight/mypage/wait";
	}
	
	@GetMapping(value = "/review/wait/{waitId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<RevwVO> getRevwByWaitId(HttpSession session,@PathVariable("waitId") Long waitId){

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");

		return  new ResponseEntity<>(revwService.findRevwWtihImgsByWaitId(waitId), HttpStatus.OK);
	} 

	@GetMapping("/like")
	public String like(Model model, HttpSession session,Criteria cri) {

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");
		

		// TODO 찜 목록은 Grid 형식으로 보여준다.
		if(cri.getPageNum() == 0)
			cri = new Criteria(1,5);

		List<StoreVO> storeList = likeService.findStoreListWithPagingByUserId(userId, cri);
		int total = likeService.getLikeTotalByUserId(userId, cri);

		model.addAttribute("userId", userId);
		model.addAttribute("storeList", storeList);
		model.addAttribute("total",total);
		model.addAttribute("pageMaker",new PageDTO(cri,total));

		return "/dealight/mypage/like";
	}
	
	@GetMapping(value = "/like/list/{pageNum}/{amount}/{userId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<LikeListDTO> getLikeList(@PathVariable("pageNum") int pageNum, @PathVariable("amount") int amount,
														@PathVariable("userId") String userId){
		LikeListDTO dto = new LikeListDTO();
		Criteria cri = new Criteria(pageNum,amount);
		dto.setStoreList(likeService.findStoreListWithPagingByUserId(userId,cri));
		dto.setTotal(likeService.getLikeTotalByUserId(userId, cri));
		dto.setPageMaker(new PageDTO(cri,dto.getTotal()));
		
		return new ResponseEntity<>(dto, HttpStatus.OK);
	}

	
	
	

//	@GetMapping("/modify")
	public String modify(Model model, HttpSession session) {

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");
		UserVO user = userService.read(userId);
		

		model.addAttribute("user",user);

		return "/dealight/mypage/modify";
	}

//	@PostMapping("/modify")
	public String modifyPost(Model model, HttpSession session, RedirectAttributes rttr, UserVO user) {

		boolean result = userService.modify(user);

		if(result)
			rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
		else
			rttr.addFlashAttribute("msg", "수정이 실패했습니다.");

		return "redirect:/dealight/mypage/modify";
	}


	@PostMapping("/withdrawal")
	public String withdrawal(Model model, HttpSession session) {

		String userId = (String) session.getAttribute("userId");

		userService.withdrawalUser(userId);

		return "redirect:/dealight/dealight";
	}

	@GetMapping("/myreview")
	public String review(HttpSession session) {

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");

		String userId = (String) session.getAttribute("userId");

		return "/dealight/mypage/myreview";
	}

	@GetMapping("/changepwd")
	public String changepwd(HttpSession session,Model model) {

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		String userId = (String) session.getAttribute("userId");
		UserVO user = userService.read(userId);

		model.addAttribute("user",user);

		return "/dealight/mypage/changepwd";
	}

	@PostMapping("/changepwd")
	public String changepwdPost(HttpSession session, String pwd, String changepwd, RedirectAttributes rttr) {

		log.info("change pwd...............");

		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");
		UserVO user = userService.read(userId);

		// 비밀번호가 일치할 때
		if(pwd.equals(user.getPwd())) {
			user.setPwd(changepwd);
			boolean result = userService.changePwd(user);
			if(result) {
				String msg = "비밀번호가 변경되었습니다.";
				rttr.addFlashAttribute("msg",msg);
			}
			return "redirect:/dealight/mypage/changepwd"; 
		}
		// 비밀번호가 일치하지 않을 때
		else {
			String msg = "비밀번호가 틀렸습니다.";
			rttr.addFlashAttribute("msg",msg);
			return "redirect:/dealight/mypage/changepwd";
		}

	}
	
	// 리뷰의 이미지를 가져온다.
	@GetMapping(value = "/getRevwImgs", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<RevwImgVO>> getStoreImage(Long revwId) {
		
		log.info("getAttachList" + revwId);
		
		return new ResponseEntity<>(revwService.findRevwImgsByRevwId(revwId), HttpStatus.OK);
	}

	@GetMapping("/notice")
	public String notice() {

		// 필요없는 페이지 같다. 삭제 요망

		return "/dealight/mypage/notice";
	}
	
	// rsvdId로 예약 객체와 예약 상세 객체를 가져온다.
	@GetMapping(value = "/reservation/dtls/{rsvdId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	@ResponseBody
	public ResponseEntity<RsvdVO> getRsvdDtls(@PathVariable("rsvdId") Long rsvdId) {
		
		log.info("get rsvd dtls..................");
		
		return new ResponseEntity<>(rsvdService.findRsvdByRsvdIdWithDtls(rsvdId), HttpStatus.OK);
	}
	
	// 해당 유저의 매장 내역 리스트를 보여준다. 
	@GetMapping(value = "/reservation/list/{storeId}/{userId}", 
			produces = {
					MediaType.APPLICATION_JSON_UTF8_VALUE,
					MediaType.APPLICATION_XML_VALUE
	})
	@ResponseBody
	public ResponseEntity<List<RsvdVO>> getRsvdList(@PathVariable("storeId") long storeId, @PathVariable("userId") String userId) {
		
		log.info("get user rsvd list....................");		
		
		List<RsvdVO> rsvdList = userService.getRsvdListStoreUser(storeId, userId);
		
		rsvdList = rsvdList.stream().sorted((r1,r2) -> (int) (r2.getRegdate().getTime() - r1.getRegdate().getTime())).collect(Collectors.toList());
		
		return new ResponseEntity<>(rsvdList, HttpStatus.OK);
		//return new ResponseEntity<>(userService.getRsvdListStoreUser(storeId, userId), HttpStatus.OK);
	}	


}
