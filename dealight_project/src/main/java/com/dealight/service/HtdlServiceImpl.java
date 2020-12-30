package com.dealight.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.AttachFileDTO;
import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlCriteria;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlPageDTO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.StoreMenuVO;
import com.dealight.mapper.HtdlDtlsMapper;
import com.dealight.mapper.HtdlMapper;
import com.dealight.mapper.HtdlRsltMapper;
import com.dealight.mapper.StoreMenuMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인] 
 * 
 */
//jongwoo

@Service
@RequiredArgsConstructor
@Log4j
public class HtdlServiceImpl implements HtdlService {

	@Autowired
	private HtdlTimeCheckService checkService;
	
	private final HtdlMapper htdlMapper;
	private final StoreMenuMapper menuMapper;
	private HtdlDtlsMapper htdlDtlsMapper;
	private HtdlRsltMapper htdlRsltMapper;
	
	
	@Override
	public HtdlVO readHtdlDtls(Long htdlId) {
		// TODO Auto-generated method stub
		
		log.info("htdl read dtls...");
		return htdlMapper.findHtdlDtlsById(htdlId);
	}
	
	@Override
	public boolean curPnumModify(HtdlVO vo) {
		// TODO Auto-generated method stub
		
		log.info("hotdeal curPnum update...");
		return htdlMapper.curPnumUpdate(vo) == 1;
	}

	
	@Override
	public HtdlVO readHtdl(Long htdlId) {
		// TODO Auto-generated method stub
		
		log.info("hotdeal find read....");
		return htdlMapper.findById(htdlId);
	}

	
	
	@Override
	public List<HtdlVO> findAll() {
		// TODO Auto-generated method stub
		return htdlMapper.getList();
	}
	
	@Override
	public HtdlPageDTO getListPage(String stusCd, HtdlCriteria hCri) {
		// TODO Auto-generated method stub
		return new HtdlPageDTO(
				htdlMapper.getTotalCount(stusCd, hCri),
				htdlMapper.getListWithPaging(stusCd, hCri));
	}

//	@Override
//	public HtdlPageDTO getPageDto(HtdlCriteria hCri, int total, List<HtdlVO> lists) {
//		// TODO Auto-generated method stub
//		return new HtdlPageDTO(hCri, total, lists);
//	}
	
	@Override
	public int getTotal(String stusCd, HtdlCriteria hCri) {
		// TODO Auto-generated method stub
		log.info("get total count");
		return htdlMapper.getTotalCount(stusCd, hCri);
	}

	@Override
	public List<HtdlVO> getList(String stusCd, HtdlCriteria hCri) {
		// TODO Auto-generated method stub
		log.info("get list with criteria : " + hCri);
		return htdlMapper.getListWithPaging(stusCd, hCri);
	}
	
	
	@Transactional
	@Override
	public void register(HtdlVO vo, List<HtdlDtlsVO> dtlsList) {
		// TODO Auto-generated method stub
		
		log.info("register....");
		
		//핫딜 등록
		//checkService.addHtdl(vo);
		htdlMapper.insertSelectKey(vo);
		
		Long sequence = htdlMapper.getSeqHtdl();
		
		//핫딜 메뉴가 하나이상 일 때
		if(dtlsList.size()>1) {
			
			dtlsList.forEach(dtls -> dtls.setHtdlId(sequence));
			htdlMapper.insertDtlsList(dtlsList);
			return;
		}
			HtdlDtlsVO firstDtlsVO = dtlsList.get(0);
			firstDtlsVO.setHtdlId(sequence);
			htdlMapper.insertDtls(firstDtlsVO);
	}
	
	@Transactional(readOnly = true)
	@Override
	public List<HtdlVO> getList() {
		// TODO Auto-generated method stub
		
		log.info("get List....");
		return htdlMapper.getHtdlList();
	}

	@Override
	public HtdlVO read(Long htdlId) {
		// TODO Auto-generated method stub
		log.info("read.....");
		return htdlMapper.findHtdlWithStore(htdlId);
	}
	
	@Override
	public boolean modify(HtdlVO vo) {
		// TODO Auto-generated method stub
		log.info("modify....");
		return false;
	}
	
	@Transactional
	@Override
	public boolean remove(Long htdlId) {
		// TODO Auto-generated method stub
		log.info("remove.....");
		
		//현재 핫딜 존재하는 지 확인
		//현재 핫딜이 시작 전에만 취소 가능
		HtdlVO findHtdl = htdlMapper.findHtdlById(htdlId);
		Optional.ofNullable(findHtdl)
		.orElseThrow(()-> new IllegalArgumentException(htdlId+"번 핫딜은 존재하지 않습니다." ));
		
		//핫딜 상세 존재하는 지 확인
		List<HtdlDtlsVO> findDtlsList = htdlMapper.findDtlsById(htdlId);
		Optional.ofNullable(findHtdl)
		.orElseThrow(()-> new IllegalArgumentException(htdlId+"번 핫딜 상세는 존재하지 않습니다." ));
		
		if(!(findHtdl.getStusCd().equalsIgnoreCase("p")))
			throw new IllegalArgumentException("현재 핫딜 취소는 불가능합니다.");
			
		
		return htdlMapper.delete(htdlId) == 1 && htdlMapper.deleteDtls(htdlId) == findDtlsList.size();
	}

//	@Override
//	public void asyncMethodTest() {
//		log.info("==============async meyhod : " + Thread.currentThread().getName());
//	}

	@Override
	public List<StoreMenuVO> findMenuById(Long storeId) {
		// TODO Auto-generated method stub
		log.info("find menus....");
		return menuMapper.findById(storeId);
	}

//	@Override
//	public MenuDTO findPriceByName(Long storeId, String name) {
//		// TODO Auto-generated method stub
//		log.info("find price....");
//		return menuMapper.findPriceByName(storeId, name);
//	}

	

	@Override
	public List<HtdlDtlsVO> readDtls(long htdlId) {

		return htdlDtlsMapper.findByHtdlId(htdlId);
	}

	@Override
	public HtdlRsltVO readRslt(long htdlId) {

		return htdlRsltMapper.findById(htdlId);
	}

	@Override
	public int calHtdlEndTm(HtdlVO htdl) {
		
		Date today = new Date();

		String pattern = "HH:mm";
    	
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    	
    	String date = simpleDateFormat.format(today);
    	
    	//log.info("test.....................................date : " + date);
    	
    	String[] times1 = htdl.getEndTm().split(":");
    	int endTm = Integer.valueOf(times1[0])*60 + Integer.valueOf(times1[1]);
		
    	//log.info("test.....................................endTm : " + endTm);
    	
    	String[] times2 = date.split(":");
    	int curTm = Integer.valueOf(times2[0])*60 + Integer.valueOf(times2[1]);
    	
    	//log.info("test.....................................curTm : " + curTm);
    	
    	
		return endTm - curTm;
	}

	// 해당 매장의 모든 핫딜 리스트 가져오기
	@Override
	public List<HtdlVO> readAllStoreHtdlList(long storeId) {
		
		return htdlMapper.findByStoreId(storeId);
	}

	// 현재 Active 상태인 핫딜 가져오기
	@Override
	public List<HtdlVO> readActStoreHtdlList(long storeId) {
		
		return htdlMapper.findByStoreIdStusCd(storeId, "A");
	}

	@Override
	public String getStusCdById(Long htdlId) {
		// TODO Auto-generated method stub
		log.info("get stusCd by id ...");
		
		return htdlMapper.findStusCdById(htdlId);
		
	}

	@Override
	public List<HtdlVO> readMainHtdlList(){
		return htdlMapper.getMainHtdlList();
	}
	
	@Override
	public List<HtdlVO> findHtdlWithRsltByStoreId(Long storeId, Criteria cri) {
		return htdlMapper.findHtdlWithRsltByStoreId(storeId, cri);
	}

	@Override
	public int getHtdlTotal(Long storeId, Criteria cri) {
		return htdlMapper.getHtdlTotal(storeId, cri);
	}

	@Override
	public HtdlVO getHtdlDetail(Long storeId) {
		return htdlMapper.getActHtdlWithDtls(storeId);
	}

}
