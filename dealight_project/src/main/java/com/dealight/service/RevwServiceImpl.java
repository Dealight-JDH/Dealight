package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwPageDTO;
import com.dealight.domain.RevwVO;
import com.dealight.mapper.RevwMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class RevwServiceImpl implements RevwService {
	
	private RevwMapper mapper;
	
//	@Override
//	public List<RevwVO> revws(Long storeId) {
//		log.info("revws............"+storeId);
//		return mapper.getRevwList(storeId);
//	}

	@Override
	public List<RevwVO> revws(Long storeId, Criteria cri) {
		log.info("revws with paging......" + storeId);

		return mapper.getRevwListWithPaging(storeId, cri);
	}

	@Override
	public RevwPageDTO getListPage(Criteria cri, Long storeId) {
		return  new RevwPageDTO(
				mapper.getCountByStoreId(storeId),
				mapper.getRevwListWithPaging(storeId, cri));
	}

}
