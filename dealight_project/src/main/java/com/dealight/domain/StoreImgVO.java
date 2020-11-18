package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class StoreImgVO {
	
    private Long storeId;

    private Long imgSeq;
    
    
    // ******************file upload 
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;

    // 매장사진주소 
    private String imgUrl;
}
