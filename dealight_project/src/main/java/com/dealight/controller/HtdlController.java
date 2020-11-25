package com.dealight.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.HtdlCriteria;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlMenuDTO;
import com.dealight.domain.HtdlPageDTO;
import com.dealight.domain.HtdlRequestDTO;
import com.dealight.domain.HtdlVO;
import com.dealight.service.HtdlService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

//jongwoo

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/dealight/hotdeal/*")
public class HtdlController {

	private final HtdlService service;
	
	//사업자 회원 매장 핫딜 제안
	@PostMapping("/register")
	public String register(Long storeId, @Valid HtdlRequestDTO requestDto,
			BindingResult bindingResult, RedirectAttributes rttr) {
		
		if(bindingResult.hasErrors()) {
			//유효성 검사
			List<ObjectError> errorList = bindingResult.getAllErrors();
	        for (ObjectError error : errorList)
	            log.info("=====error: " + error.getDefaultMessage());
	        
	        rttr.addFlashAttribute("msg", "필수 항목을 입력해 주세요");
	        return "redirect:/dealight/hotdeal/register?storeId="+storeId;
		}
		
		//핫딜 상세vo list
		List<HtdlDtlsVO> dtlsList = new ArrayList<>();

		HtdlVO vo = requestDto.toEntity();
		vo.setStoreId(storeId);
		
		//String[] menu = requestDto.getMenu();
		List<HtdlMenuDTO> menuList = requestDto.getMenu();
		log.info("=================menuDTO "+ menuList);
		//log.info("=============================vo: " + vo);
		//요청 리스트 생성
		for(int i=0; i< menuList.size(); i++) {
			//log.info("======================menu: "+ Arrays.toString(menu));
//			MenuDTO menuDto = service.findPriceByName(storeId, menu[i].trim());
			
			//log.info("======================menuDto: "+ menuDto);
//			HtdlDtlsVO dtlsVO = HtdlDtlsVO.builder()
//									.menuName(menuDto.getName())
//									.menuPrice(menuDto.getPrice()).build();
			HtdlMenuDTO menuDto = menuList.get(i);
			
			if(menuDto.getName() != null && menuDto.getPrice() != null) {				
				HtdlDtlsVO dtlsVO = HtdlDtlsVO.builder()
						.menuName(menuDto.getName())
						.menuPrice(menuDto.getPrice()).build();
				
				log.info("===================dtlsVO: " + dtlsVO);
				dtlsList.add(dtlsVO);
			}
		}
		
		service.register(vo, dtlsList);
		
		//rttr.addFlashAttribute("result", vo.getHtdlId());
		
		return "redirect:/dealight/hotdeal/main";
	}
	
	//사업자 회원 매장 핫딜 제안
	@GetMapping("/register")
	public void register(@ModelAttribute("storeId")Long storeId, Model model) {
		log.info("register...");
		
		model.addAttribute("stordId", storeId);
		model.addAttribute("menuLists", service.findById(storeId));
		
	}
	
	//핫딜 상세
	@GetMapping("/get")
	public void get(@RequestParam("htdlId") Long htdlId, Model model) {
		log.info("get...");
		
		HtdlVO htdlVO = service.read(htdlId);
		model.addAttribute("vo", htdlVO);
	}

	//핫딜 메인 페이지
	@GetMapping("/main")
	public void getList(HtdlCriteria hCri,Model model) {
		
		log.info("hotdeal getList...");
		List<HtdlVO> lists = service.getList();
		
//		List<HtdlVO> filterList = lists.stream()
//										.filter(htdl -> htdl.getStusCd().equals(stusCd))
//										.collect(Collectors.toList());
//		
//		log.info("======currentActivate"+filterList);
//		log.info("=======getList"+service.getList());
//		
//		if(filterList.size() > 0) {
//			model.addAttribute("lists", filterList);
//			return;
//		}
		
//		model.addAttribute("lists", lists.stream()
//					.filter(htdl -> htdl.getStusCd().equals("A"))
//					.collect(Collectors.toList()));
		
		model.addAttribute("lists", service.getList("A", hCri));
//		model.addAttribute("pageMaker", new HtdlPageDTO(hCri, 123));
	}
	
	//핫딜 메인 페이지
//	@GetMapping("/main")
//	public void getList(Model model) {
//		
//		log.info("hotdeal getList...");
//		List<HtdlVO> lists = service.getList();
//		
////		List<HtdlVO> filterList = lists.stream()
////										.filter(htdl -> htdl.getStusCd().equals(stusCd))
////										.collect(Collectors.toList());
////		
////		log.info("======currentActivate"+filterList);
////		log.info("=======getList"+service.getList());
////		
////		if(filterList.size() > 0) {
////			model.addAttribute("lists", filterList);
////			return;
////		}
//		
//		model.addAttribute("lists", lists.stream()
//					.filter(htdl -> htdl.getStusCd().equals("A"))
//					.collect(Collectors.toList()));
//	}
}
