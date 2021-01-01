package com.dealight.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.dealight.domain.SnsVO;
import com.dealight.domain.UserVO;
import com.dealight.mapper.SnsMapper;
import com.dealight.mapper.UserMapper;
import com.dealight.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	private UserMapper userMapper;
//	@Autowired
//	private SnsMapper snsMapper;
//	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
			log.warn("load user by username : " + username);
			UserVO user = userMapper.read(username);
			
			log.warn("queried by user mapper : " + user);
			CustomUser customUser = new CustomUser(user);
			return user == null ? null : customUser;
			
		
	}

}
