package com.dealight.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreTagVO;
import com.dealight.domain.WaitVO;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

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
	
	// 파일 저장 경로를 지정한다.
	final static private String ROOT_FOLDER = "C:\\Users\\kjuio\\Desktop\\ex05";
	
	// 핫딜 히스토리
	@GetMapping("/dealhistory")
	public String dealHistory(Model model,long storeId,HttpServletRequest request) {
		
		log.info("business manage dealhistory..");
		
		List<HtdlVO> htdlList = htdlService.readAllStoreHtdlList(storeId);
		
		model.addAttribute("htdlList",htdlList);
		
		// 현재 상태가 Active인 핫딜을 가져온다.
		List<HtdlVO> curList = htdlList.stream().filter(htdl -> 
			htdl.getStusCd().equals("A")
		).collect(Collectors.toList());
		
		model.addAttribute("curList", curList);
		
		return "/dealight/business/manage/dealhistory";
	}
	
	// 매장 수정 페이지
	@GetMapping("/modify")
	public String storeModify(Model model,Long storeId, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");
		
		log.info("business store modify get.." + storeId);
		
		if(storeId == null) {
			storeId = (Long) request.getAttribute("storeId");
		}
		
		AllStoreVO store = storeService.findAllStoreInfoByStoreId(storeId);
		
		log.info("All store......................"+store);
		
		if(store != null) {
			List<MenuVO> menuList = store.getMenuList();
			List<StoreImgVO> imgs = store.getImgs();
			List<RevwVO> revwList = store.getRevwList();
			List<StoreTagVO> tagList = store.getTagList();
			model.addAttribute("menuList",menuList);
			model.addAttribute("imgs",imgs);
			model.addAttribute("revwList",revwList);
			model.addAttribute("tagList",tagList);
		}
		
		
		model.addAttribute("store", store);
		model.addAttribute("userId",userId);
		
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
				menu.setThumImgUrl(URLEncoder.encode(menu.getThumImgUrl()));
		});
		
		model.addAttribute("menus",menus);
		model.addAttribute("storeId",storeId);
		
		return "/dealight/business/manage/modify/menu";
	}
	
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-",File.separator);
	}
	
	private boolean checkImageType(File file) {
		
		try {
			
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 메뉴 등록
	@PostMapping("/menu/register")
	public String menuRegister(Model model, MenuVO menu) {
		
		log.info("business menu register..");
		
		log.info("menu......" + menu);
		
		menu.setRecoMenu("N");

		if(menu.getRecoMenu().equalsIgnoreCase("on"))
			menu.setRecoMenu("Y");
		
		storeService.registerMenu(menu);
		
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
