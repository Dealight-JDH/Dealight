package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class StoreTagVOTests {
	
    // �����ȣ 
    private long storeId = 13;

    // �ؽ��±��̸� 
    private String tagNm = "�н�";

    
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
