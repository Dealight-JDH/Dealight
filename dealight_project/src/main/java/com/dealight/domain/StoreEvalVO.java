package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class StoreEvalVO {

	// 매장번호 
    private Long storeId;

    // 평균평점 
    private double avgRating;

    // 리뷰수 
    private int revwTotNum;
    
    // 좋아요합계 
    private int likeTotNum;
    
    //등록 날짜
    private Date regDate;
    
    //수정 날짜
    private Date updateDate;
    
}
