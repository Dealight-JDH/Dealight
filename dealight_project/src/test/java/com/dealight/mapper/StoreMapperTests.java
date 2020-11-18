package com.dealight.mapper;

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

	private long storeId = 13;
	private String storeNm = "��������";
	private String telno = "010-2737-5157";
	private String clsCd = "I";
	private String userId = "kjuioq";

	@Setter(onMethod_ = @Autowired)
	private StoreMapper mapper;

	// mapper �� ���ԵǾ����� DI �׽�Ʈ
	@Test
	public void mapperDItest() {
		log.info("mapper DI test : " + mapper);
	}

	// mapper read
	@Test
	public void mapperFindByIdTest() {

		StoreVO store = mapper.findById(3);

		log.info(store);

	}
	
	@Test
	public void mapperFindAllTests1() {
		
		List<StoreVO> list = mapper.findAll();
		
		System.out.println(list);
		
	}
	
	@Test
	public void storeMapperInsertTests1() {
		
		StoreVO store = new StoreVO().builder()
				.storeId(storeId)
				.storeNm(storeNm)
				.telno(telno)
				.clsCd(clsCd)
				.build();
		
		mapper.insert(store);
		
		log.info(store);
		
		store = mapper.findById(store.getStoreId());
		
		assertNotNull(store);
		
	}
	
	@Test
	public void storeMapperInsertSelectKeyTests1() {
		
		StoreVO store = new StoreVO().builder()
				.storeId(storeId)
				.storeNm(storeNm)
				.telno(telno)
				.clsCd(clsCd)
				.build();
		
		List<StoreVO> list = mapper.findAll();
		
		int bf = list.size();
		
		mapper.insertSelectKey(store);
		
		log.info(store);
		
		list = mapper.findAll();
		
		assertTrue(list.size() == bf + 1);
		
		assertTrue(list.get(list.size()-1).getStoreId() == store.getStoreId());
		
		
		
	}
	
	@Test
	public void storeMapperDeleteTests1() {
		
		int result = mapper.delete(4L);
		
		assertTrue(result == 1);
		
	}
	
	@Test
	public void findByIdJoinNStoreTest1() {
		
		StoreVO store = mapper.findByIdJoinNStore(storeId);
		
		log.info(store);
		
		assertNotNull(store.getBstore());
	}
	
	@Test
	public void findByIdJoinBStoreTest1() {
		
		StoreVO store = mapper.findByIdJoinBStore(storeId);
		
		log.info(store);
		
		
		assertNotNull(store.getBstore());
	
	}

	@Test
	public void findByUserIdJoinBStoreTest1() {
		
		List<StoreVO> list = mapper.findByUserIdJoinBStore(userId);
		
		log.info(list);
		
		list.stream().forEach(store -> {
			assertNotNull(store.getBstore());
			assertNotNull(store.getBstore().getBuserId().equals(userId));
		});
	}

}
