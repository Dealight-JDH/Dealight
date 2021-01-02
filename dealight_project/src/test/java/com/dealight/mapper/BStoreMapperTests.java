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

import com.dealight.domain.BStoreVO;
import com.dealight.domain.HtdlWithStoreDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BStoreMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BStoreMapper mapper;
	
	
	@Test
	public void testHtdlRsvd() {
		List<HtdlWithStoreDTO> dto = mapper.findHtdlRslt();
		dto.forEach(vo -> log.info(vo));
		
	}
	
	@Test
	public void testUpdateHtdlStus() {
		mapper.updateHtdlStus(17l, "I");
	}
	@Test
	public void testInsert() {
		
		BStoreVO bStore = new BStoreVO.Builder(4L, "aaaa", "종로본점", "김밥", "a.jpg", "10:00", "20:00")
									  .setAcmPnum(40).setAvgMealTm(40).setHldy("연중무휴").setN4SeatNo(10)
									  .setStoreIntro("김밥 맛있는집").build();
		log.info(bStore);
		mapper.insert(bStore);
	}
	
	@Test
	public void testGetList() {
		
		mapper.getList().forEach(store -> log.info(store));
		
	}
	
	@Test
	public void testRead() {
		
		log.info(mapper.read(1L));
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.delete(3L));
	}
	
	@Test
	public void testUpdate() {
		BStoreVO bStore = new BStoreVO.Builder(5L, "aaaa", "종로1호점"	, "돈까쓰", "b.jpg", "10:00", "22:00").setAcmPnum(40).setAvgMealTm(30)
				.setseatStusCd("G").setBreakEntm("17:00").setBreakSttm("15:00").setHldy("매주 월요일").setN4SeatNo(10).build();
		
		mapper.update(bStore);
		log.info(mapper.read(5L));
	}
	
	// �ʼ� �Է�
    private long storeId = 13;
    private String seatStusCd;
    private String openTm = "09:30";
    private String closeTm = "21:30";
    
    // ���� �Է�
    private String buserId = "kjuioq";
    private String breakSttm = "15:00";
    private String breakEntm = "16:00";
    private String lastOrdTm = "21:00";
    private int n1SeatNo = 8;
    private int n2SeatNo = 10;
    private int n4SeatNo = 5;
    private String storeIntro = "�ȳ�?";
    private int avgMealTm = 30;
    private String hldy = "�Ͽ���"; 
    private int acmPnum = 40;
    
    @Test
    public void findByStoreIdTest1() {
    	
    	BStoreVO bstore = mapper.findByStoreId(storeId);
    	
    	assertNotNull(bstore);
    	
    	log.info(bstore);
    	
    }
    
    @Test
    public void findAllTest1() {
    	
    	List<BStoreVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);
    	
    }
    
    @Test
    public void insertTest1() {
    	BStoreVO bstore = new BStoreVO().builder()
				.storeId(storeId)
				.openTm(openTm)
				.closeTm(closeTm)
				.breakSttm(breakSttm)
				.breakEntm(breakEntm)
				.lastOrdTm(lastOrdTm)
				.n1SeatNo(n1SeatNo)
				.n2SeatNo(n2SeatNo)
				.n4SeatNo(n4SeatNo)
				.storeIntro(storeIntro)
				.avgMealTm(avgMealTm)
				.hldy(hldy)
				.acmPnum(acmPnum)
				.seatStusCd("B")
				.build();
    	
    	log.info(bstore);
    	
    	BStoreVO b = mapper.findByStoreId(storeId);
    	
    	mapper.insert(bstore);
    	
    	b = mapper.findByStoreId(storeId);
    	
    }
    
    @Test
    public void updateTest1() {
    	
    	BStoreVO bstore = mapper.findByStoreId(storeId);
    	
    	assertNotNull(bstore);
    	
    	String b = bstore.getHldy();
    	
    	bstore.setHldy("����");
    	
    	int result = mapper.update(bstore);
    	
    	assertTrue(result == 1);
    	
    	bstore = mapper.findByStoreId(storeId);
    	
    	assertTrue(!bstore.getHldy().equals(b));
    	
    	bstore.setHldy(b);
    	
    	result = mapper.update(bstore);
    	
    	assertTrue(result == 1);
    	
    }
    
    @Test
    public void deleteTest1() {
    	BStoreVO bstore = new BStoreVO().builder()
				.storeId(12L)
				.openTm(openTm)
				.closeTm(closeTm)
				.breakSttm(breakSttm)
				.breakEntm(breakEntm)
				.lastOrdTm(lastOrdTm)
				.n1SeatNo(n1SeatNo)
				.n2SeatNo(n2SeatNo)
				.n4SeatNo(n4SeatNo)
				.storeIntro(storeIntro)
				.avgMealTm(avgMealTm)
				.hldy(hldy)
				.acmPnum(acmPnum)
				.seatStusCd("B")
				.build();
    	
    	log.info(bstore);
    	
    	mapper.insert(bstore);
    	
    	BStoreVO b = mapper.findByStoreId(12);
    	
    	assertNotNull(b);
    	
    	mapper.delete(b.getStoreId());
    	
    	b = mapper.findByStoreId(12);
    	
    	assertNull(b);
    }
    
	
	@Test
	public void changeSeatStusTest1() {
		
		BStoreVO bstore =  mapper.findByStoreId(storeId);
		
		log.info(bstore);
		
		seatStusCd = "R";
		
		int result = mapper.changeSeatStus(storeId, seatStusCd);
		
		assertTrue(result == 1);
		
		bstore =  mapper.findByStoreId(storeId);
		
		assertTrue(bstore.getSeatStusCd().equals(seatStusCd));
	}

}
