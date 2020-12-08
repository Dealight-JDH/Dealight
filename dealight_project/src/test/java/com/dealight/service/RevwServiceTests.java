package com.dealight.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
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
import com.dealight.domain.RsvdVO;
import com.dealight.domain.RsvdWithWaitDTO;
import com.dealight.domain.WaitVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RevwServiceTests {

	@Autowired
	private RevwService revwService;
	
	@Autowired
	private StoreService storeSerivce;
	
	@Autowired
	private RsvdService rsvdService;
	
	@Autowired
	private WaitService waitService;
	
	
	@Test
	public void getRevwListWithPagingByStoreId() {
		
		Long storeId = 16L;
		int pageNum = 1;
		int amount = 3;
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RevwVO> revwList = revwService.getRevwListWithPagingByStoreId(storeId,cri);
		
		log.info(revwList);
		
		assertNotNull(revwList);
		
		revwList.stream().forEachOrdered(revw -> {
			log.info("revw : " + revw);
			assertTrue(revw.getStoreId().equals(storeId));
			assertNotNull(revw.getImgs());
			
		});
		
		assertTrue(revwList.size() == amount);
	}
	
	@Test
	public void getRevwListWithPagingByUserId() {
		
		String userId = "kjuioq";
		int pageNum = 1;
		int amount = 3;
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RevwVO> revwList = revwService.getRevwListWithPagingByUserId(userId,cri);
		
		log.info(revwList);
		
		assertNotNull(revwList);
		
		revwList.stream().forEachOrdered(revw -> {
			log.info("revw : " + revw);
			assertTrue(revw.getUserId().equals(userId));
			assertNotNull(revw.getImgs());
			
		});
		
		assertTrue(revwList.size() == amount);
	}
	
	@Test
	public void getCountByStoreIdTest1() {
		
		Long storeId = 16L;
				
		int result = revwService.getCountByStoreId(storeId);
		
		log.info("resutl.............. : " + result);
		
	}
	
	@Transactional
	@Test
	public void regRevwRsvdImgNullTest1() {
		
		Long storeId = 16L;
		String userId = "kjuioq";
		String storeNm = storeSerivce.findByStoreIdWithBStore(storeId).getStoreNm();
		Long rsvdId = 1L;
		String cnts = "너무 맛있어요";
		double rating = 4.5;
		
		
		RevwVO revw = new RevwVO().builder()
				.storeId(storeId)
				.userId(userId)
				.storeNm(storeNm)
				.rsvdId(1L)
				//.waitId(waitId)
				.userId(userId)
				.cnts(cnts)
				.rating(rating)
				.build();
		
		log.info("before revw .................. : "+revw);
		
		log.info("before rsvd revw stus......... : "+rsvdService.read(revw.getRsvdId()).getRevwStus());
		
		revwService.regRevw(revw);
		
		Long revwId = revw.getRevwId();
		
		log.info("after revw id .................. : "+revwId);
		
		revw = revwService.findById(revwId);
		
		log.info("after revw .................. : "+revw);
		
		log.info("after rsvd revw stus......... : "+rsvdService.read(revw.getRsvdId()).getRevwStus());
				
	}

	@Transactional
	@Test
	public void regRevwWaitImgNullTest1() {
		
		Long storeId = 16L;
		String userId = "kjuioq";
		String storeNm = storeSerivce.findByStoreIdWithBStore(storeId).getStoreNm();
		Long waitId = 1L;
		String cnts = "너무 맛있어요";
		double rating = 4.5;
		
		
		RevwVO revw = new RevwVO().builder()
				.storeId(storeId)
				.userId(userId)
				.storeNm(storeNm)
				//.rsvdId(1L)
				.waitId(waitId)
				.userId(userId)
				.cnts(cnts)
				.rating(rating)
				.build();
		
		log.info("before revw .................. : "+revw);
		
		log.info("before wait revw stus......... : "+waitService.read(revw.getWaitId()).getRevwStus());
		
		revwService.regRevw(revw);
		
		Long revwId = revw.getRevwId();
		
		log.info("after revw id .................. : "+revwId);
		
		revw = revwService.findById(revwId);
		
		log.info("after revw .................. : "+revw);
		
		log.info("after wait revw stus......... : "+waitService.read(revw.getWaitId()).getRevwStus());
				
	}
	
	@Transactional
	@Test
	public void regRevwRsvdWithImgsTest1() {
		
		Long storeId = 16L;
		String userId = "kjuioq";
		String storeNm = storeSerivce.findByStoreIdWithBStore(storeId).getStoreNm();
		Long rsvdId = 1L;
		String cnts = "너무 맛있어요";
		double rating = 4.5;
		
		
		RevwVO revw = new RevwVO().builder()
				.storeId(storeId)
				.userId(userId)
				.storeNm(storeNm)
				.rsvdId(1L)
				//.waitId(waitId)
				.userId(userId)
				.cnts(cnts)
				.rating(rating)
				.build();
		
		
		log.info("before revw .................. : "+revw);
		
		log.info("before rsvd revw stus......... : "+rsvdService.read(revw.getRsvdId()).getRevwStus());
		
		String uuid1 = "aaaa";
		String uuid2 = "bbbb";
		String uuid3 = "cccc";
		
		String uploadPath1 = "c:/1/";
		String uploadPath2 = "c:/2/";
		String uploadPath3 = "c:/3/";
		
		boolean img1 = true;
		boolean img2 = false;
		boolean img3 = true;
		
		String fileName1 = "aaa.jpg";
		String fileName2 = "bbb.jpg";
		String fileName3 = "ccc.jpg";
		
		
		List<RevwImgVO> list = new ArrayList<>();
		
		RevwImgVO revwImg1 = new RevwImgVO().builder()
				.uuid(uuid1)
				.uploadPath(uploadPath1)
				.image(img1)
				.fileName(fileName1)
				.build();
		RevwImgVO revwImg2 = new RevwImgVO().builder()
				.uuid(uuid2)
				.uploadPath(uploadPath2)
				.image(img2)
				.fileName(fileName2)
				.build();
		RevwImgVO revwImg3 = new RevwImgVO().builder()
				.uuid(uuid3)
				.uploadPath(uploadPath3)
				.image(img3)
				.fileName(fileName3)
				.build();
		
		list.add(revwImg1);
		list.add(revwImg2);
		list.add(revwImg3);
		
		revw.setImgs(list);
		
		revwService.regRevw(revw);
		
		Long revwId = revw.getRevwId();
		
		revw = revwService.findRevwWtihImgsById(revwId);
		
		log.info("after revw .................. : "+revw);
		
		log.info("after rsvd revw stus......... : "+rsvdService.read(revw.getRsvdId()).getRevwStus());
				
	}
	
	@Transactional
	@Test
	public void regRevwWaitWithImgsTest1() {
		
		Long storeId = 16L;
		String userId = "kjuioq";
		String storeNm = storeSerivce.findByStoreIdWithBStore(storeId).getStoreNm();
		Long rsvdId = 1L;
		String cnts = "너무 맛있어요";
		double rating = 4.5;
		Long waitId = 1L;
		
		
		RevwVO revw = new RevwVO().builder()
				.storeId(storeId)
				.userId(userId)
				.storeNm(storeNm)
				//.rsvdId(1L)
				.waitId(waitId)
				.userId(userId)
				.cnts(cnts)
				.rating(rating)
				.build();
		
		
		log.info("before revw .................. : "+revw);
		
		log.info("before rsvd revw stus......... : "+waitService.read(revw.getWaitId()).getRevwStus());
		
		String uuid1 = "aaaa";
		String uuid2 = "bbbb";
		String uuid3 = "cccc";
		
		String uploadPath1 = "c:/1/";
		String uploadPath2 = "c:/2/";
		String uploadPath3 = "c:/3/";
		
		boolean img1 = true;
		boolean img2 = false;
		boolean img3 = true;
		
		String fileName1 = "aaa.jpg";
		String fileName2 = "bbb.jpg";
		String fileName3 = "ccc.jpg";
		
		
		List<RevwImgVO> list = new ArrayList<>();
		
		RevwImgVO revwImg1 = new RevwImgVO().builder()
				.uuid(uuid1)
				.uploadPath(uploadPath1)
				.image(img1)
				.fileName(fileName1)
				.build();
		RevwImgVO revwImg2 = new RevwImgVO().builder()
				.uuid(uuid2)
				.uploadPath(uploadPath2)
				.image(img2)
				.fileName(fileName2)
				.build();
		RevwImgVO revwImg3 = new RevwImgVO().builder()
				.uuid(uuid3)
				.uploadPath(uploadPath3)
				.image(img3)
				.fileName(fileName3)
				.build();
		
		list.add(revwImg1);
		list.add(revwImg2);
		list.add(revwImg3);
		
		revw.setImgs(list);
		
		revwService.regRevw(revw);
		
		Long revwId = revw.getRevwId();
		
		revw = revwService.findRevwWtihImgsById(revwId);
		
		log.info("after revw .................. : "+revw);
		
		log.info("after rsvd revw stus......... : "+waitService.read(revw.getWaitId()).getRevwStus());
				
	}
	
	@Test
	public void findByIdTest1() {
		
		Long revwId = 10L;
		
		RevwVO revw = revwService.findById(revwId);
		
		assertNotNull(revw);
		
		log.info(revw);
		
	}
	
	@Test
	public void findRevwWtihImgsByIdTest1() {
		
		Long revwId = 10L;
		
		RevwVO revw = revwService.findRevwWtihImgsById(revwId);
		
		assertNotNull(revw);
		assertNotNull(revw.getImgs());
		
		log.info(revw);
		revw.getImgs().forEach(img -> {
			
			log.info("img : " + img);
			
		});
		
	}
	
	@Test
	public void getWrittenListTest1() {
		
		String userId = "kjuioq";
		
		List<RevwVO> list = revwService.getWrittenList(userId);
		
		assertNotNull(list);
		
		
		list.stream().forEachOrdered(revw -> {
			
			if(revw.getRsvdId() != null && revw.getRsvdId() > 0 )
				assertTrue(rsvdService.read(revw.getRsvdId()).getRevwStus() != 0);
			else if(revw.getWaitId() != null && revw.getWaitId() > 0)
				assertTrue(waitService.read(revw.getWaitId()).getRevwStus() != 0);
			log.info("revw : " + revw);
		});
		
		log.info("revw list size.................."+list.size());
		log.info("revw list.................."+list);
		
	}
	
	@Test
	public void countRevwTest1() {
		
		String userId = "kjuioq";
		
		int result = revwService.countRevw(userId);
		
		log.info("result ................. : " + result);
	}
	
	@Test
	public void countWaitTest1() {
		
		String userId = "kjuioq";
		
		int result = revwService.countWait(userId);
		
		log.info("result ................. : " + result);
	}
	
	@Test
	public void countRsvdTest1() {
		
		String userId = "kjuioq";
		
		int result = revwService.countRsvd(userId);
		
		log.info("result ................. : " + result);
	}
	
	@Test
	public void countTotalTest1() {
		
		String userId = "kjuioq";
		
		int result = revwService.countTotal(userId);
		
		log.info("result ................. : " + result);
	}
	
	@Test
	public void getWritableListByRsvdTest1() {
		
		String userId = "kjuioq";
		
		List<RsvdVO> list = revwService.getWritableListByRsvd(userId);
		
		assertNotNull(list);
		
		
		list.stream().forEach(rsvd -> {
			log.info("rsvd : " + rsvd);
			assertTrue(rsvd.getRevwStus() == 0);
		});
		
		log.info("revw list size.................."+list.size());
		log.info("revw list.................."+list);
		
	}
	
	@Test
	public void getWritableListByWaitTest1() {
		
		String userId = "kjuioq";
		
		List<WaitVO> list = revwService.getWritableListByWait(userId);
		
		assertNotNull(list);
		
		
		list.stream().forEach(wait -> {
			log.info("wait : " + wait);
			assertTrue(wait.getRevwStus() == 0);
		});
		
		log.info("revw list size.................."+list.size());
		log.info("revw list.................."+list);
		
	}
	
	@Transactional
	@Test
	public void regReplyTest1() {
		
		String replyCnts = "답글답글답글";
		Long revwId = 10L;
		
		RevwVO revw = revwService.findById(revwId);
		
		assertNotNull(revw);
		log.info("before revw................. : "+revw);
		log.info("before revw reply cnts................. : "+revw.getReplyCnts());
		
		assertTrue(revwService.regReply(revwId,replyCnts));

		revw = revwService.findById(revwId);
		
		assertNotNull(revw);
		log.info("after revw................. : "+revw);
		log.info("after revw reply cnts................. : "+revw.getReplyCnts());
		
	}
	
	@Transactional
	@Test
	public void deleteRevwTest1() {
		
		Long revwId = 10L;

		RevwVO revw = revwService.findById(revwId);
		
		assertNotNull(revw);
		
		assertTrue(revwService.deleteRevw(revwId));
		
		revw = revwService.findById(revwId);
		
		assertNull(revw);
		
	}
	
	@Test
	public void getWritableListWithPagingByUserIdTest1() {
		String userId = "kjuioq";
		int pageNum = 1;
		int amount = 50;
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RsvdWithWaitDTO> list = revwService.getWritableListWithPagingByUserId(userId, cri);
		
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
	public void getWrittenListWtihPagingByUserIdTest1() {
		
		
		String userId = "kjuioq";
		int pageNum = 1;
		int amount = 4;
		
		Criteria cri = new Criteria(pageNum,amount);
		
		List<RevwVO> list = revwService.getWrittenListWtihPagingByUserId(userId, cri);
		
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
		
		RevwVO revw = revwService.findRevwWtihImgsByRsvdId(rsvdId);
		
		assertNotNull(revw);
		assertTrue(revw.getRsvdId().equals(rsvdId));
		log.info(revw);
		
	}
	
	@Test
	public void findRevwWtihImgsByWaitIdTest1() {
		
		Long waitId = 111L;
		
		RevwVO revw = revwService.findRevwWtihImgsByWaitId(waitId);
		
		assertNotNull(revw);
		assertTrue(revw.getWaitId().equals(waitId));
		log.info(revw);
		
	}
	
}
