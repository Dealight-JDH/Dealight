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
public class UserWithRsvdDTO {
	
	// 회원아이디 
		private String userId;

		// 회원이름 
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
		private String snsLginYn = "N";

		// 회원구분코드 
		private String clsCd = "C";

		// 패널티회원여부 
		private String pmStus = "N";

		// 패널티횟수 
		private int pmCnt = 0;

		// 패널티만료일자 
		private Date pmExpi;
		// composition
		private List<RsvdDtlsVO> rsvdDtlsList;
		
	    // 예약번호 
		@NonNull
	    private long id;

	    // 매장번호
		@NonNull
	    private long storeId;


	    // 핫딜번호 
	    private long htdlId;

	    // 결제승인번호 
	    private int aprvNo;

	    // 예약인원
	    @NonNull
	    private int pnum;

	    // 예약시간
	    @NonNull
	    private String time;

	    // 예약상태코드
	    @NonNull
	    @Builder.Default
	    private String stusCd = "P";

	    // 예약총액
	    @NonNull
	    private int totAmt;

	    // 총메뉴수량
	    @NonNull
	    private int totQty;
	    
	    private Date inDate;

}
