package com.dealight.domain;

import lombok.Data;

@Data
public class AmountVO {

	//전체 결제금액, 비과세 금액,부과세 금액, 포인트 금액, 할인 금액
    private Integer total, tax_free, vat, point, discount;

}
