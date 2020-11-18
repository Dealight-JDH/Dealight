package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;

public interface RsvdMapper {

	//예약 mapper
	void insert(RsvdVO vo);
	void insertSelectKey(RsvdVO vo);
	RsvdVO findById(Long rsvdId);
	int update(RsvdVO vo);
	int delete(Long rsvdId);
	List<RsvdVO> getList();
	
	Long getSeqRsvd();
	Long getDaySeqRsvd();
	
	//예약 상세 mapper
	void insertDtls(RsvdDtlsVO vo);
	void insertDtlsList(List<RsvdDtlsVO> dtlsList);
	List<RsvdDtlsVO> findDtlsById(Long rsvdId);
	int updateDtls(RsvdDtlsVO vo);
	int deleteDtls(Long rsvdId);
	
	//예약+상세
	
	
}
