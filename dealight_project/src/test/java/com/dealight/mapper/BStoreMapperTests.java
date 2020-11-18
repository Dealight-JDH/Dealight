package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.BStoreVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BStoreMapperTests {

	@Setter(onMethod_ = @Autowired)
	private BStoreMapper mapper;
	
	@Test
	public void testInsert() {
		
		BStoreVO bStore = new BStoreVO.Builder(4L, "aaaa", "종로본점", "김밥", "a.jpg", "10:00", "20:00")
									  .setAcmPnum(40).setAvgMealTm(40).setHldy("연중무휴").setN4SeatNo(10)
									  .setStoreIntro("김밥 맛있는집").build();
		log.info(bStore);
		mapper.insert(bStore);
	}
	
	@Test
	public void testGetList() {
		
		mapper.getList().forEach(store -> log.info(store));
		
	}
	
	@Test
	public void testRead() {
		
		log.info(mapper.read(1L));
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.delete(3L));
	}
	
	@Test
	public void testUpdate() {
		BStoreVO bStore = new BStoreVO.Builder(5L, "aaaa", "종로1호점"	, "돈까쓰", "b.jpg", "10:00", "22:00").setAcmPnum(40).setAvgMealTm(30)
				.setseatStusCd("G").setBreakEntm("17:00").setBreakSttm("15:00").setHldy("매주 월요일").setN4SeatNo(10).build();
		
		mapper.update(bStore);
		log.info(mapper.read(5L));
		
		
	}

}
