package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.FaqVO;
import com.dealight.mapper.FaqMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class FaqServiceImpl implements FaqService {

	private FaqMapper mapper;
	
	@Override
	public void register(FaqVO faq) {
		log.info("register FAQ : " + faq);
		
		mapper.insertSelectKey(faq);
		
		log.info("faqId : " + faq.getFaqId());
		
	}

	@Override
	public FaqVO get(long faqId) {
		log.info("get by faqId : " + faqId);
		
		FaqVO faq = mapper.read(faqId);
		
		log.info(faq);
		
		return faq;
	}

	@Override
	public List<FaqVO> getList(Criteria cri) {
		log.info("get List by Cri : " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total by cri : " + cri);

		return mapper.getTotalCount(cri);
	}

	@Override
	public boolean modify(FaqVO faq) {
		log.info("modify : " + faq);
		
		return mapper.update(faq) == 1 ? true : false;
	}

	@Override
	public boolean remove(long faqId) {
		log.info("delete by faqId : " + faqId);
		
		return mapper.delete(faqId) == 1 ? true : false;
	}

}
