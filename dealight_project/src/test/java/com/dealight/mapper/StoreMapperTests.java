package com.dealight.mapper;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

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
	
	public void tsetsRead() {
		log.info(mapper.read(1L));
		log.info(mapper.read(14L));
		log.info(mapper.read(0L));
	}

	public void testUpdate() {
		
		StoreVO store = new StoreVO();
		store.setStoreId(1L);
		store.setStoreNm("냉면집");
		store.setTelno("111-1234");
		store.setClsCd("B");
		
		log.info(mapper.update(store));
		
		
		
	}
	public void testDelete() {
		log.info(mapper.delete(3L));
	}
	
	public void testJoinLoc() {
		mapper.joinLoc().forEach(store-> {
			log.info(store);
			log.info(store.getLoc());
		});
	}
	
	public void testGetListAllInfo() {
		mapper.getListAllInfo().forEach(store->{
			log.info(store);
			log.info(store.getBstore());
			log.info(store.getLoc());
		});
	}
	
	//사업자아이디로 검색
	public void testFindByUserIdJoinBStore() {
		mapper.findByUserIdJoinBStore("aaaa").forEach(store-> log.info(store));
	}
	
	
	public void testGetNstore() {
		StoreVO store = mapper.getNstore(21L);
		log.info(store);
	}
	
	/*
	 * public void testGetStoreCd() { String storeCode = mapper.getStoreCd(1L);
	 * log.info(storeCode); }
	 */
	public void testGetBstore() {
		StoreVO store = mapper.getBstore(3L);
		log.info(store);
	}

	
	
	private long storeId = 13;
	private String storeNm = "��������";
	private String telno = "010-2737-5157";
	private String clsCd = "I";
	private String userId = "kjuioq";

	// mapper �� ���ԵǾ����� DI �׽�Ʈ
	public void mapperDItest() {
		log.info("mapper DI test : " + mapper);
	}
	
	public void storeMapperInsertTests1() {
		
		StoreVO store = new StoreVO().builder()
				.storeId(storeId)
				.storeNm(storeNm)
				.telno(telno)
				.clsCd(clsCd)
				.build();
		
		mapper.insert(store);
		
		log.info(store);
		
		
	}
	
	
	public void storeMapperDeleteTests1() {
		
		int result = mapper.delete(4L);
		
		assertTrue(result == 1);
		
	}
	
	public void findByIdJoinNStoreTest1() {
		
		StoreVO store = mapper.findByIdJoinNStore(storeId);
		
		log.info(store);
		
		assertNotNull(store.getBstore());
	}
	
	public void findByIdJoinBStoreTest1() {
		
		StoreVO store = mapper.findByIdJoinBStore(storeId);
		
		log.info(store);
		
		
		assertNotNull(store.getBstore());
	
	}

	public void findByUserIdJoinBStoreTest1() {
		
		List<StoreVO> list = mapper.findByUserIdJoinBStore(userId);
		
		log.info(list);
		
		list.stream().forEach(store -> {
			assertNotNull(store.getBstore());
			assertNotNull(store.getBstore().getBuserId().equals(userId));
		});
	}

}
