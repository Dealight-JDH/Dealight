package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class StoreLocVOTests {
	
	private long storeId = 13;
	private String addr = "�ּ�";
	private Double lat = 90.0;
	private Double lng = 30.0;
	
	@Test
	public void StoreLocGenerateTest1() {
		
		StoreLocVO sloc = new StoreLocVO.StoreLocVOBuilder()
				.addr(addr)
				.lat(lat)
				.lng(lng)
				.storeId(storeId)
				.build();
		
		assertNotNull(sloc);
		
		assertTrue(sloc.getStoreId() == storeId);
		assertTrue(sloc.getAddr().equals(addr));
		assertTrue(sloc.getLat() == lat);
		assertTrue(sloc.getLng() == lng);
		
		
	}

}
