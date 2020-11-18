package com.dealight.service;

import java.util.List;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreMenuVO;

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
	
}
