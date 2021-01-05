package com.dealight.service;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.RsvdAvailVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdTimeDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreMenuVO;
import com.dealight.domain.TimeDTO;
import com.dealight.domain.UserWithRsvdDTO;
import com.dealight.mapper.BStoreMapper;
import com.dealight.mapper.RsvdDtlsMapper;
import com.dealight.mapper.RsvdMapper;
import com.dealight.mapper.StoreMenuMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인] 
 * 
 */
//jongwoo

@Service
@Log4j
@RequiredArgsConstructor
public class RsvdServiceImpl implements RsvdService{

	private final RsvdMapper rsvdMapper;
	private final StoreMenuMapper menuMapper;
	private final BStoreMapper bstoreMapper;
	
	
//	SimpleDateFormat format = new SimpleDateFormat("yyyy/mm/dd hh:mm");
//	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/mm/dd hh:mm");
	
	@Transactional
	@Override
	public void registerRsvdAvail(Long storeId) {
		// TODO Auto-generated method stub
		log.info("============register rsvd Avail");
		
		//등록된 해당 매장 vo get
		BStoreVO vo = bstoreMapper.selectStoreWithAcmPnum(storeId);
		
		
		RsvdAvailVO rsvdAvail = RsvdAvailVO.builder()
				.storeId(vo.getStoreId()).nine(vo.getAcmPnum()).nineHalf(vo.getAcmPnum()).ten(vo.getAcmPnum()).tenHalf(vo.getAcmPnum()).eleven(vo.getAcmPnum()).elevenHalf(vo.getAcmPnum())
				.twelve(vo.getAcmPnum()).twelveHalf(vo.getAcmPnum()).thirteen(vo.getAcmPnum()).thirteenHalf(vo.getAcmPnum()).fourteen(vo.getAcmPnum()).fourteenHalf(vo.getAcmPnum())
				.fifteen(vo.getAcmPnum()).fifteenHalf(vo.getAcmPnum()).sixteen(vo.getAcmPnum()).sixteenHalf(vo.getAcmPnum()).seventeen(vo.getAcmPnum()).seventeenHalf(vo.getAcmPnum())
				.eighteen(vo.getAcmPnum()).eighteenHalf(vo.getAcmPnum()).nineteen(vo.getAcmPnum()).nineteenHalf(vo.getAcmPnum()).twenty(vo.getAcmPnum()).twentyHalf(vo.getAcmPnum())
				.twentyone(vo.getAcmPnum()).twentyoneHalf(vo.getAcmPnum()).twentytwo(vo.getAcmPnum())
				.build();
		
		//브레이크 타임이 있는 경우
		if(isBreakTime(vo.getBreakSttm(), vo.getBreakEntm())) {
			
			RsvdAvailVO breakVO = setBreakTimeAvail(rsvdAvail, vo.getBreakSttm(), vo.getBreakEntm());
			rsvdMapper.insertRsvdAvail(breakVO);
			return;
		}
		
		rsvdMapper.insertRsvdAvail(rsvdAvail);
		
	}
	
	
	@Override
	public RsvdVO readRsvdVO(Long rsvdId) {
		// TODO Auto-generated method stub
		log.info("rsvd find vo..");
		return rsvdMapper.findRsvdById(rsvdId);
	}
	
	
	@Override
	public boolean checkExistHtdl(String userId, Long htdlId) {
		// TODO Auto-generated method stub
		log.info("hotdeal rsvd check...");
		
		return rsvdMapper.checkExistHtdl(userId, htdlId) > 0;
	}
	
	@Override
	public RsvdAvailVO getRsvdAvailByStoreId(Long storeId) {
		// TODO Auto-generated method stub
		log.info("get Rsvd availVO....");
		return rsvdMapper.findRsvdAvailByStoreId(storeId);
	}

	@Transactional
	@Override
	public boolean completeUpdateAvail(Long storeId, String time, int pnum) {
		// TODO Auto-generated method stub

		//해당 매장의 예약 가능 row가져오기
		RsvdAvailVO findRsvdAvailVO = rsvdMapper.findRsvdAvailByStoreId(storeId);
		
		//해당 예약시간의 값 가져오기
		TimeDTO updateTimeField = getTimeValue(time);
		
		//예약 vo reflect
		log.info("=========Time DTO: " + updateTimeField);
		try {			
			Class<?> availClass = findRsvdAvailVO.getClass();
			
			Field[] fields = availClass.getDeclaredFields();
			
			for(Field field : fields) {
				if(field.getName().equalsIgnoreCase(updateTimeField.toString())) {
					field.setAccessible(true);
					
					int acmPnum = (int)field.get(findRsvdAvailVO);					
					acmPnum -= pnum;
					log.warn("============update acmPnum: " + acmPnum);
					
					field.set(findRsvdAvailVO, acmPnum);
					return rsvdMapper.completeUpdateAvail(findRsvdAvailVO) == 1;
					
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	@Override
	public boolean completeUpdateHtdl() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<RsvdAvailVO> getRsvdAvailList() {
		// TODO Auto-generated method stub
		log.info("get Rsvd Avail list.....");
		
		List<RsvdAvailVO> list = rsvdMapper.getRsvdAvailList();
		list.forEach(availVO -> log.info(availVO));
		
		return list;
	}
	
	
	@Transactional
	@Override
	public void initRsvdAvail() {
		// TODO Auto-generated method stub
		
		//등록된 매장번호 get(매장번호, 수용인원, 브레이크 시작,종료 타임)
		List<BStoreVO> list = bstoreMapper.selectIdWithAcmPnum();
		list.forEach(vo -> log.info(".............." + vo));

		//각 매장별 수용인원으로 예약가능 여부 채우기
		//브레이크 타임 시간 고려
		//보통 12 - 16 사이
		//리스트를 조회한다
		//시작,종료 타임이 있으면
		//범위에 맞는 변수에 -1 객체에 어떻게 담아야 할까....
		//아니면 수용인원
		list.forEach(vo -> {

			RsvdAvailVO rsvdAvail = RsvdAvailVO.builder()
					.storeId(vo.getStoreId()).nine(vo.getAcmPnum()).nineHalf(vo.getAcmPnum()).ten(vo.getAcmPnum()).tenHalf(vo.getAcmPnum()).eleven(vo.getAcmPnum()).elevenHalf(vo.getAcmPnum())
					.twelve(vo.getAcmPnum()).twelveHalf(vo.getAcmPnum()).thirteen(vo.getAcmPnum()).thirteenHalf(vo.getAcmPnum()).fourteen(vo.getAcmPnum()).fourteenHalf(vo.getAcmPnum())
					.fifteen(vo.getAcmPnum()).fifteenHalf(vo.getAcmPnum()).sixteen(vo.getAcmPnum()).sixteenHalf(vo.getAcmPnum()).seventeen(vo.getAcmPnum()).seventeenHalf(vo.getAcmPnum())
					.eighteen(vo.getAcmPnum()).eighteenHalf(vo.getAcmPnum()).nineteen(vo.getAcmPnum()).nineteenHalf(vo.getAcmPnum()).twenty(vo.getAcmPnum()).twentyHalf(vo.getAcmPnum())
					.twentyone(vo.getAcmPnum()).twentyoneHalf(vo.getAcmPnum()).twentytwo(vo.getAcmPnum())
					.build();
			
			//브레이크 타임이 있는 경우
			if(isBreakTime(vo.getBreakSttm(), vo.getBreakEntm())) {
				
				RsvdAvailVO breakVO = setBreakTimeAvail(rsvdAvail, vo.getBreakSttm(), vo.getBreakEntm());
				rsvdMapper.insertRsvdAvail(breakVO);
				return;
			}
			
			rsvdMapper.insertRsvdAvail(rsvdAvail);
			
		});
		
	}
	
	//예약 가능여부 체크
	@Override
	public boolean isRsvdAvailChecked(RsvdAvailVO vo, String time, int pnum) {
	
		log.info("===============isRsvdAvailChecked==================");
		
		TimeDTO timeValue = getTimeValue(time);
		
		log.info("time value : " + timeValue);
		
		//해당 시간에 맞는 vo 필드 뽑아내기
		try {
			Class<?> availClass = vo.getClass();
			
			log.info("availClass : " + availClass);
			
			Field[] fields = availClass.getDeclaredFields();
			
			log.info("fileds : " + fields);
			
			for(Field field : fields) {
				
				log.info("filed : " + field);
				
				if(field.getName().equalsIgnoreCase(timeValue.toString())) {
					field.setAccessible(true);
					int curPnum = field.getInt(vo);
					return curPnum - pnum >= 0;
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	//해당 예약시간의 시간상수 반환
	private TimeDTO getTimeValue(String time) {
		
//		String strRsvdTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+time;
//		LocalDateTime rsvdTime = LocalDateTime.parse(strRsvdTime);
		
		LocalDateTime rsvdTime = formatDate(time);
		for(TimeDTO timeValue : TimeDTO.values()) {
			
			if(timeValue.getTime().isEqual(rsvdTime)){
				return timeValue;
			}
		}
		return null;
	}
	
	//날짜 변환 메서드
	private LocalDateTime formatDate(String time) {
		
		LocalDate sysdate = LocalDate.now();
		//String strTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+time;
		String strTime = sysdate+"T"+time;
		LocalDateTime formatTime = LocalDateTime.parse(strTime);
		return formatTime;
	}
	
	//브레이크 타임 확인
	private boolean isBreakTime(String startTm, String endTm) {	
		return (startTm != null && !startTm.isEmpty()) && (endTm != null && !endTm.isEmpty());
	}
	
	//예약 가능 시간대 브레이크 타임 범위 필드 추출 메서드
	private RsvdAvailVO setBreakTimeAvail(RsvdAvailVO vo , String startTm, String endTm) {
		
//		String strStartTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+startTm;
//		String strEndTime = sysdate.getYear()+"-"+sysdate.getMonthValue()+"-"+sysdate.getDayOfMonth()+"T"+endTm;
//		LocalDateTime startTime = LocalDateTime.parse(strStartTime);
//		LocalDateTime endTime = LocalDateTime.parse(strEndTime);
		
		LocalDateTime startTime = formatDate(startTm);
		LocalDateTime endTime = formatDate(endTm);

		log.info("startTime : " + startTime);
		log.info("endTime : " + endTime);
		
		//List<TimeDTO> breakTimeList = new ArrayList<>();
		
		try {
			
			for(TimeDTO timeValue : TimeDTO.values()) {
				log.info("==========time value: " + timeValue+", "+ timeValue.getTime());
				if(
					(timeValue.getTime().isEqual(startTime) || timeValue.getTime().isAfter(startTime)) && 
					(timeValue.getTime().isBefore(endTime)) || (timeValue.getTime().equals(endTime))
				){
					log.info("브레이크 범위에 해당하는 브레이크 시간: " + timeValue.getTime());
					//breakTimeList.add(timeValue);
					
					//예약 가능 VO클래스
					Class<?> availClass = vo.getClass();
					
					//VO클래스 에 대한 필드 추출(private까지)
					Field fields[] = availClass.getDeclaredFields();
					
					for(Field field : fields) {
						//브레이크 범위에 해당하는 필드
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
		return vo;
			
		}
	
	
	@Transactional
	@Override
	public boolean removeRsvdAvail() {
		// TODO Auto-generated method stub
		log.info("rsvd Avail remove...");
		
		int count = rsvdMapper.countAll();
		log.info("count : " + count);
		
		return rsvdMapper.deleteRsvdAvail() == count;
	}
	
	@Override
	public boolean modifyStusCd(Long rsvdId, String stusCd) {
		// TODO Auto-generated method stub
		log.info("change rsvd stusCd..");
		return rsvdMapper.updateStusCd(rsvdId, stusCd) == 1;
	}

	@Override
	public List<RsvdTimeDTO> getCurrRsvdList() {
		// TODO Auto-generated method stub
		
		log.info("get current rsvd list...");
		return rsvdMapper.findCurrRsvd() ;
	}

	@Override
	public void registerTid(String aprvNo, Long rsvdId) {
		// TODO Auto-generated method stub
		log.info("kakao pay... tid register");
		rsvdMapper.updateTid(aprvNo, rsvdId);
	}
	
	@Override
	public List<StoreMenuVO> getMenuList(Long storeId) {
		
		return menuMapper.findById(storeId);
	}
	
	@Override
	public Long getRsvdId() {
		
		return rsvdMapper.getSeqRsvd();
	}
	
	
//	@Override
//	public MenuDTO findPriceByName(Long storeId, String name) {
//		// TODO Auto-generated method stub
//		log.info("find price....");
//		return menuMapper.findPriceByName(storeId, name);
//	}
	
	
	@Transactional
	@Override
	public void register(RsvdVO vo, List<RsvdDtlsVO> dtlsList) {
		
		log.info("reservation register...");
		
		//예약 등록
		rsvdMapper.insertSelectKey(vo);
		//예약 id 가져오기
		Long sequence = rsvdMapper.getSeqRsvd();
		
		//예약 메뉴가 하나이상 일 때
		if(dtlsList.size()>1) {
			
			dtlsList.forEach(dtls -> dtls.setRsvdId(sequence));
			dtlsList.forEach(dto ->log.info("======rsvd Dtls List: " + dto));
			rsvdMapper.insertDtlsList(dtlsList);
			return;
		}
			RsvdDtlsVO firstDtlsVO = dtlsList.get(0);
			log.info("======rsvd Dtls: " + firstDtlsVO);
			firstDtlsVO.setRsvdId(sequence);
			rsvdMapper.insertDtls(firstDtlsVO);
	}

	@Transactional
	@Override
	public boolean cancel(Long rsvdId) {
		// TODO Auto-generated method stub
		
		log.info("reservation remove...");
		//현재 예약이 존재하는 지 확인
		RsvdVO findRsvd = rsvdMapper.findById(rsvdId);
		log.info("========"+findRsvd);
		Optional.ofNullable(findRsvd)
		.orElseThrow(()-> new IllegalArgumentException(findRsvd+"번 예약은 존재하지 않습니다." ));
		
		//예약 상세
		List<RsvdDtlsVO> findDtlsList = rsvdMapper.findDtlsById(rsvdId);
		log.info("========"+findDtlsList);
		Optional.ofNullable(findRsvd)
		.orElseThrow(()-> new IllegalArgumentException(findRsvd+"번 예약은 존재하지 않습니다." ));
		
		if(findRsvd.getStusCd().equalsIgnoreCase("c"))
			throw new IllegalArgumentException("예약 완료된 상태에서 취소는 불가능합니다.");
		
		return rsvdMapper.delete(rsvdId) == 1 && rsvdMapper.deleteDtls(rsvdId) == findDtlsList.size();
	}

	@Override
	public boolean complete(Long rsvdId) {
		
		log.info("reservation complete ....");
		
		return rsvdMapper.completeStusUpdate(rsvdId) == 1;
	}


	private RsvdDtlsMapper rsvdDtlsMapper;
	
		
	@Override
	public RsvdVO read(long rsvdId) {
		
		return rsvdMapper.findById(rsvdId);
	}

	@Override
	public List<RsvdDtlsVO> readDetail(long rsvdId) {
		
		return rsvdDtlsMapper.findByRsvdId(rsvdId);

	}

	@Override
	public List<RsvdVO> readAllRsvdList(long storeId) {
		
		return rsvdMapper.findByStoreId(storeId);
	}

	@Override
	public List<RsvdVO> readCurRsvdList(long storeId) {
		
		return rsvdMapper.findByStoreIdAndCurStus(storeId,"C");
	}

	@Override
	public List<RsvdVO> readTodayCurRsvdList(long storeId) {
		
    	LocalDate currentDate = LocalDate.now();
    	
    	DateTimeFormatter dateTimeForMatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    	
    	String today = currentDate.format(dateTimeForMatter);
    	
    	// sorted는 뒤에가 기준이다.
		return rsvdMapper.findByStoreIdAndDate(storeId, today).stream().filter(rsvd -> rsvd.getStusCd().equals("C"))
				.sorted((r1,r2) -> (int) (r1.getRsvdId() - r2.getRsvdId()))
				.sorted((r1,r2) -> (int) calTimeMinutes(getTime(r1.getTime())) - calTimeMinutes(getTime(r2.getTime())))
				.collect(Collectors.toList());
	}
	
	@Override
	public List<RsvdVO> readTodayCurAndLastRsvdList(long storeId) {
    	
		LocalDate currentDate = LocalDate.now();
    	
    	DateTimeFormatter dateTimeForMatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    	
    	String today = currentDate.format(dateTimeForMatter);
    	
    	// sorted는 뒤에가 기준이다.
		return rsvdMapper.findByStoreIdAndDate(storeId, today).stream().filter(rsvd -> rsvd.getStusCd().equals("C") || rsvd.getStusCd().equals("L"))
				.sorted((r1,r2) -> (int) (r1.getRsvdId() - r2.getRsvdId()))
				.sorted((r1,r2) -> (int) calTimeMinutes(getTime(r1.getTime())) - calTimeMinutes(getTime(r2.getTime())))
				.collect(Collectors.toList());
	}
	
	@Override
	public List<RsvdVO> getListByDate(long storeId, String date) {
		
		return rsvdMapper.findByStoreIdAndDate(storeId, date);
	}
	
	@Override
	public String getTime(String time) {
		
//		String pattern = "HH/mm";
//		
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
//		
//		String time = simpleDateFormat.format(date);
		
		String[] times = time.split(":");
		
		String strHour = times[0].substring(times[0].length()-2);
		String minute = times[1].substring(0, 2);
		time = strHour +":"+ minute;
		
		return time;
	}
	
	@Override
	public int calTimeMinutes(String time) {
		
		String[] toMinutes = time.split(":");
		
		int minutes = Integer.valueOf(toMinutes[0]) * 60+ Integer.valueOf(toMinutes[1]);
		
		return minutes;
	}
	
	@Override
	public String toRsvdByTimeFormat(String time) {
		
		String[] times = time.split(":");
		
		String strHour = times[0];
		int minute = Integer.valueOf(times[1]);
		int result = 0;
		String strMinute ="";
		
		if(minute < 60)
			result = 30;
		if(minute < 30)
			result = 0;
		
		strMinute = Integer.toString(result);
		
		if(result == 0)
			strMinute = "0" + Integer.toString(result);
		
		
		return strHour+":"+strMinute;
	}
	
	@Override
	public HashMap<String, List<Long>> getRsvdByTimeMap(List<RsvdVO> listByDate) {
		
		HashMap<String,List<Long>> map = new HashMap<>();
		
		listByDate.stream().forEach((rsvd) -> {
			
			log.info("for each ......................");
			
			if(!rsvd.getStusCd().equalsIgnoreCase("C") && !rsvd.getStusCd().equalsIgnoreCase("L")) {
				log.info("sture cd ......" + rsvd.getStusCd());
				return;
			}
			
			log.info("stus check ......................");
			
			//String time = getTime(rsvd.getRegdate());

			//log.info("reg date............" + rsvd.getRegDate());
			
			String time = getTime(rsvd.getTime());
			
			log.info("get time ......................" + time);
			
			String fomatedTime = toRsvdByTimeFormat(time);
			
			log.info("to rsvd by time formate ......................" + fomatedTime);
			
			if(map.get(fomatedTime) == null)
				map.put(fomatedTime, new ArrayList<Long>());
				
			map.get(fomatedTime).add(rsvd.getRsvdId());
			
		});
		
		return map;
	}
	

	@Override
	public boolean isReserveThisTimeStore(long storeId, String rsvdTime,int acm) {
		
		String time = getTime(rsvdTime);
		
		String pattern = "yyyyMMdd";
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		
		List<RsvdVO> list = getListByDate(storeId, time);
		
		HashMap<String,List<Long>> map = getRsvdByTimeMap(list);
		
		time = toRsvdByTimeFormat(time);
		
		return map.get(time) == null ? true : map.get(time).size() < acm ? true : false;
	}

	@Override
	public long readNextRsvdId(HashMap<String, List<Long>> getTodayRsvdByTimeMap) {
		
		SortedSet<String> keys = new TreeSet<>(getTodayRsvdByTimeMap.keySet());
		
		Iterator it = keys.iterator();
		
		String first = "";
		
		if(it.hasNext())
			first = (String) it.next();
		
		if(first.equals(""))
			return -1;
		if(getTodayRsvdByTimeMap == null)
			return -1;
		if(getTodayRsvdByTimeMap.get(first) == null)
			return -1;
		if(getTodayRsvdByTimeMap.get(first).stream().sorted().collect(Collectors.toList()).get(0) == null)
			return -1;
		
		return getTodayRsvdByTimeMap.get(first).stream().sorted().collect(Collectors.toList()).get(0);
	}

	@Override
	public boolean isHtdl(RsvdVO rsvd) {
		
		return rsvd.getHtdlId() > 0;
	}

	@Override
	public int totalTodayRsvd(List<RsvdVO> readTodayCurRsvdList) {

		AtomicInteger cnt = new AtomicInteger();
		
		readTodayCurRsvdList.stream().forEach((rsvd)->{
			
			// C Ȥ�� L���� �Ѵ�.
			if(rsvd.getStusCd().equalsIgnoreCase("C") || rsvd.getStusCd().equalsIgnoreCase("L"))
				cnt.incrementAndGet();
				
		});
		
		return cnt.get();
	}

	@Override
	public int totalTodayRsvdPnum(List<RsvdVO> readTodayCurRsvdList) {
		
		AtomicInteger cnt = new AtomicInteger();
		
		readTodayCurRsvdList.stream().forEach((rsvd)->{
			
			if(rsvd.getStusCd().equalsIgnoreCase("C") || rsvd.getStusCd().equalsIgnoreCase("L")) {
				
				cnt.addAndGet(rsvd.getPnum());
				
			}
		});
		
		return cnt.get();
		
	}

	@Override
	public HashMap<String,Integer> todayFavMenu(long storeId) {
		
		LocalDate currentDate = LocalDate.now();
    	
    	DateTimeFormatter dateTimeForMatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    	
    	String date = currentDate.format(dateTimeForMatter);
    	/*
    	List<HashMap<String,Integer>> list = rsvdMapper.findMenuCntByStoreIdAndDate(storeId, date);
    	
    	Collections.sort(list, new Comparator<HashMap<String,Integer>>() {
    		@Override
    		public int compare(HashMap<String,Integer> m1, HashMap<String,Integer> m2) {
    			
    			String key1 = m1.keySet().iterator().next();
    			String key2 = m2.keySet().iterator().neRxt();
    			
    			return (Integer) (m1.get(key1) - m2.get(key2));
    		}
    	});
		*/
    	
    	HashMap<String,Integer> hash = new HashMap<String, Integer>();
    	
    	rsvdMapper.findMenuCntByStoreIdAndDate(storeId, date).stream().forEach((m) -> {
    		log.info("test............"+m.get("MENU_NM"));
    		log.info("test............"+m.get("COUNT(*)"));
    		hash.put((String) m.get("MENU_NM"), Integer.parseInt(m.get("COUNT(*)").toString()));
    		
    	});
		return hash;
	}



	@Override
	public List<UserWithRsvdDTO> userListTodayRsvd(long storeId) {
		
		LocalDate currentDate = LocalDate.now();
    	
    	DateTimeFormatter dateTimeForMatter = DateTimeFormatter.ofPattern("yyyyMMdd");
    	
    	String date = currentDate.format(dateTimeForMatter);
    	
    	log.info("today..................." + date);
		
		return rsvdMapper.findUserByStoreIdAndDate(storeId, date);
	}

	@Override
	public List<RsvdVO> readRsvdListByDate(long storeId, String date) {
		
		return rsvdMapper.findByStoreIdAndDate(storeId, date);
	}

	@Override
	public RsvdVO findRsvdByRsvdId(long rsvdId,List<RsvdVO> readTodayCurRsvdList) {
		
		for(RsvdVO rsvd : readTodayCurRsvdList) {
			if(rsvd.getRsvdId() == rsvdId)
				return rsvd;
		}
		
		return null;
	}

	@Override
	public RsvdVO findRsvdByRsvdIdWithDtls(long rsvdId) {
				
		return rsvdMapper.findRsvdByRsvdIdWithDtls(rsvdId);
	}

	@Override
	public List<RsvdVO> findLastWeekRsvd(long storeId) {
		
		return rsvdMapper.findLastWeekRsvdListByStoreId(storeId);
	}

	@Override
	public List<RsvdVO> findRsvdListWithPagingByUserId(String userId, Criteria cri) {

		return rsvdMapper.findRsvdListWithPagingByUserId(userId, cri);
	}

	@Override
	public List<RsvdVO> findRsvdListWithPagingAndDtlsByUserId(String userId, Criteria cri) {
		
		return rsvdMapper.findRsvdListWithPagingAndDtlsByUserId(userId, cri);
	}

	@Override
	public int getRsvdTotalCount(String userId, Criteria cri) {
		
		return rsvdMapper.getRsvdTotalCount(userId, cri);
	}

	@Override
	public int getRsvdLastCount(String userId, Criteria cri) {
		
		return rsvdMapper.getRsvdCount(userId, cri, "L");
	}

	@Override
	public int getRsvdCompleteCount(String userId, Criteria cri) {
		
		return rsvdMapper.getRsvdCount(userId, cri, "C");
	}


	@Override
	public HashMap<String, String> getTodayRsvdStusByTime(Long storeId) {
		
		String[] timeArr = {"","09:00","09:30","10:00","10:30","11:00","11:30","12:00"
		       	,"12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00",
		       	"16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00"};

		log.info("time arr length : "+timeArr.length);
		
		String[] stusArr = new String[timeArr.length];
		
		log.info("stus arr length : "+timeArr.length);
		
		int[] curNumArr = new int[timeArr.length];
		
		RsvdAvailVO rsvdAvail = getRsvdAvailByStoreId(storeId);
		
		BStoreVO bstore = bstoreMapper.findByStoreId(storeId);
		
		int acm = bstore.getAcmPnum();
		
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
					
					int rsvdPnum = acm-curPnum;
					
					//log.info("availPnum : " + availPnum);
					
					if(rsvdPnum == (acm))
						stusArr[i] = "R";
					else if(acm > rsvdPnum && rsvdPnum >= (acm*0.6))
						stusArr[i] = "Y";
					else if ((acm*0.6) > rsvdPnum && rsvdPnum > 0)
						stusArr[i] = "G";
					else if (rsvdPnum > acm)
						stusArr[i] = "B";
					else if (rsvdPnum == 0)
						stusArr[i] = "E";
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		}
		log.info("========================stusArr=======================");
		log.info(Arrays.toString(stusArr));
		log.info("======================red===================");
		log.info("red : " + acm);
		log.info("======================yellow===================");
		log.info("cur num이  : " + (acm - acm*0.6) +"보다 크면 yellow");
		log.info("available num이  : " + acm*0.6 +"보다 크면 yellow");
		log.info("======================green===================");
		log.info("acm 0 : " + 0);
		//log.info("cur stus arr : " + Arrays.toString(stusArr));
		//log.info("curNumArr : " + Arrays.toString(curNumArr));
		
		HashMap<String,String> map = new HashMap<>();
		
		for(int i = 1; i < timeArr.length; i++)
			map.put(timeArr[i], stusArr[i]);

		return map;
	}



}