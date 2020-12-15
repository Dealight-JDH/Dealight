package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;
import com.dealight.mapper.BUserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BizAuthServiceImpl implements BizAuthService {

	private BUserMapper mapper;
	
	@Override
	public void register(BUserVO buser) {
		
		log.info("register : " + buser);
		
		mapper.insertSelectKey(buser);
	}

	@Override
	public BUserVO read(long brSeq) {
		
		log.info("read by brseq : " + brSeq);
		
		return mapper.findBySeq(brSeq);
	}

	@Override
	public List<BUserVO> getList() {

		log.info("getList.................");
		
		
		return mapper.findAll();
	}
	
	@Override
	public List<BUserVO> getListWithCri(Criteria cri){
		
		log.info("getList with cri : " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public List<BUserVO> getListByUserId(String userId){
		log.info("getListByUserId : " + userId);	
		
		return mapper.findAllByUserId(userId);
	}

	@Override
	public boolean modify(BUserVO buser) {
		
		log.info("modify.........." + buser);
		
		return mapper.update(buser) == 1;
	}

	@Override
	public boolean delete(long brSeq) {

		log.info("delete.........." + brSeq);
		
		return mapper.delete(brSeq) == 1;
	}

	@Override
	public boolean updateStusCdToB(Long brSeq) {

		return 1 == mapper.updateBrJdgStusCd(brSeq, "B");
	}

}
