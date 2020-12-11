package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.LikeVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LikeServiceTests {
	
	Long storeId = 16L;
	String userId = "kjuioq";
	
	@Autowired
	LikeService likeService;
	
	
	@Test
	public void findListByUserIdTest1() {
		
		List<LikeVO> list = likeService.findListByUserId(userId);
		
		log.info(list);
		assertNotNull(list);
		
		list.stream().forEach(like -> {
			log.info("like : "+like);
			assertTrue(like.getUserId().equals(userId));
		});
		
	}
	
	@Test
	public void findListByStoreIdTest1() {
		
		List<LikeVO> list = likeService.findListByStoreId(storeId);
		
		log.info(list);
		assertNotNull(list);
		
		list.stream().forEach(like -> {
			log.info("like : "+like);
			assertTrue(like.getStoreId() == storeId);
		});
	}
	
	@Test
	public void findListByStoreIdAndUserIdTest1() {
		
		LikeVO like = likeService.findByUserIdAndStoreId(userId, storeId);
		
		log.info(like);
		assertNotNull(like);
		assertTrue(like.getUserId().equals(userId));
		assertTrue(like.getStoreId().equals(storeId));
		
	}
	
	@Transactional
	@Test
	public void insertTests1() {
		
		userId = "hyun";
		storeId = 20L;
		
		likeService.pick(userId,storeId);
		
		LikeVO insertLike = likeService.findByUserIdAndStoreId(userId, storeId);
		
		assertTrue(storeId == insertLike.getStoreId());
		assertTrue(userId.equals(insertLike.getUserId()));
		
	}
	
	@Transactional
	@Test
	public void deleteTest1() {
		
		userId = "hyun";
		storeId = 19L;
		
		boolean result = likeService.cancel(userId, storeId);
		
		assertTrue(result);
		
	}
	
	@Test
	public void getLikeTotalByUserIdTest1() {
		
		
		
		int pageNum = 1;
		int amount = 3;
		Criteria cri = new Criteria();
		
		int result = likeService.getLikeTotalByUserId(userId, cri);
		
		log.info(result);
	}

}
