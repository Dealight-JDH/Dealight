package com.dealight.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.Criteria;
import com.dealight.domain.StoreVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class )
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreServiceTests {

	@Setter(onMethod_ =@Autowired )
	private StoreService service;
	
	@Test
	public void testBstore() {
		StoreVO store = service.bstore(3L);
		log.info(store);
	}
	
	public void testExist(){
		log.info(service);
		assertNotNull(service);
	}
	
}
