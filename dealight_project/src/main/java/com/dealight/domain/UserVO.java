package com.dealight.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserVO {
	
    // 회원아이디 
    private String userId;

    // 회원이름 dd
    private String name;

    // 회원비밀번호 
    private String pwd;

    // 회원이메일 
    private String email;

    // 회원전화번호 
    private String telno;

    // 생년월일 
    private String brdt;

    // 성별 
    private String sex;

    // 회원프로필사진 
    private String photoSrc;

    // 소셜로그인여부 
    private String snsLginYn;

    // 회원구분코드 
    private String clsCd;

    // 패널티회원여부 
    private String pmStus;

    // 패널티횟수 
    private int pmCnt;

    // 패널티만료일자 
    private Date pmExpi;
    
    // ***************추가 동인
    // Buser와 조인을 하려고 일단 넣어놨는데 필요없으면 삭제
    private BUserVO buser;
	 
}
