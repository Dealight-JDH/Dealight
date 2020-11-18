package com.dealight.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RevwVO {

	// 리뷰번호
	private Long id;
	// 매장번호
	private Long storeId;
	// 예약번호
	private Long rsvdId;
	// 웨이팅번호
	private Long waitId;
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
}
