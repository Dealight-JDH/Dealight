package com.dealight.mapper;

import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.UserVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	// �ʼ� �Է°�
	String id = "kjuioq";
	String name = "�赿��";
	String pwd = "123123";
	String email = "kjuioq@naver.com";
	String telno = "010-2737-5157";
	String sex = "M";

	// ���� �Է°�
	String brdt = "931211";
	String photoSrc = "/a.jpg";
	Date pmExpi = new Date();
	
	@Test
	public void testUserWithAuthorityRead() {
		UserVO vo = mapper.read("admin5");
		log.info(vo);
		
		vo.getAuthList().forEach(auth -> log.info(auth));
	}

	// mapper �� ���ԵǾ����� DI �׽�Ʈ
	@Test
	public void mapperDItest() {
		log.info("mapper DI test : " + mapper);
	}
	
	// mapper read
	@Test
	public void mapperFindByIdTest() {
		
		UserVO user = mapper.findById("kjuioq");
		
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
	// mapper read
	// get list
	@Test
	public void mapperFindAllTest() {
		
		List<UserVO> list = mapper.findAll();
		
		log.info(list);
		
	}
	
	// mapper create

	
	//
	@Test
	public void mapperUpdateTest() {
		
		UserVO user = mapper.findById("kjuioq");
		
		log.info(user);
		
		String bfUserClsCd = user.getClsCd();
		
		if(bfUserClsCd.equals("C"))
			user.setClsCd("B");
		
		if(bfUserClsCd.equals("B"))
			user.setClsCd("C");
		
		mapper.update(user);
		//int result = mapper.update(user);
		//log.info("result...." + result);
		
		UserVO afUser = mapper.findById("kjuioq");
		
		//assertTrue(result == 1);
		assertTrue(!bfUserClsCd.equals(afUser.getClsCd()));
		
	}
	
	@Test
	public void checkPanaltyDurationTest1() {
		
		int upNum = mapper.checkPanaltyDuration();
		
		log.info("upNum........................."+upNum);
		
	}
	
	@Transactional
	@Test
	public void withdrawalUserTest() {
		
		String userId = "aaaa";
		
		int result = mapper.withdrawalUser(userId);
		
		assertTrue(result == 1);
		
		UserVO user = mapper.read(userId);
		
		log.info(user);
		
	}
	
	@Test
	public void readTest1() {
		
		String userId = "aaaa";
		
		UserVO user = mapper.read(userId);
		
		log.info(user);
		
	}
	
}
