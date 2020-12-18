package com.dealight.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.Criteria;
import com.dealight.domain.FaqVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FaqMapperTests {

	@Setter(onMethod_ = @Autowired)
	private FaqMapper mapper;
	
	@Test
	public void testInsertSelectKey() {
		
		FaqVO faq = new FaqVO();
		faq.setAdminId("aaaa");
 		faq.setFaqCnts("이렇게 저렇게 하시면됩니다.");
 		faq.setFaqTitle("탈퇴는 어떻게?..");
 		faq.setQClsCd("C");
 		
 		log.info("Before insert faq : " + faq);
 		
 		mapper.insertSelectKey(faq);
		
 		log.info("After insert faq : " + faq);
	}
	
	@Test
	public void testRead() {
		
		log.info("read by faqId...........");
		
		log.info(mapper.read(1));
	}
	
	@Test
	public void testGetListWithPaging() {
		
		log.info("get List with paging..........no sort");
		
		Criteria cri = new Criteria();
		cri.setAmount(10);
		cri.setPageNum(1);
		cri.setKeyword("취");
		
		mapper.getListWithPaging(cri).forEach(faq -> log.info(faq));
		
	}
	
	@Test
	public void testUpdate() {
		log.info("update....................");
		
		FaqVO faq = new FaqVO();
		
		faq.setAdminId("aaaa");
		faq.setFaqCnts("안물 안궁");
		faq.setFaqId(3L);
		faq.setFaqTitle("예약취소가안되요...");
		faq.setQClsCd("R");
		
		
		log.info("faq : " + faq);
		
		log.info(mapper.update(faq)==1);
		
	}
	
	@Test
	public void testDelete() {
		log.info("delete...................");
		
		log.info(".............." + (mapper.delete(6L)==1));
	}
	
	@Test
	public void testGetTotalCount() {
		
		log.info("get Total Count ............");
		Criteria cri = new Criteria();
		log.info(mapper.getTotalCount(cri));
	}
}
