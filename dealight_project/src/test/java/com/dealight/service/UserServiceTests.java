package com.dealight.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.UserVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private UserService service;
	
	@Test
	public void testExist() {
		
		log.info(service);
		assertNotNull(service);
	}
	
//	@Test
	public void testRegister() {
		
		UserVO user = new UserVO();
		
		user.setUserId("serviceTest");
		user.setName("serviceTest");
		user.setPwd("ser456");
		user.setEmail("ser@vice.com");
		user.setTelno("01012345678");
	    user.setBrdt("20201118");
		user.setSex("W");
		user.setSnsLginYn("N");
		
		service.register(user);
		
		log.info("생성된 회원 정보: "+user);
}
	
//	@Test
	public void testGetList() {
		service.getList().forEach(user -> log.info(user));
	}
	
//	@Test
	public void testGet() {
		log.info(service.get("dlagustn720"));
	}
	
//	@Test
	public void testDelete() {
		log.info("REMOVE RESULT: "+service.remove("test55"));
	}
	
//	@Test
	public void testUpdate() {
		UserVO user = service.get("qwer");
		
		if(user == null) {
			return;
		}
		
		user.setName("유후예헤");
		user.setPwd("하하test#");
		user.setEmail("serTest@git.com");
		user.setTelno("0105678432");
		log.info("MODIFY RESULT:"+service.modify(user));
	}
}
