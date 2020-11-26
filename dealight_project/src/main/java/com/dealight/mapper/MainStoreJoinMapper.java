package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.MainStoreJoinVO;
//현중
public interface MainStoreJoinMapper {
	
	public List<MainStoreJoinVO> getList();
	
	public MainStoreJoinVO read(Long storeId);
	
//	public List<MainStoreJoinVO> findByStoreIds(List<Long> storeIds);
	
	public List<MainStoreJoinVO> getListWithPaging(Criteria cri);
	
	public List<MainStoreJoinVO> getDistWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
}
