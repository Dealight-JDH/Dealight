package com.dealight.service;

import java.util.Date;
import java.util.List;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.BStoreVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreVO;

public interface StoreService {
	
	// ���� ���� ���� Ȯ��
	String getCurSeatStus(long storeId);
	
	// ���� ���� ���� ����
	// bstore mapper update
	boolean changeSeatStus(long storeId,String seatStusCd);
	
	// ����ð�?
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
	
	
	// ���� ����ϱ�
	void registerStoreAndBStore(StoreVO store);
	
	
	// ���� �����ϱ�
	// bstore ����
	boolean modifyStore(StoreVO store);
	
	boolean modifyStore(AllStoreVO store);
	
	// ���� ��� ���� ��������
	AllStoreVO findAllStoreInfoByStoreId(long storeId);
	

	// ===============���� ���� ����
	
	List<StoreImgVO> getStoreImageList(long storeId);
	
	void removeStoreImgAll(long storeId);


}
