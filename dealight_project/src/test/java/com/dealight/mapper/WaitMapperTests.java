package com.dealight.mapper;

import static org.junit.Assert.assertFalse;
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
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.WaitVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class WaitMapperTests {
	
	SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	//�ʼ� �Է°�
    private Long waitId = 1L;
    private Long storeId = 13L;
    private String waitRegTm = formater.format(new Date());
    private int waitPnum = 30;
    private String custTelno = "010-0000-0000";
    private String custNm = "�赿��"; 
    private String waitStusCd;
    
    // �����Է°�
    private String userId = "kjuioq";
    
    @Autowired
    private WaitMapper mapper;
    
    // create
    @Transactional
    @Test
    public void insertTest1() {
    	
    	WaitVO waiting = new WaitVO().builder()
    			.waitId(waitId)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno(custTelno)
				.custNm(custNm)
				.waitStusCd("Y")
				.build();
    	
    	List<WaitVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insert(waiting);
    	
    	list = mapper.findAll();
    	
    	assertTrue(bf + 1 == list.size());
    	
    }
    
    // create
    @Transactional
    @Test
    public void insertSelectKeyTest1() {
    	WaitVO waiting = new WaitVO().builder()
    			.waitId(waitId)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno(custTelno)
				.custNm(custNm)
				.waitStusCd("N")
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
    	
    	WaitVO waiting = mapper.findById(waitId);
    	
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
    			.waitId(waitId)
				.storeId(storeId)
				.waitRegTm(waitRegTm)
				.waitPnum(waitPnum)
				.custTelno("����")
				.custNm(custNm)
				.build();

    	String bf = mapper.findById(waitId).getCustTelno();
    	
    	int result = mapper.update(waiting);
    	
    	assertTrue(result == 1);
    	
    	waiting = mapper.findById(waitId);
    	
    	assertTrue(!waiting.getCustTelno().equals(bf));
    	
    	waiting.setCustTelno(bf);
    	
    	result = mapper.update(waiting);
    	
    	assertTrue(result == 1);
    	
    }
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	int result = mapper.delete(21L);
    	
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
    	
    	waitId = 58L;
    	
    	WaitVO wait = mapper.findById(waitId);
    	
    	log.info(wait);
    	
    	int result = mapper.changeWaitStusCd(wait.getWaitId(), waitStusCd);
    	
    	assertTrue(result==1);
    	
    	wait = mapper.findById(waitId);
    	
    	log.info(wait);
    	
    	assertTrue(wait.getWaitStusCd().equals(waitStusCd));
    	
    	
    }
    
    @Transactional
    @Test
    public void waitInitTest1() {
    	
    	List<WaitVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	boolean flag = true;
    	
    	for(WaitVO wait : list)
    		if(wait.getWaitStusCd().equals("W"))
    			flag = false;
    	
    	assertFalse(flag);
    	
    	mapper.waitInit();
    	
    	list = mapper.findAll();
    	
    	log.info(list);
    	
    	flag = true;
    	
    	for(WaitVO wait : list)
    		if(wait.getWaitStusCd().equals("W"))
    			flag = false;
    	
    	assertTrue(flag);
    	
    }
    
    @Test
    public void findWaitListWithPagingByUserIdTest1() {
    	
    	userId = "kjuioq";
    	
    	int pageNum = 1;
    	int amount = 3;
    	
    	Criteria cri = new Criteria(pageNum,amount);
    	
    	userId = "kjuioq";
    	
    	List<WaitVO> list = mapper.findWaitListWithPagingByUserId(userId, cri);
    	
    	list.stream().forEach(wait -> {
    		
    		log.info("wait : " + wait);
    		
    		assertTrue(wait.getUserId().equals(userId));
    	});
    	
    	log.info("list : "+list);
    	log.info("list size : "+list.size());
    	
    	assertTrue(list.size() == amount);
    	
    }
    
    @Test
    public void getWaitCntTest1() {
    	
    	userId = "kjuioq";
    	
    	int pageNum = 1;
    	int amount = 3;
    	
    	Criteria cri = new Criteria(pageNum,amount);
    	
    	String stusCd = "W";
    	
    	int wait = mapper.getWaitCnt(userId, cri, "W");
    	int enter = mapper.getWaitCnt(userId, cri, "E");
    	int panalty = mapper.getWaitCnt(userId, cri, "P");
    	int total = wait + enter + panalty;
    	
    	log.info("wait : " + wait);
    	log.info("enter : " + enter);
    	log.info("panalty : " + panalty);
    	log.info("kjuioq의 웨이팅 상태 개수"+total);
    	
    }
    
    @Test
    public void getWaitByUserIdTest1() {
    	
    	userId = "kjuioq";
    	
    	WaitVO wait = mapper.getCurWaitByUserId(userId);
    	
    	log.info(wait);
    	
    }
    
    @Test
    public void findLastWeekRsvdListByStoreIdTest1() {
    	
    	Long storeId = 1L;
    	
    	List<WaitVO> list = mapper.findLastWeekRsvdListByStoreId(storeId);
    	
    	assertNotNull(list);
    	
    	list.stream().forEachOrdered(wait -> {
    		
    		assertTrue(wait.getStoreId().equals(storeId));
    		log.info("wait : " + wait);
    	});
    	
    }

}
