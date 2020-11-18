package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreVO;
import com.dealight.mapper.BStoreMapper;
import com.dealight.mapper.StoreEvalMapper;
import com.dealight.mapper.StoreLocMapper;
import com.dealight.mapper.StoreMapper;

import lombok.AllArgsConstructor;
import lombok.Builder.ObtainVia;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class StoreServiceImpl implements StoreService {
	
	private StoreMapper sMapper;
	private BStoreMapper bMapper;
	private StoreLocMapper lMapper;
	private StoreEvalMapper eMapper;
	
	private StoreVO setId(StoreVO store) {
		
		Long storeId =store.getStoreId();
		
		//userid를 넣어줘야할 객체를 꺼낸다.
		BStoreVO bstore = store.getBstore();
		StoreLocVO loc = store.getLoc();
		StoreEvalVO eval = store.getEval();
		
		//꺼낸객체에 id를 넣어준다.
		bstore.setStoreId(storeId);
		loc.setStoreId(storeId);
		eval.setStoreId(storeId);

		//수정한 객체를 store에 넣어준다.
		store.setBstore(bstore);
		store.setLoc(loc);
		store.setEval(eval);
		
		return store;
	}
	
	@Override
	@Transactional
	public void register(StoreVO store) {
		
		//store 먼저 insert한 뒤 
		sMapper.insertSelectKey(store);
		//스토어가 생성되는 시점에는 통계정보가 없다.
		//store.setEval(new StoreEvalVO(0L,0.0,0,0));
		//store가 가진 객체들에게 storeId를 통일시켜준다.
		store = setId(store);
		
		
		//차례대로 종속테이블을 insert해준다.
		lMapper.insert(store.getLoc());
		eMapper.insert(store.getEval());
		bMapper.insert(store.getBstore());
		
		
	}

	@Override
	public StoreVO getAllInfo(Long storeId) {
		
		log.info("get............" +storeId);
		
		return sMapper.readAllInfo(storeId);
	}

	@Override
	@Transactional
	public boolean modify(StoreVO store) {
		//모든정보를 다 가지고 있어야한다.
		log.info("modify........." + store);
		
		return sMapper.update(store) + bMapper.update(store.getBstore())
				+ lMapper.update(store.getLoc()) + eMapper.update(store.getEval()) == 4;
	}

	@Override
	@Transactional
	public boolean delete(Long storeId) {
		
		log.info("delete.........");
		
		return lMapper.delete(storeId) + bMapper.delete(storeId)
				 + eMapper.delete(storeId) + sMapper.delete(storeId) == 4;
	}
	
	@Override
	public List<StoreVO> getList() {
		
		log.info("getList...............");
		
		return sMapper.getListAllInfo();
	}
	
	@Override
	public List<StoreVO> getStoreListByUserId(String userId){
		
		log.info("getStoreListByUserId...........");
		
		return sMapper.findByUserIdJoinBStore(userId);
	}

}
