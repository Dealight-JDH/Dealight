package com.dealight.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

import com.dealight.domain.Criteria;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreMenuVO;
import com.dealight.domain.UserWithRsvdDTO;
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
			rsvdMapper.insertDtlsList(dtlsList);
			return;
		}
			RsvdDtlsVO firstDtlsVO = dtlsList.get(0);
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
	public void complete(Long rsvdId) {
		
//		rsvdMapper.update(rsvd)
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
			result = 45;
		if(minute < 45)
			result = 30;
		if(minute < 30)
			result = 15;
		if(minute < 15)
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
			
			if(!rsvd.getStusCd().equalsIgnoreCase("C")) {
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


	
}