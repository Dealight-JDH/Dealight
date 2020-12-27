package com.dealight.domain;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.lang.Nullable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//jongwoo
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserVO {
	
    // 회원아이디 
	@NotEmpty
	@Pattern(regexp = "[A-za-z0-9]{5,50}")
    private String userId;

    // 회원이름 dd
	@NotEmpty
	@Pattern(regexp = "[\\w\\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,8}")
    private String name;

    // 회원비밀번호 
	@NotEmpty
	@Pattern(regexp = "(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,16}")
    private String pwd;

    // 회원이메일 
	@NotEmpty
	@Email
    private String email;

    // 회원전화번호 
	@NotEmpty
	@Pattern(regexp = "\\d{3}\\d{3,4}\\d{4}")
    private String telno;

    // 생년월일 
	@NotEmpty
	@Pattern(regexp = "(19[0-9][0-9]|20\\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])")
    private String brdt;

    // 성별 
	@NotEmpty
    private String sex;

    // 회원프로필사진
	@Nullable
    private String photoSrc;

    // 소셜로그인여부
	@Nullable
    private String snsLginYn = "N";

    // 회원구분코드 
    private String clsCd;

    // 패널티회원여부 
    private String pmStus;

    // 패널티횟수 
    private int pmCnt;

    // 패널티만료일자 
    private String pmExpi;
    
    private Date regDate;
    
    private Date updateDate;
    
    //sns 고유식별번호
    private Long snsNum;
    
    //유저 권한
    private List<AuthVO> authList;
    
    
    // ***************추가 동인
    // Buser와 조인을 하려고 일단 넣어놨는데 필요없으면 삭제
    private BUserVO buser;
	 
//    
//    private Date regdate;
// 	private Date updatedate;
}
