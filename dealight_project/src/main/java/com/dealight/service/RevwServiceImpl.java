package com.dealight.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwPageDTO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.WaitVO;
import com.dealight.mapper.RevwMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RevwServiceImpl implements RevwService {

	// === 수빈 ===
	
	@Setter(onMethod_ = @Autowired)
	private RevwMapper mapper;

	@Override
	public List<RevwVO> getWrittenList(String userId) {
		log.info("GET WRITTEN LIST");
		return mapper.getWrittenList(userId);
	}
	
//	@Override
//	public List<RevwImgVO> getWrittenListImg(String userId) {
//		log.info("get written list img...");
//		return mapper.getWrittenListImg(userId);
//	}

	@Override
	public int countRevw(String userId) {
		log.info("COUNT REVW");
		return mapper.countRevw(userId);
	}

	@Override
	public int countStore(String userId) {
		log.info("COUNT STORE");
		return mapper.countStore(userId);
	}

	@Override
	public RevwVO getRevw(Long revwId) {
		log.info("GET REVW");
		log.info("REVWID: " + revwId + "@@");
		return mapper.readRevw(revwId);
	}

	@Override
	public List<RsvdVO> getWritableListByRsvd(String userId) {
		log.info("GET WRITABLE LIST BY RSVD");
		return mapper.getWritableListByRsvd(userId);
	}

	@Override
	public List<WaitVO> getWritableListByWait(String userId) {
		log.info("GET WRITABLE LIST BY WAIT");
		return mapper.getWritableListByWait(userId);
	}

	@Override
	public void registerRevw(RevwVO revw) {
		log.info("REGISTER REVW");
		log.info("REVW: " + revw);
		mapper.insertRevw(revw);
	}

	@Override
	public void registerRevwImg(RevwImgVO img) {
		log.info("REGISTER REVW IMG");
		log.info("IMG: " + img);
		mapper.insertRevwImg(img);
	}

	@Override
	public RsvdVO getWritableItemByRsvd(@Param("userId") String userId, @Param("rsvdId") Long rsvdId) {
		log.info("GET WRITABLE ITEM BY RSVD");
		log.info("USERID: " + userId + "@@");
		log.info("RSVDID: " + rsvdId + "@@");
		return mapper.getWritableItemByRsvd(userId, rsvdId);
	}

	@Override
	public WaitVO getWritableItemByWait(@Param("userId") String userId, @Param("waitId") Long waitId) {
		log.info("GET WRITABLE ITEM BY WAIT");
		log.info("USERID: " + userId);
		log.info("WAITID: " + waitId);
		return mapper.getWritableItemByWait(userId, waitId);
	}
	
	@Override
	public boolean updateRsvdRevwStus(@Param("userId") String userId, @Param("rsvdId") Long rsvdId) {
		log.info("UPDATE RSVD REVW STUS");
		log.info("USERID: " + userId + "@@");
		log.info("RSVDID: " + rsvdId + "@@");
		return mapper.updateRsvdRevwStus(userId, rsvdId) == 1;
	}
	
	@Override
	public boolean updateWaitRevwStus(@Param("userId") String userId, @Param("waitId") Long waitId) {
		log.info("UPDATE WAIT REVW STUS");
		log.info("USERID: " + userId + "@@");
		log.info("WAITID: " + waitId + "@@");
		return mapper.updateWaitRevwStus(userId, waitId) == 1;
	}

	@Override
	public boolean updateRevwReply(RevwVO revw) {
		log.info("UPDATE REVW REPLY");
		log.info(revw);
		return mapper.updateRevwReply(revw) == 1;
	}

	@Override
	public boolean removeRevw(Long revwId) {
		log.info("REMOVE REVW");
		log.info("REVWID: " + revwId);
		return mapper.deleteRevw(revwId) == 1;
	}
	
	// === === ===
	
//	@Override
//	public List<RevwVO> revws(Long storeId) {
//		log.info("revws............"+storeId);
//		return mapper.getRevwList(storeId);
//	}

	@Override
	public List<RevwVO> revws(Long storeId, Criteria cri) {
		log.info("revws with paging......" + storeId);

		return mapper.getRevwListWithPaging(storeId, cri);
	}

	@Override
	public RevwPageDTO getListPage(Criteria cri, Long storeId) {
		return  new RevwPageDTO(
				mapper.getCountByStoreId(storeId),
				mapper.getRevwListWithPaging(storeId, cri));
	}

}
