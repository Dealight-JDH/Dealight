package com.dealight.mapper;

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
import com.dealight.domain.StoreVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class LikeMapperTests {
	
	@Autowired
	LikeMapper mapper;
	
	Long storeId = 16L;
	String userId = "kjuioq";
	
	
	@Test
	public void findListByUserIdTest1() {
		
		List<LikeVO> list = mapper.findListByUserId(userId);
		
		log.info(list);
		assertNotNull(list);
		
		list.stream().forEach(like -> {
			log.info("like : "+like);
			assertTrue(like.getUserId().equals(userId));
		});
		
	}
	
	@Test
	public void findListByStoreIdTest1() {
		
		List<LikeVO> list = mapper.findListByStoreId(storeId);
		
		log.info(list);
		assertNotNull(list);
		
		list.stream().forEach(like -> {
			log.info("like : "+like);
			assertTrue(like.getStoreId() == storeId);
		});
	}
	
	@Test
	public void findListByStoreIdAndUserIdTest1() {
		
		LikeVO like = mapper.findByUserIdAndStoreId(userId, storeId);
		
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
		
		LikeVO like = new LikeVO().builder()
				.storeId(storeId)
				.userId(userId)
				.build();
		
		mapper.insert(userId,storeId);
		
		LikeVO insertLike = mapper.findByUserIdAndStoreId(userId, storeId);
		
		assertTrue(like.getStoreId() == insertLike.getStoreId());
		assertTrue(like.getUserId().equals(insertLike.getUserId()));
		
	}
	
	@Transactional
	@Test
	public void deleteTest1() {
		
		userId = "hyun";
		storeId = 19L;
		
		int result = mapper.delete(userId, storeId);
		
		assertTrue(result == 1);
		
	}
	
	@Test
	public void findListWithPagingByUserIdTest1() {
		
		userId = "kjuioq";
		int pageNum = 1;
		int amount = 3;
		
		List<LikeVO> list = mapper.findListWithPagingByUserId(userId, new Criteria(pageNum,amount));
		
		log.info(list);
		assertNotNull(list);
		assertTrue(list.size() == amount);
		
	}
	
	@Test
	public void getLikeTotalTest1() {
		
		userId = "kjuioq";
		int pageNum = 1;
		int amount = 3;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		int result = mapper.getLikeTotal(userId, cri);
		
		log.info("result.............. : " + result);
		
	}
	
	@Test
	public void findStoreListWithPagingByUserIdTest1() {
		
		String userId = "aaaa";
		int pageNum = 1;
		int amount = 5;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		List<StoreVO> list = mapper.findStoreListWithPagingByUserId(userId,cri);
		
		list.stream().forEach(store -> {
			log.info("store : "+store);
			log.info("store name : "+store.getStoreNm());
		});
	}

}
