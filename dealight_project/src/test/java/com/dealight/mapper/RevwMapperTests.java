package com.dealight.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RevwMapperTests {
	
	@Setter(onMethod_ =@Autowired )
	private RevwMapper mapper;
	
	@Test
	public void testGetRevwListWithPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		List<RevwVO> revws = mapper.getRevwListWithPaging(4L,cri);
		revws.forEach(revw -> log.info(revw));
	}
	

}
