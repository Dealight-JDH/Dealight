package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.stream.Collectors;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReservationServiceTests {

	@Autowired
	private RsvdService reservationService;
	
	long storeId = 13;
	long rsvdId = 9;
	
	//ReservationDetailVO readDetail(long rsvdId);
	//List<ReservationVO> readAllRsvdList(long storeId);
	//List<ReservationVO> readCurRsvdList(long storeId);
	//List<ReservationVO> readTodayCurRsvdList(long storeId);
	//boolean isReserveThisTimeStore(List<ReservationVO> readTodayCurRsvdList);
	//ReservationVO readNextRsvd(List<ReservationVO> readTodayCurRsvdList);
	//boolean isHtdl(ReservationVO rsvd);
	
	//int totalTodayRsvd(List<ReservationVO> readTodayCurRsvdList);
	//int totalTodayRsvdPnum(List<ReservationVO> readTodayCurRsvdList);
	//int todayFavMenu(List<ReservationVO> readTodayCurRsvdList);
	//List<UserVO> userListTodayRsvd(List<ReservationVO> readTodayCurRsvdList);
	
	@Test
	public void readByRsvdIdTest1() {
		
		RsvdVO rsvd = reservationService.read(rsvdId);
		
		assertNotNull(rsvd);
		
		log.info(rsvd);
		
	}
	
	@Test
	public void readDetailByRsvdIdTest1() {
		
		List<RsvdDtlsVO> list = reservationService.readDetail(rsvdId);
		
		assertNotNull(list);
		
		list.forEach((rsvdDtls) -> {
			
			assertTrue(rsvdDtls.getRsvdId() == rsvdId);
			
		});
		
		log.info(list);
	}
	
	@Test
	public void readListReservationByStoreIdTest1() {
		
		List<RsvdVO> list = reservationService.readAllRsvdList(storeId);
		
		assertNotNull(list);
		
		list.forEach((rsvd) -> {
			
			assertTrue(rsvd.getStoreId() == storeId);
			
		});
		
		log.info(list);
	}
	
	@Test
	public void readListCurReservationByStoreIdTest1() {
		
		List<RsvdVO> list = reservationService.readCurRsvdList(storeId);
		
		assertNotNull(list);
		
		list.forEach((rsvd) -> {
			
			assertTrue(rsvd.getStusCd().equals("C"));
			
		});
		
		log.info(list);
	}
	
	
	
	@Test
	public void readRsvdTodayTest1() {
		
		List<RsvdVO> list = reservationService.readTodayCurRsvdList(101);
		
		assertNotNull(list);
		
		String pattern = "yyyy-MM-dd";
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		
		Date date = new Date();
		
		list.forEach((rsvd) -> {
			
			assertTrue(simpleDateFormat.format(rsvd.getRegDate()).equals(simpleDateFormat.format(date)));
			
		});
		
		log.info(list);
		
	}
	
	@Test
	public void getRsvdListByDateTest1() {
		
		String date = "20201107";
		
		List<RsvdVO> list = reservationService.getListByDate(storeId, date);
		
		assertNotNull(list);
		
		String pattern = "yyyyMMdd";
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		
		list.forEach((rsvd) -> {
			
			assertTrue(rsvd.getStoreId() == storeId);
			assertTrue(simpleDateFormat.format(rsvd.getRegDate()).equals(date));
			
		});
		
		log.info(list);

	}
	
	
	@Test
	public void getTimeTest1() {
		
		List<RsvdVO> list = reservationService.readTodayCurRsvdList(storeId);
		
		list.forEach((rsvd) -> {
			log.info(reservationService.getTime(rsvd.getRegDate()));
		});
		
	}
	
	@Test
	public void calTimeMinutesTest1() {
		
		List<RsvdVO> list = reservationService.readTodayCurRsvdList(storeId);
		
		list.forEach((rsvd) -> {
			String time = reservationService.getTime(rsvd.getRegDate());
			log.info(time + ":::::::::::::" + reservationService.calTimeMinutes(time));
		});
		
	}
	
	@Test
	public void toRsvdByTimeFormatTest1() {
		
		String time = "14:59";
		
		time = reservationService.toRsvdByTimeFormat(time);
		
		log.info(time);
		
		//assertTrue(time.equals("11:30"));
		
	}
	
	@Test
	public void getRsvdByTimeMapTest1() {
		
		String date = "20201107";
		
		List<RsvdVO> list = reservationService.getListByDate(storeId, date);
		
		log.info(list);
		
		HashMap<String, List<Long>> map = reservationService.getRsvdByTimeMap(list);
		
		log.info(map);
		
	};

	
	@Test
	public void isReserveThisTimeStoreTest1() {
		
		// 2020�� 11�� 7�� 11�� 47�� 30��
		// true�� ���;� ��
		//Date date = new Date(120,10,7,11,47,30);
		
		// 2020�� 11�� 7�� 12�� 12�� 30��
		// false�� ���;� ��
		Date date = new Date(120,10,7,12,12,30);

		int acm = 5;
		
		log.info(date);
		
		List<RsvdVO> list = reservationService.getListByDate(storeId, "20201107");
		
		
		
		log.info(list);
		
		log.info(reservationService.getRsvdByTimeMap(list));
		
		assertTrue(reservationService.isReserveThisTimeStore(storeId, date, acm));
		
		
	}
	
	@Test
	public void readNextRsvdTest1() {
		
		List<RsvdVO> list = reservationService.readTodayCurRsvdList(0);
		
		HashMap<String,List<Long>> map = reservationService.getRsvdByTimeMap(list);
	
		if(list.size()>0) {
			long rsvdId = reservationService.readNextRsvdId(map);
			
			assertNotNull(rsvdId);
			
			log.info(rsvdId);
			
		}
		
	}
	
	@Test
	public void isHtdlTest1() {
		
		RsvdVO rsvd = reservationService.read(50);
		
		assertTrue(reservationService.isHtdl(rsvd));
		
	}
	
	@Test
	public void totalTodayRsvdTest() {
		
		storeId = 101;
		
		List<RsvdVO> readTodayCurRsvdList = reservationService.readTodayCurRsvdList(storeId);
		
		log.info(reservationService.totalTodayRsvd(readTodayCurRsvdList));
	}
	
	@Test
	public void totalTodayRsvdPnumTest() {
		
		storeId = 101;
		
		List<RsvdVO> readTodayCurRsvdList = reservationService.readTodayCurRsvdList(storeId);
		
		log.info(reservationService.totalTodayRsvdPnum(readTodayCurRsvdList));
	}
	
	@Test
	public void userListTodayRsvdTest() {
		
		storeId = 101;
		
		reservationService.userListTodayRsvd(storeId);
	}
	
	
	// ���� �ð��� ����
	@Test
	public void test() {
		
		String date = "20201107";
		
		List<RsvdVO> list = reservationService.getListByDate(storeId, date);
		
		HashMap<String, List<Long>> map = reservationService.getRsvdByTimeMap(list);
				
		SortedSet<String> keys = new TreeSet<>(map.keySet());
		
		log.info("test..............................."+keys);
		
		Iterator<String> it = keys.iterator();
		
		while(it.hasNext()) {
			
			String key = it.next();
			
			map.get(key).stream().forEach(rsvdId -> {
				
				log.info("test...............key : " + key);
				log.info("test...............rsvdId : "+rsvdId);
				
			});;
			
		}
		
		
	}
	
	@Test
	public void readRsvdListByDateTest1() {
		
		String date = "20201107";
		
		List<RsvdVO> listByDate = reservationService.readRsvdListByDate(storeId, date);
		
		assertNotNull(listByDate);
		
		log.info(listByDate);
	}
	
	@Test
	public void readNextRsvdIdTest1() {
		
		//List<ReservationVO> listByDate = reservationService.readTodayCurRsvdList(storeId);
		
		String date = "20201107";
		
		List<RsvdVO> listByDate = reservationService.readRsvdListByDate(storeId, date);
		
		log.info("test....................list"+listByDate);
		
		HashMap<String,List<Long>> getTodayRsvdByTimeMap = reservationService.getRsvdByTimeMap(listByDate);
		
		log.info("test....................map"+getTodayRsvdByTimeMap);
		
		long rsvdId = reservationService.readNextRsvdId(getTodayRsvdByTimeMap);
		
		log.info("test....................rsvdId"+rsvdId);
		
		RsvdVO vo = null;
		
		for(RsvdVO rsvd : listByDate) {
			if(rsvd.getRsvdId() == rsvdId)
				vo = rsvd;
		}
		
		log.info("test....................vo"+vo);
	}
	
	@Test
	public void findRsvdByRsvdIdTest() {
		
		String date = "20201107";
		
		List<RsvdVO> listByDate = reservationService.readRsvdListByDate(storeId, date);
		
		log.info("test....................list"+listByDate);
		
		RsvdVO rsvd = reservationService.findRsvdByRsvdId(44, listByDate);
		
		log.info(rsvd);
		
		assertNotNull(rsvd);
		
		
	}
	
	@Test
	public void findRsvdByRsvdIdWithDtlsTest1(){
		
		RsvdVO rsvd = reservationService.findRsvdByRsvdIdWithDtls(rsvdId);
		
		assertNotNull(rsvd);
		
		log.info(rsvd);
		
		rsvd.getRsvdDtlsList().stream().forEach(rsvdDtls -> {
			
			assertTrue(rsvdDtls.getRsvdId() == rsvdId);
			
		});
		
	}
	
	@Test
	public void todayFavMenuTest1(){
		
		HashMap<String,Integer> map = reservationService.todayFavMenu(101);
		
		log.info(map);
		
	}
	
	@Test
	public void lastWeekRsvdTest1() {
		
		storeId= 101;
		
		List<RsvdVO> list = reservationService.findLastWeekRsvd(storeId);
		
		log.info(list);
		
	}
	
}
