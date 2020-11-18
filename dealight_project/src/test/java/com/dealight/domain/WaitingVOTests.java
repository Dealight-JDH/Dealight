package com.dealight.domain;

import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;

import org.junit.Test;

public class WaitingVOTests {
	
	//�ʼ� �Է°�
    private long id = 1;
    private long storeId = 1;
    private Date waitRegTm = new Date();
    private int waitPnum = 30;
    private String custTelno = "010-0000-0000";
    private String custNm = "�赿��"; 
    private String waitStusCd = "W";
    
    // �����Է°�
    private String userId = "kjuioq";


	// 1. �ʼ� �Է°��� �Է��ϰ� ���尴ü�� ������ �� �ִ���.
	// not null ���� �Է�
	// �ʼ��� : id, storeId, waitRegTm, waitPnum,custTelno,custNm,waitStusCd
	// ���ð� : userId
	@Test
	public void waitingGenerateTest1() {
		WaitVO waiting = new WaitVO().builder()
				.waitId(id)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno(custTelno)
				.custNm(custNm)
				.waitStusCd(waitStusCd)
				.build();
		
		assertTrue(waiting.getWaitId() == id);
		assertTrue(waiting.getStoreId() == storeId);
		assertTrue(waiting.getWaitRegTm().equals(waitRegTm));
		assertTrue(waiting.getWaitPnum() == waitPnum);
		assertTrue(waiting.getCustTelno().equals(custTelno));
		assertTrue(waiting.getCustNm().equals(custNm));
		assertTrue(waiting.getWaitStusCd().equals("W"));
		
		assertNull(waiting.getUserId());
		
	}
	
	// 2. ��� �Է°�
	@Test
	public void waitingGenerateTest2() {
		WaitVO waiting = new WaitVO().builder()
				.waitId(id)
				.userId(userId)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno(custTelno)
				.custNm(custNm)
				.waitStusCd(waitStusCd)
				.build();
		
		assertTrue(waiting.getWaitId() == id);
		assertTrue(waiting.getStoreId() == storeId);
		assertTrue(waiting.getWaitRegTm().equals(waitRegTm));
		assertTrue(waiting.getWaitPnum() == waitPnum);
		assertTrue(waiting.getCustTelno().equals(custTelno));
		assertTrue(waiting.getCustNm().equals(custNm));
		assertTrue(waiting.getWaitStusCd().equals("W"));
		assertTrue(waiting.getUserId().equals(userId));
		
	}

}
