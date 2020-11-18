package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserServiceTests {
	
	@Autowired
	private UserService userService;
	
	
	String userId = "kjuioq";
	long storeId = 13;

	@Test
	public void userServiceDITests1() {
		
		log.info(userService);
		
		assertNotNull(userService);

	}
	
	@Test
	public void userReadTests1() {
		
		UserVO user = userService.read(userId);
		
		assertNotNull(user);
		
		assertTrue(user.getUserId().equals(userId));
		
	}
	
	@Test
	public void isCurPaneltyTests1() {
		
		
		assertTrue(!userService.isCurPanalty(userId));
		
	}
	
	@Test
	public void isCurWaitingTests1() {
		
		assertTrue(!userService.isCurWaiting(userId));
	}
	
	@Test
	public void rsvdListByUserTest1() {
		
		List<RsvdVO> list = userService.getRsvdListThisUser(userId);
		
		log.info(list);
		
		list.forEach((rsvd)->{
	
			assertTrue(rsvd.getUserId().equals(userId));
			
		});
		
	}
	
	@Test
	public void rsvdListStoreUserTests() {
		
		
		List<RsvdVO> list = userService.getRsvdListStoreUser(storeId, userId);
		
		log.info(list);
		
		log.info(list.size());
		
		list.forEach((rsvd) -> {
			assertTrue(rsvd.getStoreId() == storeId);
			assertTrue(rsvd.getUserId().equals(userId));
		});
	}

	
}
