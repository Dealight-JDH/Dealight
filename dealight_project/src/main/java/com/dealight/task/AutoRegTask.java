package com.dealight.task;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.mapper.RsvdDtlsMapper;
import com.dealight.mapper.RsvdMapper;
import com.dealight.mapper.StoreImgMapper;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
@AllArgsConstructor
public class AutoRegTask {
	
	@Setter(onMethod_ = @Autowired)
	private RsvdService rsvdService;
	
	@Setter(onMethod_ = @Autowired)
	private StoreImgMapper storeImgMapper;
	
	@Setter(onMethod_ = @Autowired)
	private RsvdMapper rsvdMapper;
	
	@Setter(onMethod_ = @Autowired)
	private RsvdDtlsMapper rsvdDtlsMapper;
	
	@Setter(onMethod_ = @Autowired)
	private WaitService waitService;
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@Setter(onMethod_ = @Autowired)
	private StoreService storeService;
	
		//자동 웨이팅 생성기
		//@Scheduled(cron ="0 * * * * *")
		public void registerOnWait() throws Exception{
			log.warn("Auto Online Wait Register Task run..................");
			
	    	List<String> userIdList = new ArrayList<>();
	    	
	    	List<UserVO> userVOList = userService.getList();
	    	
	    	userVOList.stream().forEach(user -> {
	    		
	    		userIdList.add(user.getUserId());
	    	});
	    	
	    	// 테스트용 user id
	    	List<StoreVO> list = storeService.getStoreListByUserId("aaaa");
	    	
	    	List<Long> storeList = new ArrayList<>();
	    	
	    	list.stream().forEach(store -> {
	    		storeList.add(store.getStoreId());
	    	});
	    	
	    	
	    	List<Integer> waitPnumList = new ArrayList<>();
	    	
	    	IntStream stream = IntStream.range(1,10);
	    	
	    	stream.forEach((i) -> {
	    		waitPnumList.add(i);
	    	});
	    	
	    	
	    	int userIdx = (int) (Math.random() * userIdList.size());
	    	int storeIdx = (int) (Math.random() * storeList.size());
	    	int pnumIdx = (int) (Math.random() * waitPnumList.size());
	    	
	        String userId = userIdList.get(userIdx);
	        Long storeId = storeList.get(storeIdx);
	        int waitPnum = waitPnumList.get(pnumIdx);
	        
	        UserVO user = userService.get(userId);
			SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			
	    	WaitVO wait = new WaitVO().builder()
	    			.waitId(0L)
	    			.storeId(storeId)
	    			//.storeId(1L)
	    			.userId(userId)
	    			.waitRegTm(formater.format(new Date()))
	    			.waitPnum(waitPnum)
	    			.custTelno(user.getTelno())
	    			.custNm(user.getName())
	    			.waitStusCd("W")
	    			.build();
	    	
	    	log.info("wait id ................. : " + waitService.registerOnWaiting(wait));

	    	Long waitId = wait.getWaitId();
	    	
	    	
	    	log.warn(wait);
	    	if(waitId > 0 ) {
	    		log.warn("=========================================wait 웨이팅 완료");
	        	/* 웹 소켓*/
	        	ManageSocketHandler handler = ManageSocketHandler.getInstance();
	        	Map<String, WebSocketSession> map = handler.getUserSessions();
	        	WebSocketSession session = map.get("kjuioq");
	        	TextMessage message = new TextMessage("{\"sendUser\":\""+userId+"\",\"waitId\":\""+waitId+"\",\"cmd\":\"wait\",\"storeId\":\""+storeId+"\"}");
	        	handler.handleMessage(session, message);
	    	}
	    	else if(wait.getWaitId() == 0)
	    		log.warn("=========================================wait 웨이팅 실패");
			
		}
		
		// 자동 예약 생성기//
		//@Scheduled(cron="30 * * * * *")
		public void registerRsvd() throws Exception{
			log.warn("Auto Rsvd Register Task run .....................");
			
	    	List<RsvdDtlsVO> list = new ArrayList<>();
	    	
	    	List<String> userIdList = new ArrayList<>();
	    	
	    	List<UserVO> userVOList = userService.getList();
	    	
	    	userVOList.stream().forEach(user -> {
	    		
	    		userIdList.add(user.getUserId());
	    	});
	    	
	    	List<String> menuList = new ArrayList<>();
	    	
	    	int userIdx = (int) (Math.random() * userIdList.size());
	    	
	    	List<Long> storeList = new ArrayList<>();
	    	
	    	// 테스트용 user id
	    	List<StoreVO> storeTestList = storeService.getStoreListByUserId("aaaa");
	    	
	    	storeTestList.stream().forEach(store -> {
	    		storeList.add(store.getStoreId());
	    	});
	    	
	    	int storeIdx = (int) (Math.random() * storeList.size());
	    	
	    	List<String> timeList = new ArrayList<>();
	    	
	    	Calendar cal = Calendar.getInstance();
	    	cal.set(2020, 10, 23);
	    	
	    	List<Integer> hourList = new ArrayList<>();
	    	
	    	hourList.add(9);
	    	hourList.add(10);
	    	hourList.add(11);
	    	hourList.add(12);
	    	hourList.add(13);
	    	hourList.add(14);
	    	hourList.add(15);
	    	hourList.add(16);
	    	hourList.add(17);
	    	hourList.add(18);
	    	hourList.add(19);
	    	hourList.add(20);
	    	hourList.add(21);
	    	
	    	int hourIdx = (int) (Math.random() * hourList.size());
	    	
	    	List<Integer> minuteList = new ArrayList<>();
	    	
	    	minuteList.add(0);
	    	minuteList.add(30);
	    	
	    	int minuteIdx = (int) (Math.random() * minuteList.size());
	    	
	        long id = 6;
	        long storeId = 1;
	        String userId = "soo";
	        int pnum = 30;
	        String time = "09:30";
	        String stusCd;
	        int totAmt = 30;
	        int totQty = 30;
	    	
	    	//예약 상세 정보
	        long rsvdId = 9;
	        long rsvdtSeq = 22;
	        String menuNm = "떡볶이";
	        int menuTotQty = 5;
	        int menuPrc = 3000;
	        
	        long htdlId = 121;
	        
	        
	        userId = userIdList.get(userIdx);
	        storeId = storeList.get(storeIdx);
	        Date date = new Date();
	    	cal.set(2020, date.getMonth(), date.getDate());
	    	cal.set(cal.HOUR_OF_DAY,hourList.get(hourIdx));
	    	cal.set(cal.MINUTE, minuteList.get(minuteIdx));
	    	
	    	SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy/MM/dd HH:mm:ss");
	        
	    	RsvdVO rsvd = new RsvdVO().builder()
	    			.rsvdId(id)
	    			.htdlId(htdlId)
					.storeId(storeId)
					.userId(userId)
					.pnum(pnum)
					.time(formatter.format(new Date(cal.getTimeInMillis())))
					.totAmt(totAmt)
					.totQty(totQty)
					.stusCd("C")
					.build();
	    	
	    	rsvdMapper.insertSelectKey(rsvd);
	    	
	    	rsvdId = rsvd.getRsvdId();
	    	
	    	log.warn(rsvd);
	    	

	    	RsvdDtlsVO rsvdDtls = new RsvdDtlsVO().builder()
					.rsvdId(rsvdId)
					.menuNm(menuNm)
					.menuTotQty(menuTotQty)
					.menuPrc(menuPrc)
					.build();
	    	
	    	
	    	RsvdDtlsVO rsvdDtls2 = new RsvdDtlsVO().builder()
					.rsvdId(rsvdId)
					.menuNm("순대")
					.menuTotQty(menuTotQty)
					.menuPrc(menuPrc)
					.build();
	    	
	    	
	    	RsvdDtlsVO rsvdDtls3 = new RsvdDtlsVO().builder()
					.rsvdId(rsvdId)
					.menuNm("튀김")
					.menuTotQty(menuTotQty)
					.menuPrc(menuPrc)
					.build();
	    	
	    	list.add(rsvdDtls);
	    	list.add(rsvdDtls2);
	    	list.add(rsvdDtls3);
	    	
	    	log.warn(list);
	    	
	    	int result = rsvdDtlsMapper.insertRsvdDtls(list);
	    	
	    	/* 웹 소켓*/
	    	ManageSocketHandler handler = ManageSocketHandler.getInstance();
	    	Map<String, WebSocketSession> map = handler.getUserSessions();
	    	WebSocketSession session = map.get("kjuioq");
	    	TextMessage message = new TextMessage("{\"sendUser\":\""+userId+"\",\"rsvdId\":\""+rsvdId+"\",\"cmd\":\"rsvd\",\"storeId\":\""+storeId+"\"}");
	    	handler.handleMessage(session, message);
	    	
	    	log.warn(result);
			log.warn("=========================================rsvd 예약 완료");
		}

}
