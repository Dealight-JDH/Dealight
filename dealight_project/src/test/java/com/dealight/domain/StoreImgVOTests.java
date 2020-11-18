package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class StoreImgVOTests {
	
	private long storeId = 13;
	private long imgSeq = 1;
	private String imgUrl = "/a.jpg";
	
	@Test
	public void StoreImgGenerateTest1() {
		
		StoreImgVO simg = new StoreImgVO.StoreImgVOBuilder()
				.storeId(storeId)
				.imgSeq(imgSeq)
				.build();
		
		assertNotNull(simg);
		
		assertTrue(simg.getStoreId() == storeId);
		assertTrue(simg.getImgSeq() == imgSeq);

	}

}
