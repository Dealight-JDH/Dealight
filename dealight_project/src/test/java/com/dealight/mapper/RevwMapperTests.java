package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.BUserVO;
import com.dealight.domain.RevwVO;

import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.WaitVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RevwMapperTests {
	
	// �ʼ� �Է°�
    private long id = 1;
    private long storeId = 13;
    private String userId = "kjuioq";
    private String cnts = "�ʹ� ���־��~";
    private String regDt = "20201107"; 
    private double rating = 5.5;
    private String replyCnts = "�� �����ּ���~";
    private String replyRegDt = "20201107";
    
    // ���� �Է°�
    private long rsvdId = 1;
    private long waitId = 1;
    
    @Autowired
    private RevwMapper mapper;
    
    // create
    @Test
    public void insertTest1() {
    	RevwVO review = new RevwVO().builder()
				.storeId(storeId)
				.userId(userId)
				.cnts(cnts)
				.regDt(regDt)
				.rating(rating)
				.replyCnts(replyCnts)
				.replyRegDt(replyRegDt)
				.build();
    	
    	List<RevwVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insert(review);

    	list = mapper.findAll();
    	
    	assertTrue(list.size() == bf + 1);
    	
    }
    
    // create
    @Test
    public void insertSelectKeyTest1() {
    	RevwVO review = new RevwVO().builder()
				.storeId(storeId)
				.userId(userId)
				.cnts(cnts)
				.regDt(regDt)
				.rating(rating)
				.replyCnts(replyCnts)
				.replyRegDt(replyRegDt)
				.build();
    	
    	List<RevwVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	mapper.insertSelectKey(review);

    	list = mapper.findAll();
    	
    	assertTrue(list.size() == bf + 1);
    	
    	assertTrue(list.get(list.size()-1).getRevwId() == review.getRevwId());
    	
    }
    
    // read
    @Test
    public void findTest1() {
    	
    	RevwVO revw = mapper.findById(22);
    	
    	assertNotNull(revw);
    	
    }
    
    
    // read list
    @Test
    public void findAllTest1() {
    	List<RevwVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);

    	
    }
    
    
    // update
    @Test
    public void updateTest1() {
    	RevwVO review = new RevwVO().builder()
				.revwId(22L)
				.storeId(storeId)
				.userId(userId)
				.cnts(cnts)
				.regDt(regDt)
				.rating(rating)
				.replyCnts("����")
				.replyRegDt(replyRegDt)
				.build();
    	
    	String bf = mapper.findById(22).getReplyCnts();
    	
    	int result = mapper.update(review);
    	
    	assertTrue(result == 1);
    	
    	review = mapper.findById(22);
    	
    	assertTrue(!review.getReplyCnts().equals(bf));
    	
    	review.setReplyCnts(bf);
    	
    	result = mapper.update(review);
    	
    	assertTrue(result == 1);

    	
    }
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	int result = mapper.delete(22);
    	
    	assertTrue(result == 1);
    	
    }


	@Test
	public void testGetWrittenList() {
		String userId = "user1id";
		mapper.getWrittenList(userId).forEach(review -> log.info(review));
	}
	
	@Test
	public void testCountRevw() {
		String userId = "user1id";
		int count = mapper.countRevw(userId);
		log.info(count);
	}

	@Test
	public void testCountStore() {
		String userId = "user1id";
		int count = mapper.countStore(userId);
		log.info(count);
	}

	@Test
	public void testRead() {
		RevwVO revw = mapper.readRevw(102L);
		log.info(revw);
	}

	@Test
	public void testGetWritableListByRsvd() {
		String userId = "user1id";
		mapper.getWritableListByRsvd(userId).forEach(rsvdList -> log.info(rsvdList));
	}

	@Test
	public void testGetWritableListByWait() {
		String userId = "user1id";
		mapper.getWritableListByWait(userId).forEach(waitList -> log.info(waitList));
	}

	@Test
	public void testInsertRevw() {
		RevwVO revw = new RevwVO();
		revw.setStoreId(10010L);
		revw.setStoreNm("test식당");
		revw.setWaitId(9999L);
		revw.setUserId("user1id");
		revw.setCnts("테스트테스트");
		revw.getRegDt();
		revw.setRating(4.5);

		mapper.insertRevw(revw);
		log.info(revw);
	}

	@Test
	public void testGetWritableItemByRsvd() {
		mapper.getWritableItemByRsvd("user1id", 1);
	}

	@Test
	public void testGetWritableItemByWait() {
		mapper.getWritableItemByWait("user1id", 4);
	}

	@Test
	public void testUpdateRsvdRevwStus() {
		RsvdVO rsvd = new RsvdVO();
		rsvd.setRsvdId(1L);
		rsvd.setStoreId(10001L);
		rsvd.setUserId("usere1id");
		rsvd.setHtdlId(101L);
		rsvd.setAprvNo(111L);
		rsvd.setPnum(2);
		rsvd.getTime();
		rsvd.setStusCd("L");
		rsvd.setTotAmt(20000);
		rsvd.setTotQty(2);
		rsvd.getRegDate();
		rsvd.getUpdateDate();

		mapper.updateRsvdRevwStus("user1id", 1);
		log.info(rsvd);
	}

	@Test
	public void testUpdateWaitRevwStus() {
		WaitVO wait = new WaitVO();
		wait.setWaitId(4L);
		wait.setStoreId(10006L);
		wait.setUserId("user1id");
		wait.getWaitRegTm();
		wait.setWaitPnum(2);
		wait.setCustTelno("010-1111-1111");
		wait.setCustNm("뉘뉘뉘");
		wait.setWaitStusCd("E");

		mapper.updateWaitRevwStus("user1id", 4);
		log.info(wait);
	}

	@Test
	public void testUpdateRevwReply() {
		RevwVO revw = mapper.readRevw(87L);
		revw.setReplyCnts("내용테스트");
		revw.getReplyRegDt();

		int count = mapper.updateRevwReply(revw);
		log.info("UPDATED REVW REPLY: " + count);
	}

	@Test
	public void testDeleteRevw() {
		log.info("DELETED COUNT: " + mapper.deleteRevw(179L));
	}
}
