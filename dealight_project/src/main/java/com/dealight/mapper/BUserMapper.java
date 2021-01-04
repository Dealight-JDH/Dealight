package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;

/*
 * 
 *****[김동인] , 현중
 * 
 */

public interface BUserMapper {
	
	// create
	public void insert(BUserVO buser);
	// create and get brseq
	public void insertSelectKey(BUserVO buser);
	
	// read by brseq
	public BUserVO findBySeq(long brSeq);
	
	// read list
	public List<BUserVO> findAll();
	
	public List<BUserVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	// update
	public int update(BUserVO buser);
	
	// delete
	public int delete(long brSeq);
	
	//유저로 모록가져오기
	public List<BUserVO> findAllByUserId(String userId);
	
	// 현재 심사완료된 사업자 리스트 가져오기
	public List<BUserVO> findComBrListByUserIdAndStusCd(@Param("userId")String userId, @Param("brJdgStusCd") String brJdgStusCd);
	
	// 현재 심사 상태 변경
	public int updateBrJdgStusCd(@Param("brSeq") Long brSeq, @Param("brJdgStusCd") String brJdgStusCd);
	
	int updateStoreId(@Param("buserId") String buserId, @Param("storeId") Long storeId,@Param("storeNm") String storeNm);
}
