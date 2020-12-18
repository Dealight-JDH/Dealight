package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.StoreDTO;
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
	public void testGetStore() {
		StoreDTO dto = mapper.findByStoreId(3l);
		log.info("======="+ dto);
	}
	
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
	
	@Test
	public void findByIdJoinBStoreTest1() {
		
		storeId = 1L;
		
		StoreVO store = mapper.findByIdJoinBStore(storeId);
		
		log.info(store);
		
		
		assertNotNull(store.getBstore());
	
	}

	@Test
	public void findByUserIdJoinBStoreTest1() {
		
		userId = "aaaa";
		
		List<StoreVO> list = mapper.findByUserIdJoinBStore(userId);
		
		log.info(list);
		
		list.stream().forEach(store -> {
			assertNotNull(store.getBstore());
			assertNotNull(store.getBstore().getBuserId().equals(userId));
		});
	}
	
	@Test
	public void findStoreWithLocByStoreIdTest1() {
		
		storeId = 13L;
		
		StoreVO store= mapper.findStoreWithLocByStoreId(storeId);
		
		log.info("store : " + store);
		log.info("store loc : " + store.getLoc());
		
		assertNotNull(store.getLoc());
	}
	
	@Test
	public void findStoreWithBstoreAndLocByStoreIdTest1() {
		
		storeId = 13L;
		
		StoreVO store = mapper.findStoreWithBstoreAndLocByStoreId(storeId);
		
		log.info(store);
		
		assertNotNull(store);
		assertNotNull(store.getBstore());
		assertNotNull(store.getLoc());
	}
	
	@Transactional
	@Test
	public void suspendStoreTest1() {
		
		storeId = 1L;
		
		StoreVO store = mapper.findByIdJoinBStore(storeId);
		
		log.info("before store cls cd : " + store.getClsCd());
		
		
		int result = mapper.suspendStore(storeId);
		
		assertTrue(result == 1);
		
		store = mapper.findByIdJoinBStore(storeId);
		
		assertTrue(store.getClsCd().equals("I"));
		
		log.info("after store cls cd : " + store.getClsCd());
		
	}
	
	
	@Test
	public void getTotalCntTest1() {
		
		int pageNum = 1;
		int amount = 5;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		int result = mapper.getTotalCnt(cri);
		
		log.info("result : "+result);
		
	}
	
	@Test
	public void findStoreListWithPagingTest1() {
		
		int pageNum = 1;
		int amount = 5;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		List<StoreVO> list = mapper.findStoreListWithPaging(cri);
		
		list.stream().forEachOrdered(store -> {
			
			log.info("store : "+store);
			
		});
		
		assertTrue(list.size() == amount);
		
	}
	
	@Test
	public void findStoreListWithPagingTest2() {
		
		int pageNum = 1;
		int amount = 5;
		String type = "S";
		String keyword = "버거";
		
		Criteria cri = new Criteria(pageNum,amount);
		cri.setType(type);
		cri.setKeyword(keyword);
		
		List<StoreVO> list = mapper.findStoreListWithPaging(cri);
		
		list.stream().forEachOrdered(store -> {
			
			log.info("store : "+store);
			assertTrue(store.getStoreNm().contains(keyword));
			
		});
		
	}

}
