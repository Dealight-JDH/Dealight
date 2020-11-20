package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class StoreTagVOTests {
	
    // 매장번호 
    private long storeId = 13;

    // 해시태그이름 
    private String tagNm = "분식";

    
    @Test
    public void generateTest1() {
    	
    	StoreTagVO stag = new StoreTagVO().builder()
    			.storeId(storeId)
    			.tagNm(tagNm)
    			.build();
    	
    	assertNotNull(stag);
    	
    	assertTrue(stag.getStoreId() == storeId);
    	assertTrue(stag.getTagNm().equals(tagNm));
    	
    }

}
