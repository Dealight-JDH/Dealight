package com.dealight.service;

import java.util.Date;
import java.util.List;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.BStoreVO;
import com.dealight.domain.MenuVO;
import com.dealight.domain.StoreImgVO;
import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwVO;
import com.dealight.domain.StoreVO;

public interface StoreService {

	
	public void register(StoreVO store);
	
	public StoreVO getAllInfo(Long storeId);
	
	public boolean modify(StoreVO store);
	
	public boolean delete(Long StoreId);
	
	public List<StoreVO> getList();
	
	public List<StoreVO> getStoreListByUserId(String userId);
	
	
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

	public StoreVO nstore(Long storeId);
	
	public StoreVO bstore(Long storeId);
	
	public String storeCd(Long storeId);
	
}