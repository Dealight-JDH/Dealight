package com.dealight.service;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.KakaoPayReadyVO;
import com.dealight.domain.PymtVO;
import com.dealight.domain.RsvdRequestDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PymtServiceTests {

	@Autowired
	private PymtService service;
	
	
	@Transactional
	@Test
	public void testRegister() {
		long time = System.currentTimeMillis();
		Date date = new Date(time);
		Date calDate = setDateFormat(date);
		
		PymtVO vo = createPymtEntity(calDate);
//		PymtVO vo = PymtVO.builder()
//		.rsvdId(100l)
//		.userId("whhddn528")
//		.tamt(35000)
//		.stusCd("R")
//		.aprvNo("T2839131261777955995")
//		.regDate(date).build();
//		
		service.register(vo);
	}
	
	//결제 vo 생성
	private PymtVO createPymtEntity(Date createdAt) {
		
		return PymtVO.builder()
					.rsvdId(100l)
					.userId("whddn528")
					.tamt(3500)
					.stusCd("R")
					.regDate(createdAt)
					.build();
	}
	
	//한국시간에 맞추기
	private Date setDateFormat(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
        cal.add(Calendar.HOUR_OF_DAY, -9);
        return new Date(cal.getTimeInMillis());
	}
}
