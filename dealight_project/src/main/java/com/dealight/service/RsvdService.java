package com.dealight.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.UserWithRsvdDTO;

public interface RsvdService {
	
	final static int timeGap = 30;
	
	// '예약' 확인
	// reservation mapper read
	// select
	RsvdVO read(long rsvdId);

	// '예약 상세' 확인
	// reservation detail mapper read
	// select
	List<RsvdDtlsVO> readDetail(long rsvdId);
	
	// 추가 mapper method 필요 - 추가 완료
	// '매장'의 '예약 리스트' 확인하기
	// 예약 히스토리
	// read list
	List<RsvdVO> readAllRsvdList(long storeId);
	
	// 추가 mapper method 필요
	// '매장'의 '현재예약'중인 '예약리스트'확인하기
	// read list
	// rsvd_stus = "c"
	List<RsvdVO> readCurRsvdList(long storeId);
	
	// 추가 mapper method 필요
	// '매장'의 '오늘'의 '예약리스트'확인하기
	// 지금 당장은 당일예약만 있으므로 크게 상관 x
	// time = today
	List<RsvdVO> readTodayCurRsvdList(long storeId);
	
	// read
	List<RsvdVO> readRsvdListByDate(long storeId,String date);

	// read
	RsvdVO findRsvdByRsvdIdWithDtls(long rsvdId);
	
	// 예약 가능여부 판단하기
	// "이 시간"에 "이 매장"에서 예약이 가능한지
	// rsvd_stus = "c", time = this time
	// acm는 한 매장의 총 예약 가능 인원
	// *******acm는 매장의 예약 가능 인원으로 변경해야함
	boolean isReserveThisTimeStore(long storeId, Date date, int acm);
	
	// time으로 받은 string 타임을 second로 계산
	// 00:00 -> 0
	// 12:30 -> 12*60 + 30-> 720 + 30 == 750
	String getTime(Date date);
	
	// time으로 받은 string 타임을 second로 계산
	// 00:00 -> 0
	// 12:30 -> 12*60 + 30-> 720 + 30 == 750
	int calTimeMinutes(String time);
	
	// 날짜별 예약 리스트
	// mapper 추가
	// date 의 형식은 "yyyyMMdd"
	List<RsvdVO> getListByDate(long storeId,String date);
	
	// 시간대별 예약 리스트
	// map으로 해야하나?
	// 15분 단위로 넣기
	// HashMap<String rsvdByTime,int count>.
	HashMap<String,List<Long>> getRsvdByTimeMap(List<RsvdVO> listByDate);
	
	
	// hour = hour
	// if minute < 60 -> 45
	// 		minute < 45 -> 30
	// 		minute < 30 -> 15
	// 		minute < 15 -> 00
	// String rsvdByTime = hour.toString() + ":" + minute.toString()
	String toRsvdByTimeFormat(String time);
	
	
	// 바로 다음 예약 확인하기
	// 시간순으로 정렬해야함
	long readNextRsvdId(HashMap<String, List<Long>> getTodayRsvdByTimeMap);
	
	
	// 핫딜인지 아닌지 확인하기
	boolean isHtdl(RsvdVO rsvd);
	
	RsvdVO findRsvdByRsvdId(long rsvdId, List<RsvdVO> readTodayCurRsvdList);
	
	
	// ===============당일 현황판 로직
	
	// 당일 예약 접수 합계
	int totalTodayRsvd(List<RsvdVO> readTodayCurRsvdList);
	
	// 당일 예약 인원 합계
	int totalTodayRsvdPnum(List<RsvdVO> readTodayCurRsvdList);
	
	// 당일 선호 메뉴
	HashMap<String,Integer> todayFavMenu(long storeId);
	
	// 당일 예약 고객 리스트
	List<UserWithRsvdDTO> userListTodayRsvd(long storeId);
	
	// 주 이용 시간대
	// 일단 제외
	
	// 일별 예약 추이(일주일)
	//일단 제외
	
	
	List<RsvdVO> findLastWeekRsvd(long storeId);
	
}
