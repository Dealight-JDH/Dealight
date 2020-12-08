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
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdWithWaitDTO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.WaitVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RevwMapperTests {

	@Setter(onMethod_ =@Autowired)
	private RsvdMapper rsvdMapper;
	
	@Setter(onMethod_ =@Autowired)
	private RevwMapper mapper;
	
	@Setter(onMethod_ =@Autowired)
	private WaitMapper waitMapper;

	
	@Test
	public void testGetRevwListWithPagingByStoreId() {
		
		Long revwId = 1L;
		storeId = 16L;

		int pageNum = 1;
		int amount = 3;
		
		
		Criteria cri = new Criteria(pageNum,amount);
		List<RevwVO> revws = mapper.getRevwListWithPagingByStoreId(storeId, cri);
		revws.forEach(revw -> {log.info(revw); assertTrue(revw.getStoreId() == storeId);});
	}
	
	@Test
	public void testGetRevwListWithPagingByUserId() {
		
		Long revwId = 1L;
		userId = "kjuioq";

		int pageNum = 1;
		int amount = 3;
		
		Criteria cri = new Criteria(pageNum,amount);
		List<RevwVO> revws = mapper.getRevwListWithPagingByUserId(userId, cri);
		revws.forEach(revw -> {log.info(revw); revw.getUserId().equals(userId);});
	}
	

	// �ʼ� �Է°�
    private long id = 1;
    private long storeId = 13;
    private String userId = "kjuioq";
    private String cnts = "�ʹ� ���־��~";
    private String regdate = "20201107"; 
    private double rating = 5.5;
    private String replyCnts = "�� �����ּ���~";
    private String replyRegDt = "20201107";
    
    // ���� �Է°�
    private long rsvdId = 1;
    private long waitId = 1;
    
    
    // create
    @Test
    public void insertTest1() {
    	RevwVO review = new RevwVO().builder()
				.storeId(storeId)
				.userId(userId)
				.cnts(cnts)
				.regdate(regdate)
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
				.regdate(regdate)
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
    	
    	RevwVO revw = mapper.findById(22L);
    	
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
				.regdate(regdate)
				.rating(rating)
				.replyCnts("����")
				.replyRegDt(replyRegDt)
				.build();
    	
    	String bf = mapper.findById(22L).getReplyCnts();
    	
    	int result = mapper.update(review);
    	
    	assertTrue(result == 1);
    	
    	review = mapper.findById(22L);
    	
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
		String userId = "kjuioq";
		mapper.getWrittenList(userId).forEach(review -> log.info("review : "+ review));
	}
	
	@Test
	public void testCountRevw() {
		String userId = "kjuioq";
		int count = mapper.countRevw(userId);
		log.info(count);
	}

	@Test
	public void testCountRsvd() {
		String userId = "kjuioq";
		int count = mapper.countRsvd(userId);
		log.info(count);
	}
	
	@Test
	public void testCountWait() {
		String userId = "kjuioq";
		int count = mapper.countWait(userId);
		log.info(count);
	}

	@Test
	public void testRead() {
		RevwVO revw = mapper.findById(102L);
		log.info(revw);
	}

	@Test
	public void testGetWritableListByRsvd() {
		String userId = "kjuioq";
		mapper.getWritableListByRsvd(userId).forEach(rsvdList -> log.info(rsvdList));
	}

	@Test
	public void testGetWritableListByWait() {
		String userId = "kjuioq";
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
		revw.getRegdate();
		revw.setRating(4.5);

		mapper.insert(revw);
		log.info(revw);
	}
	
	@Transactional
	@Test
	public void testaddCntRsvdRevwStus() {

		log.info(rsvdMapper.findById(1L));
		
		mapper.addCntRsvdRevwStus(1L);
		
		log.info(rsvdMapper.findById(1L));
	}

	@Transactional
	@Test
	public void testUpdateWaitRevwStus() {
		log.info(waitMapper.findById(100L));
		
		mapper.addCntWaitRevwStus(100L);
		
		log.info(waitMapper.findById(100L));
	}

	@Transactional
	@Test
	public void testRegReply() {
		
		Long revwId = 12L;
		
		RevwVO revw = mapper.findById(revwId);
		log.info(revw);

		int result = mapper.regReply(revwId,"내용!");
		log.info("UPDATED REVW REPLY: " + result);
		
		assertTrue(result == 1);
		
		revw = mapper.findById(revwId);
		log.info(revw);
	}

	@Transactional
	@Test
	public void testDeleteRevw() {
		log.info("DELETED COUNT: " + mapper.deleteRevw(179L));
	}
	
	@Transactional
	@Test
	public void insertAllTest1() {
		
		Long revwId = 10L;
		Long imgSeq = 1L;
		String uuid = "dsaf-dsaf-qwdw-ewes";
		String uploadPath = "C:\\upload";
		boolean image = true;
		String fileName = "mat.jpg";
		
		List<RevwImgVO> list = new ArrayList<>();
		
		RevwImgVO revwImg1 = new RevwImgVO().builder()
				.revwId(revwId)
				.uuid(uuid)
				.uploadPath(uploadPath)
				.image(image)
				.fileName(fileName)
				.build();
		RevwImgVO revwImg2 = new RevwImgVO().builder()
				.revwId(revwId)
				.uuid(uuid)
				.uploadPath(uploadPath)
				.image(image)
				.fileName(fileName)
				.build();
		RevwImgVO revwImg3 = new RevwImgVO().builder()
				.revwId(revwId)
				.uuid(uuid)
				.uploadPath(uploadPath)
				.image(image)
				.fileName(fileName)
				.build();
		
		list.add(revwImg1);
		list.add(revwImg2);
		list.add(revwImg3);
		
		log.info(mapper.findRevwWtihImgsById(revwId));
		
		mapper.insertAllImgs(list);
		
		log.info(mapper.findRevwWtihImgsById(revwId));		
	}
	
	@Test
	public void getRevwListWithPagingByUserIdTest1() {
		
		String userId = "kjuioq";
		int pageNum = 1;
		int amount = 3;
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RsvdWithWaitDTO> list = mapper.getWritableListWithPagingByUserId(userId, cri);
		
		log.info("dto................. : "+list);
		
		list.stream().forEachOrdered(dto -> {
			log.info("store id : " + dto.getStoreId());
			log.info("user id : " + dto.getUserId());
			log.info("time : " + dto.getTime());
			log.info("revw stus"+dto.getRevwStus());
			log.info("rsvd : "+dto.getRsvd());
			log.info("wait : "+dto.getWait());
		});
		
	}
	
	@Test
	public void countWritableWait() {
		
		String userId = "kjuioq";
		
		int result = mapper.countWritableWait(userId);
		
		log.info(result);
	}
	
	@Test
	public void countWritableRsvd() {
		
		String userId = "kjuioq";
		
		int result = mapper.countWritableRsvd(userId);
		
		log.info(result);
	}
	
	@Test
	public void getWrittenListWtihPagingByUserIdTest1() {
		
		
		String userId = "kjuioq";
		int pageNum = 1;
		int amount = 5;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RevwVO> list = mapper.getWrittenListWtihPagingByUserId(userId, cri);
		
		log.info(list);
		
		list.stream().forEachOrdered(revw -> {
			log.info("revw : " + revw);
			assertTrue(revw.getUserId().equals(userId));
			assertTrue(revw.getWaitId() > 0 || revw.getRsvdId() > 0);
		});
		
		assertTrue(list.size() == amount);
		
	}
	
	@Test
	public void findRevwWtihImgsByRsvdIdTest1() {
		
		Long rsvdId = 264L;
		
		RevwVO revw = mapper.findRevwWtihImgsByRsvdId(rsvdId);
		
		assertNotNull(revw);
		assertTrue(revw.getRsvdId().equals(rsvdId));
		log.info(revw);
		
	}
	
	@Test
	public void findRevwWtihImgsByWaitIdTest1() {
		
		Long waitId = 111L;
		
		RevwVO revw = mapper.findRevwWtihImgsByWaitId(waitId);
		
		assertNotNull(revw);
		assertTrue(revw.getWaitId().equals(waitId));
		log.info(revw);
		
	}
	
	@Test
	public void findRevwImgsByRevwIdTest1() {
		
		Long revwId = 126L;
		
		List<RevwImgVO> list = mapper.findRevwImgsByRevwId(revwId);
		
		assertNotNull(list);
		list.stream().forEach(img -> {
			assertNotNull(img);
			assertTrue(img.getRevwId().equals(revwId));
			log.info("img : " + img);
		});
		
	}
}
