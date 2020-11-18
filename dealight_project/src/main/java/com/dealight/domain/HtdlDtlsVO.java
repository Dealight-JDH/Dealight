package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class HtdlDtlsVO {
	
    private Long htdlId;

    private Long htdlSeq;

    private String menuName;

    private int menuPrice;

}
