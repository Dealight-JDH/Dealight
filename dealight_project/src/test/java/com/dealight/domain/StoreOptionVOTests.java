package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class StoreOptionVOTests {
	
    // 매장번호 
    private long storeId = 13;
    private String park = "Y";
    private String nokids = "Y";
    private String pg = "N";
    private String wifi = "N";
    private String pet = "N";
    private String smoke = "N";
	
	@Test
	public void StoreOptionGenerateTest1() {
		
		StoreOptionVO sopt = new StoreOptionVO.StoreOptionVOBuilder()
				.park(park)
				.nokids(nokids)
				.pg(pg)
				.wifi(wifi)
				.pet(pet)
				.smoke(smoke)
				.storeId(storeId)
				.build();
		
		assertNotNull(sopt);
		
		assertTrue("Y".equals(sopt.getPark()));
		assertTrue("Y".equals(sopt.getNokids()));
		assertTrue("N".equals(sopt.getPg()));
		assertTrue("N".equals(sopt.getWifi()));
		assertTrue("N".equals(sopt.getPet()));
		assertTrue("N".equals(sopt.getSmoke()));
		
	}

}
