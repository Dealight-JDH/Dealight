package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.PymtVO;
import com.dealight.mapper.PymtMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@RequiredArgsConstructor
public class PymtServiceImpl implements PymtService{

	private final PymtMapper mapper;
	

	@Transactional
	@Override
	public boolean removeCancelAll() {
		// TODO Auto-generated method stub
		
		log.info("delete cancel list...");
		List<PymtVO> lists = mapper.findCancelList();
		lists.forEach(cancelVO -> log.info(cancelVO));
		
		return mapper.deleteCancelAll() == lists.size();
	}
	
	@Override
	public List<PymtVO> getCancelList() {
		// TODO Auto-generated method stub
		log.info("pymt cancel list....");
		return mapper.findCancelList();
	}

	@Override
	public boolean stusCdModify(PymtVO vo) {
		// TODO Auto-generated method stub
		return mapper.stusCdUpdate(vo) == 1;
	}
	@Override
	public PymtVO getByRsvdId(Long rsvdId) {
		// TODO Auto-generated method stub
		log.info("find pymt by rsvdId....");
		return mapper.findByRsvdId(rsvdId);
	}
	
	@Override
	public void register(PymtVO vo) {
		// TODO Auto-generated method stub
		log.info("pymt register...");
		
		mapper.insertSelectKey(vo);
		
	}

	@Override
	public PymtVO get(Long pymtId) {
		// TODO Auto-generated method stub
		log.info("find Pymt By id...");
		
		return mapper.findById(pymtId);
	}

	@Override
	public boolean modify(PymtVO vo) {
		// TODO Auto-generated method stub
		log.info("pymt stusCd and approvedAt update...");
		
		return mapper.update(vo) == 1;
	}

	@Override
	public boolean remove(Long pymtId) {
		// TODO Auto-generated method stub
		log.info("pymt remove....");
		
		return mapper.delete(pymtId) == 1;
	}

	@Override
	public List<PymtVO> getList() {
		// TODO Auto-generated method stub
		
		log.info("pymt get List ....");
		return mapper.getList();
	}



	
	
	

	

}
