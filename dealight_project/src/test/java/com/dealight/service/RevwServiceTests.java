package com.dealight.service;

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
public class RevwServiceTests {

	@Setter(onMethod_ =@Autowired )
	private RevwService service;
	
	@Test
	public void testRevws() {
		
		service.revws(3L, new Criteria(1,4)).forEach(revw->log.info(revw));;
	}
	
//	public void testRevws() {
//		List<RevwVO> revws = service.revws(3L);
//		revws.forEach(revw->log.info(revw));
//	}
	
	
}
