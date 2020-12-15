package com.dealight.service;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.QnAVO;

public interface QnAService {
	
	public void register(QnAVO qna);
	
	public void registerWithOrd(QnAVO qna);
	
	public List<QnAVO> get(long qnaId);
	
	public QnAVO getWithOrd(long qnaId, int qnaOrd);
	
	public List<QnAVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public boolean modify(QnAVO qna);
	
	public boolean remove(long qnaId, int qnaOrd);
}
