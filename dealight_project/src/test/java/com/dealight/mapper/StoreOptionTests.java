package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreOptionVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class StoreOptionTests {
	
	@Setter(onMethod_ = @Autowired)
	private StoreOptionMapper mapper;
	
	private long storeId = 101;
	private String park = "Y";
	private String nokids = "N";
	private String pg = "N";
	private String wifi = "N";
	private String pet = "N";
	private String smoke = "N";
	
	
	@Test
	public void updateTest1() {
		
		StoreOptionVO opt = new StoreOptionVO().builder()
				.storeId(storeId)
				.park(park)
				.nokids(nokids)
				.pg(pg)
				.wifi(wifi)
				.pet(pet)
				.smoke(smoke)
				.build();
		
		int result = mapper.update(opt);
		
		assertTrue(result == 1);
	}
	
	@Test
	public void findByStoreIdTests1() {
		
		StoreOptionVO opt = mapper.findByStoreId(storeId);
		
		assertNotNull(opt);
		
		log.info(opt);
		
	}
	
	@Test
	public void insertTest1() {
		
		storeId = 74;
		
		StoreOptionVO opt = new StoreOptionVO().builder()
				.storeId(storeId)
				.park(park)
				.nokids(nokids)
				.pg(pg)
				.wifi(wifi)
				.pet(pet)
				.smoke(smoke)
				.build();
		
		mapper.insert(opt);
		
		opt = mapper.findByStoreId(storeId);
		
		assertNotNull(opt);
		
		log.info(opt);
	}

}
