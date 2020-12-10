package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.mapper.BStoreMapper;
import com.dealight.mapper.BUserMapper;
import com.dealight.mapper.StoreEvalMapper;
import com.dealight.mapper.StoreImgMapper;
import com.dealight.mapper.StoreLocMapper;
import com.dealight.mapper.StoreMapper;
import com.dealight.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService {

	private BUserMapper bMapper;
	private StoreMapper sMapper;
	private UserMapper	uMapper;
	/* 동인 추가 */
	private StoreLocMapper lMapper;
	private StoreEvalMapper eMapper;
	private StoreImgMapper iMapper;
	private BStoreMapper bsMapper;
	
	
	@Override
	public List<BUserVO> getBUserList() {
		log.info("getBUserList........................");
		return bMapper.findAll();
	}

	@Override
	public BUserVO readBUser(long brSeq) {
		log.info("read BUser by brSeq : " + brSeq);
		return bMapper.findBySeq(brSeq);
	}

	@Override
	public void registerBUser(BUserVO buser) {
		log.info("register BUser : " + buser);
		
		//insertSelectKey?????
		bMapper.insert(buser);
	}

	@Override
	public boolean modifyBUser(BUserVO buser) {
		log.info("modify BUser : " + buser);
		return bMapper.update(buser) == 1;
	}

	@Override
	public boolean deleteBUser(long brSeq) {
		log.info("delete by brSeq : " + brSeq);
		return bMapper.delete(brSeq) == 1;
	}
	
	@Override
	public List<BUserVO> getBUserListWithCri(Criteria cri){
		
		log.info("getList with cri : " + cri);
		
		return bMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return bMapper.getTotalCount(cri);
	}
	
	//----------------------매장관리-------------------------
	
	@Override
	public List<StoreVO> getStroeList() {
		log.info("getStoreList........................");
		return sMapper.getList();
	}

	@Override
	public StoreVO readStore(long storeId) {
		log.info("read Store by storeId : " + storeId);
		return sMapper.readAllInfo(storeId);
	}

	@Override
	public void registerStore(StoreVO store) {
		log.info("register : " + store);
		
		sMapper.insert(store);
	}

	@Transactional
	@Override
	public boolean modifyStore(StoreVO store) {
		log.info("modify : " + store);
		
		iMapper.deleteAll(store.getStoreId());
		if(store.getImgs() != null) {
			store.getImgs().stream().forEach(img -> {
				img.setStoreId(store.getStoreId());
			});
			iMapper.insertAll(store.getImgs());
		}
		
		return sMapper.update(store) + lMapper.update(store.getLoc()) + eMapper.update(store.getEval()) + 
					bsMapper.update(store.getBstore()) == 4;
	}

	@Override
	public boolean deleteStore(long storeId) {
		log.info("delete : " + storeId);
		return sMapper.delete(storeId)==1;
	}

	//---------------유저관리--------------------
	@Override
	public List<UserVO> getUserList() {
		log.info("getUserList........................");
		return uMapper.findAll();
	}

	@Override
	public UserVO readUser(String userId) {
		log.info("read User by userId : " + userId);
		return uMapper.read(userId);
	}

	@Override
	public void register(UserVO user) {
		log.info("register : " + user );
		uMapper.insert(user);
	}

	@Override
	public boolean modifyUser(UserVO user) {
		log.info("modify user : " + user);
		
		return uMapper.update(user)==1;
	}

	@Override
	public boolean delete(String userId) {
		log.info("delete : " + userId);
		return uMapper.delete(userId)==1;
	}

}
