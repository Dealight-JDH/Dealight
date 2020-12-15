package com.dealight.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.Criteria;
import com.dealight.domain.PageDTO;
import com.dealight.domain.QnAVO;
import com.dealight.service.FaqService;
import com.dealight.service.QnAService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/custservice/*")
@AllArgsConstructor
public class CustServiceController {

	private FaqService fService;
	private QnAService qService;
	
	private QnAVO replaceBR(QnAVO qna) {
		
		String contents = qna.getQnaCnts();
		
		log.info(contents);
		contents = contents.replace("\r\n","<br>");

		log.info(contents);
		
		qna.setQnaCnts(contents);
		return qna;
	}
	
	private QnAVO replaceRN(QnAVO qna) {
		String contents = qna.getQnaCnts();
		
		log.info(contents);
		contents = contents.replace("<br>", "\r\n");

		log.info(contents);
		
		qna.setQnaCnts(contents);
		return qna;
	}
	
	//==========================FAQ
	@GetMapping("/")
	public String FaqList(Criteria cri, Model model) {
		log.info("==================FaqList==================");
		
		if(cri == null || cri.getPageNum()<1)
			cri = new Criteria(1, 10);
		
		int total = fService.getTotal(cri);
		
		log.info("Total count : " + total);
		
		
		model.addAttribute("list", fService.getList(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, total));
		
		return "dealight/custservice/faqlist";
	}
	
	@GetMapping("/getfaq")
	public void getFAQ(@RequestParam("faqId") long faqId, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("================get FAQ==================");
		log.info("faqId : "+ faqId);
		log.info("Criteria : " +cri);
		
		model.addAttribute("faq", fService.get(faqId));
	}
	
	@GetMapping("/qnalist")
	public void QnAList(Criteria cri, Model model) {
		log.info("==================QnAList==================");
		
		if(cri == null || cri.getPageNum()<1)
			cri = new Criteria(1, 10);
		
		int total = qService.getTotal(cri);
		
		log.info("Total count : " + total);
		
		
		model.addAttribute("list", qService.getList(cri));
		model.addAttribute("pageDTO", new PageDTO(cri, total));
		
		
	}
	
	@GetMapping("/getqna")
	public void getQnA(@RequestParam("qnaId") long qnaId, @ModelAttribute("cri") Criteria cri, Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.setAttribute("userId", "aaaa");
		log.info("================get QnA==================");
		log.info("QnAId : "+ qnaId);
		log.info("Criteria : " +cri);
		
		model.addAttribute("list", qService.get(qnaId));
	}
	
	@GetMapping("/registerqna")
	public void registerQnA() {
		
	}
	
	@PostMapping("/registerqna")
	public String registerQnA(QnAVO qna, RedirectAttributes rttr) {
		log.info("register qna : " + qna);
		
		qna = replaceBR(qna);
		
		if(qna.getQnaId()!=0) {
			qService.registerWithOrd(qna);
			return "redirect:/dealight/custservice/getqna?qnaId=" + qna.getQnaId();
		} else {
			qService.register(qna);
			return "redirect:/dealight/custservice/qnalist";
		}
	}
	
	@PostMapping("/removeqna")
	public String removeQnA(@RequestParam("qnaId") long qnaId, @RequestParam("qnaOrd")int qnaOrd, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove qna : " + qnaId);
		
		if(qService.remove(qnaId, qnaOrd)) {
			rttr.addFlashAttribute("result", "success");
		}
		//ord 삭제하면 get으로
		//id 삭제하면 list로 
		if(qnaOrd == 0) {
			return "redirect:/dealight/custservice/qnalist" + cri.getFilterTypeLink();
		}
		return "redirect:/dealight/custservice/get?qnaId=" + qnaId;
	}
	
	@GetMapping("/modifyqna")
	public void get(@RequestParam("qnaId")long qnaId, @RequestParam("qnaOrd")int qnaOrd, @ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("get with qnaId : " + qnaId);
		log.info("get with ord : " + qnaOrd);
		
		QnAVO qna = qService.getWithOrd(qnaId, qnaOrd);
		
		qna = replaceRN(qna);
		
		model.addAttribute("qna", qna);
		
	}
	
	@PostMapping("/modifyqna")
	public String modifyQnA(QnAVO qna, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify qna : " + qna);
		
		qna = replaceBR(qna);
		
		if(qService.modify(qna)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/custservice/getqna"+ cri.getFilterTypeLink()+"&qnaId="+qna.getQnaId();
	}
	
	
	
}
