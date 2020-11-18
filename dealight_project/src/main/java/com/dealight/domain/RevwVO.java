package com.dealight.domain;

import lombok.Data;

@Data
public class RevwVO {

	// 리뷰번호 
    private int id;

    // 매장번호 
    private int storeId;
    
    // 매장이름 - 테스트용으로 일단 추가함
    private String storeNm;

    // 예약번호 
    private int rsvdId = -1;

    // 웨이팅번호 
    private int waitId = -1;

    // 회원아이디 
    private String userId;

    // 리뷰내용 
    private String cnts;

    // 리뷰작성날짜 
    private String regDt;

    // 평점 
    private double rating;

    // 답글내용 
    private String replyCnts;

    // 답글등록날짜 
    private String replyRegDt;
    
//    private Date regdate;
//    private Date updatedate;
	
    // composition
    // 리뷰사진첨부파일 - 리뷰 사진 가져오기용
    private RevwImgVO img;
}
