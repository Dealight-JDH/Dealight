package com.dealight.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dealight.domain.BUserVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.mapper.BUserMapper;
import com.dealight.mapper.StoreMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService {

	private BUserMapper bMapper;
	private StoreMapper sMapper;
	
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

	//----------------------매장관리-------------------------
	@Override
	public List<StoreVO> getStroeList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StoreVO readStore(long brSeq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void registerStore(StoreVO store) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean modifyStore(StoreVO store) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteStore(long storeId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<UserVO> getUserList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserVO readUser(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void register(UserVO user) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean modifyUser(UserVO user) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(long userId) {
		// TODO Auto-generated method stub
		return false;
	}

}
