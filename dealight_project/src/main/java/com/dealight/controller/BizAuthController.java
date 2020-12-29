package com.dealight.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.BUserVO;
import com.dealight.service.BizAuthService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/mypage/bizauth/*")
@AllArgsConstructor
public class BizAuthController {

	private BizAuthService service;
	
	//첨부파일 삭제
	private void deleteFile(String imgSrc) {
		log.info("delete img file.............");
		log.info(imgSrc);
		String uploadPath = imgSrc.substring(0, imgSrc.lastIndexOf("/"));
		String fileName = imgSrc.substring(imgSrc.lastIndexOf("/")+1);
		try {
			Path file = Paths.get("/Users/hyeonjung/Desktop/upload/" + imgSrc);
			Files.deleteIfExists(file);
			log.info("file : " + file);
			Path thummbnail = Paths.get("/Users/hyeonjung/Desktop/upload/" + uploadPath + "/s_" + fileName);
			Files.deleteIfExists(thummbnail);
			log.info("thumbnail : " + thummbnail);
		}catch (Exception e) {
			log.error("delete file error" +e.getMessage());
		}
	}
	
	@PostMapping("/register")
	public String brnoRegister(BUserVO buser, RedirectAttributes rttr) {
		
		log.info("buser : " + buser);
		
		//TODO
		//등록이 실패하면???
		buser.setReason("테스트");
		service.register(buser);
		log.info("brSeq :" + buser.getBrSeq());
		rttr.addFlashAttribute("result", buser.getBrSeq());
		
		return "redirect:/dealight/mypage/bizauth/list";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping("/request")
	public String requestReg(@RequestParam("brSeq")long brSeq, Model model) {
		
		log.info("get by brSeq : " + brSeq);
		
		model.addAttribute("buser", service.read(brSeq));
		
		return "dealight/mypage/bizauth/register";
	}
	
	
	
	
	@GetMapping("/list")
	public void list(Model model, HttpSession session) {
		//로그인 유저 아이디를 불러온다.
		String userId = (String)session.getAttribute("userId");
		if(userId == null & userId.equals("")) {
			//처리필요
		}
		
		log.info("list");
		
		model.addAttribute("list", service.getListByUserId(userId));
		
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("brSeq")long brSeq, Model model) {
		
		log.info("get by brSeq : " + brSeq);
		
		model.addAttribute("buser", service.read(brSeq));
		
	}
	
	
	@PostMapping("/modify")
	public String modify(BUserVO buser, RedirectAttributes rttr) {
		log.info("modify : "+ buser);
		
		if(service.modify(buser)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/mypage/bizauth/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("brSeq") Long brSeq,@RequestParam("brPhotoSrc") String imgSrc, RedirectAttributes rttr) {
		log.info("remove...." + brSeq);
		log.info("imgSrc : " + imgSrc);
		if(service.delete(brSeq)) {
			
			deleteFile(imgSrc);
			
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/mypage/bizauth/list";
	}
	
}
