package com.dealight.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.WaitVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RevwServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private RevwService service;

	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}

	@Test
	public void testGetWrittenList() {
		String userId = "user1id";
		service.getWrittenList(userId).forEach(revw -> log.info(revw));
	}
	
	@Test
	public void testCountRevw() {
		String userId = "user1id";
		log.info(service.countRevw(userId));
	}

	@Test
	public void testCountStore() {
		String userId = "user1id";
		log.info(service.countStore(userId));
	}

	@Test
	public void testGet() {
		log.info(service.getRevw(58L));
	}

	@Test
	public void testGetWritableListByRsvd() {
		String userId = "user1id";
		service.getWritableListByRsvd(userId).forEach(revw -> log.info(revw));
	}

	@Test
	public void testGetWritableListByWait() {
		String userId = "user1id";
		service.getWritableListByWait(userId).forEach(revw -> log.info(revw));
	}

	@Test
	public void testRegisterRevw() {
		RevwVO revw = new RevwVO();
		revw.setStoreId(10010L);
		revw.setStoreNm("서비스테스트");
		revw.setWaitId(9999L);
		revw.setUserId("user1id");
		revw.setCnts("서비스내용테스트여");
		revw.getRegDt();
		revw.setRating(4.5);
		
		service.registerRevw(revw);
		log.info("REGISTERED REVWID: " + revw.getRevwId() + "@@");
		
		RevwImgVO img = new RevwImgVO();
		img.setImgUrl("서비스이미지테스트여.jpg");
		
		service.registerRevwImg(img);
		log.info("REGISTERED REVW IMG: " + img.getImgSeq() + "@@");
	}

	@Test
	public void testGetWritableItemByRsvd() {
		RsvdVO rsvd = new RsvdVO();
		log.info("RSVDVO: " + rsvd);
		service.getWritableItemByRsvd("user1id", 1L);
	}

	@Test
	public void testGetWritableItemByWait() {
		WaitVO wait = new WaitVO();
		log.info("WAITVO: " + wait);
		service.getWritableItemByWait("user1id", 4L);
	}

	@Test
	public void testUpdateRsvdRevwStus() {
		String userId = "usere1id";
		Long rsvdId = 1L;
		service.updateRsvdRevwStus(userId, rsvdId);
	}

	@Test
	public void testUpdateWaitRevwStus() {
		String userId = "user1id";
		Long waitId = 4L;
		service.updateWaitRevwStus(userId, waitId);
	}

	@Test
	public void testUpdateRevwReply() {
		RevwVO revw = service.getRevw(190L);

		if(revw == null) {
			return;
		}

		revw.setReplyCnts("나는서비스매장답변테스트야");
		revw.getReplyRegDt();

		log.info("UPDATE REVW REPLY");
		log.info("UPDATED REVW REPLYVO: " + service.updateRevwReply(revw));
	}

	@Test
	public void testDeleteRevw() {
		log.info("REMOVE REVW");
		log.info("REMOVED REVWVO: " + service.removeRevw(71L));
	}
}
