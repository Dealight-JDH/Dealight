package com.dealight.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserWithRsvdDTO;
import com.dealight.domain.WaitVO;
import com.dealight.service.HtdlService;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.WaitService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/business/*")
public class BusinessController {
	
	@Autowired
	private StoreService storeService;
	
	@Autowired
	private RsvdService rsvdService;
	
	@Autowired
	private WaitService waitService;
	
	@Autowired
	private HtdlService htdlService;
	
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
	
	// ������ 0
	@GetMapping("/register")
	public String storeRegister(Model model,HttpServletRequest request) {
		
		log.info("business store register..");
		
		HttpSession session = request.getSession();
		
		String userId = (String) session.getAttribute("userId");
		
		model.addAttribute("userId",userId);
		
		return "/business/register";
	}
	
	@PostMapping("/register")
	public String waitingRegister(Model model,StoreVO store,BStoreVO bstore, RedirectAttributes rttr) {
		
		//log.info("business waiting register..");
		
		log.info("register bstore................... : "+bstore);
		
		store.setBstore(bstore);
		
		log.info("register store................... : "+store);

		storeService.registerStoreAndBStore(store);
		
		
		return "redirect:/business/";
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
