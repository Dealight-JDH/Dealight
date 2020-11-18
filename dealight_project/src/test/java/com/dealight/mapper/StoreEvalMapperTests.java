package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.StoreEvalVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreEvalMapperTests {

	@Setter(onMethod_ = @Autowired)
	private StoreEvalMapper mapper;
	
	@Test
	public void testInsert() {
		
		StoreEvalVO eval = new StoreEvalVO();
		eval.setAvgRating(5.0);
		eval.setLikeTotNum(40);
		eval.setRevwTotNum(20);
		eval.setStoreId(2L);
	
		mapper.insert(eval);
		log.info(eval);
		
	}
	
	@Test
	public void testRead() {
		log.info(mapper.read(1L));
	}
	
	@Test
	public void testUpdate() {
		
		StoreEvalVO eval = new StoreEvalVO();
		eval.setAvgRating(3.0);
		eval.setLikeTotNum(10);
		eval.setRevwTotNum(30);
		eval.setStoreId(2L);
		
		log.info(mapper.update(eval));
	}
	
//	@Test
	public void testDelet() {
		log.info(mapper.delete(2L));
	}

}
