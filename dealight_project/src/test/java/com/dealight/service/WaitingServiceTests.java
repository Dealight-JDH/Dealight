package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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
				.userId("a")
				.waitPnum(3)
				.waitRegTm(new Date())
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
				.waitRegTm(new Date())
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
	
}