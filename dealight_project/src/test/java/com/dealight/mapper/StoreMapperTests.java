package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.StoreVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreMapperTests {

	@Setter(onMethod_ = @Autowired)
	private StoreMapper mapper;

	@Test
	public void testGetList() {
		mapper.getList().forEach(store -> log.info(store));
	}
	
//	@Test
	public void testInsertSelectKey() {
		//화면과 서비스에서 유효성검사 필수
		StoreVO store = new StoreVO();
		store.setStoreNm("얌샘");
		store.setTelno("000-0000");
		store.setClsCd(	"B");
		
		mapper.insertSelectKey(store);
		
		log.info(store);
	}
	
	@Test
	public void tsetsRead() {
		log.info(mapper.read(1L));
		log.info(mapper.read(14L));
		log.info(mapper.read(0L));
	}

	@Test
	public void testUpdate() {
		
		StoreVO store = new StoreVO();
		store.setStoreId(1L);
		store.setStoreNm("냉면집");
		store.setTelno("111-1234");
		store.setClsCd("B");
		
		log.info(mapper.update(store));
		
		
		
	}
	@Test	
	public void testDelete() {
		log.info(mapper.delete(3L));
	}
	
	@Test
	public void testJoinLoc() {
		mapper.joinLoc().forEach(store-> {
			log.info(store);
			log.info(store.getLoc());
		});
	}
	
	@Test
	public void testGetListAllInfo() {
		mapper.getListAllInfo().forEach(store->{
			log.info(store);
			log.info(store.getBstore());
			log.info(store.getLoc());
		});
	}
	
	//사업자아이디로 검색
	@Test
	public void testFindByUserIdJoinBStore() {
		mapper.findByUserIdJoinBStore("aaaa").forEach(store-> log.info(store));
	}
}
