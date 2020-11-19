package com.dealight.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwVO;
import com.dealight.domain.StoreVO;
import com.dealight.mapper.StoreMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class StoreServiceImpl implements StoreService{

	@Setter(onMethod_ = @Autowired)
	private StoreMapper mapper;

	@Override
	public StoreVO bstore(Long storeId) {
		log.info("bstore......"+storeId);
		return mapper.getBstore(storeId);
	}

	@Override
	public StoreVO nstore(Long storeId) {
		log.info("nstore......"+storeId);
		return mapper.getNstore(storeId);
	}

	@Override
	public String storeCd(Long storeId) {
		log.info("store code......"+storeId);
		return mapper.getStoreCd(storeId);
	}

}
