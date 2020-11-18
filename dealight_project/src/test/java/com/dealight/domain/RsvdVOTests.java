package com.dealight.domain;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class RsvdVOTests {
	

	// �ʼ��Է°�
    private long id = 1;
    private long storeId = 1;
    private String userId = "kjuioq";
    private int pnum = 30;
    private String time = "09:30";
    private String stusCd;
    private int totAmt = 30;
    private int totQty = 30;
    
    // �����Է°�
    private long htdlId = 2;
    private Long aprvNo = 1111L; // ***************변경

	// 1. �ʼ� �Է°��� �Է��ϰ� ���尴ü�� ������ �� �ִ���.
	@Test
	public void reservationGenerateTest1() {
		
		RsvdVO rsvd = new RsvdVO.RsvdVOBuilder()
				.rsvdId(id)
				.storeId(storeId)
				.userId(userId)
				.pnum(pnum)
				.time(time)
				.totAmt(totAmt)
				.totQty(totQty)
				.stusCd(stusCd)
				.stusCd("P")
				.build();
		
		assertTrue(rsvd.getRsvdId() == id);
		assertTrue(rsvd.getStoreId() == storeId);
		assertTrue(rsvd.getUserId().equals(userId));
		assertTrue(rsvd.getPnum() == pnum);
		assertTrue(rsvd.getTime().equals(time));
		assertTrue(rsvd.getTotAmt() == totAmt);
		assertTrue(rsvd.getTotQty() == totQty);
		assertTrue(rsvd.getStusCd().equals("P"));
		
		
	}
	
	// 2. ����Է°�
	@Test
	public void reservationGenerateTest2() {
		
		RsvdVO rsvd = new RsvdVO.RsvdVOBuilder()
				.rsvdId(id)
				.storeId(storeId)
				.userId(userId)
				.pnum(pnum)
				.time(time)
				.totAmt(totAmt)
				.totQty(totQty)
				.htdlId(htdlId)
				.aprvNo(aprvNo)
				.stusCd("P")
				.build();
		
		assertTrue(rsvd.getRsvdId() == id);
		assertTrue(rsvd.getStoreId() == storeId);
		assertTrue(rsvd.getUserId().equals(userId));
		assertTrue(rsvd.getPnum() == pnum);
		assertTrue(rsvd.getTime().equals(time));
		assertTrue(rsvd.getTotAmt() == totAmt);
		assertTrue(rsvd.getTotQty() == totQty);
		assertTrue(rsvd.getStusCd().equals("P"));
		
		
	}

}
