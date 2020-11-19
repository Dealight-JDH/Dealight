package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class HotDealServiceTests {
	
	long htdlId = 29;
	long storeId = 13;

	@Autowired
	private HtdlService hotDealService;
	
	@Test
	public void DITest() {
		
		log.info(hotDealService);
		
	}
	
	@Test
	public void readByHtdlTest() {
		
		HtdlVO htdl = hotDealService.read(htdlId);
		
		assertNotNull(htdl);
		
	}
	
	@Test
	public void readDtlsByHtdlIdTest() {
		
		List<HtdlDtlsVO> list = hotDealService.readDtls(htdlId);
		
		assertNotNull(list);
		
		list.stream().forEach(htdlDtls -> {
			
			assertTrue(htdlDtls.getHtdlId() == htdlId);
			
		});
	}
	
	@Test
	public void readRsltTest1() {
		
		htdlId = 4;
		
		HtdlRsltVO htdlRslt = hotDealService.readRslt(htdlId);
		
		assertNotNull(htdlRslt);
		
	}
	
	@Test
	public void calHtdlEndTmTest1() {
		
		HtdlVO htdl = hotDealService.read(htdlId);
		
		int result = hotDealService.calHtdlEndTm(htdl);
		
		log.info("ÇÖµô ¸¶°¨ ½Ã°£ : " + result);
		
	}
	
	@Test
	public void readAllStoreHtdlListTest1() {
		
		List<HtdlVO> list = hotDealService.readAllStoreHtdlList(storeId);
		
		assertNotNull(list);
		
		list.stream().forEach(htdl -> {
			
			assertTrue(htdl.getStoreId() == storeId);
			
		});
	}
	
	@Test
	public void readActStoreHtdlListTest1() {
		
		List<HtdlVO> list = hotDealService.readActStoreHtdlList(storeId);
		
		assertNotNull(list);
		
		list.stream().forEach(htdl -> {
			
			assertTrue(htdl.getStoreId() == storeId);
			assertTrue(htdl.getStusCd().equals("A"));
			
		});
		
	}
	
}
