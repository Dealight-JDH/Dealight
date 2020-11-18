package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

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
public class StoreLocTests2 {
	
	@Setter(onMethod_ = @Autowired)
	private StoreLocMapper mapper;
	
	private long storeId = 102;
	private String addr = "�����ּ�";
	private double lat = 90;
	private double lng = 40;
	
	@Test
	public void updateTest1() {
		
		StoreLocVO loc = new StoreLocVO().builder()
				.storeId(storeId)
				.addr(addr)
				.lat(lat)
				.lng(lng)
				.build();
		
		int result = mapper.update(loc);
		
		assertTrue(result == 1);
	}
	
	@Test
	public void findByStoreIdTests1() {
		
		StoreLocVO loc = mapper.findByStoreId(storeId);
		
		assertNotNull(loc);
		
		log.info(loc);
	}
	
	@Test
	public void insertTests() {
		
		storeId = 86;
		
		StoreLocVO loc = new StoreLocVO().builder()
				.storeId(storeId)
				.addr(addr)
				.lat(lat)
				.lng(lng)
				.build();
		
		mapper.insert(loc);
		
		loc = mapper.findByStoreId(storeId);
		
		assertNotNull(loc);
		
		log.info(loc);
		
		
	}

}
