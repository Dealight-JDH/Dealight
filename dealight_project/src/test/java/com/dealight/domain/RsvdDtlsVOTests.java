package com.dealight.domain;

import static org.junit.Assert.*;

import org.junit.Test;

import lombok.NonNull;

public class RsvdDtlsVOTests {

	//필수 입력값
    private long rsvdId = 1;
    private long rsvdSeq = 1;
    private String menuNm = "돈까스";
    private int menuTotQty = 5;
    private int menuPrc = 3000;
	
	// 1. 필수 입력값만 입력하고 매장객체가 생성될 수 있는지.
	@Test
	public void reservationDetailGenerateTest1() {
		
		RsvdDtlsVO rsvdDtls = new RsvdDtlsVO.RsvdDtlsVOBuilder()
				.rsvdId(rsvdId)
				.rsvdSeq(rsvdSeq)
				.menuNm(menuNm)
				.menuTotQty(menuTotQty)
				.menuPrc(menuPrc)
				.build();
		
		assertTrue(rsvdDtls.getRsvdId() == rsvdId);
		assertTrue(rsvdDtls.getRsvdSeq() == rsvdSeq);
		assertTrue(rsvdDtls.getMenuNm().equals(menuNm));
		assertTrue(rsvdDtls.getMenuTotQty() == menuTotQty);
		assertTrue(rsvdDtls.getMenuPrc() == menuPrc);
		
		
	}

}
