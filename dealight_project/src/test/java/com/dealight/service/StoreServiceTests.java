package com.dealight.service;

import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreServiceTests {

	@Setter(onMethod_ = @Autowired)
	private StoreService service;
	
	@Test
	@Transactional
	@Rollback(false)
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
	
	@Test
	public void testGet() {
		
		log.info(service.getAllInfo(15L));
		
	}
	
	@Test
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
	
	@Test
	public void testDelete() {
		assertTrue(service.delete(10L));
	}
	
	@Test
	public void testGetList() {
		
		service.getList().forEach(store -> { 
			log.info(store);
			log.info(store.getBstore());
		});
		
	}
	
	@Test
	public void testGetStoreListByUserId() {
		service.getStoreListByUserId("aaaa").forEach(store->log.info(store));
	}
}
