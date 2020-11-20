package com.dealight.service;

import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RsvdServiceTests {
	
	@Autowired
	private RsvdService service;
	
	@Test
	@Transactional
	public void testRemove() {
		Long rsvdId = 12l;
		
		assertTrue(service.cancel(rsvdId));
	}
	
	
	@Test
	@Transactional
	public void testRegister() {
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String sysdate = format.format(date);
		String[][] dtlsFood = {{"김밥", "2000","3"},{"튀김","3000","3"},{"떡볶이","2500","2"}};
		List<RsvdDtlsVO> dtlsList = new ArrayList<>();
		
		//예약 VO 생성
		RsvdVO vo = RsvdVO.builder()
							.storeId(3l)
							.userId("whddn528")
							.aprvNo(202011073583l)
							.pnum(2)
							.time(sysdate+" 18:00")
							.stusCd("P")
							.totAmt(20000)
							.totQty(8)
							.build();
		
		//요청 리스트 생성
		for(int i=0; i< dtlsFood.length; i++) {			
			RsvdDtlsVO dtlsVO = RsvdDtlsVO.builder()
									.menuNm(dtlsFood[i][0])
									.menuPrc(Integer.valueOf(dtlsFood[i][1]))
									.menuTotQty(Integer.valueOf(dtlsFood[i][2])).build();
			dtlsList.add(dtlsVO);
		}
		
		service.register(vo, dtlsList);
		
	}
}
