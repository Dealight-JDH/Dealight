package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreImgVO {
	  // 매장번호 
    private Long storeId;

    // 첨부사진일련번호 
    private Long imgSeq;

    // 매장사진주소 
    private String imgUrl;
}
