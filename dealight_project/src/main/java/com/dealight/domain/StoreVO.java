package com.dealight.domain;


import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreVO {
	    // 매장번호 
	    private Long storeId;
	    // 매장이름 
	    private String storeNm;
	    // 매장전화번호 
	    private String telno;
	    // 매장분류코드 
	    private String clsCd;
	    
	    //요거
	    private BStoreVO bstore;
//	    private NStoreVO nstore;
	    
	    private StoreLocVO loc;

	    private StoreEvalVO eval;
	    
	    private List<StoreImgVO> imgs; 
	    
	    
	   
}
