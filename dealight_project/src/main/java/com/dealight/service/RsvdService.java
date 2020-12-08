package com.dealight.service;

import java.util.HashMap;
import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreMenuVO;
import com.dealight.domain.UserWithRsvdDTO;

/*
 * 
 *****[김동인] 
 * 
 */
//jongwoo

public interface RsvdService {
	//실시간 예약, 특정 시간 예약
		//예약 시간, 인원수에 따라 현재 매장 예약 가능한 지 체크
		
		//, 브레이크 시간 체크
		
		//테이블 1,2,4 갯수 체크
	//착석 상태
	
	//요청 폼(예약시간,인원수,메뉴,수량,가격,핫딜메뉴,가격,총 금액)
	
	//예약을 요청한다(생성)
	void register(RsvdVO vo, List<RsvdDtlsVO> dtlsList);
	//예약을 생성한다, 예약 상세
	
	//현재 결제번호 가져온다
	//결제 완료 아닌 경우-> 예약 취소
	Long getRsvdId();
	boolean cancel(Long rsvdId);
	
	//해당 스토어 메뉴 가져오기
	List<StoreMenuVO> getMenuList(Long storeId);
	
	//메뉴에 해당하는 가격 조회
//	MenuDTO findPriceByName(Long storeId, String name);
		
	//결제 서비스
	//결제 준비
	//결제 진행중
	//결제 완료
	
	//예약 완료(상태코드 업데이트)
	void complete(Long rsvdId);
	
	//테이블 갯수 업데이트
	//해당 핫딜이 있을 경우 핫딜 예약 인원 업데이트
	final static int timeGap = 30;
	
	// reservation mapper read
	// select
	RsvdVO read(long rsvdId);

	// reservation detail mapper read
	// select
	List<RsvdDtlsVO> readDetail(long rsvdId);
	
	// read list
	List<RsvdVO> readAllRsvdList(long storeId);
	
	// read list
	// rsvd_stus = "c"
	List<RsvdVO> readCurRsvdList(long storeId);
	
	// time = today
	List<RsvdVO> readTodayCurRsvdList(long storeId);
	
	// read
	List<RsvdVO> readRsvdListByDate(long storeId,String date);

	// read
	RsvdVO findRsvdByRsvdIdWithDtls(long rsvdId);

	// 현재 스토어에 예약이 가능한지
	boolean isReserveThisTimeStore(long storeId, String rsvdTime, int acm);
	
	// date의 시간을 String time (HH:mm)으로 변환
	// 00:00 -> 0
	// 12:30 -> 12*60 + 30-> 720 + 30 == 750
	String getTime(String time);
	
	// String 시간을 seconds로 변환, 계산에 용이
	// 00:00 -> 0
	// 12:30 -> 12*60 + 30-> 720 + 30 == 750
	int calTimeMinutes(String time);

	// 해당 '매장'의 해당 '시간' 예약 리스트를 가져온다.
	List<RsvdVO> getListByDate(long storeId,String date);
	
	// 시간 Map 형식으로 rsvd를 가져온다.
	// HashMap<String rsvdByTime,int count>.
	HashMap<String,List<Long>> getRsvdByTimeMap(List<RsvdVO> listByDate);
	
	
	// hour = hour
	// if minute < 60 -> 45
	// 		minute < 45 -> 30
	// 		minute < 30 -> 15
	// 		minute < 15 -> 00
	// String rsvdByTime = hour.toString() + ":" + minute.toString()
	String toRsvdByTimeFormat(String time);
	
	long readNextRsvdId(HashMap<String, List<Long>> getTodayRsvdByTimeMap);
	
	boolean isHtdl(RsvdVO rsvd);
	
	RsvdVO findRsvdByRsvdId(long rsvdId, List<RsvdVO> readTodayCurRsvdList);
	
	int totalTodayRsvd(List<RsvdVO> readTodayCurRsvdList);
	
	int totalTodayRsvdPnum(List<RsvdVO> readTodayCurRsvdList);
	
	HashMap<String,Integer> todayFavMenu(long storeId);
	
	List<UserWithRsvdDTO> userListTodayRsvd(long storeId);
	
	List<RsvdVO> findLastWeekRsvd(long storeId);
	
	List<RsvdVO> findRsvdListWithPagingByUserId(String userId, Criteria cri);
	
	List<RsvdVO> findRsvdListWithPagingAndDtlsByUserId(String userId, Criteria cri);
	
	int getRsvdTotalCount(String userId, Criteria cri);
	
	int getRsvdLastCount(String userId, Criteria cri);
	
	int getRsvdCompleteCount(String userId, Criteria cri);
	
}
