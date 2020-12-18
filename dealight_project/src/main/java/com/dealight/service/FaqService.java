package com.dealight.service;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.FaqVO;

public interface FaqService {
	
	public void register(FaqVO faq);
	
	public FaqVO get(long faqId);
	
	public List<FaqVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public boolean modify(FaqVO faq);
	
	public boolean remove(long faqId);
	
}
