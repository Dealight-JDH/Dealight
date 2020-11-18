package com.dealight.domain;

import static org.junit.Assert.*;

import org.junit.Test;

public class HtdlVOTests {
	
	// �ʼ��Է°�
    private long hotdealId = 1;
    private String name = "�����Ʈ";
    private long storeId = 1;
    private double dcRate = 0.5;
    private String startTm = "13:00";
    private String endTm = "14:00";
    private int lmtPnum = 40;
    private int befPrice = 15000; 
    private int ddct = 7500;
    private int curPnum = 25;
    
    // �⺻��
    private String stusCd;
    
    //���� �Է°�
    private String intro = "�ֵ� ���";

    // 1. �ʼ��Է°�
	@Test
	public void hotDealGenerateTest1() {
		
		HtdlVO htdl = new HtdlVO.HtdlVOBuilder()
				.htdlId(hotdealId)
				.name(name)
				.storeId(storeId)
				.dcRate(dcRate)
				.startTm(startTm)
				.endTm(endTm)
				.lmtPnum(lmtPnum)
				.befPrice(befPrice)
				.ddct(ddct)
				.curPnum(curPnum)
				.stusCd("A")
				.build();
		
		assertTrue(htdl.getHtdlId() == hotdealId);
		assertTrue(htdl.getName().equals(name));
		assertTrue(htdl.getStoreId() == storeId);
		assertTrue(htdl.getDcRate() == dcRate);
		assertTrue(htdl.getStartTm().equals(startTm));
		assertTrue(htdl.getEndTm().equals(endTm));
		assertTrue(htdl.getLmtPnum() == lmtPnum);
		assertTrue(htdl.getBefPrice() == befPrice);
		assertTrue(htdl.getDdct() == ddct);
		assertTrue(htdl.getCurPnum() == curPnum);
		assertTrue(htdl.getStusCd().equals("A"));
		assertNull(htdl.getIntro());
		
	}
	
	 // 1. ����Է°�
		@Test
		public void hotDealGenerateTest2() {
			
			HtdlVO htdl = new HtdlVO.HtdlVOBuilder()
					.htdlId(hotdealId)
					.name(name)
					.storeId(storeId)
					.dcRate(dcRate)
					.startTm(startTm)
					.endTm(endTm)
					.lmtPnum(lmtPnum)
					.befPrice(befPrice)
					.ddct(ddct)
					.curPnum(curPnum)
					.intro(intro)
					.stusCd("A")
					.build();
			
			assertTrue(htdl.getHtdlId() == hotdealId);
			assertTrue(htdl.getName().equals(name));
			assertTrue(htdl.getStoreId() == storeId);
			assertTrue(htdl.getDcRate() == dcRate);
			assertTrue(htdl.getStartTm().equals(startTm));
			assertTrue(htdl.getEndTm().equals(endTm));
			assertTrue(htdl.getLmtPnum() == lmtPnum);
			assertTrue(htdl.getBefPrice() == befPrice);
			assertTrue(htdl.getDdct() == ddct);
			assertTrue(htdl.getCurPnum() == curPnum);
			assertTrue(htdl.getStusCd().equals("A"));
			assertTrue(htdl.getIntro().equals(intro));
			
		}

}
