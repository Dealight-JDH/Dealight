package com.dealight.mapper;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.UserVO;
import com.dealight.mapper.UserMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Test
	public void testInsert() {
	
		UserVO user = new UserVO();
		
		user.setUserId("gitTest2");
		user.setName("github2");
		user.setPwd("09876");
		user.setEmail("git2@test.com");
		user.setTelno("010123456");
		user.setBrdt("20201118");
		user.setSex("M");
		user.setSnsLginYn("N");
		
		mapper.insert(user);
		
		log.info(user);
		
	}
	
//	@Test
	public void testRead() {
		UserVO user = mapper.read("hijk");
		
		log.info(user);
	}
	
//	@Test
	public void testDelete() {
		log.info("DELETE COUNT: "+mapper.delete("testtest"));
	}
	
//	@Test
	public void testUpdate() {
		
		UserVO user = new UserVO();
		
		//실행전 존재하는 아이디인지 확인할 것 
		user.setUserId("hijk");
		user.setName("현수쓰");
		user.setPwd("3333");
		user.setEmail("hs@eeee");
		user.setTelno("01055556666");
		user.setSnsLginYn("Y");
		
		int count = mapper.update(user);
		
		log.info("UPDATE COUNT: " +count);
	}
	
//	@Test
	public void testUpdatePhoto() {
		
		UserVO user = new UserVO();
		
		//실행전 존재하는 아이디인지 확인할 것 
				user.setUserId("hijk");
				user.setPhotoSrc("gitTest.jsp");
				
				int count = mapper.updatePhoto(user);
				
				log.info("UPDATEPHOTO COUNT: " +count);
	}
}
