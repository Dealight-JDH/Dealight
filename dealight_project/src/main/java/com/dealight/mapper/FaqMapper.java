package com.dealight.mapper;

import java.util.List;

import com.dealight.domain.Criteria;
import com.dealight.domain.FaqVO;

public interface FaqMapper {

	//FAQ생성
	public void insertSelectKey(FaqVO faq);
	//FAQ조회
	public FaqVO read(long faqId);
	//FAQ리스트(페이징처리, 필터처리)
	public List<FaqVO> getListWithPaging(Criteria cri);
	//수정
	public int update(FaqVO faq);
	//삭제
	public int delete(long faqId);
	//총개수 
	public int getTotalCount(Criteria cri);

}
