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

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RevwVO {

	// 리뷰번호
	@NotNull
	private Long revwId;
	
	// 매장번호
	@NotNull
	private Long storeId;
	
	// 매장이름 - 테스트용으로 일단 추가함
	// 오라클에 추가해야한다.!!!!!!
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

	// 리뷰작성날짜 - regdate, updatedate 컬럼 반영되기 이전 ver.
    private String regDt;
	
	// 평점 
	@NotNull
    private double rating;

    // 답글내용 
    private String replyCnts;

    // 답글등록날짜 
    private String replyRegDt;
    
//    private Date regdate;
//    private Date updatedate;
	
    // composition
    // 리뷰사진첨부파일 - 리뷰 사진 가져오기용
    // 1:N관계 LIST로 받아야함 (수정 예정)
    // private List<RevwImgVO> imgs;
    private RevwImgVO img;
}
