package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class HtdlServiceTests {

	@Autowired
	private HtdlService service;
	
	@Autowired
	private HtdlTimeCheckService timeCheck;
	//TODO 핫딜 서비스 테스트
	
//	@Test
//	public void testAsync() throws ParseException {
//		service.asyncMethodTest();
//	
//			//timeCheck.postConstruct();
//		//service.asyncMethodTest();
//	}
	
//	@Test
//	public void testFindPriceByName() {
//		Long storeId = 4l;
//		String name = "불고기 버거";
//		
////		MenuDTO menu = service.findPriceByName(storeId, name);
//		
//		log.info(menu);
//	}
	
	@Test
	@Transactional
	public void testRemove() {
		
		//핫뒬 취소 불가능(핫딜이 존재x)
		Long htdlId = 20l;
		service.remove(htdlId);
		
		//핫딜 취소 가능
		//Long htdlId = 72l;
		assertTrue(service.remove(htdlId));
		
		//핫딜 취소 불가능(핫딜 시작이후)
		Long htdlId1 = 8l;
		assertTrue(service.remove(htdlId1));
		
	}
	
	@Test
	@Transactional
	public void testRead() {
		//해당 핫딜 가져오기
		Long htdlId =118l;
		
		HtdlVO vo =  service.read(htdlId);
		
		log.info(vo);
	}
	@Test
	public void testGetList() {
		//핫딜(핫딜+상세+매장평가)리스트 가져오기
		List<HtdlVO> list = service.getList();
		list.forEach(vo -> log.info(vo));
	}
	
	@Test
	public void testRegister() {
		
		log.info(service);
		String[][] dtlsFood = {{"싸이 버거", "8000"}, {"새우 버거","6000"}};
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
		Date date = new Date();
		String sysdate = format.format(date);
		String intro = "음료 서비스!";
		//핫딜 상세vo list
		List<HtdlDtlsVO> dtlsList = new ArrayList<>();

		//핫딜 VO 생성
		HtdlVO vo = HtdlVO.builder()
							.name("new hotdeal name6")
							.storeId(4l)
							.dcRate(0.2)
							.startTm(sysdate+" 04:10")
							.endTm(sysdate+" 04:11")
							.lmtPnum(50)
							.intro(intro)
							.befPrice(14000)
							.ddct(11200).curPnum(0).stusCd("A").build();
		
		//요청 리스트 생성
		for(int i=0; i< dtlsFood.length; i++) {			
			HtdlDtlsVO dtlsVO = HtdlDtlsVO.builder()
									.menuName(dtlsFood[i][0])
									.menuPrice(Integer.valueOf(dtlsFood[i][1])).build();
			dtlsList.add(dtlsVO);
		}
		
		dtlsList.forEach(System.out::println);
		service.register(vo, dtlsList);
	} 
	@Test
	public void testService() {
		//서비스 객체 확인
		assertNotNull(service);
	}
}