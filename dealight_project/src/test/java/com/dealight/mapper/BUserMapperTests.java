package com.dealight.mapper;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;

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
    private String storeNm = "storeNm";
    private String telno = "010-2112-1232";
    private String storeTelno = "02-123-1234";
    
    @Autowired
    private BUserMapper mapper;
    
    @Test
    public void insertTest1() {
    	
		BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc,storeNm,telno,storeTelno)
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
    	
		BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc,storeNm,telno,storeTelno)
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
    	
		BUserVO buser = new BUserVO.Builder(brSeq,userId,brno,brPhotoSrc,storeNm,telno,storeTelno)
				.setStoreId(storeId)
				.build();
    	
    	mapper.insert(buser);
    	
    	BUserVO b = mapper.findBySeq(2);
    	
    	log.info(b);
    	
    	mapper.delete(2);
    	
    	b = mapper.findBySeq(2);
    	
    	assertNull(b);
    	
    	
    }

    @Test
    public void testPaging() {
    	
    	Criteria cri = new Criteria();
    	cri.setAmount(5);
    	cri.setPageNum(1);
    	cri.setKeyword("aa");
    	cri.setType("I");
    	cri.setSortType("D");
    	
    	List<BUserVO> list = mapper.getListWithPaging(cri);
    	list.forEach(buser -> log.info(buser));
    	
    }
    
    @Test
    public void findComBrListByUserIdAndStusCdTest1() {
    	
    	String userId = "aaaa";
    	String brJdgStusCd = "C";
    	
    	List<BUserVO> list = mapper.findComBrListByUserIdAndStusCd(userId, brJdgStusCd);
    	
    	list.stream().forEachOrdered(buser -> {
    		buser.getUserId().equals(userId);
    		buser.getBrJdgStusCd().equals(brJdgStusCd);
    		log.info("buser : " + buser);
    	});
    	
    	log.info(list);
    	
    }
    
    @Transactional
    @Test
    public void updateBrJdgStusCdTest1() {
    	
    	Long brSeq = 2L;
    	String brJdgStusCd = "B";
    	
    	BUserVO buser = mapper.findBySeq(brSeq);
    	
    	String bfStusCd = buser.getBrJdgStusCd();
    	
    	int result = mapper.updateBrJdgStusCd(brSeq, brJdgStusCd);
    	
    	buser = mapper.findBySeq(brSeq);
    	
    	assertTrue(result==1);
    	assertFalse(bfStusCd.equals(buser.getBrJdgStusCd()));
    	
    	log.info("before  : "+bfStusCd);
    	log.info("after  : "+buser.getBrJdgStusCd());
    }
}
