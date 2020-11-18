package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.BUserVO;
import com.dealight.domain.HtdlVO;

public interface HtdlMapper {
	
	// create
	public void insert(HtdlVO htdl);
	
	public void insertSelectKey(HtdlVO htdl);
	
	// read
	public HtdlVO findById(long htdlId);
	
	// read
	// by store id
	public List<HtdlVO> findByStoreId(long storeId);
	
	// read
	// by store id
	public List<HtdlVO> findByStoreIdStusCd(@Param("storeId")long storeId,@Param("stusCd") String stusCd);
	
	// read list
	public List<HtdlVO> findAll();
	
	// update
	public int update(HtdlVO htdl);
	
	// delete
	public int delete(long htdlId);

}
