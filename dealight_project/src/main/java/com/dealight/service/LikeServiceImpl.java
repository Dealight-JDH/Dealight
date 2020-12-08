package com.dealight.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.LikeVO;
import com.dealight.mapper.LikeMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class LikeServiceImpl implements LikeService {

	@Autowired
	LikeMapper likeMapper;
	
	@Override
	public void pick(LikeVO like) {
		
		likeMapper.insert(like);

	}

	@Override
	public boolean cancel(String userId, Long storeId) {
		
		return 1 == likeMapper.delete(userId, storeId);
	}

	@Override
	public LikeVO findByUserIdAndStoreId(String userId, Long storeId) {

		return likeMapper.findByUserIdAndStoreId(userId, storeId);
	}

	@Override
	public List<LikeVO> findListByUserId(String userId) {
		
		return likeMapper.findListByUserId(userId);
	}

	@Override
	public List<LikeVO> findListByStoreId(Long storeId) {
		
		return likeMapper.findListByStoreId(storeId);
	}

	@Override
	public List<LikeVO> findListWithPagingByUserId(String userId, Criteria cri) {

		return likeMapper.findListWithPagingByUserId(userId, cri);
	}

	@Override
	public int getLikeTotalByUserId(String userId, Criteria cri) {
		
		return likeMapper.getLikeTotal(userId, cri);
	}

}
