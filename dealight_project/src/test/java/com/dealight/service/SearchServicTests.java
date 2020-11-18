package com.dealight.service;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SearchServicTests {

	
	@Setter(onMethod_ = @Autowired)
	private SearchService service;
	
//	@Test
//	public void testGetRadiusStoreWithPaging() {
//
//		Criteria cri = new Criteria();
//		cri.setAmount(30);
//		cri.setPageNum(10);
//		
//		service.getRadiusStore(cri).forEach(store-> log.info(store));
//		
//	}

}
