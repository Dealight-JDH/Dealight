package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KakaoPayReadyVO {

	//결제 고유번호, 결제 준비 url
    private String tid, next_redirect_pc_url;
    private Date created_at;
    
}
