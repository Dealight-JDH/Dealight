package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.QnAVO;
import com.dealight.mapper.QnAMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class QnAServiceImpl implements QnAService {

	private QnAMapper mapper;
	
	@Override
	public void register(QnAVO qna) {
		log.info("register FAQ : " + qna);
		
		mapper.insertSelectKey(qna);
		
		log.info("qnaId : " + qna.getQnaId());
		
	}

	@Override
	public void registerWithOrd(QnAVO qna) {
		
		log.info("register FAQ : " + qna);
		
		mapper.insertWithOrd(qna);
		
		log.info("qnaId : " + qna.getQnaId());
		log.info("qnaOrd : " + qna.getQnaOrd());
	}

	@Override
	public List<QnAVO> get(long qnaId) {
		log.info("get by qnaId : " + qnaId);
		
		List<QnAVO> list = mapper.read(qnaId);
		
		list.forEach(qna -> log.info(qna));
		
		return list;
	}
	
	@Override
	public QnAVO getWithOrd(long qnaId, int qnaOrd) {
		log.info("get by qnaord : "+ qnaOrd);
		
		return mapper.readWithOrd(qnaId, qnaOrd);
	}

	@Override
	public List<QnAVO> getList(Criteria cri) {
		log.info("get List by Cri : " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total by cri : " + cri);

		return mapper.getTotalCount(cri);
	}

	@Override
	public boolean modify(QnAVO qna) {
		log.info("modify : " + qna);
		
		return mapper.update(qna) == 1 ? true : false;
	}

	@Override
	public boolean remove(long qnaId, int qnaOrd) {
		log.info("delete by qnaId : " + qnaId);
		
		return mapper.delete(qnaId, qnaOrd) == 1 ? true : false;
	}

}
