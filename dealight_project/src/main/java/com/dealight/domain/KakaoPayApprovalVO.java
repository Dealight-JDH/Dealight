package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KakaoPayApprovalVO {

	//요청 고유번호, 결제 고유번호, 가맹점 코드, 정기 결제용 id 단건 결제 요청 시 발급
    private String aid, tid, cid, sid;
    //가맹점 주문번호, 가맹점 회원 id, 결제 수단 card or money
    private String partner_order_id, partner_user_id, payment_method_type;
    //결제 금액 정보
    private AmountVO amount;
    //결제 상세 정보 카드일 경우
    private CardVO card_info;
    //상품 이름, 상품 코드, 결제 승인 요청에 대해 저장한
    private String item_name, item_code, payload;
    //상품 수량, 상품 비과세 금액, 상품 부과세 금액
    private Integer quantity, tax_free_amount, vat_amount;

    //결제 승인 날짜
    private Date created_at, approved_at;
    
}
