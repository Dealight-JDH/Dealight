package com.dealight.domain;

import static org.junit.Assert.*;

import org.junit.Test;

public class BUserVOTests {
	
    private long brSeq = 1;
    private String userId = "kjuioq";
    private String brno = "1";
    private String brPhotoSrc = "/a.jpg";
    private String brJdgStusCd;
    private long storeId = 3;

	// 1. 필수 입력값만 입력하고 유저객체가 생성될 수 있는지.
	// not null 값만 입력
	// 필수값 : brSeq,userId,brno,brPhotoSrc,brJdgStusCd(deafult 값)
	// 선택값 : storeId
	// 필수 입력값을 입력하지 않았을시 컴파일에러
	@Test
	public void buserGenerateTest1() {
		BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc)
				.build();
		
		assertTrue(buser.getBrSeq() == brSeq);
		assertTrue(buser.getUserId().equals(userId));
		assertTrue(buser.getBrno() == brno);
		assertTrue(buser.getBrPhotoSrc().equals(brPhotoSrc));
		
		// default값인 "W"가 잘 들어갔는지
		assertTrue(buser.getBrJdgStusCd().equals("W"));
		assertNotNull(buser);
		
	}
	
	// 2. 모든 입력값을 입력해서 유저 객체를 생성한다.
	// 필수값 : brSeq,userId,brno,brPhotoSrc,brJdgStusCd(deafult 값)
	// 선택값 : storeId
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
		
		// default값인 "W"가 잘 들어갔는지
		assertTrue(buser.getBrJdgStusCd().equals("W"));
		assertNotNull(buser);
		
	}

}
