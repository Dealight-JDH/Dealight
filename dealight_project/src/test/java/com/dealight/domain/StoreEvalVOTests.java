package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class StoreEvalVOTests {
	
	private long storeId = 13;
	private double avgRating = 4.5;
	private int revwTotNum = 5;
	private int likeTotNum = 25;
	
	@Test
	public void StoreEvalGenerateTest1() {
		
		StoreEvalVO seval = new StoreEvalVO.StoreEvalVOBuilder()
				.storeId(storeId)
				.avgRating(avgRating)
				.revwTotNum(revwTotNum)
				.likeTotNum(likeTotNum)
				.build();
		
		assertNotNull(seval);
		
		assertTrue(seval.getStoreId() == storeId);
		assertTrue(seval.getAvgRating() == avgRating);
		assertTrue(seval.getRevwTotNum() == revwTotNum);
		assertTrue(seval.getLikeTotNum() == likeTotNum);
		
		
	}

}
