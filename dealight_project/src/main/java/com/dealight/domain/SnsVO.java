package com.dealight.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SnsVO {

	//이메일 아이디
	private String userId;
	
	//sns 회원번호
	private Long id;
	//이름
	private String name;
	//닉네임
	private String nickName;
	//연령대
	private String age;
	//성별
	private String gender;
	//생일
	private String birthday;
	//프로필 사진
	private String profileImg;
	//전화번호
	private String phoneNumber;
	
	
}  
