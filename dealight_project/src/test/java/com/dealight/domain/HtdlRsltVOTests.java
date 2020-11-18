package com.dealight.domain;

import static org.junit.Assert.*;

import org.junit.Test;

import lombok.NonNull;

public class HtdlRsltVOTests {
	
    private long htdlId = 1;
    private long storeId = 1;
    private int lastPnum = 30;
    private int htdlLmtPnum = 50;
    private Double rsvdRate = 0.5;
    private String elapTm = "30:00";

	@Test
	public void htdlRsltGenerateTest1() {
		
		HtdlRsltVO htdlRslt = new HtdlRsltVO.HtdlRsltVOBuilder()
				.htdlId(htdlId)
				.storeId(storeId)
				.lastPnum(lastPnum)
				.htdlLmtPnum(htdlLmtPnum)
				.rsvdRate(rsvdRate)
				.elapTm(elapTm)
				.build();
		
		assertTrue(htdlRslt.getHtdlId() == htdlId);
		assertTrue(htdlRslt.getStoreId() == storeId);
		assertTrue(htdlRslt.getLastPnum() == lastPnum);
		assertTrue(htdlRslt.getHtdlLmtPnum() == htdlLmtPnum);
		assertTrue(htdlRslt.getRsvdRate() == rsvdRate);
		assertTrue(htdlRslt.getElapTm().equals(elapTm));
		
		
	}

}
