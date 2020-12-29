package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.net.URLEncoder;
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
import com.dealight.domain.BUserVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class )
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreServiceTests {

	@Setter(onMethod_ = @Autowired)
	private StoreService service;
	
	@Test
	public void storeTest() {
		
		log.info(service);
		
		log.info(service.getBStore(1L));
		
		
		
	}
	
	
	@Test
	public void URLtest() {
		
		Long storeId = 1L;
		
		StoreVO store = service.findByStoreIdWithBStore(storeId);
		
		log.info("store........................."+store);
		
		log.info("repimg......................."+store.getBstore().getRepImg());
		
		log.info("get rep img..................."+URLEncoder.encode(store.getBstore().getRepImg()));
		
		
		
	}
	
	@Test
	public void getStoreListByUserIdTest1() {
		
		String userId = "aaaa";
		
		log.info("aaaa........................");
		
		log.info(service);
		
		log.info(service.findAllStoreInfoByStoreId(1L));
		
		List<StoreVO> list = service.getStoreListByUserId(userId);
		
		log.info(list);
		
		list.stream().forEach(store -> {
			assertNotNull(store.getBstore());
			assertTrue(store.getBstore().getBuserId().equals(userId));
			
		});
	}
	
	//@Test
	//@Transactional
	//@Rollback(false)
	public void testRegister() {
		
		StoreVO store = new StoreVO();
		store.setStoreNm("순대집");
		store.setTelno("123-123");
		store.setClsCd("B");

		StoreLocVO loc = new StoreLocVO();
		loc.setAddr("종로구");
		loc.setLng(3.0);
		loc.setLat(1.0);
		
		StoreEvalVO eval = new StoreEvalVO();
		eval.setAvgRating(2.5);
		eval.setLikeTotNum(20);
		eval.setRevwTotNum(5);
		
		BStoreVO bstore = new BStoreVO.Builder(0L, "aaaa", "종로본점", "순대국밥", "a.jpg", "10:00", "20:00")
				  .setAcmPnum(40).setAvgMealTm(40).setHldy("연중무휴").setN4SeatNo(10)
				  .setBreakSttm("15:00").setBreakEntm("18:00")
				  .setStoreIntro("안오면 후회하는 맛").build();
		store.setBstore(bstore);
		store.setLoc(loc);
		store.setEval(eval);
		service.register(store);
		
		log.info(store);
		
	}
	
//	@Test
	public void testNullRegister() {
		
		StoreVO store = new StoreVO();
		store.setStoreNm("순대집");
		store.setTelno("123-123");
		store.setClsCd("B");

		StoreLocVO loc = new StoreLocVO();
		loc.setAddr("종로구");
		loc.setLng(3.0);
		loc.setLat(1.0);
		
//		BStoreVO bStore = new BStoreVO.Builder(-1L, "aaaa", store.getStoreNm(), "10:00", "20:00").setStoreIntro("쩐맛탱구리다 안오면 후회").build();
//		store.setBStore(bStore);
		store.setLoc(loc);
		service.register(store);
		
		log.info(store);
		
	}
	
	//@Autowired
	private StoreService storeService;
	
	String userId = "kjuioq";
	long storeId = 13;
	
	//@Test
	public void serviceDITest() {
		
		log.info(storeService);
		
	}
	
	//@Test
	public void getSeatStusTests1() {
		
		long storeId = 13;
		String seatStusCd = "G";
		
		String stus = storeService.getCurSeatStus(storeId);
		
		log.info(stus);
		
		stus.equals("G");
	}

	
	//@Test
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
	
	//@Test
	// @Transactional �ѹ�, ����¸�
	// @Rollback(false) �ѹ��� �ȵȴ�.
	public void getCurTests1() {
		
		log.info(storeService.getCurTime());
	}
	
	//@Test
	public void getStore() {
		
		StoreVO store = storeService.getStore(13);
		
		assertNotNull(store);
	}
	
	@Test
	public void getBStore() {
		
		BStoreVO bstore = storeService.getBStore(13);
		
		assertNotNull(bstore);
		
	}
	

	
	//@Test
	public void findByStoreIdWithBStoreTest() {
		
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		log.info(store);
		
		assertNotNull(store);
		
		assertTrue(store.getStoreId() == storeId);
		
	}
	
	public void testModify() {
		StoreVO store = new StoreVO();
		store.setStoreId(4L);
		store.setStoreNm("명인돈까스");
		store.setTelno("123-123");
		store.setClsCd("B");

		StoreLocVO loc = new StoreLocVO();
		loc.setStoreId(4L);
		loc.setAddr("종로구");
		loc.setLng(3.0);
		loc.setLat(0.0);
		
		StoreEvalVO eval = new StoreEvalVO();
		eval.setStoreId(4L);
		eval.setAvgRating(4.5);
		eval.setLikeTotNum(20);
		eval.setRevwTotNum(50);
		
		BStoreVO bStore = new BStoreVO.Builder(4L, "aaaa", "종로본점", "돈까스", "a.jpg", "10:00", "20:00")
									  .setStoreIntro("쩐맛탱구리다 안오면 후회")
									  .setseatStusCd("G").setAcmPnum(40).setAvgMealTm(30).setN4SeatNo(6)
									  .setN2SeatNo(3).setN1SeatNo(0).setBreakEntm("17:00").setBreakSttm("15:00")
									  .setHldy("연중무휴").build();
		store.setBstore(bStore);
		store.setLoc(loc);
		store.setEval(eval);
		assertTrue(service.modify(store));
	}
	
	//@Test
	public void testDelete() {
		assertTrue(service.delete(10L));
	}
	
	//@Test
	public void testGetList() {
		
		service.getList().forEach(store -> { 
			log.info(store);
			log.info(store.getBstore());
		});
		
	}
	
	
	
	  @Test public void modifyBStoreTest1() {
	  
	  StoreVO store = storeService.findByStoreIdWithBStore(storeId);
	  store.setClsCd("B");
	  
	  log.info(store);
	  
	  //store.getBstore().setHldy("����"); store.setRepImg("d"); store.setBrch("d");
	  
	  assertTrue(storeService.modifyStore(store));
	  
	 store = storeService.findByStoreIdWithBStore(storeId);
	  
	  log.info(store);
	  
	  }
	 
	
	/*
	 * @Test
	 * 
	 * @Transactional
	 * 
	 * @Rollback(false) public void registerStoreAndBStoreTest2() throws Exception {
	 * 
	 * BStoreVO bstore = new BStoreVO().builder() .closeTm("22:00")
	 * .storeIntro("�ȳ��ϼ���!") .openTm("09:00") .buserId("aaa") .repImg("d")
	 * .brch("d") .build();
	 * 
	 * StoreVO store = new StoreVO().builder() .storeId(13L) .storeNm("ds")
	 * .telno("000") .bstore(bstore) .brch("d") .build();
	 * 
	 * storeService.registerStoreAndBStore(store);
	 * 
	 * 
	 * }
	 */
	
	//@Test
	public void findAllStoreByStoreIdTest1() {
		
		storeId = 16;
		
		AllStoreVO allStore = storeService.findAllStoreInfoByStoreId(storeId);
		
		assertNotNull(allStore);
		
		log.info(allStore);
		
	}
	
	//@Test
	public void getStoreImageListTest1() {
		
		storeId = 101;
		
		List<StoreImgVO> list = storeService.getStoreImageList(storeId);
		
		assertNotNull(list);
		
		log.info(list);
		
	}
	
	//@Transactional
	//@Test
	public void deleteImgAll() {
		
		
		log.info(storeService.getStoreImageList(storeId));
		
		storeService.removeStoreImgAll(storeId);
		
		assertTrue(0 ==storeService.getStoreImageList(storeId).size());
	}
	
	//@Test
	public void findMenuByStoreIdTest1() {
		
		List<MenuVO> list = storeService.findMenuByStoreId(storeId);
		
		assertNotNull(list);
		
		log.info(list);
		
	}
	
	//@Transactional
	//@Test
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
	
	//@Test
	public void testBstore() {
		StoreVO store = service.bstore(3L);
		log.info(store);
	}
	
	public void testExist(){
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void getStoreLocTest1() {
		
		storeId = 1L;
		
		StoreLocVO loc = service.getStoreLoc(storeId);
		
		log.info("loc.........................."+loc);
		
	}
	
	@Test
	public void findStoreWithLocByStoreIdTest1() {
		
		storeId = 13L;
		
		StoreVO store = service.findStoreWithLocByStoreId(storeId);
		
		
		log.info("store : "+store);
		log.info("store loc"+store.getLoc());
		
		assertNotNull(store.getLoc());
		
	}
	
	@Test
	public void findStoreWithBStoreAndLocByStoreIdTest1() {
		
		storeId = 13L;
		
		StoreVO store = service.findStoreWithBStoreAndLocByStoreId(storeId);
		
		log.info("store : " + store);
		
		
		assertNotNull(store);
		assertNotNull(store.getLoc());
		assertNotNull(store.getBstore());
		
	}
	
	@Test
	public void findComBrListByUserIdAndStusCdTest1() {
		
    	String userId = "aaaa";
    	
    	List<BUserVO> list = service.comBrListByUserId(userId);
    	
    	list.stream().forEachOrdered(buser -> {
    		buser.getUserId().equals(userId);
    		log.info("buser : " + buser);
    	});
    	
    	log.info(list);
		
	}
	
}
