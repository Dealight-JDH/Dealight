package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.BUserVO;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.RsvdDtlsVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class HtdlDtlsMapperTests {
	
	// �ʼ��Է°�
    private long hotdealId = 25;
    private String name = "�����Ʈ";
    private long storeId = 13;
    private double dcRate = 0.5;
    private String startTm = "13:00";
    private String endTm = "14:00";
    private int lmtPnum = 40;
    private int befPrice = 15000; 
    private int ddct = 7500;
    private int curPnum = 25;
    
    // �⺻��
    private String stusCd = "A";
    
    //���� �Է°�
    private String intro = "�ֵ� ���";
    
	
    private long htdlId = 4;
    private long htdlSeq = 1;
    private String menuName = "���";
    private int menuPrice = 3000;
    
    @Autowired
    private HtdlMapper htdlMapper;
    
    @Autowired
    private HtdlDtlsMapper htdlDtlsMapper;
    
    // create
    @Test
    public void insertTest1() {
    	HtdlDtlsVO htdlDtls = new HtdlDtlsVO().builder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName(menuName)
				.menuPrice(menuPrice)
				.build();
    	
    	HtdlDtlsVO ht = htdlDtlsMapper.findBySeq(htdlSeq);
    	
    	assertNull(ht);
    	
    	List<HtdlDtlsVO> list = htdlDtlsMapper.findAll();
    	
    	int bf = list.size();
    	
    	htdlDtlsMapper.insert(htdlDtls);
    	
    	list = htdlDtlsMapper.findAll();
    	
    	assertTrue(list.size() == bf + 1);
    	
    }
    
    @Test
    public void insertSelectTest1() {
    	HtdlDtlsVO htdlDtls = new HtdlDtlsVO().builder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName(menuName)
				.menuPrice(menuPrice)
				.build();
    	
    	HtdlDtlsVO ht = htdlDtlsMapper.findBySeq(htdlSeq);
    	
    	assertNull(ht);
    	
    	List<HtdlDtlsVO> list = htdlDtlsMapper.findAll();
    	
    	int bf = list.size();
    	
    	htdlDtlsMapper.insertSelectKey(htdlDtls);
    	
    	list = htdlDtlsMapper.findAll();
    	
    	assertTrue(list.size() == bf + 1);
    	
    	assertTrue(list.get(list.size()-1).getHtdlSeq() == htdlDtls.getHtdlSeq());
    	
    	log.info(htdlDtls);
    }
    
    // read
    @Test
    public void findTest1() {
    	
    	HtdlDtlsVO ht = htdlDtlsMapper.findBySeq(9);
    	
    	assertNotNull(ht);
    	
    }
    
    // read
    //
    @Test
    public void findByHtdlIdTest1() {
    	
    	List<HtdlDtlsVO> list = htdlDtlsMapper.findByHtdlId(htdlId);
    	
    	assertNotNull(list);
    	
    }
    
    
    // read list
    @Test
    public void findAllTest1() {
    	
    	List<HtdlDtlsVO> list = htdlDtlsMapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);
    	
    }
    
    
    // update
    @Test
    public void updateTest1() {
    	HtdlDtlsVO htdlDtls = new HtdlDtlsVO().builder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName("����")
				.menuPrice(menuPrice)
				.build();
    	
    	int result = htdlDtlsMapper.update(htdlDtls);
  
    	assertTrue(result == 1);
    	
   
    	HtdlDtlsVO htdl = htdlDtlsMapper.findBySeq(htdlSeq);
    	htdl.setMenuName(menuName);
    	
    	result = htdlDtlsMapper.update(htdlDtls);
    	
    	assertTrue(result == 1);
    	
    }
    
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	HtdlDtlsVO htdlDtls = new HtdlDtlsVO().builder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName(menuName)
				.menuPrice(menuPrice)
				.build();
    	
    	HtdlDtlsVO ht = htdlDtlsMapper.findBySeq(htdlSeq);
    	
    	assertNull(ht);
    	
    	htdlDtlsMapper.insert(htdlDtls);
    	
    	ht = htdlDtlsMapper.findBySeq(htdlSeq);
    	
    	assertNotNull(ht);
    	
    	int result = htdlDtlsMapper.delete(htdlSeq);
    	
    	assertTrue(result == 1);
    	
    }
    
    //@Transactional
    //@Rollback(false)
    @Test
    public void insertRsvdDtls() {
    	
    	List<HtdlDtlsVO> list = new ArrayList<>();
    	
    	int bf = htdlDtlsMapper.findAll().size();
    	
    	HtdlVO htdl = new HtdlVO().builder()
				.htdlId(hotdealId)
				.name(name)
				.storeId(storeId)
				.dcRate(dcRate)
				.startTm(startTm)
				.endTm(endTm)
				.lmtPnum(lmtPnum)
				.befPrice(befPrice)
				.ddct(ddct)
				.curPnum(curPnum)
				.stusCd(stusCd)
				.build();
    	
    	htdlMapper.insertSelectKey(htdl);
    	
    	htdlId = htdl.getHtdlId();
    	
    	HtdlDtlsVO htdlDtls = new HtdlDtlsVO().builder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName(menuName)
				.menuPrice(menuPrice)
				.build();

    	HtdlDtlsVO htdlDtls2 = new HtdlDtlsVO().builder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName(menuName)
				.menuPrice(menuPrice)
				.build();
    	
    	HtdlDtlsVO htdlDtls3 = new HtdlDtlsVO().builder()
				.htdlId(htdlId)
				.htdlSeq(htdlSeq)
				.menuName(menuName)
				.menuPrice(menuPrice)
				.build();
    	
    	list.add(htdlDtls);
    	list.add(htdlDtls2);
    	list.add(htdlDtls3);
    	
    	
    	int result = htdlDtlsMapper.insertHtdlDtls(list);
    	
    	assertTrue(result == 3);
    	
    	log.info(result);
    	
    	assertTrue(bf + 3 == htdlDtlsMapper.findAll().size());
    	
    }

}
