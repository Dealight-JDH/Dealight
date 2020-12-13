package com.dealight.domain;
// 수빈
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Null;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
/*
 * 
 *****[김동인] 
 * 
 */
//다울
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RevwVO {

	// 리뷰번호
	private Long revwId;
	
	// 매장번호
	@NotNull
	private Long storeId;
	
	// 매장이름 - 테스트용으로 일단 추가함
	@NotNull
	private String storeNm;
	
	// 예약번호
	@NotNull
	private Long rsvdId = -1L;
	
	// 웨이팅번호
	@NotNull
	private Long waitId = -1L;
    
	// 회원아이디 
	@NotNull
    private String userId;

	// 리뷰내용 
	@NotEmpty
	@NotBlank
    private String cnts;

	// 평점 
	@NotNull
    private double rating;

    // 답글내용 
    private String replyCnts;

    // 답글등록날짜 
    private String replyRegDt;
    
    private String regdate;
    private String updatedate;
	
    // composition
    // 리뷰사진첨부파일 - 리뷰 사진 가져오기용
    private List<RevwImgVO> imgs;
}
