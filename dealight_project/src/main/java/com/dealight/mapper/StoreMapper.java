package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.StoreVO;

/*
 * 
 *****[김동인] 
 * 
 */

public interface StoreMapper {
	
	//일단 매장을 등록하는 로직을 짜자..
		//매장을 등록하는데 단계가있어
		// mapper -> test -> service -> test -> controller -> mockMVC(test)
		//사업자매장을 집어넣으면
		//1.storeVO에 nextval해줘서 매장번호를 등록한다.(하지만 매장번호를 기억하고있어야한다.
		//2.그다음 그 매장번호로 bstore에 저장해준다.
		//3.
		
//		매장리스트를 읽어온다.
		public List<StoreVO> getList();
//		매장을 등록한다.
		public void insertSelectKey(StoreVO storeVO);
//		매장을 읽어온다.
		public StoreVO read(Long storeId);
//		매장정보를 모두 읽어온다.
		public StoreVO readAllInfo(Long storeId);
//		매장정보수정
		public int update(StoreVO storeVO);
//		매장정보삭제
		public int delete(Long storeId);
//		매장위치를 읽어온다.
		public List<StoreVO> joinLoc();
//		매장정보를 읽어온다.
		public List<StoreVO> getListAllInfo();
		
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
	
	// by store id
	// bstore, menu, eval, img, loc, tag, option
	public StoreVO findAllStoreById(long storeId);
	
}
