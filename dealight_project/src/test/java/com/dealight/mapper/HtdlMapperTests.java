package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

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

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class HtdlMapperTests {
	
	// �ʼ��Է°�
    private long hotdealId = 1;
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
    
    @Autowired
    private HtdlMapper mapper;
    
    // create
    @Test
    @Transactional
    @Rollback(false)
    public void insertTest1() {
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
    	
    	List<HtdlVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	log.info("list size........................." + list.size());
    	
    	mapper.insert(htdl);

    	assertTrue(mapper.findAll().size() == bf +1);
    	
    	
    }
    
    // create
    @Test
    @Transactional
    @Rollback(false)
    public void insertSelectKeyTest1() {
    	HtdlVO htdl = new HtdlVO().builder()
				.name("돈까스")
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
    	
    	List<HtdlVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	
    	mapper.insertSelectKey(htdl);
    	
    	list = mapper.findAll();

    	assertTrue(mapper.findAll().size() == bf +1);
    	
    	assertTrue(list.get(list.size()-1).getHtdlId() == htdl.getHtdlId());
    	
    	log.info("�ֵ�........................."+htdl);
    	log.info("bf................................"+bf);
    	
    
    	
    	
    }
    
    // read
    @Test
    public void findByIdTest1() {
    	

    	HtdlVO htdl = mapper.findById(2);
    	
    	assertNotNull(htdl);
    	
    }
    
    // read
    // by store id
    @Test
    public void findByStoreIdTest1() {
    	

    	List<HtdlVO> list = mapper.findByStoreId(storeId);
    	
    	assertNotNull(list);
    	
    }
    
    // read
    // by store id and stus cd
    @Test
    public void findByStoreStusCdIdTest1() {
    	

    	List<HtdlVO> list = mapper.findByStoreIdStusCd(storeId, "A");
    	
    	assertNotNull(list);
    	
    }
    
    
    // read list
    @Test
    public void findAllTest1() {
    	List<HtdlVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);

    	
    }
    
    
    // update
    @Test
    public void updateTest1() {
    	HtdlVO htdl = new HtdlVO().builder()
				.htdlId(2L)
				.name("����")
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
    	
    	String bf = mapper.findById(2).getName();
    	
    	int result = mapper.update(htdl);
    	
    	assertTrue(result == 1);
    	
    	htdl = mapper.findById(2);
    	
    	assertTrue(!htdl.getName().equals(bf));
    	
    	htdl.setName(bf);
    	
    	mapper.update(htdl);

    	
    }
    
   
    // delete
    @Test
    public void deleteTest1() {
    	
    	
    	List<HtdlVO> list = mapper.findAll();
    	
    	HtdlVO htdl = list.get(list.size()-1);
    	
    	mapper.insert(htdl);
    	
    	htdl = list.get(list.size()-1);
    	
    	long id = htdl.getHtdlId();
    	
    	htdl = new HtdlVO().builder()
				.htdlId(id+1)
				.name(name)
				.storeId(storeId)
				.dcRate(dcRate)
				.startTm(startTm)
				.endTm(endTm)
				.lmtPnum(lmtPnum)
				.befPrice(befPrice)
				.ddct(ddct)
				.curPnum(curPnum)
				.build();
    	
    	mapper.insert(htdl);
    	
    	int result = mapper.delete(id+1);
    	
    	assertTrue(result == 1);

    	
    }

}
