package com.dealight.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.StoreMenuVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreMenuMapperTests {

	@Autowired
	private StoreMenuMapper mapper;
	
	@Test
	public void testSelect() {
		Long storeId = 4l;
		List<StoreMenuVO> vo = mapper.findById(storeId);
		
		vo.forEach(menuVO -> log.info(menuVO));
	}
	
	@Test
	public void testFindMenu() {
		Long storeId = 4l;
		String name = "불고기 버거";
		
//		MenuDTO menu = mapper.findPriceByName(storeId, name);
		
//		log.info(menu);
		
		
	}
}
