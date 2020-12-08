package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MainStoreJoinMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MainStoreJoinMapper mapper;
	
	@Test
	public void testGetList() {
		
		mapper.getList().forEach(store -> log.info(store));
		
	}

	@Test
	public void testRead() {
		
		log.info(mapper.read(23L));
		
	}
	
//	@Test
//	public void testPaging() {
//		
//		Criteria cri = new Criteria();
//		
//		mapper.getListWithPaging(cri).forEach(store -> log.info(store));
//	}
//	
//	@Test
//	public void testSearch() {
//		
//		Criteria cri = new Criteria();
////		cri.setSortType("R");
//		cri.setSortPriority("H");
//		cri.setAmount(100);
//		cri.setPageNum(1);
//		mapper.getListWithPaging(cri).forEach(store -> log.info(store));
//	}
	
	
}
