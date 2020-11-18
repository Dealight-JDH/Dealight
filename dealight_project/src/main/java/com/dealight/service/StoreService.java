package com.dealight.service;

import java.util.Date;
import java.util.List;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.BStoreVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreVO;

public interface StoreService {
	
	// 현재 착석 상태 확인
	String getCurSeatStus(long storeId);
	
	// 착석 가능 여부 변경
	// bstore mapper update
	boolean changeSeatStus(long storeId,String seatStusCd);
	
	// 현재시간?
	Date getCurTime();
	
	StoreVO getStore(long storeId);
	
	// BStores
	StoreVO findByStoreIdWithBStore(long storeId);
	
	BStoreVO getBStore(long storeId);
	
	List<StoreVO> getStoreListByUserId(String userId);
	
	// read
	// by user id
	List<StoreVO> findByUserId(String userId);
	
	List<MenuVO> findMenuByStoreId(long storeId);
	
	void registerMenu(MenuVO menu);
	
	
	// 매장 등록하기
	void registerStoreAndBStore(StoreVO store);
	
	
	// 매장 수정하기
	// bstore 포함
	boolean modifyStore(StoreVO store);
	
	boolean modifyStore(AllStoreVO store);
	
	// 매장 모든 정보 가져오기
	AllStoreVO findAllStoreInfoByStoreId(long storeId);
	

	// ===============매장 수정 로직
	
	List<StoreImgVO> getStoreImageList(long storeId);
	
	void removeStoreImgAll(long storeId);


}
