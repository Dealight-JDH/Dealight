package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.WaitVO;
import com.dealight.mapper.WaitMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class WaitingServiceTests {

	@Autowired
	private WaitService waitingService;
	
	@Autowired
	private WaitMapper waitMapper;
	
	
	@Test 
	public void DITest1(){
		
		assertNotNull(waitingService);
	}
	SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	private long waitId = 24;
	private String userId = "kjuioq";
	private long storeId = 13;
	
	@Test
	public void readByIdTest() {
		
		WaitVO wait = waitingService.read(waitId);
		
		assertNotNull(wait);
		
	}
	
	@Test
	public void registerOnWaitingTest1() {
		
		WaitVO waiting = new WaitVO().builder()
				.waitId(30L)
				.storeId(13L)
				.userId("aaa")
				.waitPnum(3)
				.waitRegTm(formater.format(new Date()))
				.custTelno("010-2737-3333")
				.custNm("����")
				.waitStusCd("W")
				.build();
		
		waitingService.registerOnWaiting(waiting);
		
		long result = waiting.getWaitId();
		log.info("size.................................."+waitMapper.findAll().size());
		log.info("result................................"+result);
		
		//assertTrue(result == 49);
		
	}
	
	@Test
	public void isCurWaitingUserTest() {
		
		assertTrue(waitingService.isCurWaitingUser(userId));
		
	}
	
	@Test
	public void isCurPanaltyUserTest1() {
		
		assertTrue(!waitingService.isCurPanaltyUser(userId));
	}
	
	@Test
	public void isPossibleWaitingUserTest1() {
		
		userId = "aaa";
		
		assertTrue(waitingService.isPossibleWaitingUser(userId));
	}
	
	@Test
	public void registerOffWaitingTest1() {
		
		WaitVO waiting = new WaitVO().builder()
				.waitId(30L)
				.storeId(13L)
				.waitPnum(3)
				.waitRegTm(formater.format(new Date()))
				.custTelno("010-2737-3333")
				.custNm("����մ�")
				.waitStusCd("W")
				.build();
		
		waitingService.registerOffWaiting(waiting);
		
		long result = waiting.getWaitId();
		
	}
	
	@Test
	public void cancelWaitingTest1() {
		
		assertTrue(waitingService.cancelWaiting(waitId));
		
		assertTrue(waitingService.read(waitId).getWaitStusCd().equals("C"));
	}
	
	@Test
	public void enterWatingTest1() {
		
		assertTrue(waitingService.enterWaiting(waitId));
		
		assertTrue(waitingService.read(waitId).getWaitStusCd().equals("E"));
	}
	
	@Test
	public void panaltyWaitingTest1() {
		
		assertTrue(waitingService.panaltyWaiting(waitId));
		
		assertTrue(waitingService.read(waitId).getWaitStusCd().equals("P"));
	}
	
	@Test
	public void allStoreWaitListTest1() {
		
		List<WaitVO> list = waitingService.allStoreWaitList(storeId);
		
		assertNotNull(list);
		
		list.stream().forEach(wait -> {
			assertTrue(wait.getStoreId() == storeId);
		});

	}
	
	@Test
	public void curStoreWaitListTest1() {
		
		List<WaitVO> list = waitingService.curStoreWaitList(storeId, "C");
		
		assertNotNull(list);
		
		list.stream().forEach(wait -> {
			assertTrue(wait.getStoreId() == storeId);
			assertTrue(wait.getWaitStusCd().equalsIgnoreCase("C"));
		});
	}
	
	@Test
	public void calWatingOrderTest1() {
		
		List<WaitVO> list = waitingService.curStoreWaitList(storeId, "W");
		
		log.info(list);
		
		int result = waitingService.calWatingOrder(list, 25L);
		
		log.info("result..................... : " + result);
		
	}
	
	@Test
	public void calWaitingTimeTest1() {
		
		List<WaitVO> list = waitingService.curStoreWaitList(storeId, "W");
		
		int result = waitingService.calWaitingTime(list, waitId, 30);
	
		log.info("result..................... : " + result);
		
	}
	
	@Test
	public void readNextWaitTest() {
		
		long storeId = 13;
		
		List<WaitVO> curStoreWaitiList = waitingService.curStoreWaitList(storeId, "W");
		
		log.info(curStoreWaitiList);
		
		WaitVO wait = waitingService.readNextWait(curStoreWaitiList);
		
		log.info(wait);
	}
	
	@Transactional
	@Test
	public void waitInitTest1() {
		
		int upNum = waitingService.waitInit();
		
		log.info("=================="+upNum);
		
		assertTrue(1 <= upNum);
		
	}
	
    @Test
    public void findWaitListWithPagingByUserIdTest1() {
    	
    	userId = "kjuioq";
    	
    	int pageNum = 1;
    	int amount = 3;
    	
    	Criteria cri = new Criteria(pageNum,amount);
    	
    	userId = "kjuioq";
    	
    	List<WaitVO> list = waitingService.findWaitListWithPagingByUserId(userId, cri);
    	
    	list.stream().forEach(wait -> {
    		
    		log.info("wait : " + wait);
    		
    		assertTrue(wait.getUserId().equals(userId));
    	});
    	
    	log.info("list : "+list);
    	log.info("list size : "+list.size());
    	
    	assertTrue(list.size() == amount);
    	
    }
    
    @Test
    public void getWaitCntTest1() {
    	
    	userId = "kjuioq";
    	
    	int pageNum = 1;
    	int amount = 3;
    	
    	Criteria cri = new Criteria(pageNum,amount);
    	
    	int wait = waitingService.getCurWaitCnt(userId, cri);
    	int enter = waitingService.getEnterWaitCnt(userId, cri);
    	int panalty = waitingService.getPanaltyWaitCnt(userId, cri);
    	int total = wait + enter + panalty;
    	
    	log.info("wait : " + wait);
    	log.info("enter : " + enter);
    	log.info("panalty : " + panalty);
    	log.info("kjuioq의 웨이팅 상태 개수 : "+total);
    	
    }
    
    @Test
    public void getWaitByUserIdTest1() {
    	
    	userId = "kjuioq";
    	
    	WaitVO wait = waitingService.getCurWaitByUserId(userId);
    	
    	log.info(wait);
    	
    }
    
    @Test
    public void findList() {
    	
    	
    	Long storeId = 146L;
    	
    	List<WaitVO> waitList = waitingService.findLastWeekRsvdListByStoreId(storeId);
		
		// 예약 등록 날짜의 포맷을 설정해준다.
		waitList.stream().forEach((wait) -> {
			wait.setStrWaitRegTm(wait.getWaitRegTm().substring(0,10));
			log.info("time : " + wait.getStrWaitRegTm());
		});
    }
    
    @Test
    public void cancelWait() {
    	
    	boolean isAvalCancel = false; 
    	
		Date curTime = new Date();
		
		WaitVO wait = waitingService.read(138L);
		String regWaitTime = wait.getWaitRegTm();
		//String regWaitTime = "2021/01/02 14:53:47";
		SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String strCurTime = formater.format(curTime);
		log.info("wait reg time : " + wait.getWaitRegTm());
		log.info("cur time : " + strCurTime);
		
		log.info("regWaitTime.split(\":\")[1] : " + regWaitTime.split(":")[1]);
		log.info("regWaitTime.split(\":\")[2] : " + regWaitTime.split(":")[2]);
		
		log.info("Integer.parseInt(strCurTime.split(\":\")[1] : " + strCurTime.split(":")[1]);
		log.info("Integer.parseInt(strCurTime.split(\":\")[2] : " + strCurTime.split(":")[2]);
		
		int intWaitTime = (Integer.parseInt(regWaitTime.split(":")[1]) * 60) + (Integer.parseInt(regWaitTime.split(":")[2]));
		int intCurTime = (Integer.parseInt(strCurTime.split(":")[1]) * 60) + (Integer.parseInt(strCurTime.split(":")[2]));
		
		log.info("intWaitTime : "+intWaitTime);
		log.info("intCurTime : "+intCurTime);
		
		log.info("regWaitTime.substring(0, 13)" + regWaitTime.substring(0, 13));
		log.info("strCurTime.substring(0, 13)" + strCurTime.substring(0, 13));
		
		if(regWaitTime.substring(0, 13).equals(strCurTime.substring(0, 13)) && intCurTime - intWaitTime <= 300) {
			isAvalCancel = true;
		}
		
		log.info("result : " + isAvalCancel);
    }
}
