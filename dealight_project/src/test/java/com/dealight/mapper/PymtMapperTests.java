package com.dealight.mapper;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.PymtVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PymtMapperTests {

	
	@Autowired
	private PymtMapper mapper;
	
	@Test
	public void getListTest() {
		List<PymtVO> list = mapper.getList();
		
		list.forEach(vo -> log.info(vo));
	}
	
	@Test
	public void updateTest() {
		long time = System.currentTimeMillis();
		Date date = new Date(time);
		
		PymtVO updateVO = PymtVO.builder()
				.pymtId(106l)
				.stusCd("P")
				.approvedAt(date)
				.build();
		
		mapper.update(updateVO);
		
		PymtVO vo = mapper.findById(106l);
		
		log.info("update vo : " + vo);
	}
	
	@Test
	public void insertTest() {
		long time = System.currentTimeMillis();
		Date date = new Date(time);
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.HOUR_OF_DAY, -9);
		Date calDate = new Date(cal.getTimeInMillis());
		System.out.println(date);
		PymtVO vo = PymtVO.builder()
							.rsvdId(3l)
							.userId("whddn528")
							.mtd("money")
							.tamt(4000)
							.stusCd("R")
							.aprvNo("T2839131261777955995")
							.regDate(calDate)
							.build();
		
		mapper.insertSelectKey(vo);
		
	}
}
