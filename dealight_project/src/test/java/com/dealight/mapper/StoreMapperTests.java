package com.dealight.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.StoreVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class StoreMapperTests {

	@Setter(onMethod_ = @Autowired)
	private StoreMapper mapper;
	
	
	public void testGetNstore() {
		StoreVO store = mapper.getNstore(1L);
		log.info(store);
	}
	
	public void testGetStoreCd() {
		String storeCode = mapper.getStoreCd(1L);
		log.info(storeCode);
	}
	@Test
	public void testGetBstore() {
		StoreVO store = mapper.getBstore(3L);
		log.info(store);
	}

	
	
}
