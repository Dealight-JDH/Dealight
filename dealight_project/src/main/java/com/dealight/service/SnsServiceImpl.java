package com.dealight.service;

import org.springframework.stereotype.Service;

import com.dealight.domain.SnsVO;
import com.dealight.mapper.SnsMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class SnsServiceImpl implements SnsService {

	
	private final SnsMapper mapper;
	
	@Override
	public void register(SnsVO vo) {
		// TODO Auto-generated method stub
		log.info("sns user register...");
		
		mapper.insert(vo);
	}

	@Override
	public SnsVO read(String userId) {
		// TODO Auto-generated method stub
		log.info("sns user read...");
		return mapper.findById(userId);
	}

}
