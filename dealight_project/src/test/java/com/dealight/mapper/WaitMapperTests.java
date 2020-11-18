package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.WaitVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class WaitMapperTests {
	
	//�ʼ� �Է°�
    private long id = 1;
    private long storeId = 13;
    private Date waitRegTm = new Date();
    private int waitPnum = 30;
    private String custTelno = "010-0000-0000";
    private String custNm = "�赿��"; 
    private String waitStusCd;
    
    // �����Է°�
    private String userId = "kjuioq";
    
    @Autowired
    private WaitMapper mapper;
    
    // create
    @Test
    public void insertTest1() {
    	WaitVO waiting = new WaitVO().builder()
    			.waitId(id)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno(custTelno)
				.custNm(custNm)
				.build();
    	
    	List<WaitVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insert(waiting);
    	
    	list = mapper.findAll();
    	
    	assertTrue(bf + 1 == list.size());
    	
    }
    
    // create
    @Test
    public void insertSelectKeyTest1() {
    	WaitVO waiting = new WaitVO().builder()
    			.waitId(id)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno(custTelno)
				.custNm(custNm)
				.build();
    	
    	List<WaitVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insertSelectKey(waiting);
    	
    	list = mapper.findAll();
    	
    	assertTrue(bf + 1 == list.size());
    	
    	assertTrue(list.get(list.size()-1).getWaitId() == waiting.getWaitId());
    	
    }
    
    // read
    @Test
    public void findTest1() {
    	
    	WaitVO waiting = mapper.findById(id);
    	
    	assertNotNull(waiting);
    	
    }
    
    // read
    // by store id
    @Test
    public void findByStoreIdTest1() {
    	
    	List<WaitVO> list = mapper.findByStoreId(storeId);
    	
    	assertNotNull(list);
    	
    	list.stream().forEach(wait -> {
    		
    		assertTrue(wait.getStoreId() == storeId);
    		
    	});
    	
    }
    
    // read
    // by store id and stus_cd
    @Test
    public void findByStoreIdAndStusCdTest1() {
    	
    	// C
    	List<WaitVO> list = mapper.findByStoreIdAndStusCd(storeId, waitStusCd);
    	
    	assertNotNull(list);
    	
    	list.stream().forEach(wait -> {
    		
    		assertTrue(wait.getStoreId() == storeId);
    		assertTrue(wait.getWaitStusCd().equalsIgnoreCase("C"));
    		
    	});
    	
    }
    
    // read
    // by store id and date
    @Test
    public void findByStoreIdAndDateTest1() {
    	
    	String date = "20201107";
    	
    	List<WaitVO> list = mapper.findByStoreIdAndDate(storeId, date);
    	
    	assertNotNull(list);
    	
    	String pattern = "yyyyMMdd";
    	
    	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    	
    	list.stream().forEach(wait -> {
    		
    		assertTrue(wait.getStoreId() == storeId);
    		assertTrue(simpleDateFormat.format(wait.getWaitRegTm()).equals(date));
    		
    	});
    	
    }
    
    // read list
    @Test
    public void findAllTest1() {
    	List<WaitVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);

    	
    }
    
    
    // update
    @Test
    public void updateTest1() {
    	WaitVO waiting = new WaitVO().builder()
    			.waitId(id)
				.waitId(id)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno("����")
				.custNm(custNm)
				.build();

    	String bf = mapper.findById(id).getCustTelno();
    	
    	int result = mapper.update(waiting);
    	
    	assertTrue(result == 1);
    	
    	waiting = mapper.findById(id);
    	
    	assertTrue(!waiting.getCustTelno().equals(bf));
    	
    	waiting.setCustTelno(bf);
    	
    	result = mapper.update(waiting);
    	
    	assertTrue(result == 1);
    	
    }
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	int result = mapper.delete(21);
    	
    	assertTrue(result==1);
    	
    	
    	
    }
    
    @Test
    public void findByUserIdAndStusCd() {
    	
    	String userId = "kjuioq";
    	String waitStusCd = "C";
    	
    	List<WaitVO> list = mapper.findByUserId(userId, waitStusCd);
    	
    	log.info(list);
    	
    	assertNotNull(list);
    }
    
    @Test
    public void changeWaitStusCdTest1() {
    	
    	String waitStusCd = "W";
    	
    	id = 58;
    	
    	WaitVO wait = mapper.findById(id);
    	
    	log.info(wait);
    	
    	int result = mapper.changeWaitStusCd(wait.getWaitId(), waitStusCd);
    	
    	assertTrue(result==1);
    	
    	wait = mapper.findById(id);
    	
    	log.info(wait);
    	
    	assertTrue(wait.getWaitStusCd().equals(waitStusCd));
    	
    	
    }

}
