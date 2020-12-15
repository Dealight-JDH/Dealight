package com.dealight.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dealight.domain.Criteria;
import com.dealight.domain.QnAVO;

public interface QnAMapper {

	public void insertSelectKey(QnAVO qna);
	
	public void insertWithOrd(QnAVO qna);
	
	public List<QnAVO> read(long qnaId);
	
	public QnAVO readWithOrd(@Param("qnaId")long qnaId, @Param("qnaOrd") int qnaOrd);
	
	public List<QnAVO> getListWithPaging(Criteria cri);
	
	public int update(QnAVO qna);
	
	public int delete(@Param("qnaId")long qnaId, @Param("qnaOrd") int qnaOrd);
	
	public int getTotalCount(Criteria cri);
}
