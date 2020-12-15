package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.StoreEvalVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreEvalTests {
	
	private long storeId = 102;
	private double avgRating = 4.5;
	private int revwTotNum = 30;
	private int likeTotNum = 24;
	
	@Setter(onMethod_ = @Autowired)
	private StoreEvalMapper mapper;
	
	@Test
	public void updateTest1() {
		
		StoreEvalVO eval = new StoreEvalVO().builder()
				.storeId(storeId)
				.avgRating(avgRating)
				.revwTotNum(revwTotNum)
				.likeTotNum(likeTotNum)
				.build();
		
		int result = mapper.update(eval);
		
		assertTrue(result == 1);
	}
	
	@Test
	public void insertTest1() {
		
		storeId = 23;
		
		StoreEvalVO eval = new StoreEvalVO().builder()
				.storeId(storeId)
				.avgRating(avgRating)
				.revwTotNum(revwTotNum)
				.likeTotNum(likeTotNum)
				.build();
		
		mapper.insert(eval);
		
		assertNotNull(mapper.findByStoreID(storeId));
		
	}
	
	@Test
	public void findByIdTests1() {
		
		assertNotNull(mapper.findByStoreID(storeId));
	}
	
	@Transactional
	@Test
	public void addLikeTests1() {
		
		Long storeId = 1L;
		
		StoreEvalVO eval = mapper.read(storeId);
		int befLikeTot = eval.getLikeTotNum();
		
		int result = mapper.addLike(storeId);
		assertTrue(result == 1);
		
		eval = mapper.read(storeId);
		
		
		log.info("before eval like tot num : " + befLikeTot);
		log.info("after eval like tot num : "+eval.getLikeTotNum());
		assertTrue(befLikeTot+1 == eval.getLikeTotNum());
		
		
	}
	
	@Transactional
	@Test
	public void removeLikeTests1() {
		
		Long storeId = 1L;
		
		StoreEvalVO eval = mapper.read(storeId);
		int befLikeTot = eval.getLikeTotNum();
		
		int result = mapper.removeLike(storeId);
		assertTrue(result == 1);
		
		eval = mapper.read(storeId);
		
		
		log.info("before eval like tot num : " + befLikeTot);
		log.info("after eval like tot num : "+eval.getLikeTotNum());
		assertTrue(befLikeTot-1 == eval.getLikeTotNum());
		
	}
	
	
	

}
