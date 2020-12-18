package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.Criteria;
import com.dealight.domain.QnAVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class QnAMapperTests {

	@Setter(onMethod_ = @Autowired)
	private QnAMapper mapper;
	
	@Test
	public void testInsertSelectKey() {
		
		QnAVO qna = new QnAVO();
		qna.setUserId("aaaa");
 		qna.setQnaCnts("예약취소 어떻게해용??");
 		qna.setQnaTitle("질문잇는데?");
 		qna.setQClsCd("C");
 		qna.setQnaOrd(0);
 		
 		log.info("Before insert qna : " + qna);
 		
 		mapper.insertSelectKey(qna);
		
 		log.info("After insert qna : " + qna);
	}
	
	@Test
	public void testInsertWithOrd() {
		QnAVO qna = new QnAVO();
		qna.setQnaId(4L);
		qna.setUserId("aaaa");
 		qna.setQnaCnts("이렇게 저렇게 하시면됩니다.");
 		qna.setQnaTitle("질문잇는데?");
 		qna.setQClsCd("C");
 		
 		mapper.insertWithOrd(qna);
 		log.info(qna);
	}
	
	@Test
	public void testRead() {
		
		log.info("read by qnaId...........");
		
		log.info(mapper.read(2));
	}
	
	@Test
	public void testGetListWithPaging() {
		
		log.info("get List with paging..........no sort");
		
		Criteria cri = new Criteria();
		cri.setAmount(10);
		cri.setPageNum(1);
		cri.setKeyword("취");
		
		mapper.getListWithPaging(cri).forEach(qna -> log.info(qna));
		
	}
	
	@Test
	public void testUpdate() {
		log.info("update....................");
		
		QnAVO qna = new QnAVO();
		
		qna.setUserId("aaaa");
		qna.setQnaCnts("안물 안궁");
		qna.setQnaId(3L);
		qna.setQnaTitle("예약취소가안되요...");
		qna.setQClsCd("R");
		
		
		log.info("qna : " + qna);
		
		log.info(mapper.update(qna)==1);
		
	}
	
	
	@Test
	public void testGetTotalCount() {
		
		log.info("get Total Count ............");
		Criteria cri = new Criteria();
		log.info(mapper.getTotalCount(cri));
	}
}
