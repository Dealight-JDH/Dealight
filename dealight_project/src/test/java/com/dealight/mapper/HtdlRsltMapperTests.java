package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.BUserVO;
import com.dealight.domain.HtdlRsltVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class HtdlRsltMapperTests {
	
    private long htdlId = 5;
    private long storeId = 13;
    private int lastPnum = 30;
    private int htdlLmtPnum = 50;
    private double rsvdRate = 0.5;
    private String elapTm = "30:00";
    
    @Autowired
    private HtdlRsltMapper mapper;

    // create
    @Test
    public void insertTest1() {
    	HtdlRsltVO htdlRslt = new HtdlRsltVO().builder()
				.htdlId(htdlId)
				.storeId(storeId)
				.lastPnum(lastPnum)
				.htdlLmtPnum(htdlLmtPnum)
				.rsvdRate(rsvdRate)
				.elapTm(elapTm)
				.build();
    	
    	List<HtdlRsltVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insert(htdlRslt);

    	list = mapper.findAll();
    	
    	assertTrue(list.size() == bf + 1);
    	
    	
    }
    

    
    // read
    @Test
    public void findTest1() {
    	
    	HtdlRsltVO htdlRs = mapper.findById(htdlId);
    	
    	assertNotNull(htdlRs);
    	
    }
    
    
    // read list
    @Test
    public void findAllTest1() {
    	List<HtdlRsltVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);

    	
    }
    
    
    // update
    @Test
    public void updateTest1() {
    	HtdlRsltVO htdlRslt = new HtdlRsltVO().builder()
				.htdlId(htdlId)
				.storeId(storeId)
				.lastPnum(999)
				.htdlLmtPnum(htdlLmtPnum)
				.rsvdRate(rsvdRate)
				.elapTm(elapTm)
				.build();
    	
    	int bf = mapper.findById(htdlId).getLastPnum();
    	
    	int result = mapper.update(htdlRslt);

    	assertTrue(result == 1);
    	
    	htdlRslt = mapper.findById(htdlId);
    	
    	assertTrue(htdlRslt.getLastPnum() != bf);
    	
    	htdlRslt.setLastPnum(lastPnum);
    	
    	result = mapper.update(htdlRslt);
    	
    	assertTrue(result == 1);
    }
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	HtdlRsltVO htdlRslt = new HtdlRsltVO().builder()
				.htdlId(6L)
				.storeId(storeId)
				.lastPnum(lastPnum)
				.htdlLmtPnum(htdlLmtPnum)
				.rsvdRate(rsvdRate)
				.elapTm(elapTm)
				.build();
    	
    	List<HtdlRsltVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insert(htdlRslt);

    	list = mapper.findAll();
    	
    	assertTrue(list.size() == bf + 1);
    	
    	int result = mapper.delete(htdlId);
    	
    	assertTrue(result == 1);
    	
    	list = mapper.findAll();
    	
    	assertTrue(list.size() == bf);
    	
    }
}
