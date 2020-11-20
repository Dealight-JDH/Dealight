package com.dealight.domain;

import static org.junit.Assert.*;

import org.junit.Test;

import lombok.NonNull;

public class HtdlDtlsVOTests {
	
    private long htdlId = 1;
    private long htdlSeq = 1;
    private String menuName = "µ·±î½º";
    private int menuPrice = 3000;

	@Test
	public void hotDealDetailGenerateTest1() {
		HtdlDtlsVO htdlDtls = new HtdlDtlsVO.HtdlDtlsVOBuilder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName(menuName)
				.menuPrice(menuPrice)
				.build();
		
		assertTrue(htdlDtls.getHtdlId() == htdlId);
		assertTrue(htdlDtls.getHtdlSeq() == htdlSeq);
		assertTrue(htdlDtls.getMenuName().equals(menuName));
		assertTrue(htdlDtls.getMenuPrice() == menuPrice);
	}

}
