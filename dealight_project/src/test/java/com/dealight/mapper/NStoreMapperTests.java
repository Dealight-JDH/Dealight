package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

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
	
	// nstore ��ü
	private long storeId = 1;
	private String breakEntm = "21:00";
	private String menu = "���";
	
	// store ��ü
    private String storeNm = "��������";
    private String telno = "010-2737-5157";
    private String clsCd = "I";
    
    
	// mapper �� ���ԵǾ����� DI �׽�Ʈ
	@Test
	public void mapperDItest() {
		log.info("mapper DI test : " + mapper);
	}
    
    @Test
    public void findByStoreIdTest() {
    	
    	NStoreVO nstore = mapper.findByStoreId(1);
    	
    	assertNotNull(nstore);
    	
    	log.info(nstore);
    	
    }
    
    
    @Test
    public void insertNStoreTest1() {
    	
		NStoreVO nstore = new NStoreVO().builder()
				.storeId(storeId)
				.bizTm(breakEntm)
				.menu(menu)
				.build();
		
		
		log.info(nstore);
		
		mapper.insert(nstore);
    	
    }
    
    @Test
    public void updateNStoreTest1() {
    	
		NStoreVO nstore = new NStoreVO().builder()
				.storeId(storeId)
				.bizTm("13:00")
				.menu(menu)
				.build();
		
		log.info(nstore);
		
		String bf = mapper.findByStoreId(storeId).getBizTm();
		
		int result = -100;
		if(!bf.equals(nstore.getBizTm()))
			result = mapper.update(nstore);
		if(bf.equals(nstore.getBizTm())) {
			nstore.setBizTm("14:00");
			result = mapper.update(nstore);
		}
		
		assertTrue(result == 1);
		
		nstore = mapper.findByStoreId(storeId);
		
		
		log.info(nstore);
		
		assertTrue(!bf.equals(nstore.getBizTm()));
		
    	
    }
    

}
