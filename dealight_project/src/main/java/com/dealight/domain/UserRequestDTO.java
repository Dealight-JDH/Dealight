package com.dealight.domain;

import lombok.Data;

@Data
public class UserRequestDTO {
	
	private String userId;
	private String pwd;
	private String name;
	
	private String sex;
    private String email;
    
    private String[] brdt;
    
    private String telno;
    
    
    
    public UserVO toEntity() {
    	String birthday = "";
    	
    	for(String birth : brdt) {
    		birthday += birth;
    	}
    	
    	return UserVO.builder()
    			.userId(userId)
    			.pwd(pwd)
    			.name(name)
    			.sex(sex)
    			.email(email)
    			.brdt(birthday)
    			.snsLginYn("N")
    			.telno(telno).build();
    }
}
