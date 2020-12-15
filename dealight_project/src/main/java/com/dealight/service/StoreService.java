package com.dealight.service;

import java.util.Date;
import java.util.List;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.BStoreVO;
import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.MenuVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface StoreService {

	
	public void register(StoreVO store);
	
	public StoreVO getAllInfo(Long storeId);
	
	public boolean modify(StoreVO store);
	
	public boolean delete(Long StoreId);
	
	public List<StoreVO> getList();
	
	public List<StoreVO> getStoreListByUserId(String userId);
	
	
	String getCurSeatStus(long storeId);
	
	// bstore mapper update
	boolean changeSeatStus(long storeId,String seatStusCd);
	
	Date getCurTime();
	
	StoreVO getStore(long storeId);
	
	StoreVO findByStoreIdWithBStore(long storeId);
	
	BStoreVO getBStore(long storeId);
	
	
	// read
	// by user id
	List<StoreVO> findByUserId(String userId);
	
	List<MenuVO> findMenuByStoreId(long storeId);
	
	void registerMenu(MenuVO menu);
	
	void registerStoreAndBStore(StoreVO store);
	
	boolean modifyStore(StoreVO store);
	
	boolean modifyStore(AllStoreVO store);
	
	AllStoreVO findAllStoreInfoByStoreId(long storeId);
	
	List<StoreImgVO> getStoreImageList(long storeId);
	
	void removeStoreImgAll(long storeId);

	public StoreVO nstore(Long storeId);
	
	public StoreVO bstore(Long storeId);
	
	//public String storeCd(Long storeId);
	
	
	public StoreLocVO getStoreLoc(Long storeId);
	
	public int modifyMenu(MenuVO menu);
	
	public boolean deleteMenu(Long menuSeq);
	
	public StoreVO findStoreWithLocByStoreId(Long storeId);
	
	public StoreVO findStoreWithBStoreAndLocByStoreId(Long storeId);
	
	boolean suspendStore(Long storeId);
	
	List<StoreVO> findStoreListWithPaging(Criteria cri);
	
	int getTotalCnt(Criteria cri);
	
	StoreEvalVO getEval(Long storeId);
	
	
	List<BUserVO> comBrListByUserId(String userId);
	
}
