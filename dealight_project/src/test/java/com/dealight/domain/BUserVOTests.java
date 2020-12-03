package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;

import org.junit.Test;

public class BUserVOTests {
	
    private long brSeq = 1;
    private String userId = "kjuioq";
    private String brno = "1";
    private String brPhotoSrc = "/a.jpg";
    private String brJdgStusCd;
    private long storeId = 3;

    
    @Test
    public void test() {
    	Date date = new Date();
    	System.out.println(date);
    	System.out.println(date.getDate());
    	System.out.println(date.getMonth() );
    	System.out.println(date.getYear());
    }
	// 1. �ʼ� �Է°��� �Է��ϰ� ������ü�� ������ �� �ִ���.
	// not null ���� �Է�
	// �ʼ��� : brSeq,userId,brno,brPhotoSrc,brJdgStusCd(deafult ��)
	// ���ð� : storeId
	// �ʼ� �Է°��� �Է����� �ʾ����� �����Ͽ���
	@Test
	public void buserGenerateTest1() {
		BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc)
				.build();
		
		assertTrue(buser.getBrSeq() == brSeq);
		assertTrue(buser.getUserId().equals(userId));
		assertTrue(buser.getBrno() == brno);
		assertTrue(buser.getBrPhotoSrc().equals(brPhotoSrc));
		
		// default���� "W"�� �� ������
		assertTrue(buser.getBrJdgStusCd().equals("W"));
		assertNotNull(buser);
		
	}
	
	// 2. ��� �Է°��� �Է��ؼ� ���� ��ü�� �����Ѵ�.
	// �ʼ��� : brSeq,userId,brno,brPhotoSrc,brJdgStusCd(deafult ��)
	// ���ð� : storeId
	@Test
	public void buserGenerateTest2() {
		BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc)
				.setStoreId(storeId)
				.build();
		
		assertTrue(buser.getBrSeq() == brSeq);
		assertTrue(buser.getUserId().equals(userId));
		assertTrue(buser.getBrno() == brno);
		assertTrue(buser.getBrPhotoSrc().equals(brPhotoSrc));
		assertTrue(buser.getStoreId() == storeId);
		
		// default���� "W"�� �� ������
		assertTrue(buser.getBrJdgStusCd().equals("W"));
		assertNotNull(buser);
		
	}

}
