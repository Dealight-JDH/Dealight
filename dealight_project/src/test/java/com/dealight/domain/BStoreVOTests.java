package com.dealight.domain;

import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class BStoreVOTests {
	
	// �ʼ� �Է�
    private long storeId = 1;
    private String seatStusCd;
    private String openTm = "09:30";
    private String closeTm = "21:30";
    
    // ���� �Է�
    private String buserId = "kjuioq";
    private String breakSttm = "15:00";
    private String breakEntm = "16:00";
    private String lastOrdTm = "21:00";
    private int n1SeatNo = 8;
    private int n2SeatNo = 10;
    private int n4SeatNo = 5;
    private String storeIntro = "�ȳ�?";
    private int avgMealTm = 30;
    private String hldy = "�Ͽ���"; 
    private int acmPnum = 40;

	// 1. �ʼ� �Է°��� �Է��ϰ� ���尴ü�� ������ �� �ִ���.
	// not null ���� �Է�
	// �ʼ��� : storeId,openTm,closeTm, storenm
	// �⺻�� : clsCd
	@Test
	public void storeGenerateTest1() {
		BStoreVO bstore = new BStoreVO.BStoreVOBuilder()
				.storeId(storeId)
				.openTm(openTm)
				.closeTm(closeTm)
				.build();
		
		assertTrue(bstore.getStoreId() == storeId);
		assertTrue(bstore.getOpenTm().equals(openTm));
		assertTrue(bstore.getCloseTm().equals(closeTm));

		assertNull(bstore.getBreakSttm());
		assertNull(bstore.getBreakEntm());
		assertNull(bstore.getLastOrdTm());
		assertTrue(bstore.getN1SeatNo() == 0);
		assertTrue(bstore.getN2SeatNo() == 0);
		assertTrue(bstore.getN4SeatNo() == 0);
		assertNull(bstore.getStoreIntro());
		assertTrue(bstore.getAvgMealTm() == 0);
		assertNull(bstore.getHldy());
		assertTrue(bstore.getAcmPnum() == 0);
		
	}
	
	// 2. �ʼ� �Է°��� �Է����� �ʾ��� ��
	// nullpointer exception �߻�
	@Test(expected=NullPointerException.class)
	public void storeGenerateTest2() {
		BStoreVO bstore = new BStoreVO.BStoreVOBuilder()
				.storeId(storeId)
				.openTm(openTm)
				.closeTm(closeTm)
				.build();
		
	}
	
	// 3. ��� �Է°�
	@Test
	public void storeGenerateTest3() {
		BStoreVO bstore = new BStoreVO.BStoreVOBuilder()
				.storeId(storeId)
				.openTm(openTm)
				.closeTm(closeTm)
				.breakSttm(breakSttm)
				.breakEntm(breakEntm)
				.lastOrdTm(lastOrdTm)
				.n1SeatNo(n1SeatNo)
				.n2SeatNo(n2SeatNo)
				.n4SeatNo(n4SeatNo)
				.storeIntro(storeIntro)
				.avgMealTm(avgMealTm)
				.hldy(hldy)
				.acmPnum(acmPnum)
				.build();
		
		assertTrue(bstore.getStoreId() == storeId);
		assertTrue(bstore.getOpenTm().equals(openTm));
		assertTrue(bstore.getCloseTm().equals(closeTm));

		assertTrue(bstore.getBreakSttm().equals(breakSttm));
		assertTrue(bstore.getBreakEntm().equals(breakEntm));
		assertTrue(bstore.getLastOrdTm().equals(lastOrdTm));
		assertTrue(bstore.getN1SeatNo() == n1SeatNo);
		assertTrue(bstore.getN2SeatNo() == n2SeatNo);
		assertTrue(bstore.getN4SeatNo() == n4SeatNo);
		assertTrue(bstore.getStoreIntro().equals(storeIntro));
		assertTrue(bstore.getAvgMealTm() == avgMealTm);
		assertTrue(bstore.getHldy().equals(hldy));
		assertTrue(bstore.getAcmPnum() == acmPnum);
	}
}
