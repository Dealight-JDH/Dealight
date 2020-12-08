package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FaqVO {

	// FAQ번호 
    private int faqId;

    // FAQ제목 
    private String faqTitle;

    // FAQ구분코드 
    private String qClsCd;

    // FAQ내용 
    private String faqCnts;

    // 작성자ID 
    private String adminId;

}
