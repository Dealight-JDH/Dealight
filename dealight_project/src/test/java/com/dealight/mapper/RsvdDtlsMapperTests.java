package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.BUserVO;
import com.dealight.domain.RsvdDtlsVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RsvdDtlsMapperTests {
	
	//필수 입력값
    private long rsvdId = 9;
    private long rsvdtSeq = 22;
    private String menuNm = "돈까스";
    private int menuTotQty = 5;
    private int menuPrc = 3000;
    
    @Autowired
    private RsvdDtlsMapper mapper;
    
    @Test
    public void rsvdDtlsDITest() {
    	
    	log.info(mapper);
    	
    }
    
    // create
    @Test
    public void insertTest1() {
    	RsvdDtlsVO rsvdDtls = new RsvdDtlsVO().builder()
				.rsvdId(rsvdId)
				.rsvdSeq(rsvdtSeq)
				.menuNm(menuNm)
				.menuTotQty(menuTotQty)
				.menuPrc(menuPrc)
				.build();
    	
    	List<RsvdDtlsVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insert(rsvdDtls);
    	
    	list = mapper.findAll();
    	
    	assertTrue(bf + 1 == list.size());

    	
    }
    
    // create
    @Test
    public void insertSelectKeyTest1() {
    	RsvdDtlsVO rsvdDtls = new RsvdDtlsVO().builder()
				.rsvdId(rsvdId)
				.rsvdSeq(rsvdtSeq)
				.menuNm(menuNm)
				.menuTotQty(menuTotQty)
				.menuPrc(menuPrc)
				.build();
    	
    	List<RsvdDtlsVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insertSelectKey(rsvdDtls);
    	
    	list = mapper.findAll();
    	
    	assertTrue(bf + 1 == list.size());
    	
    	list = mapper.findAll();
    	
    	assertTrue(list.get(list.size()-1).getRsvdSeq() == rsvdDtls.getRsvdSeq());
    	
    	log.info(rsvdDtls);

    	
    }
    
    // read
    @Test
    public void findTest1() {
    	
    	RsvdDtlsVO rsvdDtls = mapper.findBySeq(22);
    	
    	assertNotNull(rsvdDtls);
    	
    }
    
    // read by rsvd id
    @Test
    public void findByRsvdIdTest1() {
    	
    	List<RsvdDtlsVO> list = mapper.findByRsvdId(rsvdId);
    	
    	log.info(list);
    	
    	assertNotNull(list);
    	
    	list.forEach((rsvdDtls) -> {
    		
    		assertTrue(rsvdDtls.getRsvdId() == rsvdId); 
    	});
    	
    }
    
    
    // read list
    @Test
    public void findAllTest1() {
    	List<RsvdDtlsVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);

    	
    }
    
    
    // update
    @Test
    public void updateTest1() {
    	RsvdDtlsVO rsvdDtls = new RsvdDtlsVO().builder()
				.rsvdId(rsvdId)
				.rsvdSeq(rsvdtSeq)
				.menuNm(menuNm)
				.menuTotQty(menuTotQty)
				.menuPrc(999)
				.build();
    	
    	int bf = mapper.findBySeq(rsvdtSeq).getMenuPrc();
    	
    	int result = mapper.update(rsvdDtls);

    	assertTrue(result == 1);
    	
    	rsvdDtls = mapper.findBySeq(rsvdtSeq);
    	
    	assertTrue(rsvdDtls.getMenuPrc() != bf);
    	
    	rsvdDtls.setMenuPrc(menuPrc);

    	result = mapper.update(rsvdDtls);
    	
    	assertTrue(result == 1);
    }
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	int result = mapper.delete(23);
    	
    	assertTrue(result == 1);
    	
    }
    
    @Test
    public void insertRsvdDtls() {
    	
    	List<RsvdDtlsVO> list = new ArrayList<>();
    	
    	int bf = mapper.findAll().size();
    	
    	RsvdDtlsVO rsvdDtls = new RsvdDtlsVO().builder()
				.rsvdId(rsvdId)
				.rsvdSeq(rsvdtSeq)
				.menuNm(menuNm)
				.menuTotQty(menuTotQty)
				.menuPrc(menuPrc)
				.build();
    	
    	
    	RsvdDtlsVO rsvdDtls2 = new RsvdDtlsVO().builder()
				.rsvdId(rsvdId)
				.rsvdSeq(rsvdtSeq)
				.menuNm(menuNm)
				.menuTotQty(menuTotQty)
				.menuPrc(menuPrc)
				.build();
    	
    	
    	RsvdDtlsVO rsvdDtls3 = new RsvdDtlsVO().builder()
				.rsvdId(rsvdId)
				.rsvdSeq(rsvdtSeq)
				.menuNm(menuNm)
				.menuTotQty(menuTotQty)
				.menuPrc(menuPrc)
				.build();
    	
    	list.add(rsvdDtls);
    	list.add(rsvdDtls2);
    	list.add(rsvdDtls3);
    	
    	
    	int result = mapper.insertRsvdDtls(list);
    	
    	assertTrue(result == 3);
    	
    	log.info(result);
    	
    	assertTrue(bf + 3 == mapper.findAll().size());
    	
    }
  

}
