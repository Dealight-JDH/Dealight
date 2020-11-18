package com.dealight.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.UserWithRsvdDTO;
import com.dealight.mapper.RsvdDtlsMapper;
import com.dealight.mapper.RsvdMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RsvdServiceImpl implements RsvdService {

	@Autowired
	private RsvdMapper rsvdMapper;
	
	@Autowired
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
		
		return rsvdMapper.findByStoreIdToday(storeId, today);
	}
	
	@Override
	public List<RsvdVO> getListByDate(long storeId, String date) {
		
		return rsvdMapper.findByStoreIdAndDate(storeId, date);
	}
	
	@Override
	public String getTime(Date date) {
		
		String pattern = "HH:mm";
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		
		String time = simpleDateFormat.format(date);
		
		return time;
	}
	
	@Override
	public int calTimeMinutes(String time) {
		
		String[] toMinutes = time.split(":");
		
		int minutes = Integer.valueOf(toMinutes[0]) * 60+ Integer.valueOf(toMinutes[1]);
		
		return minutes;
	}
	
	// time = "yyyyMMdd"
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
			
			// C���� �ȴ�.
			if(!rsvd.getStusCd().equalsIgnoreCase("C"))
				return;
			
			String time = getTime(rsvd.getRegDate());
			String fomatedTime = toRsvdByTimeFormat(time);
			
			if(map.get(fomatedTime) == null)
				map.put(fomatedTime, new ArrayList<Long>());
				
			map.get(fomatedTime).add(rsvd.getRsvdId());
			
		});
		
		return map;
	}
	

	@Override
	public boolean isReserveThisTimeStore(long storeId, Date date,int acm) {
		
		//log.info("test..................date" + date);
		
		String time = getTime(date);
		
		//log.info("test..................time" + time);
		
		String pattern = "yyyyMMdd";
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		
		//log.info("test.....................date"+simpleDateFormat.format(date));
		
		List<RsvdVO> list = getListByDate(storeId, simpleDateFormat.format(date));
		
		//log.info("test..................list" + list);
		
		HashMap<String,List<Long>> map = getRsvdByTimeMap(list);
		
		//log.info("test..................map" + map);
		
		time = toRsvdByTimeFormat(time);
		
		//log.info("test..................time" + time);
		
		//log.info("test..................map.get(time) : " + map.get(time));
		
		//return false;
		
		return map.get(time) == null ? true : map.get(time).size() < acm ? true : false;
	}

	@Override
	public long readNextRsvdId(HashMap<String, List<Long>> getTodayRsvdByTimeMap) {
		
		//log.info("Test.................." + getTodayRsvdByTimeMap);
		
		SortedSet<String> keys = new TreeSet<>(getTodayRsvdByTimeMap.keySet());
		
		//log.info("Test.................." + getTodayRsvdByTimeMap);
		
		/*
		
		log.info("test..............................."+keys);
		
		Iterator<String> it = keys.iterator();
		
		while(it.hasNext()) {
			
			String key = it.next();
			
			map.get(key).stream().forEach(rsvdId -> {
				
				log.info("test...............key : " + key);
				log.info("test...............rsvdId : "+rsvdId);
				
			});;
			
		}
		*/
		
		//log.info("Test........................keys : " + keys);
		
		Iterator it = keys.iterator();
		
		String first = "";
		
		if(it.hasNext())
			first = (String) it.next();
		
		//log.info("Test......................first" + first);
		
		//log.info("test................keys it next : "+getTodayRsvdByTimeMap.get(first));
		
		// ���� ���� ����� ������ -1����
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
			
			// C Ȥ�� L�̾�� �Ѵ�.
			if(rsvd.getStusCd().equalsIgnoreCase("C") || rsvd.getStusCd().equalsIgnoreCase("L")) {
				
				cnt.addAndGet(rsvd.getPnum());
				
			}
		});
		
		return cnt.getAcquire();
		
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
}
