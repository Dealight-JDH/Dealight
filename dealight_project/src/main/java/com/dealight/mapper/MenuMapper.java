package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.HtdlVO;
import com.dealight.domain.MenuVO;

public interface MenuMapper {
	
	// create
	public void insert(MenuVO menu);
	
	public void insertSelectKey(MenuVO menu);
	
	
	// read
	public MenuVO findBySeq(Long menuSeq);
	
	// read list
	public List<MenuVO> findAll();
	
	public List<MenuVO> findByStoreId(Long storeId);
	
	// update
	public int update(MenuVO menu);
	
	// delete
	public int delete(Long menuSeq);

}
