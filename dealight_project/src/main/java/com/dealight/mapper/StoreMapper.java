package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.StoreDTO;
import com.dealight.domain.StoreVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface StoreMapper {
	
	//종우
	List<StoreDTO> storeList();
	StoreDTO findByStoreId(Long storeId);
	
	List<StoreVO> findStoreListWithPaging(Criteria cri);
	
	int getTotalCnt(Criteria cri);
	
//	매장리스트를 읽어온다.
	public List<StoreVO> getList();
//	매장을 등록한다.
	public void insertSelectKey(StoreVO storeVO);
//	매장을 읽어온다.
	public StoreVO read(Long storeId);
//	매장정보를 모두 읽어온다.
	public StoreVO readAllInfo(Long storeId);
//	매장정보를 읽어온다.
	public List<StoreVO> getListAllInfo();
//	매장정보수정
	public int update(StoreVO storeVO);
//	매장정보삭제
	public int delete(Long storeId);
//	매장위치를 읽어온다.(불필요)
	
	public List<StoreVO> findByUserIdJoinBStore(String userId);
	
	public StoreVO getBstore(Long storeId);
	
	public StoreVO getNstore(Long storeId);
	
	
//	public String getStoreCd(Long storeId);
	//Create
	public void insert(StoreVO store);
	
	// join
	public StoreVO findByIdJoinNStore(long storeId);
	// join
	public StoreVO findByIdJoinBStore(long storeId);
	
	// by user id
	public List<StoreVO> findByUserId(String userId);
	
	
	public StoreVO findStoreWithLocByStoreId(Long storeId);
	
	public StoreVO findStoreWithBstoreAndLocByStoreId(Long storeId);
	
	int suspendStore(Long storeId);
	
}
