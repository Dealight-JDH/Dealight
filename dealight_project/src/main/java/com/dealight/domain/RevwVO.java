package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RevwVO {

	    // 리뷰번호 
		@NonNull
	    private long id;

	    // 매장번호 
		@NonNull
	    private long storeId;

	    // 예약번호 
	    private long rsvdId;

	    // 웨이팅번호 
	    private long waitSeq;

	    // 회원아이디 
	    @NonNull
	    private String userId;

	    // 리뷰내용
	    @NonNull
	    private String cnts;

	    // 리뷰작성날짜
	    @NonNull
	    private Date regDt;

	    // 평점 
	    @NonNull
	    private double rating;

	    // 답글내용
	    @NonNull
	    private String replyCnts;

	    // 답글등록날짜
	    @NonNull
	    private Date replyRegDt;

}
