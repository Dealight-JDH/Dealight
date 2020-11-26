package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.MainStoreJoinVO;
import com.dealight.domain.PageDTO;
import com.dealight.mapper.MainStoreJoinMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//현중
@Log4j
@Service
@AllArgsConstructor
public class SearchServicImpl implements SearchService {

	private MainStoreJoinMapper mMapper;



	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		
		return mMapper.getTotalCount(cri);
	}

	@Override
	public PageDTO getListstore(Criteria cri) {
		return new PageDTO(cri, mMapper.getTotalCount(cri),
					mMapper.getListWithPaging(cri));
	}
	
	@Override
	public PageDTO getListDistStore(Criteria cri) {
		return new PageDTO(cri, mMapper.getTotalCount(cri),
				mMapper.getDistWithPaging(cri));
		
	}
}
