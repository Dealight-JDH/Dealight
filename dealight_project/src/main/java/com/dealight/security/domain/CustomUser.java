package com.dealight.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.dealight.domain.UserVO;

import lombok.Getter;

@Getter
public class CustomUser extends User{

	private UserVO user;
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public CustomUser(String username, String password,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		
	}
	
	public CustomUser(UserVO vo) {
		super(vo.getUserId(), vo.getPwd(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));

		this.user = vo;
	}

	
}
