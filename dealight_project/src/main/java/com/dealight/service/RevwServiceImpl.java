package com.dealight.service;
// 수빈
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.RevwImgVO;
import com.dealight.domain.RevwPageDTO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.RsvdWithWaitDTO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.WaitVO;
import com.dealight.mapper.RevwMapper;
import com.dealight.mapper.StoreEvalMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
//다울
@Log4j
@Service
@AllArgsConstructor
public class RevwServiceImpl implements RevwService {

	@Setter(onMethod_ = @Autowired)
	private RevwMapper revwMapper;
	
	@Setter(onMethod_ = @Autowired)
	private StoreEvalMapper evalMapper;

	@Override
	public List<RevwVO> getRevwListWithPagingByStoreId(Long storeId, Criteria cri) {

		return revwMapper.getRevwListWithPagingByStoreId(storeId, cri);
	}

	@Override
	public List<RevwVO> getRevwListWithPagingByUserId(String userId, Criteria cri) {

		return revwMapper.getRevwListWithPagingByUserId(userId, cri);
	}

	@Override
	public int getCountByStoreId(Long storeId) {

		return revwMapper.getCountByStoreId(storeId);
	}

	@Override
	@Transactional
	public void regRevw(RevwVO revw) {
		
		
		revwMapper.insertSelectKey(revw);

		List<RevwImgVO> imgs = revw.getImgs();
		if(imgs != null) {
			imgs.stream().forEach(img -> {
				img.setRevwId(revw.getRevwId());
			});
			revwMapper.insertAllImgs(imgs);
		}
		
		log.info(".........................reg revw vo : "+revw);

		evalMapper.addRevwRating(revw.getStoreId(), revw.getRating());
		
		Long rsvdId = revw.getRsvdId();
		Long waitId = revw.getWaitId();
		
		log.info(".........................rsvd id : "+rsvdId);
		log.info("......................... id : "+waitId);
		
		if(rsvdId != null && rsvdId > 0)
			revwMapper.addCntRsvdRevwStus(rsvdId);
		else if(waitId != null && waitId > 0)
			revwMapper.addCntWaitRevwStus(waitId);
		
	}

	@Override
	public RevwVO findById(Long revwId) {

		return revwMapper.findById(revwId);
	}

	@Override
	public RevwVO findRevwWtihImgsById(Long revwId) {

		return revwMapper.findRevwWtihImgsById(revwId);
	}

	@Override
	public List<RevwVO> getWrittenList(String userId) {

		return revwMapper.getWrittenList(userId);
	}

	@Override
	public int countRevw(String userId) {
		
		return revwMapper.countRevw(userId);
	}

	@Override
	public int countTotal(String userId) {

		return countWait(userId) + countRsvd(userId);
	}
	

	@Override
	public int countRsvd(String userId) {
		
		return revwMapper.countRsvd(userId);
	}

	@Override
	public int countWait(String userId) {

		return revwMapper.countWait(userId);
	}

	@Override
	public List<RsvdVO> getWritableListByRsvd(String userId) {

		return revwMapper.getWritableListByRsvd(userId);
	}

	@Override
	public List<WaitVO> getWritableListByWait(String userId) {

		return revwMapper.getWritableListByWait(userId);
	}

	@Override
	public boolean regReply(Long revwId,String replyCnts) {
		
		return revwMapper.regReply(revwId,replyCnts) == 1;
	}

	@Override
	public boolean deleteRevw(Long revwId) {
		
		return revwMapper.deleteRevw(revwId) == 1;
	}

	@Override
	public List<RsvdWithWaitDTO> getWritableListWithPagingByUserId(String userId, Criteria cri) {

		return revwMapper.getWritableListWithPagingByUserId(userId, cri);
	}

	@Override
	public int countWritableTotal(String userId) {

		return revwMapper.countWritableWait(userId) + revwMapper.countWritableRsvd(userId);
	}

	@Override
	public int countWritableWait(String userId) {

		return revwMapper.countWritableWait(userId);
	}

	@Override
	public int countWritableRsvd(String userId) {

		return revwMapper.countWritableRsvd(userId);
	}

	@Override
	public List<RevwVO> getWrittenListWtihPagingByUserId(String userId, Criteria cri) {

		return revwMapper.getWrittenListWtihPagingByUserId(userId, cri);
	}

	@Override
	public RevwVO findRevwWtihImgsByRsvdId(Long rsvdId) {
		
		return revwMapper.findRevwWtihImgsByRsvdId(rsvdId);
	}

	@Override
	public RevwVO findRevwWtihImgsByWaitId(Long waitId) {

		return revwMapper.findRevwWtihImgsByWaitId(waitId);
	}

	@Override
	public List<RevwImgVO> findRevwImgsByRevwId(Long revwId) {

		return revwMapper.findRevwImgsByRevwId(revwId);
	}

}
