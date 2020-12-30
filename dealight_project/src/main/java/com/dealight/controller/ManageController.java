package com.dealight.controller;

import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.PageDTO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreTagVO;
import com.dealight.domain.StoreVO;
import com.dealight.service.HtdlService;
import com.dealight.service.RevwService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인] 
 * 
 */

@Controller
@Log4j
@RequestMapping("/dealight/business/manage/*")
public class ManageController {
	
	@Setter(onMethod_ = @Autowired)
	private StoreService storeService;
	
	@Setter(onMethod_ = @Autowired)
	private RsvdService rsvdService;
	
	@Setter(onMethod_ = @Autowired)
	private HtdlService htdlService;
	
	@Setter(onMethod_ = @Autowired)
	private WaitService waitService;
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@Setter(onMethod_ = @Autowired)
	private RevwService revwService;
	
	// 파일 저장 경로를 지정한다.
	final static private String ROOT_FOLDER = "C:\\dealgiht\\rds\\";
	
	// 핫딜 히스토리
	@GetMapping("/dealhistory")
	public String dealHistory(Model model,long storeId,HttpServletRequest request,Criteria cri) {
		
		log.info("business manage dealhistory..");
		
		log.info("before cri : "+cri);
		
		if(cri.getPageNum() < 1)
			cri = new Criteria(1,10);
		
		log.info("after cri : "+cri);
		
		List<HtdlVO> htdlList = htdlService.findHtdlWithRsltByStoreId(storeId, cri);
		
		model.addAttribute("htdlList",htdlList);
		
		
		int total = htdlService.getHtdlTotal(storeId, cri);
		
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		HtdlVO curHtdl = htdlService.getHtdlDetail(storeId);
		
		log.info("htdlList : " + htdlList);
		log.info("cur htdl : "+curHtdl);
		
		model.addAttribute("curHtdl",curHtdl);
		model.addAttribute("storeId",storeId);
		model.addAttribute("store",store);
		model.addAttribute("pageMaker",new PageDTO(cri,total));
		
		return "/dealight/business/manage/dealhistory";
	}
	
	// 매장 수정 페이지
	@GetMapping("/modify")
	public String storeModify(Model model,Long storeId, HttpServletRequest request,Criteria cri) {
		
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");
		
		log.info("business store modify get.." + storeId);
		
		if(storeId == null)
			storeId = (Long) request.getAttribute("storeId");
		
		
		// All Store
		
		// 매장
		// B store
		// 매장 위치
		// 매장 평가
		// 사진리스트
		
		// 메뉴
		// 리뷰리스트
		// 태그리스트
	
		
		AllStoreVO allStore = storeService.findAllStoreInfoByStoreId(storeId);
		
		log.info("All store......................"+allStore);
		
		if(cri.getPageNum() == 0)
			cri = new Criteria(1,5);
		
		List<RevwVO> revwList = revwService.getRevwListWithPagingByStoreId(storeId, cri);
		
		revwList.stream().forEach(revw -> {
	    	if(revw.getImgs() != null)
	    	revw.getImgs().stream().forEach(img -> {
	    		if(img != null && img.getUploadPath() != null)
	    		img.setUploadPath(img.getUploadPath().replace("\\", "/"));
	    	});
	    });
		
		if(allStore != null) {
			List<MenuVO> menuList = allStore.getMenuList();
			
			log.info(menuList);
			
			menuList.stream().forEach((menu) -> {
				if(menu.getThumImgUrl() != null)
					menu.setEncThumImgUrl(URLEncoder.encode(menu.getThumImgUrl()));
				log.info(menu);
			});
			
			List<StoreImgVO> imgs = allStore.getImgs();
			
			List<StoreTagVO> tagList = allStore.getTagList();
			model.addAttribute("menuList",menuList);
			model.addAttribute("imgs",imgs);
			model.addAttribute("storeId",storeId);
			model.addAttribute("tagList",tagList);
		}
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		model.addAttribute("store", store);
		model.addAttribute("allStore", allStore);
		model.addAttribute("userId",userId);
		model.addAttribute("revwList",revwList);
		
		return "/dealight/business/manage/modify/modify";
	}
	
	@PostMapping("/modify")
	public String storeModify(Model model,AllStoreVO store,RedirectAttributes rttr) {
		
		log.info("business store modify post..");
		
		rttr.addFlashAttribute("msg","수정 완료");
		
		log.info("store................" + store);
		
		if(!storeService.modifyStore(store)) {
			rttr.addFlashAttribute("storeId",store.getStoreId());
			rttr.addFlashAttribute("msg", "수정 실패");
			return "redirect:/business/manage/modify?storeId="+store.getStoreId();
		}
		 
		return "redirect:/dealight/business/manage/modify?storeId="+store.getStoreId();
	}
	
	@PutMapping(value="/review/reply",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> regReply(@RequestBody HashMap<String, Object> map){
		
		String replyCnts = (String) map.get("replyCnts");
		Long revwId = Long.parseLong((String) map.get("revwId")); 
		
		log.info("put revw.................");
		
		log.info("replyCnts..............." + replyCnts);
		log.info("revwId..............." + revwId);
		
		return revwService.regReply(revwId, replyCnts)
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping(value="/review/{revwId}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<RevwVO> getRevw(@PathVariable("revwId") Long revwId){
		
		log.info("get revw.................");
		
		return new ResponseEntity<>(revwService.findById(revwId),HttpStatus.OK);
	}
	
	// 매장의 이미지를 가져온다.
	@GetMapping(value = "/getStoreImgs", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreImgVO>> getStoreImage(Long storeId) {
		
		log.info("getAttachList" + storeId);
		
		return new ResponseEntity<>(storeService.getStoreImageList(storeId), HttpStatus.OK);
	}
	
	private void deleteFiles(List<StoreImgVO> imgs) {
		if(imgs == null || imgs.size() == 0) {
			return;
		}
		
		log.info("delete imgs..................");
		log.info(imgs);
		
		imgs.forEach(img -> {
			
			try {
				Path file = Paths.get(img.getUploadPath() + "\\" + img.getUuid() + "_" + img.getFileName());
				
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get(img.getUploadPath() +"\\s_" + img.getUuid()
								+ "_" + img.getFileName());
					
					Files.delete(thumbNail);
							
				}
			} catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			} // end catch
		}); // end for each
	}
	
	// 메뉴 수정 페이지//
	@GetMapping("/menu")
	public String menuModify(Model model, Long storeId) {
		
		log.info("business menu modify..");
		
		List<MenuVO> menus = storeService.findMenuByStoreId(storeId);
		
		log.info("menus................................."+menus);
		
		menus.forEach((menu) -> {
			if(menu.getThumImgUrl() != null)
				menu.setEncThumImgUrl(URLEncoder.encode(menu.getThumImgUrl()));
		});
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		model.addAttribute("store", store);
		model.addAttribute("menus",menus);
		model.addAttribute("storeId",storeId);
		
		return "/dealight/business/manage/modify/menu";
	}
	
	// 메뉴 등록
	@PostMapping("/menu/register")
	public String menuRegister(Model model, MenuVO menu) {
		
		log.info("business menu register..");
		
		log.info("menu......" + menu);
		
		if(menu.getRecoMenu() == null)
			menu.setRecoMenu("N");
			
		if(menu.getRecoMenu().equalsIgnoreCase("on"))
			menu.setRecoMenu("Y");
		
		
		storeService.registerMenu(menu);
		
		return "redirect:/dealight/business/manage/menu?storeId="+menu.getStoreId();
	}
	
	// 메뉴 수정
	@PostMapping("/menu/modify")
	public String menuModify(Model model, MenuVO menu) {
		
		log.info("business menu modify..");
		
		log.info("menu......" + menu);
		
		if(menu.getRecoMenu() == null)
			menu.setRecoMenu("N");
			
		if(menu.getRecoMenu().equalsIgnoreCase("on"))
			menu.setRecoMenu("Y");
		
		storeService.modifyMenu(menu);
		
		return "redirect:/dealight/business/manage/menu?storeId="+menu.getStoreId();
	}
	
	// 메뉴 수정
	@PostMapping("/menu/delete")
	public String menuDelete(Model model, MenuVO menu) {
		
		log.info("business menu register..");
		
		if(storeService.deleteMenu(menu.getMenuSeq())) {
			log.info(menu.getMenuSeq() + "의 메뉴 제거가 완료되었습니다...............");
		};
		
		
		return "redirect:/dealight/business/manage/menu?storeId="+menu.getStoreId();
	}
//
//	// 웨이팅 입장
//	@GetMapping("/enter")
//	public String enter(Model model,long storeId,long waitId) {
//		
//		log.info("business menu modify..");
//		
//		waitService.enterWaiting(waitId);
//		
//		return "redirect:/dealight/business/manage?storeId="+storeId;
//	}
//	
//	// 웨이팅 노쇼
//	@GetMapping("/noshow")
//	public String noshow(Model model,long storeId,long waitId) {
//		
//		log.info("business menu modify..");
//		
//		waitService.panaltyWaiting(waitId);	
//		
//		return "redirect:/dealight/business/manage?storeId="+storeId;
//	}
//	
//	// 착석 상태 변경
//	@PostMapping("/seat")
//	public String seatStus(Model model,long storeId, String seatStusColor) {
//		
//		storeService.changeSeatStus(storeId, seatStusColor);
//		
//		return "redirect:/dealight/business/manage?storeId="+storeId;
//	}

}
