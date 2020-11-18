package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.BStoreVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreServiceTests {

	@Autowired
	private StoreService storeService;
	
	String userId = "kjuioq";
	long storeId = 13;
	
	@Test
	public void serviceDITest() {
		
		log.info(storeService);
		
	}
	
	@Test
	public void getSeatStusTests1() {
		
		long storeId = 13;
		String seatStusCd = "G";
		
		String stus = storeService.getCurSeatStus(storeId);
		
		log.info(stus);
		
		stus.equals("G");
	}

	
	@Test
	public void seatStusChangeTests1() {
		
		long storeId = 13;
		String seatStusCd = "B";
		
		String stus = storeService.getCurSeatStus(storeId);
		
		log.info(stus);
		
		assertTrue(storeService.changeSeatStus(storeId, seatStusCd));
		
		stus = storeService.getCurSeatStus(storeId);
		
		log.info(stus);
		
		assertTrue(stus.equals(seatStusCd));
	}
	
	@Test
	// @Transactional �ѹ�, ����¸�
	// @Rollback(false) �ѹ��� �ȵȴ�.
	public void getCurTests1() {
		
		log.info(storeService.getCurTime());
	}
	
	@Test
	public void getStore() {
		
		StoreVO store = storeService.getStore(13);
		
		assertNotNull(store);
	}
	
	@Test
	public void getBStore() {
		
		BStoreVO bstore = storeService.getBStore(13);
		
		assertNotNull(bstore);
		
	}
	
	@Test
	public void getStoreListByUserIdTest1() {
		
		List<StoreVO> list = storeService.getStoreListByUserId(userId);
		
		log.info(list);
		
		list.stream().forEach(store -> {
			assertNotNull(store.getBstore());
			assertTrue(store.getBstore().getBuserId().equals(userId));
			
		});
	}
	
	@Test
	public void findByStoreIdWithBStoreTest() {
		
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		log.info(store);
		
		assertNotNull(store);
		
		assertTrue(store.getStoreId() == storeId);
		
	}
	
	@Test
	public void registerStoreTest1() {
		
		
	}
	
	@Test
	public void modifyStoreTest1() {
		
		StoreVO store = storeService.getStore(storeId);
		
		log.info(store);
		
		store.setStoreNm("����");
		store.setRepImg("d");
		store.setBrch("d");
		
		assertTrue(storeService.modifyStore(store));
		
		store = storeService.findByStoreIdWithBStore(storeId);
		
		log.info(store);
		
	}
	
	@Test
	public void modifyBStoreTest1() {
		
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		store.setClsCd("B");
		
		log.info(store);
		
		store.getBstore().setHldy("����");
		store.setRepImg("d");
		store.setBrch("d");
		
		assertTrue(storeService.modifyStore(store));
		
		store = storeService.findByStoreIdWithBStore(storeId);
		
		log.info(store);
		
	}
	
	@Test
	@Transactional
	@Rollback(false)
	public void registerStoreAndBStoreTest2() throws Exception {
		
		BStoreVO bstore = new BStoreVO().builder()
				.closeTm("22:00")
				.storeIntro("�ȳ��ϼ���!")
				.openTm("09:00")
				.buserId("aaa")
				.repImg("d")
				.brch("d")
				.build();
		
		StoreVO store = new StoreVO().builder()
				.storeId(13L)
				.storeNm("ds")
				.telno("000")
				.bstore(bstore)
				.brch("d")
				.build();
		
		storeService.registerStoreAndBStore(store);

		
	}
	
	@Test
	public void findAllStoreByStoreIdTest1() {
		
		storeId = 101;
		
		AllStoreVO allStore = storeService.findAllStoreInfoByStoreId(storeId);
		
		assertNotNull(allStore);
		
		log.info(allStore);
		
	}
	
	@Test
	public void getStoreImageListTest1() {
		
		storeId = 101;
		
		List<StoreImgVO> list = storeService.getStoreImageList(storeId);
		
		assertNotNull(list);
		
		log.info(list);
		
	}
	
	@Transactional
	@Test
	public void deleteImgAll() {
		
		
		log.info(storeService.getStoreImageList(storeId));
		
		storeService.removeStoreImgAll(storeId);
		
		assertTrue(0 ==storeService.getStoreImageList(storeId).size());
	}
	
	@Test
	public void findMenuByStoreIdTest1() {
		
		List<MenuVO> list = storeService.findMenuByStoreId(storeId);
		
		assertNotNull(list);
		
		log.info(list);
		
	}
	
	@Transactional
	@Test
	public void registerMenuTest1() {
		
		long storeId = 13;
		String recoMenu = "N";
		int price = 5000;
		String name = "ġ��";
		String imgUrl = "/a.jpg";
		
		MenuVO menu = new MenuVO().builder()
				.storeId(storeId)
				.recoMenu(recoMenu)
				.price(price)
				.name(name)
				.imgUrl(imgUrl)
				
				.build();
		
		storeService.registerMenu(menu);
		
		log.info(storeService.findMenuByStoreId(storeId));
		
	}
}
