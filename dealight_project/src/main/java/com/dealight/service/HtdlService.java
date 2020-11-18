package com.dealight.service;

import java.util.List;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;

public interface HtdlService {
	
	// 핫딜 확인
	// htdl mapper read
	// select
	HtdlVO read(long htdlId);
	
	// 핫딜 상세 확인
	// htdlDtls mapper read
	// select
	List<HtdlDtlsVO> readDtls(long htdlId);
	
	// 핫딜 결과 확인
	// htdlRslt mapper read
	// select
	HtdlRsltVO readRslt(long htdlId);
	
	// 핫딜 마감 시간 카운트 다운
	// 핫딜 마감 시간 - 현재시간
	// 남은 분
	int calHtdlEndTm(HtdlVO htdl);
	
	// mapper method 필요
	// 현재 '이 매장'에 등록된 '핫딜' 리스트 '전부' 보기
	List<HtdlVO> readAllStoreHtdlList(long storeId);
	
	// mapper method 필요
	// 현재 '이 매장'에 등록된 '핫딜' 중 '활성화'상태인 리스트 보기
	// htdl_stus_cd = 'A'
	List<HtdlVO> readActStoreHtdlList(long storeId);

}
