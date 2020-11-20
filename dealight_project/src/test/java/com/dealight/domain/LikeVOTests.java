package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class LikeVOTests {

	
	private long storeId = 13;
	private String userId = "kjuioq";
	
	@Test
	public void StoreLikeGenerateTest1() {
		
		LikeVO like = new LikeVO.LikeVOBuilder()
				.storeId(storeId)
				.userId(userId)
				.build();
		
		assertNotNull(like);
		
		assertTrue(like.getStoreId() == storeId);
		assertTrue(like.getUserId().equals(userId));
		
		
	}
}
