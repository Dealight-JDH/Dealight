package com.dealight.domain;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;

import org.junit.Test;

public class RevwVOTests {
	
	// �ʼ� �Է°�
    private long id = 1;
    private long storeId = 1;
    private String userId = "kjuioq";
    private String cnts = "�ʹ� ���־��~";
    private String regDt = "20201107"; 
    private double rating = 5.5;
    private String replyCnts = "�� �����ּ���~";
    private String replyRegDt = "20201107";
    
    // ���� �Է°�
    private long rsvdId = 1;
    private long waitId = 1;

	// 1. �ʼ� �Է°��� �Է��ϰ� ���尴ü�� ������ �� �ִ���.
	@Test
	public void reviewGenerateTest1() {
		
		RevwVO review = new RevwVO.RevwVOBuilder()
				.revwId(id)
				.storeId(storeId)
				.userId(userId)
				.cnts(cnts)
				.regDt(regDt)
				.rating(rating)
				.replyCnts(replyCnts)
				.replyRegDt(replyRegDt)
				.build();
		
		assertTrue(review.getRevwId() == id);
		assertTrue(review.getStoreId() == storeId);
		assertTrue(review.getUserId().equals(userId));
		assertTrue(review.getCnts().equals(cnts));
		assertTrue(review.getRegDt().equals(regDt));
		assertTrue(review.getRating() == rating);
		assertTrue(review.getReplyCnts().equals(replyCnts));
		assertTrue(review.getRegDt().equals(replyRegDt));
		
		
	}
	
	// ��� �Է°�
	@Test
	public void reviewGenerateTest2() {
		
		RevwVO review = new RevwVO.RevwVOBuilder()
				.revwId(id)
				.storeId(storeId)
				.userId(userId)
				.cnts(cnts)
				.regDt(regDt)
				.rating(rating)
				.replyCnts(replyCnts)
				.replyRegDt(replyRegDt)
				.rsvdId(rsvdId)
				.waitId(waitId)
				.build();
		
		assertTrue(review.getRevwId() == id);
		assertTrue(review.getStoreId() == storeId);
		assertTrue(review.getUserId().equals(userId));
		assertTrue(review.getCnts().equals(cnts));
		assertTrue(review.getRegDt().equals(regDt));
		assertTrue(review.getRating() == rating);
		assertTrue(review.getReplyCnts().equals(replyCnts));
		assertTrue(review.getRegDt().equals(replyRegDt));
		assertTrue(review.getRsvdId() == rsvdId);
		assertTrue(review.getWaitId() == waitId);
		
	}

}
