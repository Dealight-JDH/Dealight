package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.StoreLocVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreLocMapperTests {

	@Setter(onMethod_ = @Autowired)
	private StoreLocMapper mapper;
	
//	@Test
	public void testInsert() {

		StoreLocVO loc = new StoreLocVO();
		loc.setStoreId(5L);
		loc.setAddr("종로구");
		loc.setLng(2.12);
		loc.setLat(1.123123);
		
		mapper.insert(loc);
		
		log.info(loc);
	}

	@Test
	public void testGetList() {
		
		mapper.getList();
	}
	
//	@Test
	public void testRead() {
		log.info(mapper.read(1L));
	}
	
//	@Test
	public void testDelete() {
		log.info("DELETE COUNT : " + mapper.delete(0L));
	}
	
//	@Test 
	public void testModify() {
		
		StoreLocVO loc = new StoreLocVO();
		loc.setStoreId(4L);
		loc.setAddr("종로구");
		loc.setLng(2.0);
		loc.setLat(3.0);
		
		mapper.update(loc);
		
	}
//	@Test
//	public void testGetRadiusList() {
//		UserLoc uLoc = new UserLoc();
//		// 비트캠프 37.570414, 126.985320
//		uLoc.setLat(37.570414);
//		uLoc.setLng(126.985320);
//		uLoc.setDistance(500);
//		
//		mapper.getRadiusList(uLoc);
//		
//	}
}
