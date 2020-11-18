package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

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
public class UserMapperTests {
	
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
	
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;

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
	
	// mapper read
	// get list
	@Test
	public void mapperFindAllTest() {
		
		List<UserVO> list = mapper.findAll();
		
		log.info(list);
		
	}
	
	// mapper create

	@Test
	public void mapperInsertTest() {
		UserVO user = new UserVO().builder()
				.userId("kjuioq")
				.brdt(brdt)
				.name(name)
				.pwd(pwd)
				.email(email)
				.sex(sex)
				.build();
		
		log.info(user);
		
		mapper.insert(user);
		
		
	}
	
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
	public void mapperDeleteTest1() {
		
		
		UserVO user = new UserVO().builder()
				.userId("kjuioq")
				.brdt(brdt)
				.name(name)
				.pwd(pwd)
				.email(email)
				.sex(sex)
				.build();
		
		log.info(user);
		
		mapper.insert(user);
		
		assertNotNull(mapper.findById("#####"));
		
		int result = mapper.delete("#####");
		
		assertTrue(result == 1);
		
		assertNull(mapper.findById("#####"));
		
	}

}
