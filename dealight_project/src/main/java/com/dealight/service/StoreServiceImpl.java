package com.dealight.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.AllStoreVO;
import com.dealight.domain.BStoreVO;
import com.dealight.domain.BUserVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.MenuVO;
import com.dealight.domain.RevwVO;
import com.dealight.domain.StoreEvalVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreLocVO;
import com.dealight.domain.StoreOptionVO;
import com.dealight.domain.StoreVO;
import com.dealight.mapper.AllStoreMapper;
import com.dealight.mapper.BStoreMapper;
import com.dealight.mapper.BUserMapper;
import com.dealight.mapper.MenuMapper;
import com.dealight.mapper.NStoreMapper;
import com.dealight.mapper.RevwMapper;
import com.dealight.mapper.StoreEvalMapper;
import com.dealight.mapper.StoreImgMapper;
import com.dealight.mapper.StoreLocMapper;
import com.dealight.mapper.StoreMapper;
import com.dealight.mapper.StoreOptionMapper;
import com.dealight.mapper.StoreTagMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인] 
 * 
 */

@Log4j
@Service
@AllArgsConstructor
public class StoreServiceImpl implements StoreService {
	//BStoreMapper StoreImgMapper StoreEvalMapper왜 두개?
	private StoreMapper sMapper;
	private BStoreMapper bMapper;
	private StoreLocMapper lMapper;
	private StoreEvalMapper eMapper;
	private BStoreMapper bStoreMapper;
	private AllStoreMapper allStoreMapper;
	private StoreImgMapper storeImgMapper;
	private StoreImgMapper imgMapper;
	private RevwMapper revwMapper;
	private MenuMapper menuMapper;
	private StoreEvalMapper evalMapper;
	private StoreOptionMapper optMapper;
	private BUserMapper buserMapper;
	
	private StoreVO setId(StoreVO store) {
		
		Long storeId =store.getStoreId();
		
		//userid를 넣어줘야할 객체를 꺼낸다.
		BStoreVO bstore = store.getBstore();
		StoreLocVO loc = store.getLoc();
		StoreEvalVO eval = store.getEval();
		
		//꺼낸객체에 id를 넣어준다.
		bstore.setStoreId(storeId);
		loc.setStoreId(storeId);
		eval.setStoreId(storeId);

		//수정한 객체를 store에 넣어준다.
		store.setBstore(bstore);
		store.setLoc(loc);
		store.setEval(eval);
		
		return store;
	}
	
	@Override
	@Transactional
	public void register(StoreVO store) {
		
		//store 먼저 insert한 뒤 
		sMapper.insertSelectKey(store);
		//스토어가 생성되는 시점에는 통계정보가 없다.
		//store.setEval(new StoreEvalVO(0L,0.0,0,0));
		//store가 가진 객체들에게 storeId를 통일시켜준다.
		store = setId(store);
		
		
		//차례대로 종속테이블을 insert해준다.
		lMapper.insert(store.getLoc());
		eMapper.insert(store.getEval());
		bMapper.insert(store.getBstore());
		buserMapper.updateStoreId(store.getBstore().getBuserId(),store.getStoreId(),store.getStoreNm());
		
		if(store.getImgs() != null)
			for(StoreImgVO img : store.getImgs()) 
				img.setStoreId(store.getStoreId());
		
		imgMapper.insertAll(store.getImgs());
		
		
	}

	
	@Override
	public StoreVO getAllInfo(Long storeId) {
		
		log.info("get............" +storeId);
		
		return sMapper.readAllInfo(storeId);
	}

	@Override
	@Transactional
	public boolean modify(StoreVO store) {
		//모든정보를 다 가지고 있어야한다.
		log.info("modify........." + store);
		
		return sMapper.update(store) + bMapper.update(store.getBstore())
				+ lMapper.update(store.getLoc()) + eMapper.update(store.getEval()) == 4;
	}

	@Override
	@Transactional
	public boolean delete(Long storeId) {
		
		log.info("delete.........");
		
		return lMapper.delete(storeId) + bMapper.delete(storeId)
				 + eMapper.delete(storeId) + sMapper.delete(storeId) == 4;
	}
	
	@Override
	public List<StoreVO> getList() {
		
		log.info("getList...............");
		
		return sMapper.getListAllInfo();
	}
	
	@Override
	public List<StoreVO> getStoreListByUserId(String userId){
		
		log.info("getStoreListByUserId...........");
		
		return sMapper.findByUserIdJoinBStore(userId);
	}


	
	
	@Override
	public boolean changeSeatStus(long storeId,String seatStusCd) {
		
		log.info("store service changeSeatStus....");
		
		return bStoreMapper.changeSeatStus(storeId, seatStusCd) == 1;
	}

	@Override
	public Date getCurTime() {
		
		log.info("store service curTime....");
		
		return new Date();
	}

	@Override
	public String getCurSeatStus(long storeId) {
		
		log.info("store service getCurSeatStus....");
		
		StoreVO store = sMapper.read(storeId);

		if(!store.getClsCd().equals("B"))
			return "현재 착석 상태가 B가 아닙니다.";
		
		BStoreVO bstore = bStoreMapper.findByStoreId(store.getStoreId());
		
		log.info("bstore................."+bstore);
		
		return bstore.getSeatStusCd();
	}

	@Override
	public StoreVO getStore(long storeId) {
		
		return sMapper.read(storeId);
	}

	@Override
	public BStoreVO getBStore(long storeId) {
		
		return bStoreMapper.findByStoreId(storeId);
	}


	@Override
	public StoreVO findByStoreIdWithBStore(long storeId) {
		
		return sMapper.findByIdJoinBStore(storeId);
	}

	@Transactional
	@Override
	public void registerStoreAndBStore(StoreVO store) {
		
		sMapper.insertSelectKey(store);
		
		log.info(store);
		
		BStoreVO bstore = store.getBstore();
		
		log.info(bstore);
		
		bstore.setStoreId(store.getStoreId());

		bStoreMapper.insert(bstore);
		
		List<StoreImgVO> imgs = store.getImgs();
		
		log.info(imgs);
		if(imgs != null) {
			
			imgs.stream().forEach(img -> {
				img.setStoreId(store.getStoreId());
			});
			storeImgMapper.insertAll(imgs);
		}
		
		
		StoreEvalVO eval = new StoreEvalVO();
		eval.setStoreId(store.getStoreId());
		
		log.info(eval);
		
		evalMapper.insert(eval);
		
		StoreLocVO loc = store.getLoc();
		if(loc == null) {
			loc = new StoreLocVO();
			loc.setStoreId(store.getStoreId());
			
		}
		if(loc.getAddr() == null || loc.getAddr().equals("NULL")) {
			loc.setAddr("default");
		}
		
		log.info(loc);
		
		lMapper.insert(loc);

		
		StoreOptionVO opt = new StoreOptionVO().builder()
				.storeId(store.getStoreId())
				.park("N")
				.nokids("N")
				.pet("N")
				.pg("N")
				.smoke("N")
				.wifi("N")
				.build();
		
		optMapper.insert(opt);
		
	}

	
	@Override
	@Transactional
	public boolean modifyStore(StoreVO store) {
		
		int result = sMapper.update(store);
		BStoreVO bstore = store.getBstore(); 
		int result2 = bStoreMapper.update(bstore);
		
		List<StoreImgVO> imgs = store.getImgs();
		if(imgs != null) {
			imgs.stream().forEach(img -> {
				img.setStoreId(store.getStoreId());
			});
			log.info("store : "+store);
			log.info("imgs : "+imgs);
			storeImgMapper.deleteAll(store.getStoreId());
			storeImgMapper.insertAll(imgs);
		}
		StoreLocVO loc = new StoreLocVO();
		StoreEvalVO eval = new StoreEvalVO();
		StoreOptionVO opt = new StoreOptionVO();

		return result == 1 && result2 == 1;
	}

	@Override
	public List<StoreVO> findByUserId(String userId) {
		
		return sMapper.findByUserId(userId);
	}

	@Override
	public AllStoreVO findAllStoreInfoByStoreId(long storeId) {
		
		return allStoreMapper.findAllStoreByStoreId(storeId);
	}

	@Override
	public List<StoreImgVO> getStoreImageList(long storeId) {
		return storeImgMapper.findByStoreId(storeId);
	}

	@Override
	public void removeStoreImgAll(long storeId) {
		
		storeImgMapper.deleteAll(storeId);
		
	}

	@Transactional
	@Override
	public boolean modifyStore(AllStoreVO store) {
		//store.getStoreId(), store.getStoreNm(), store.getTelno()
		StoreVO store1 = new StoreVO().builder()
				.storeId(store.getStoreId())
				.storeNm(store.getStoreNm())
				.telno(store.getTelno())
				.clsCd(store.getClsCd())
				.build();
		BStoreVO bstore = BStoreVO.builder()
				.seatStusCd(store.getSeatStusCd())
				.brch(store.getBrch())
				.repImg(store.getRepImg())
				.repMenu(store.getRepMenu())
				.buserId(store.getBuserId())
				.storeId(store.getStoreId())
				.openTm(store.getOpenTm())
				.closeTm(store.getCloseTm())
				.breakSttm(store.getBreakSttm())
				.breakEntm(store.getBreakEntm())
				.lastOrdTm(store.getLastOrdTm())
				.n1SeatNo(store.getN1SeatNo())
				.n2SeatNo(store.getN2SeatNo())
				.n4SeatNo(store.getN4SeatNo())
				.storeIntro(store.getStoreIntro())
				.avgMealTm(store.getAvgMealTm())
				.hldy(store.getHldy())
				.acmPnum(store.getAcmPnum())
				.build();
		StoreLocVO loc = StoreLocVO.builder()
				.storeId(store.getStoreId())
				.addr(store.getAddr())
				.lat(store.getLat())
				.lng(store.getLng())
				.build();
		StoreOptionVO opt = StoreOptionVO.builder()
				.storeId(store.getStoreId())
				.park(store.getPark())
				.nokids(store.getNokids())
				.pg(store.getPg())
				.wifi(store.getWifi())
				.pet(store.getPet())
				.smoke(store.getSmoke())
				.build();
		StoreEvalVO eval = StoreEvalVO.builder()
				.storeId(store.getStoreId())
				.avgRating(store.getAvgRating())
				.revwTotNum(store.getRevwTotNum())
				.likeTotNum(store.getLikeTotNum())
				.build();
		StoreLocVO loca = StoreLocVO.builder()
				.storeId(store.getStoreId())
				.addr(store.getAddr())
				.lat(store.getLat())
				.lng(store.getLng())
				.build();
				
		List<RevwVO> revwList = store.getRevwList();
		List<MenuVO> menuList = store.getMenuList();
		List<StoreImgVO> imgs = store.getImgs();

		int rslt1 = sMapper.update(store1);
		int rslt2 = bStoreMapper.update(bstore);
		int rslt3 = lMapper.update(loca);
		
		if(revwList != null) {
		
		revwList.stream().forEach(revw -> {
			revw.setStoreId(store.getStoreId());
			revwMapper.update(revw);
		});
		}
		
		imgMapper.deleteAll(store.getStoreId());
		
		if(imgs != null) {			
			imgs.stream().forEach(img -> {
				img.setStoreId(store.getStoreId());
			});
			imgMapper.insertAll(imgs);
		}
		
		
		return rslt1 == 1 && rslt2 == 1 && rslt3 == 1;
	}

	@Override
	public List<MenuVO> findMenuByStoreId(long storeId) {
		return menuMapper.findByStoreId(storeId);
	}

	@Override
	public void registerMenu(MenuVO menu) {
		menuMapper.insert(menu);
	}


	@Override
	public StoreVO bstore(Long storeId) {
		log.info("bstore......"+storeId);
		return sMapper.getBstore(storeId);
	}

	@Override
	public StoreVO nstore(Long storeId) {
		log.info("nstore......"+storeId);
		return sMapper.getNstore(storeId);
	}

	
	//수정필
	@Override
	public StoreLocVO getStoreLoc(Long storeId) {
		// TODO Auto-generated method stub
		return lMapper.findByStoreId(storeId);
	}

	@Override
	public int modifyMenu(MenuVO menu) {
		
		return menuMapper.update(menu);
	}

	@Override
	public boolean deleteMenu(Long menuSeq) {
		
		return menuMapper.delete(menuSeq) == 1;
	}

	@Override
	public StoreVO findStoreWithLocByStoreId(Long storeId) {
		return sMapper.findStoreWithLocByStoreId(storeId);
	}

	@Override
	public StoreVO findStoreWithBStoreAndLocByStoreId(Long storeId) {
		
		return sMapper.findStoreWithBstoreAndLocByStoreId(storeId);
	}

	@Override
	public boolean suspendStore(Long storeId) {
		
		return sMapper.suspendStore(storeId) == 1;
	}

	@Override
	public List<StoreVO> findStoreListWithPaging(Criteria cri) {
		
		return sMapper.findStoreListWithPaging(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) {
		
		return sMapper.getTotalCnt(cri);
	}

	@Override
	public StoreEvalVO getEval(Long storeId) {
		
		return eMapper.findByStoreID(storeId);
	}

	@Override
	public List<BUserVO> comBrListByUserId(String userId) {
		
		return buserMapper.findComBrListByUserIdAndStusCd(userId, "C");
	}
	
	


//	
//	  @Override public String storeCd(Long storeId) {
//	  log.info("store code......"+storeId); return sMapper.getStoreCd(storeId); }
//	 

}
