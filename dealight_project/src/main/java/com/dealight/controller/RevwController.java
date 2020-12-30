package com.dealight.controller;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.RsvdWithWaitDTO;
import com.dealight.service.RevwService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/review/*")
@AllArgsConstructor
public class RevwController {

	private RevwService revwService;
	
	private StoreService storeService;
	
	private RsvdService rsvdService;

	@GetMapping({"","writable-list"})
	public String getWritableList(HttpSession session, Model model,Criteria cri) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
		String userId = (String) session.getAttribute("userId");

		if(cri.getPageNum() == 0)
			cri = new Criteria(1,5);
		
		
		List<RsvdWithWaitDTO> dtoList = revwService.getWritableListWithPagingByUserId(userId, cri);
		dtoList.stream().forEach(dto -> {
			
			if(dto.getRsvd() != null){
				RsvdVO rsvd = rsvdService.findRsvdByRsvdIdWithDtls(dto.getRsvd().getRsvdId());
				String tmpNm = rsvd.getRsvdDtlsList().get(rsvd.getRsvdDtlsList().size() -1).getMenuNm();
				rsvd.getRsvdDtlsList().stream().forEach(dtls -> {
					dtls.setMenuNm(dtls.getMenuNm() + ", ");
				});
				rsvd.getRsvdDtlsList().get(rsvd.getRsvdDtlsList().size() -1).setMenuNm(tmpNm);
				rsvd.setStoreRepImg(storeService.getBStore(dto.getStoreId()).getRepImg());
				dto.setRsvd(rsvd);
			} else if (dto.getWait() != null) {
				dto.getWait().setStoreRepImg(storeService.getBStore(dto.getStoreId()).getRepImg());
			}
		});
		int writableRsvd = revwService.countWritableRsvd(userId);
		int writableWait = revwService.countWritableWait(userId);
		int total = writableRsvd + writableWait;
		
		log.info("dtoList..................... : "+dtoList);
		
		model.addAttribute("userId", userId);
		model.addAttribute("dtoList",dtoList);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
		model.addAttribute("writableRsvd",writableRsvd);
		model.addAttribute("writableWait",writableWait);
		
		return "/dealight/mypage/review/writable-list";
	}

	@GetMapping("/written-list")
	public void getWrittenList(HttpSession session, Model model,Criteria cri) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
	    String userId = (String) session.getAttribute("userId");
	    
	    log.info("before cri................" + cri);
	    
		if(cri.getPageNum() == 0)
			cri = new Criteria(1,5);
		
		log.info("after cri................" + cri);
	    
	    int countRevw = revwService.countRevw(userId);
	    int countRsvd = revwService.countRsvd(userId);
	    int countWait = revwService.countWait(userId);
	    int countTotal = revwService.countTotal(userId);
	    
	    List<RevwVO> writtenList = revwService.getWrittenListWtihPagingByUserId(userId, cri);
	    writtenList.stream().forEach(revw -> {
	    	if(revw.getImgs() != null)
	    	log.info("revw imgs : " + revw.getImgs());
	    	revw.getImgs().stream().forEach(img -> {
	    		if(img != null && img.getUploadPath() != null)
	    		img.setUploadPath(img.getUploadPath().replace("\\", "/"));
	    	});
	    });
	    
	    log.info("writeentList size..................."+writtenList.size());
		
		model.addAttribute("countRevw", countRevw);
		model.addAttribute("countRsvd", countRsvd);
		model.addAttribute("countWait", countWait);
		model.addAttribute("countTotal", countTotal);
		model.addAttribute("writtenList", writtenList);
		model.addAttribute("pageMaker",new PageDTO(cri,countRevw));
	}

	// 예약 리뷰 작성
	@PostMapping("/register")
	public String registerRevw(HttpSession session, Model model,RevwVO revw,String prevPage) {
		
		// 임시로 'kjuioq'의 아이디를 로그인한다.
		//session.setAttribute("userId", "kjuioq");
	    String userId = (String) session.getAttribute("userId");
	    
	    log.info("revw register .......................");
	    log.info("revw ........................" + revw);
	    log.info("prev page...................."+prevPage);
	    
	    revwService.regRevw(revw);
	    
	    
	    return "redirect:/dealight/mypage/" + prevPage;
	}
}
