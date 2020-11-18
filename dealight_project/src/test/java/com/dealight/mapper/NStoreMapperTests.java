package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.NStoreVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class NStoreMapperTests {

	@Setter(onMethod_ = @Autowired)
	private NStoreMapper mapper;
	
//	@Test
	public void testInsert() {
		
		NStoreVO nStore = new NStoreVO();
		nStore.setStoreId(10L);
		nStore.setBizTm("영업시간 - 9:00~20:00 \n휴무일 - 매주 일요일");
		nStore.setMenu("김밥");
		
		mapper.insert(nStore);
		log.info(nStore);
		
	}

	@Test
	public void testGetList() {
		
		mapper.getList().forEach(store -> log.info(store));
	}
	
	@Test 
	public void testRead() {
		log.info(mapper.read(9L));
	}
	
	@Test
	public void testDelete() {
		log.info("DELETE COUNT : " + mapper.delete(1L));
	}
	
	@Test
	public void testUpdate() {
		
		NStoreVO nStore = new NStoreVO();
		nStore.setStoreId(9L);
		nStore.setBizTm("영업시간 - 9:00~20:00 \n휴무일 - 매주 일요일");
		nStore.setMenu("된장찌개");
	
		log.info("UPDATE COUNT: " + mapper.update(nStore));
		
	}
}
