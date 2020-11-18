package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.StoreTagVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreTagTests {
	
	@Setter(onMethod_ = @Autowired)
	private StoreTagMapper mapper;
	
	private long storeId = 101;
	private String tagNm = "еб╠в";
	
	@Test
	public void updateTest1() {
		
		StoreTagVO tag = new StoreTagVO().builder()
				.storeId(storeId)
				.tagNm(tagNm)
				.build();
		
		int result = mapper.update(tag);
		
		assertTrue(result == 1);
	}
	
	@Test
	public void insertTest1() {
		
		storeId = 82;
		
		StoreTagVO tag = new StoreTagVO().builder()
				.storeId(storeId)
				.tagNm(tagNm)
				.build();
		
		mapper.insert(tag);
		
		List<StoreTagVO> list = new ArrayList<>();
		
		list = mapper.findByStoreId(storeId);
		
		assertNotNull(list);
		
		log.info(list);
	}
	
	@Test
	public void findByStoreIdTest1() {
		
		List<StoreTagVO> tag = mapper.findByStoreId(storeId);
		
		assertNotNull(tag);
		
		log.info(tag);
		
	}

}
