package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.RsvdVO;
import com.dealight.domain.RevwVO;

public interface RevwMapper {
	
	// create
	
	public void insert(RevwVO revw);

	
	public void insertSelectKey(RevwVO revw);
	
	
	// read
	public RevwVO findById(long id);
	
	// read list
	public List<RevwVO> findAll();
	
	// update
	public int update(RevwVO revw);
	
	// delete
	public int delete(long id);

}
