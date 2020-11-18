package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.BUserVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BUserMapperTests {
	
    private long brSeq = 1;
    private String userId = "kjuioq";
    private String brno = "1";
    private String brPhotoSrc = "/a.jpg";
    private String brJdgStusCd;
    private long storeId = 3;
    
    @Autowired
    private BUserMapper mapper;
    
    @Test
    public void insertTest1() {
    	
    	BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc)
				.setStoreId(storeId)
				.build();
    	
    	BUserVO b = mapper.findBySeq(brSeq);
    	
    	assertNull(b);
    	
    	mapper.insert(buser);
    	
    	b = mapper.findBySeq(brSeq);
    	
    	assertNotNull(b);
    	
    }
    
    @Test
    public void insertSelectTest1() {
    	
    	BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc)
				.setStoreId(storeId)
				.build();
    	
    	log.info(buser);
    	
    	mapper.insertSelectKey(buser);
    	
    	log.info(buser);
    	
    	List<BUserVO> list = mapper.findAll();
    	
    	assertTrue(list.get(list.size()-1).getBrSeq() == buser.getBrSeq());
    	
    }
    
    
    @Test
    public void findTest1() {
    	
    	BUserVO buser = mapper.findBySeq(brSeq);
    	
    	assertNotNull(buser);
    	
    	assertTrue(buser.getBrSeq() == brSeq);
    	
    }
    
    @Test
    public void findAllTest() {
    	
    	List<BUserVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);
    	
    }
    
    @Test
    public void deleteTest() {
    	
    	BUserVO buser = new BUserVO.Builder(2,userId,brno,brPhotoSrc)
				.setStoreId(storeId)
				.build();
    	
    	mapper.insert(buser);
    	
    	BUserVO b = mapper.findBySeq(2);
    	
    	log.info(b);
    	
    	mapper.delete(2);
    	
    	b = mapper.findBySeq(2);
    	
    	assertNull(b);
    	
    	
    }

}
