package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.AuthVO;
import com.dealight.domain.RsvdVO;
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
		AuthVO auth = AuthVO.builder().userId(user.getUserId()).auth("ROLE_USER").build();
		service.register(user, auth);
		
		log.info("생성된 회원 정보: "+user);
}
	
	@Test
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
	
	@Test
	public void checkCurPanaltyExpiTest1() {
		
		Calendar cal = Calendar.getInstance();
		cal.set(2020, Calendar.NOVEMBER, 21);
		
		log.info(cal);
		
		Date date = new Date(cal.getTimeInMillis());
		
		log.info(date);
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		log.info("result.............."+userService.checkCurPanaltyExpi(formatter.format(date) + " :::"));
		
	}
	
	@Test
	public void addPanaltyCntTest() {
		
		UserVO user = userService.get("kjuioq");
		
		log.info(user);
		
		log.info("cnt...................."+user.getPmCnt());
		
		userService.addPanaltyCnt("kjuioq");
		
		user = userService.get("kjuioq");
		
		log.info(user);
		
		log.info("cnt...................."+user.getPmCnt());
		
	}

	
}
