package com.dealight.domain;

import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

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
    private String aprvNo = "1111L"; // ***************변경

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
	
	@Test
	public void test() {
		
    	Calendar cal = Calendar.getInstance();
    	cal.set(2020, 10, 23);
    	cal.set(cal.HOUR_OF_DAY,9);
    	cal.set(cal.MINUTE, 30);

    	SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy.MM.dd HH:mm:ss");
		
		System.out.println(formatter.format(new Date(cal.getTimeInMillis())));
	}
	
	@Test
	public void test1() {
		
		int storeIdx = 0;
		
		for(int i = 0; i < 100; i++) {
			
			storeIdx = (int) (Math.random() * 5);
			System.out.println(storeIdx);
		}
	}

}
