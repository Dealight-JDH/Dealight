package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.RsvdAvailVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.RsvdWithStoreDTO;
import com.dealight.domain.TimeDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RsvdServiceTests {
	
	@Autowired
	private RsvdService rsvdService;
	
	@Autowired
	private StoreService storeService;

	@Test
	public void testRegisterAvail() {
		log.info("========register rsvd avail...");
		rsvdService.registerRsvdAvail(103l);
		
	}
	
	@Test
	public void testCheckExistHtdl() {
		
		log.info("hotdeal exist check...");
		String userId = "whddn528";
		Long htdlId = 13l;
		assertTrue(rsvdService.checkExistHtdl(userId, htdlId));
	}
	

	@Test
	public void testCompleteUpdateAvail() {
		
		Long storeId = 4l;
		String time = "12:00";
		int pnum = 3;
		
		boolean result = rsvdService.completeUpdateAvail(storeId, time, pnum);
		
		assertTrue(result);
		
		RsvdAvailVO vo = rsvdService.getRsvdAvailByStoreId(storeId);
		
		log.info("result vo: " + vo);
	}
	
	@Test
	public void testRsvdAvail() {
		rsvdService.initRsvdAvail();	
	}
	
	@Test
	public  void testGetRsvdAvail() {
		List<RsvdAvailVO> list = rsvdService.getRsvdAvailList();
		
		list.forEach(vo -> log.info(vo));
		
		
	}
	
	@Test
	public void testBreakCheckRsvdAvail() {
		log.info("...........init rsvd Avail");
		
		//rsvdService.initRsvdAvail();
		
		//setBreakTimeAvail(null, "13:00", "15:00");
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm");
//		LocalDateTime time = LocalDateTime.parse("2016-09-21 13:00", formatter);
//		System.out.println("============"+ time);
		
		//String time = "13:00";
//		LocalDate sysdate =LocalDate.now();
//		String time = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T13:00"; 

//		System.out.println(time);
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd HH:mm");
//		LocalDateTime dateTime = LocalDateTime.parse(time);
		
//		System.out.println("nine time: " + TimeDTO.NINE.getTime());
//		System.out.println("dateTIme : "+ dateTime);
//		System.out.println(dateTime.isAfter(TimeDTO.NINE.getTime()));
//		String strDatewithTime = "2015-08-04T10:11:30";
//		LocalDateTime aLDT = LocalDateTime.parse(strDatewithTime);
//		System.out.println("Date with Time: " + aLDT);

		//예약 가능 시간대 브레이크 타임 범위 필드 추출 테스트
		RsvdAvailVO vo = RsvdAvailVO.builder()
				.storeId(1l).nine(10).nineHalf(10).ten(10).tenHalf(10).eleven(10).elevenHalf(10)
				.twelve(10).twelveHalf(10).thirteen(10).thirteenHalf(10).fourteen(10).fourteenHalf(10)
				.fifteen(10).fifteenHalf(10).sixteen(10).sixteenHalf(10).seventeen(10).seventeenHalf(10)
				.eighteen(10).eighteenHalf(10).nineteen(10).nineteenHalf(10)
				.build();
		
		String startTm = "13:00";
		String endTm = "15:00";
		
		LocalDate sysdate =LocalDate.now();
		String strStartTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+startTm;
		String strEndTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+endTm;
		
		LocalDateTime startTime = LocalDateTime.parse(strStartTime);
		LocalDateTime endTime = LocalDateTime.parse(strEndTime);
	
		log.info("startTime : " + startTime);
		log.info("endTime : " + endTime);
		
		List<TimeDTO> breakTimeList = new ArrayList<>();
		
		try {
			
			for(TimeDTO timeValue : TimeDTO.values()) {
				log.info("==========time value: " + timeValue+", "+ timeValue.getTime());
				if(
					(timeValue.getTime().isEqual(startTime) || timeValue.getTime().isAfter(startTime)) && 
					(timeValue.getTime().isBefore(endTime)) || (timeValue.getTime().equals(endTime))
				){
				
					log.info("브레이크 범위에 해당하는 브레이크 시간: " + timeValue.getTime());
					breakTimeList.add(timeValue);
					
					//예약 가능 VO클래스
					Class<?> availClass = vo.getClass();
					//VO클래스 에 대한 필드 추출(private까지)
					Field fields[] = availClass.getDeclaredFields();
					
					for(Field field : fields) {
						
						//필드가 브레이크 범위가 같을 경우..
						if(field.getName().equalsIgnoreCase(timeValue.toString())){
							
							log.info("브레이크 범위 필드: "+ field.getName());
							field.setAccessible(true);
							
							//값 변경
							field.set(vo, -1);
							log.info("필드 값 변경: " + field.get(vo));
						}
					}
					

				}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		log.info("========result======: " + vo);
		
		
	}
	
	
	
	@Test
	public void testRemovaAll() {
		log.info("remove all");
		
		rsvdService.removeRsvdAvail();
	}
	
	
	@Test
	@Transactional
	public void testRemove() {
		Long rsvdId = 12l;
		
		assertTrue(rsvdService.cancel(rsvdId));
	}
	
	
	@Test
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
							.aprvNo("202011073583l")
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
		
		rsvdService.register(vo, dtlsList);
		
	}
	
	@Test
	public void findRsvdListWithPagingByUserIdTest1() {
		
		String userId = "kjuioq";
		
		int pageNum = 3;
		int amount = 10;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RsvdVO> list = rsvdService.findRsvdListWithPagingByUserId(userId, cri);
		
		list.stream().forEach(rsvd -> {
			log.info("rsvd : " + rsvd);
		});
		
		log.info("rsvd list size : " + list.size());
		
		
	}
	
	@Test
	public void findRsvdListWithPagingAndDtlsByUserIdTest1() {
		
		String userId = "kjuioq";
		
		int pageNum = 1;
		int amount = 10;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RsvdVO> list = rsvdService.findRsvdListWithPagingAndDtlsByUserId(userId, cri);
		
		list.stream().forEach(rsvd -> {
			log.info("rsvd : " + rsvd);
			assertNotNull(rsvd.getRsvdDtlsList());
			
		});
		
		log.info("rsvd list size : " + list.size());
		assertTrue(list.size() == amount);
		
		
	}
	
	@Test
	public void getRsvdTotalCountTest1() {
		
		String userId = "kjuioq";
		
		int pageNum = 1;
		int amount = 10;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		int total = rsvdService.getRsvdTotalCount(userId, cri);
		
		log.info("total....................."+total);
		
	}
	
	@Test
	public void getRsvdAvailByStoreIdTest1() {
		
		RsvdAvailVO rsvdAvail = rsvdService.getRsvdAvailByStoreId(1L);
		
		log.info("rsvd avail : "+rsvdAvail);
		
	}
	
	@Test
	public void getTimeValueTest1() {
		
		
		String time = "13:00";
		
		Long storeId = 1L;
		
		int pnum = 6;
		
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		RsvdAvailVO rsvdAvail = rsvdService.getRsvdAvailByStoreId(storeId);
		
		boolean result = rsvdService.isRsvdAvailChecked(rsvdAvail, time, pnum);
		
		log.info(".........................................result : " + result);
	}
	
	@Test
	public void getTimeValueTest2() {
		
		Long storeId = 1L;
		
		String[] timeArr = {"","09:00","09:30","10:00","10:30","11:00","11:30","12:00"
		    		       	,"12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00",
		    		       	"16:30","17:00","17:30","18:00","18:30","19:00","19:30"};
		
		log.info("time arr length : "+timeArr.length);
		
		String[] stusArr = new String[timeArr.length];
		
		log.info("stus arr length : "+timeArr.length);
		
		int[] curNumArr = new int[timeArr.length];
		
		RsvdAvailVO rsvdAvail = rsvdService.getRsvdAvailByStoreId(storeId);
		
		StoreVO store = storeService.findByStoreIdWithBStore(storeId);
		
		int acm = store.getBstore().getAcmPnum();
		
		log.info("acm : " + acm);
		
		for(int i = 1; i < timeArr.length; i++) {
			
			log.info("=================================");
			
			TimeDTO dto = getTimeValue(timeArr[i]);
			
			log.info(" "+i+"번째 get time value : " + dto);
			try {
				Class<?> availClass = rsvdAvail.getClass();
				
				log.info("avail class : " + availClass);
				
				Field[] fields = availClass.getDeclaredFields();
				
				log.info("fields : " + fields);
				
				for(Field field : fields) {
					
					log.info("field : " + field);
					
					if(field.getName().equalsIgnoreCase(dto.toString())) {
						log.info("=================equals===============");
						field.setAccessible(true);
						
						int curPnum = field.getInt(rsvdAvail);

						log.info("cur pnum : " + curPnum);
						
						curNumArr[i] = curPnum;
						
						int availPnum = acm-curPnum;
						
						log.info("availPnum : " + availPnum);
						
						if(availPnum >= (acm))
							stusArr[i] = "R";
						else if(acm > availPnum && availPnum >= (acm*0.6))
							stusArr[i] = "Y";
						else
							stusArr[i] = "G";
							
					}
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		log.info("======================red===================");
		log.info("red : " + acm);
		log.info("======================yellow===================");
		log.info("cur num이  : " + (acm - acm*0.6) +"보다 크면 yellow");
		log.info("available num이  : " + acm*0.6 +"보다 크면 yellow");
		log.info("======================green===================");
		log.info("acm 0 : " + 0);
		log.info("cur stus arr : " + Arrays.toString(stusArr));
		log.info("curNumArr : " + Arrays.toString(curNumArr));
		
		HashMap<String,String> map = new HashMap<>();
		
		for(int i = 1; i < timeArr.length; i++)
			map.put(timeArr[i], stusArr[i]);
		
		
		log.info("map : " + map);
		
	}
	
	private TimeDTO getTimeValue(String time) {
		
		
		LocalDateTime rsvdTime = formatDate(time);
		for(TimeDTO timeValue : TimeDTO.values()) {
			
			if(timeValue.getTime().isEqual(rsvdTime)){
				return timeValue;
			}
		}
		return null;
	}
	
	@Test
	public void testFormatDate() {
		LocalDate sysdate = LocalDate.now();
		log.info("sysdate: " + sysdate);
		
		log.info("================year: " + sysdate.getYear());
		log.info("================month: " + sysdate.getDayOfMonth());
		log.info("================day: " + sysdate.getDayOfMonth());
//		String strTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+time;
		String str = sysdate+"T13:00";
		LocalDateTime formatTime = LocalDateTime.parse(str);
		log.info("========formatTime: " + formatTime);
		log.info(str);
		//LocalDateTime formatTime = formatDate("13:00");
		//log.info("=====test formatTime: " + formatTime );
	}
	//날짜 변환 메서드
	private LocalDateTime formatDate(String time) {
		
		LocalDate sysdate = LocalDate.now();
		
		String strTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+time;
		LocalDateTime formatTime = LocalDateTime.parse(strTime);
		return formatTime;
	}
	
	
	@Test
	public void rsvdAvailabilityTest1() {
		rsvdService.initRsvdAvail();
	}

}
