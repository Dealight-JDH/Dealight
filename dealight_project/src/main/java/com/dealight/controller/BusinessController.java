package com.dealight.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserWithRsvdDTO;
import com.dealight.domain.WaitVO;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/business/*")
@AllArgsConstructor
public class BusinessController {

	private StoreService sService;
	
	private StoreService storeService;
	
	private RsvdService rsvdService;
	
	private WaitService waitService;
	
	private HtdlService htdlService;
	
	
	//메뉴 사진첨부파일 매장평가 사업자테이블에 태그 메뉴 옵션이 들어가야한다.
	//DTO에 대한이해가 피요하고 많아지는 객체들을 쪼갤수있는 방법을 생각하자.
	@PostMapping("/register")
	public String register(StoreVO store, BStoreVO bStore, StoreLocVO loc, StoreEvalVO eval, RedirectAttributes rttr) {
		store.setBstore(bStore);
		store.setLoc(loc);
		//테스트용 지워야함
		store.setEval(eval);
		
		log.info("register: " + store);
		
		sService.register(store);
		
		//지금 나의 생각 입력한 값들이 잘 저장되나 보고싶다.
		//결국 저장된 정보를 볼수있는 페이지는 뭐가잇을까??
		//수정페이지에서 정보를 볼 수있고 정보도 고칠수 있지 
		//그러면 수정페이지를 가지고있어야겠네
		//
		rttr.addFlashAttribute("result", store.getStoreId());
		return "redirect:/business/";
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	// ������ 1
	@GetMapping("/")
	public String list(Model model,HttpServletRequest request) {
		
		log.info("business store list..");
		
		
		HttpSession session = request.getSession();
		
		// �α��� ���� �ƴٰ� ����
		session.setAttribute("userId", "lim");
		
		// ������ ���̵� �޴´�.
		String userId = (String) session.getAttribute("userId");
		
		model.addAttribute("userId", userId);
		
		List<StoreVO> list = storeService.getStoreListByUserId(userId);
		list.stream().forEach((store)->{
			long id = store.getStoreId();
			store.setCurWaitNum(waitService.curStoreWaitList(id, "W").size());
			store.setCurRsvdNum(rsvdService.readTodayCurRsvdList(id).size());
		});
		
		model.addAttribute("storeList", list);
		
		return "/business/list";
	}
	
	
	
	
	// ������ 4 -> ������ �и��ϸ� �� 2��
	@GetMapping("/manage")
	public String manage(Model model, long storeId,HttpServletRequest request) {
		
		log.info("business manage..");
		
		HttpSession session = request.getSession();
		
		// ���ǿ� �ִ� userId�� �ҷ��´�.
		String userId = (String) session.getAttribute("userId");
		
		// store ������ �����´�.(Bstore ����)
		//StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		// ��Ʈ ���� �ð� ������ �����´�.
		//String lastOrder = store.getBstore().getLastOrdTm();
		
		// ���� ������ ����(�ð�����)
		//Date today = new Date();
		
		// ���忡 ���� �������� ���� ��������� ���� ����Ʈ�� �����´�. 
		// ����
		//List<RsvdVO> rsvdList = rsvdService.readTodayCurRsvdList(storeId);

		// ���� ������ ������ ������ ����Ʈ�� �����´�.
		// ����
		//List<WaitingVO> waitList = waitService.curStoreWaitList(storeId, "W");
		
		// �ٷ� ���� �������� �����´�.
		//WaitingVO nextWait = waitService.readNextWait(waitList);
		
		// ���� ���� ����� ����� �����´�.
		//HashMap<String,List<Long>> todayRsvdMap = rsvdService.getRsvdByTimeMap(rsvdList);
		
		// ���� ������ id�� �����´�.
		//Long nextId = rsvdService.readNextRsvdId(todayRsvdMap);
		
		// �ٷ� ���� �����ڸ� �����´�.
		//RsvdVO nextRsvd = rsvdService.findRsvdByRsvdId(nextId, rsvdList);
		
		// ���� ���� �հ踦 �����´�.
		//int totalTodayRsvd = rsvdService.totalTodayRsvd(rsvdList);
		
		// ���� ���� �հ� �ο��� �����´�.
		//int totalTodayRsvdPnum = rsvdService.totalTodayRsvdPnum(rsvdList);
		
		// ���� ���õ� �޴��� map�� �����´�.
		// ����
		//HashMap<String,Integer> todayFavMenuMap = rsvdService.todayFavMenu(storeId);
		
		//String pattern = "yyyyMMdd";
    	
		//SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    	
    	//String date = simpleDateFormat.format(today);
		
		// ���� ������ �� ����Ʈ�� �����´�.
    	// ����
		List<UserWithRsvdDTO> todayRsvdUserList = rsvdService.userListTodayRsvd(storeId);
		
		// ���� �������¸� �����´�.
		//String curSeatStus = store.getBstore().getSeatStusCd();
		
		
		model.addAttribute("storeId", storeId);
		//model.addAttribute("store", store);
		//model.addAttribute("today", today);
		//model.addAttribute("todayRsvdMap",todayRsvdMap);
		//model.addAttribute("nextRsvd",nextRsvd);
		//model.addAttribute("rsvdList", rsvdList);
		//model.addAttribute("waitList", waitList);
		//model.addAttribute("storeId",storeId);
		//model.addAttribute("nextWait",nextWait);
		//model.addAttribute("lastOrder",lastOrder);
		//model.addAttribute("curSeatStus",curSeatStus);
		
		//��Ȳ��
		//model.addAttribute("totalTodayRsvd",totalTodayRsvd);
		//model.addAttribute("totalTodayRsvdPnum",totalTodayRsvdPnum);
		//model.addAttribute("todayFavMenuMap", todayFavMenuMap);
		model.addAttribute("todayRsvdUserList", todayRsvdUserList);
		
		return "/business/manage/manage";
	}
	
	// ������ ��
		// ������ 1
		@GetMapping("/waiting/{waitId}")
		public String waiting(Model model, @PathVariable("waitId") long waitId) {
			
			log.info("business waiting detail..");
			
			WaitVO wait = waitService.read(waitId);
			
			log.info(wait);
			
			// �ش� ���忡 ���� ���°� W�� ����Ʈ�� �����´�.
			List<WaitVO> curStoreWaitiList = waitService.curStoreWaitList(wait.getStoreId(), "W");
			
			// �ش� ������ ��ȣ�� ���� ��� ������ �����ش�.
			int order = waitService.calWatingOrder(curStoreWaitiList, wait.getWaitId());
			
			// �ش� ������ ��ȣ�� ���� ���� ��� �ð��� �����ش�.
			// ���ð��� �ϴ� ���Ƿ� 15�� �����ߴ�.
			int waitTime = waitService.calWaitingTime(curStoreWaitiList, wait.getWaitId(), 15);
			
			model.addAttribute("wait",wait);
			model.addAttribute("order",order);
			model.addAttribute("waitTime", waitTime);
			
			return "/business/manage/waiting/waiting";
		}
}
