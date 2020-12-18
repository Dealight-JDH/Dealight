package com.dealight.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.AdminPageDTO;
import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.StoreDTO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.SugRequestDTO;
import com.dealight.domain.UserVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.service.AdminService;
import com.dealight.service.StoreService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/dealight/admin/*")
@AllArgsConstructor
public class AdminController {

	private AdminService service;
	
	private StoreService storeService;

	@GetMapping("/main")
	public void adminMain() {
	}

	//---------사업자등록--------------
	@GetMapping("/brnomanage")
	public String bizAuthList(Criteria cri, Model model) {

		log.info("bizAuthList");

		int total = service.getTotal(cri);
		log.info(cri);
		log.info("total : " + total);
		
		if(cri == null || cri.getPageNum() < 1)
			cri = new Criteria(1, 10);
		
		model.addAttribute("list", service.getBUserListWithCri(cri));
		model.addAttribute("pageMaker", new AdminPageDTO(cri, total));

		return "/dealight/admin/brnomanage/list";
	}
	
	@GetMapping("/brnomanage/register")
	public void registerBrno() {
		
	}
	
	@PostMapping("/brnomanage/register")
	public String registerBrno(BUserVO buser, RedirectAttributes rttr) {
		log.info("register :" + buser);
		
		service.registerBUser(buser);
		
		rttr.addFlashAttribute("result", buser.getBrSeq());
		
		return "redirect:/dealight/admin/brnomanamge";
	}
	

	@GetMapping({ "/brnomanage/get", "/brnomanage/modify" })
	public void getBrno(@RequestParam("brSeq") long brSeq, @ModelAttribute("cri")Criteria cri, Model model) {

		log.info("get by brSeq : " + brSeq);

		model.addAttribute("buser", service.readBUser(brSeq));
	}

	@PostMapping("/brnomanage/modify")
	public String modifyBrno(BUserVO buser, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify : " + buser);
		
		if(service.modifyBUser(buser)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/dealight/admin/brnomanage" + cri.getBrnoListLink();
	}
	
	@PostMapping("/brnomanage/remove")
	public String deleteBrno(@RequestParam("brSeq") long brSeq, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove by brSeq : " +brSeq);
		
		if(service.deleteBUser(brSeq)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/admin/brnomanage" + cri.getBrnoListLink();
	}
	
	//--------------------회원관리
	@GetMapping("/usermanage/user")
	public String userList(Model model) {
		
		log.info("list");
		
		model.addAttribute("list", service.getUserList());
		
		return "/dealight/admin/usermanage/user/list";
	}
	
	@GetMapping({"/usermanage/user/get", "/usermanage/user/modify"})
	public void getUser(@RequestParam("userId") String userId, Model model) {
		log.info("get user by id : " + userId);
		
		model.addAttribute("user", service.readUser(userId));
	}
	
	@PostMapping("/usermanage/user/modify")
	public String modifyUser(UserVO user, RedirectAttributes rttr) {
		log.info("modify user : " + user);
		
		if(service.modifyUser(user)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/dealight/admin/usermanage/user";
	}
	
	@PostMapping("/usermanage/user/delete")
	public String deleteUser(String userId, RedirectAttributes rttr) {
		log.info("remove by userId : " + userId);
		
		if(service.delete(userId))
			rttr.addFlashAttribute("result", "success");
		
		
		return "redirect:/dealight/usermanage/user";
	}

	//-----------------------------매장관리
	@GetMapping("/storemanage")
	public String storeList(Model model,Criteria cri) {
		
		log.info("store manage view......................");
		
		log.info("store manage view...................... cri : " + cri);
		
		if(cri == null || cri.getPageNum() < 1)
			cri = new Criteria(1, 10);
		
		List<StoreVO> storeList = storeService.findStoreListWithPaging(cri);
		int total = storeService.getTotalCnt(cri);
		
		log.info(cri);
		log.info("total : " + total);
		
		model.addAttribute("storeList", storeList);
		model.addAttribute("pageMaker", new AdminPageDTO(cri, total));
		
		return "/dealight/admin/storemanage/list";
	}
	
	@PostMapping("/storemanage/registerbstore")
	public String registerStore(StoreVO store, RedirectAttributes rttr) {
		log.info("register : " + store);
		
		storeService.register(store);
		
		return "redirect:/dealight/admin/storemanage";
	}
	
	@GetMapping("/storemanage/registerbstore")
	public void registerStore() {
		
	}
	
	@GetMapping("/storemanage/get")
	public String getStore(@RequestParam("storeId") long storeId, @RequestParam("clsCd") String clsCd, Model model) {
		log.info("get by storeId : " + storeId);
		
		if(clsCd.equals("B")) {
			
			List<StoreImgVO> imgs = storeService.getStoreImageList(storeId);
			
			log.info("imgs : "+imgs);
			
			StoreVO store = service.readStore(storeId);
			
			store.setImgs(imgs);
			
			model.addAttribute("store", store);
			return "dealight/admin/storemanage/getbstore";
		}
		
		return "dealight/admin/storemanage/getnstore";
			
	}
	
	@GetMapping("/storemanage/modify")
	public String modifyStore(@RequestParam("storeId") long storeId, @RequestParam("clsCd") String clsCd, Model model) {
		log.info("get by storeId : " + storeId);
		
		if(clsCd.equals("B")) {
			StoreVO store = service.readStore(storeId);
			store.setImgs(storeService.getStoreImageList(storeId));
			model.addAttribute("store", store);
			return "dealight/admin/storemanage/modifybstore";
		}
		
		return "dealight/admin/storemanage/modifynstore";
			
	}
	
	
	@PostMapping("/storemanage/modify")
	public String modfiyStore(StoreVO store, RedirectAttributes rttr) {
		log.info("modify store : " + store);
		
		if(service.modifyStore(store))
			rttr.addFlashAttribute("result", "success");
		
		
		rttr.addFlashAttribute("storeId",store.getStoreId());
		rttr.addFlashAttribute("clsCd",store.getClsCd());
		return "redirect:/dealight/admin/storemanage/get?storeId=" + store.getStoreId() + "&clsCd=" +store.getClsCd();
	}
	
	@PostMapping("/storemanage/suspend")
	public String deleteStore(@RequestParam("storeId") long storeId, RedirectAttributes rttr) {
		log.info("delete store : " + storeId);
		
		if(storeService.suspendStore(storeId)) {
			rttr.addFlashAttribute("msg", "변경이 성공하였습니다.");
		} else {
			rttr.addFlashAttribute("msg","변경이 실패하였습니다.");
		}
		
		return "redirect:/dealight/admin/storemanage";
	}
	
	
	
	//--------------------------핫딜관리
	@PostMapping("/htdlmanage/end")
	public String endHtdl(Long htdlId, String stusCd, RedirectAttributes rttr) {
		log.info("end htdl....");
		
		service.endHtdl(htdlId, "I");
		
		return "redirect:/dealight/admin/htdlmanage/"+stusCd;
	}
	@PostMapping("/htdlmanage/remove")
	public String removeHtdl(Long htdlId, String stusCd, RedirectAttributes rttr){
		
		log.info("remove htdl...");
		
		log.info("======================htdlId: " + htdlId );
		log.info("======================stusCd: " + stusCd );
		
		service.removeHtdl(htdlId);
		rttr.addFlashAttribute("result", "핫딜이 삭제되었습니다.");
		return "redirect:/dealight/admin/htdlmanage/"+stusCd;
		
	}
	
	@PostMapping("/htdlmanage/modify")
	public String modifyHtdl(HtdlVO vo, RedirectAttributes rttr) {
		
		log.info("modify.......");
		log.info("==========request: " + vo);
		
		if(vo.getStusCd().equalsIgnoreCase("p")) {
			//현재 날짜
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			Date date = new Date();
			String sysdate = format.format(date);
			vo.setStartTm(sysdate+" " + vo.getStartTm());
			vo.setEndTm(sysdate+" " + vo.getEndTm());
			vo.setDcRate(vo.getDcRate()/100.0);
		}
		
		service.modifyHtdl(vo);
		rttr.addFlashAttribute("result", "success");
		
		return "redirect:/dealight/admin/htdlmanage/get?htdlId="+vo.getHtdlId()+"&stusCd="+vo.getStusCd();
		
	}
	
	@GetMapping("/htdlmanage/{stusCd}")
	public String htdlList(@PathVariable String stusCd, Model model) {
		
		log.info("get htdl list..... ");
//		String htdlStusCd = service.getHtdlList(stusCd).get(0).getStusCd();
		
		model.addAttribute("stusCd", stusCd);
		model.addAttribute("lists", service.getHtdlList(stusCd));
		return "/dealight/admin/htdlmanage/list";
	}
	

	@GetMapping({"/htdlmanage/get", "/htdlmanage/modify"})
	public void getHtdl(String stusCd, Long htdlId, Model model) {
		log.info("========stusCd: " + stusCd);
		
			HtdlVO htdlVO = service.readHtdl(stusCd, htdlId);
			if(htdlVO.getStusCd().equalsIgnoreCase("P")) {
				model.addAttribute("menuLists", service.readMenu(htdlVO.getStoreId())); 
			}
			log.info("=====htdlVO : " + htdlVO);
			log.info("=======time: " + htdlVO.getStartTm()+"," + htdlVO.getEndTm());
			log.info("=======price: " + htdlVO.getHtdlDtls().get(0).getMenuPrice());
			
			model.addAttribute("htdl", htdlVO);
			
		
	}
	//--------------------------핫딜제안
	
	@GetMapping("/htdlmanage/suggest")
	public void suggestHtdl(Model model) {		
		log.info("==========suggestHtdl: " +  service.getSuggestHtdlList());
		
		model.addAttribute("lists", service.getSuggestHtdlList());
	}
	
	@GetMapping("/htdlmanage/sugregister")
	public void sugRegister(Long storeId, Model model){
		
		StoreDTO suggestStore = service.suggestStore(storeId);
		log.info("suggest store: " + suggestStore);
		
		model.addAttribute("suggestStore", suggestStore);
	}
	
	@PostMapping("/htdlmanage/sugregister")
	public String sendSuggest(SugRequestDTO dto, RedirectAttributes rttr) throws Exception {
		
		log.info("=========="+ dto);
		/* 웹 소켓*/
    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
    	Map<String, WebSocketSession> map = handler.getUserSessions();
    	
    	WebSocketSession session = map.get(dto.getBuserId());
    	TextMessage message = new TextMessage("{\"sendUser\":\"-1\",\"htdlId\":\"-1\",\"cmd\":\"htdl\",\"storeId\":\""+dto.getStoreId()+"\",\"htdlDto\":{\"htdlName\":\""+dto.getHtdlName()+"\",\"startTm\":\""+dto.getStartTm()+"\",\"endTm\":\""+dto.getEndTm()+"\",\"lmtPnum\":\""+dto.getLmtPnum()+"\"}}");
    	handler.handleMessage(session, message);
		
    	rttr.addFlashAttribute("result", "success");
		return "redirect:/dealight/admin/htdlmanage/suggest";
	}
	
}
