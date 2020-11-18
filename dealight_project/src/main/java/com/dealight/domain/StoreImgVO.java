package com.dealight.domain;

import lombok.AllArgsConstructor;
<<<<<<< HEAD
=======
import lombok.Builder;
>>>>>>> bf8ab310d18e4a1e0cd6669f63450ff680f936b7
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
<<<<<<< HEAD
@NoArgsConstructor
@AllArgsConstructor
public class StoreImgVO {
	  // 매장번호 
    private Long storeId;

    // 첨부사진일련번호 
    private Long imgSeq;
=======
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
>>>>>>> bf8ab310d18e4a1e0cd6669f63450ff680f936b7

    // 매장사진주소 
    private String imgUrl;
}
