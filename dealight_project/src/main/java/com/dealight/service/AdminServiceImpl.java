package com.dealight.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.AuthVO;
import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.HtdlWithStoreDTO;
import com.dealight.domain.RsvdWithStoreDTO;
import com.dealight.domain.StoreDTO;
import com.dealight.domain.StoreMenuVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.mapper.BStoreMapper;
import com.dealight.mapper.BUserMapper;
import com.dealight.mapper.HtdlMapper;
import com.dealight.mapper.StoreEvalMapper;
import com.dealight.mapper.StoreImgMapper;
import com.dealight.mapper.StoreLocMapper;
import com.dealight.mapper.StoreMapper;
import com.dealight.mapper.StoreMenuMapper;
import com.dealight.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService {

	private static List<StoreDTO> suggestList = new ArrayList<>();
	private BUserMapper bMapper;
	private StoreMapper sMapper;
	private UserMapper	uMapper;

	private HtdlMapper hMapper;
	private StoreMenuMapper mnMapper;
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
	
	@Transactional
	@Override
	public boolean modifyBUser(BUserVO buser) {
		log.info("modify BUser : " + buser);
		
		//심사 변경 상태가 완료일 때 권한부여
		if(buser.getBrJdgStusCd().equalsIgnoreCase("c")) {
			AuthVO auth = AuthVO.builder()
						.userId(buser.getUserId())
						.auth("ROLE_MEMBER")
						.build();
			uMapper.insertAuth(auth);
		}
			
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

	//-----------------핫딜관리----------------
	@Override
	public List<HtdlWithStoreDTO> getHtdlList(String stusCd) {
		// TODO Auto-generated method stub
		log.info("htdl with store list ....");
		return hMapper.getHtdlWithStoreList(stusCd);
	}

	@Override
	public HtdlVO readHtdl(String stusCd, Long htdlId) {
		// TODO Auto-generated method stub
		log.info("htdl get dtls..........");
		
		if("I".equalsIgnoreCase(stusCd)){
			return hMapper.getHtdlDtlsRslt(htdlId);
		}
		
		return hMapper.findHtdlDtlsById(htdlId);
		
	}

	@Override
	public void registerHtdl(HtdlVO htdl) {
		// TODO Auto-generated method stub
		
	}

	@Transactional
	@Override
	public boolean modifyHtdl(HtdlVO htdl) {
		// TODO Auto-generated method stub
		
		log.info("htdl modify....");
		
		
		//핫딜vo수정
		hMapper.updateHtdl(htdl);
		
		if(htdl.getStusCd().equalsIgnoreCase("p")) {			
			List<HtdlDtlsVO> requestDtls = htdl.getHtdlDtls();
			List<HtdlDtlsVO> insertList = new ArrayList<>();
			
			//핫딜 상세 삭제 후 생성
			hMapper.deleteDtls(htdl.getHtdlId());
						
			log.info("========requestDtls: " + requestDtls);

			/*-------------일단 보류--------------*/
//			//요청 리스트 생성
//			for(HtdlDtlsVO vo : requestDtls) {
//				vo.setHtdlId(htdl.getHtdlId());
//				System.out.println(vo.getMenuName());
//				System.out.println(vo.get);
//				insertList.add(vo);
//			}
//			
//			hMapper.insertDtlsList(insertList);
//			return true;
		}
		
		return false;
	}


	@Override
	public boolean removeHtdl(Long htdlId) {
		// TODO Auto-generated method stub
		log.info("remove htdl...");
		
		return hMapper.delete(htdlId) == 1;
	}

	@Override
	public boolean endHtdl(Long htdlId, String stusCd) {
		// TODO Auto-generated method stub
		log.info("end htdl...");
		return hMapper.updateEndHtdl(htdlId, stusCd) == 1;
	}

	@Override
	public List<StoreMenuVO> readMenu(Long storeId) {
		// TODO Auto-generated method stub
		log.info("find menu list.....");
		return mnMapper.findById(storeId);
	}

	@Override
	public boolean todayCheckHtdl(Long storeId) {
		// TODO Auto-generated method stub
		
		log.info("today htdl check...");
		return hMapper.sysdateCheckHtdl(storeId) > 0;
	}

	@Override
	public List<StoreDTO> getSuggestHtdlList() {
		// TODO Auto-generated method stub
		log.info("get suggest htdl list");
		
		List<StoreDTO> storeList = sMapper.storeList();		
		List<StoreDTO> suggestList = suggestCheck(hMapper.getSuggestHtdlList(), storeList);
		
		List<RsvdWithStoreDTO> totRsvdStoreList = bsMapper.countAllStoreWithRsvd();
		List<RsvdWithStoreDTO> rsvdStoreList =  bsMapper.findLastWeekRsvdPnum(3);
		setRsvdRate(totRsvdStoreList, rsvdStoreList);
		List<HtdlWithStoreDTO> htdlRsltList = bsMapper.findHtdlRslt();
		setHtdlRate(htdlRsltList);
		log.info("suggest list : " + suggestList);
		log.info("storeList: "+ storeList);
		return suggestList;
	}
	
	private void setHtdlRate(List<HtdlWithStoreDTO> list) {
		
		for(StoreDTO dto : suggestList) {
			for(HtdlWithStoreDTO htdlDto : list) {
				
				if(dto.getStoreId() == htdlDto.getStoreId()) {
					dto.setHtdlRate(htdlDto.getRsvdRate());
				}
			}
		}
	}
	
	private void setRsvdRate(List<RsvdWithStoreDTO> list, List<RsvdWithStoreDTO> rsvdStoreList) {
		
		for(StoreDTO dto : suggestList) {
			
			for(RsvdWithStoreDTO rsvdDto : list) {
				if(dto.getStoreId() == rsvdDto.getStoreId()) {
					
					for(RsvdWithStoreDTO rsvdStoreDto : rsvdStoreList) {
						if(rsvdDto.getStoreId() == rsvdStoreDto.getStoreId()) {
							
							log.info("======rsvdDto " + rsvdDto);
							log.info("======rsvdStoreDto " + rsvdStoreDto);
							dto.setRsvdRate((rsvdStoreDto.getTotRsvd() / rsvdDto.getTotRsvd())*100);
							log.info("======suggestLlist dto " + dto);
						}
					}
				}
					
			}
		}
		
	}
	
	private List<StoreDTO> suggestCheck(List<HtdlWithStoreDTO> list, List<StoreDTO> storeList){
		
		suggestList.clear();

		outer:
		for(StoreDTO dto : storeList) {
			log.info("htdl logic storeDTO: " + dto);
			for(HtdlWithStoreDTO htdlDto : list) {
				log.info("htdl logic storeDTO: " + htdlDto);
				if(dto.getStoreId().equals(htdlDto.getStoreId())) {
					
					dto.setSuggestChecked(false);
					log.info("htdl logic suggest check: " + dto);
					suggestList.add(dto);
					continue outer;
				}
				
			}
			suggestList.add(dto);		
		}
		
		
		for(StoreDTO dto : suggestList) {
			log.info("=============htdl suggest check: " + "storeId: "+ dto.getStoreId() + " isChecked: " + dto.isSuggestChecked());
		}
		
		for(HtdlWithStoreDTO htdlDto : list) {
			log.info("=============htdl suggest check: " + "htdl storeId: "+ htdlDto.getStoreId());
		}
		
		return suggestList;
		
	}

	@Override
	public StoreDTO suggestStore(Long storeId) {
		// TODO Auto-generated method stub
		log.info("read store .....");
		return sMapper.findByStoreId(storeId);
	}

}
