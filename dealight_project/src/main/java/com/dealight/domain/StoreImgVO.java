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
	
    private long storeId;

    private long imgSeq;
    
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;

}
