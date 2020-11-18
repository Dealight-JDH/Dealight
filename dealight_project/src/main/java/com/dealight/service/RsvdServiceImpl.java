package com.dealight.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreMenuVO;
import com.dealight.mapper.RsvdMapper;
import com.dealight.mapper.StoreMenuMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class RsvdServiceImpl implements RsvdService{

	private final RsvdMapper rsvdMapper;
	private final StoreMenuMapper menuMapper;
	
	@Override
	public List<StoreMenuVO> getMenuList(Long storeId) {
		// TODO Auto-generated method stub
		
		return menuMapper.findById(storeId);
	}

	
	@Override
	public Long getRsvdId() {
		// TODO Auto-generated method stub
		return rsvdMapper.getSeqRsvd();
	}
	
	
//	@Override
//	public MenuDTO findPriceByName(Long storeId, String name) {
//		// TODO Auto-generated method stub
//		log.info("find price....");
//		return menuMapper.findPriceByName(storeId, name);
//	}
	
	
	@Transactional
	@Override
	public void register(RsvdVO vo, List<RsvdDtlsVO> dtlsList) {
		// TODO Auto-generated method stub
		
		log.info("reservation register...");
		
		//예약 등록
		rsvdMapper.insertSelectKey(vo);
		//예약 id 가져오기
		Long sequence = rsvdMapper.getSeqRsvd();
		
		//예약 메뉴가 하나이상 일 때
		if(dtlsList.size()>1) {
			
			dtlsList.forEach(dtls -> dtls.setRsvdId(sequence));
			rsvdMapper.insertDtlsList(dtlsList);
			return;
		}
			RsvdDtlsVO firstDtlsVO = dtlsList.get(0);
			firstDtlsVO.setRsvdId(sequence);
			rsvdMapper.insertDtls(firstDtlsVO);
	}

	@Transactional
	@Override
	public boolean cancel(Long rsvdId) {
		// TODO Auto-generated method stub
		
		log.info("reservation remove...");
		//현재 예약이 존재하는 지 확인
		RsvdVO findRsvd = rsvdMapper.findById(rsvdId);
		log.info("========"+findRsvd);
		Optional.ofNullable(findRsvd)
		.orElseThrow(()-> new IllegalArgumentException(findRsvd+"번 예약은 존재하지 않습니다." ));
		
		//예약 상세
		List<RsvdDtlsVO> findDtlsList = rsvdMapper.findDtlsById(rsvdId);
		log.info("========"+findDtlsList);
		Optional.ofNullable(findRsvd)
		.orElseThrow(()-> new IllegalArgumentException(findRsvd+"번 예약은 존재하지 않습니다." ));
		
		if(findRsvd.getStusCd().equalsIgnoreCase("c"))
			throw new IllegalArgumentException("예약 완료된 상태에서 취소는 불가능합니다.");
		
		return rsvdMapper.delete(rsvdId) == 1 && rsvdMapper.deleteDtls(rsvdId) == findDtlsList.size();
	}

	@Override
	public void complete(Long rsvdId) {
		// TODO Auto-generated method stub
		
	}


	
	

}
