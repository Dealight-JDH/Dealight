package com.dealight.mapper;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.Criteria;
import com.dealight.domain.HtdlCriteria;
import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;
import com.dealight.domain.HtdlWithStoreDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class HtdlMapperTests {

	@Autowired
	private HtdlMapper mapper;
	
	
	@Test
	public void testGetListWiwhPaging() {
		HtdlCriteria hcri = new HtdlCriteria();
		List<HtdlVO> list = mapper.getListWithPaging("A", hcri);
		list.forEach(vo -> log.info(vo));
	}
	@Test
	public void testFindStusCdById() {
		log.info(mapper.findStusCdById(208l));
	}
	@Test
	public void testHtdlDtlsWithStore() {
		HtdlVO vo = mapper.findHtdlWithStore(208l);
		
		log.info("=============vo=========="+ vo);
	}
	
	@Test
	public void testHtdlDtlsRslt() {
	
		Long htdlId = 185l;
		
		HtdlVO vo = mapper.getHtdlDtlsRslt(htdlId);
		
		log.info("==========vo: " +  vo);
	}
	
	@Test
	public void testFindHtdlDtlsById() {
		Long htdlId = 191l;
		HtdlVO vo = mapper.findHtdlDtlsById(htdlId);
		
		log.info("============htdlVO: " + vo);
		vo.getHtdlDtls().forEach(dtls -> log.info(dtls));
	}
	@Test
	public void testHtdlWithStore() {
		
		List<HtdlWithStoreDTO> lists = mapper.getHtdlWithStoreList("I");
		
		lists.forEach(vo -> log.info(vo));
	}
	
	@Test
	public void testfindHtdlDtlsById() {
		Long htdlId = 185l;
		
		HtdlVO vo = mapper.findHtdlDtlsById(htdlId);
		
		log.info("============="+ vo);
	}
	@Test
	public void testSearch() {
		
		HtdlCriteria hCri = new HtdlCriteria(1,30);
//		hCri.setType("B");
		hCri.setKeyword("종로");
		hCri.setStartTm("2020/11/27 13:00");
		hCri.setEndTm("2020/11/27 14:00");
		List<HtdlVO> list = mapper.getListWithPaging("P", hCri);
		
		list.forEach(vo -> log.info(vo));
	}
	@Test
	public void testPaging() {
		HtdlCriteria hCri = new HtdlCriteria();
		hCri.setPageNum(3);
		hCri.setAmount(9);
		String stusCd = "I";
		List<HtdlVO> lists = mapper.getListWithPaging(stusCd, hCri);
		
		lists.forEach(vo -> log.info(vo));
	}
	@Test
	public void test() {
		Date date = new Date();
		long sysdate = System.currentTimeMillis();
		
		DateFormat df = new SimpleDateFormat("yy/MM/dd HH:mm:ss"); // HH=24h, hh=12h
		String str = df.format(sysdate);
		Date aaa = new Date(sysdate);
		System.out.println("================"+str);
		System.out.println("++++++++++++"+ aaa);
		
	}
	
	//TODO 핫딜+상세+매장 평가 조인 테스트
	@Test
	public void testGetHtdlList() {
		
		List<HtdlVO> list = mapper.getHtdlList();
		
		list.forEach(vo -> log.info(vo));
	}
	@Test
	public void testFindHtdlVoById() {
		
		Long htdlId = 9l;
		HtdlVO vo = mapper.findHtdlById(htdlId);
		
		log.info("=================");
		log.info(vo);
		log.info(vo.getStoreEval());
//		vo.getDtlsList().forEach(dtls -> log.info(dtls));
		
		vo.getHtdlDtls().forEach(dtls -> log.info(dtls));
		
	}
	
	//TODO 핫딜 결과 테스트
	@Test
	public void testFindRsltById() {
		//해당 매장의 핫딜 결과 조회
		Long storeId = 1l;
		Long htdlId = 3l;
		
		HtdlRsltVO rsltVO = mapper.findRsltById(storeId, htdlId);
		
		log.info(rsltVO);
	}
	@Test
	public void testgetRsltList() {
		//해당 매장의 핫딜 결과들을 조회한다
		//해당 매장 번호
		Long storeId = 1l;
		
		List<HtdlRsltVO> list = mapper.getRsltList(storeId);
		
		list.forEach(rsltVO -> log.info(rsltVO));
		
		//검증
		assertTrue(list.size() > 0);
		
	}
		
		
	
	//TODO 핫딜 상세 테스트
	@Test
	@Transactional
	public void testDeleteDtls() {
		//핫딜이 삭제될 시 같이 삭제되어야 한다
		
		//삭제할 핫딜 번호 
		Long htdlId = 82l;
		
		//삭제할 핫딜 존재하는 지 확인
		HtdlVO vo = mapper.findById(htdlId);
		Optional.ofNullable(vo).orElseThrow(IllegalArgumentException::new);
		
		
		//삭제하기 전 핫딜 갯수
		int beforeSize = mapper.getList().size();
		
		//핫딜 삭제
		int count = mapper.delete(htdlId);
		int afterSize = mapper.getList().size();

		//핫딜 상세 삭제
		int countDtls = mapper.deleteDtls(htdlId);
		
		//검증		
		assertTrue(count == 1);
		assertTrue(countDtls == 3);
		assertTrue(beforeSize - 1 == afterSize);
		
		
	}
	@Test
	@Transactional
	public void testUpdateDtls() {
		//수정할 핫딜 vo 가져오기
		Long htdlId = 10l;
		HtdlVO existVO = mapper.findById(htdlId);
		//수정할 목록
		String name = "update hotdeal name12345";
		double dcRate = 0.2;
		String startTm = "14:00";
		String endTm = "15:00";
		int lmtPnum = 20;
		String intro = "사이드 메뉴 하나 서비스로 드려요~";
		int ddct = (int)(existVO.getBefPrice() * dcRate);
		
		//수정할 핫딜 vo생성
		HtdlVO updateVO = HtdlVO.builder()
								.htdlId(htdlId)
								.name(name)
								.storeId(2l)
								.dcRate(dcRate)
								.startTm(startTm)
								.endTm(endTm)
								.lmtPnum(lmtPnum)
								.intro(intro)
								.befPrice(9000)
								.ddct(ddct).curPnum(0).stusCd("A").build();
		//핫딜 update
		int count = mapper.update(updateVO);
		assertTrue(count == 1);
		
		//수정되어야 할 핫딜 vo 생성
//		HtdlDtlsVO updateHtdlDtlsVO HtdlDtlsVO.builder().htdlId(htdlId).htdlSeq()
		
		
	}
	@Test
	public void testFindDtlsById() {
		//해당 핫딜번호
		Long htdlId = 76l;
		List<HtdlDtlsVO> list = mapper.findDtlsById(htdlId);
		
		//해당하는 핫딜상세가 없을 때
		Optional.ofNullable(list).orElseThrow(IllegalArgumentException::new);
		
		log.info(list);
	}
	
	@Test
	@Transactional
	@Rollback(false)
	public void testInsertDtls() {
		
		//핫딜 상세vo list
		List<HtdlDtlsVO> dtlsList = new ArrayList<>();

		//핫딜 VO 생성
		HtdlVO vo = HtdlVO.builder()
							.name("new hotdeal name2")
							.storeId(5l)
							.dcRate(0.1)
							.startTm("11:00")
							.endTm("00:00")
							.lmtPnum(30)
							.befPrice(3000)
							.ddct(300).curPnum(0).stusCd("A").build();
		mapper.insertSelectKey(vo);
		
		//현재 시퀀스 가져오기
		Long sequence = mapper.getSeqHtdl();
		log.info(sequence);
		
		//핫딜 상세 VO 생성
		HtdlDtlsVO dtlsVO1 = HtdlDtlsVO.builder()
										.htdlId(sequence)
										.menuName("오뎅")
										.menuPrice(2500)
										.build();
		HtdlDtlsVO dtlsVO2 = HtdlDtlsVO.builder()
										.htdlId(sequence)
										.menuName("튀김")
										.menuPrice(3000)
										.build();
		HtdlDtlsVO dtlsVO3 = HtdlDtlsVO.builder()
										.htdlId(sequence)
										.menuName("매운떡볶이")
										.menuPrice(3500)
										.build();
//		//복수 메뉴 test
		dtlsList.add(dtlsVO1);
		dtlsList.add(dtlsVO2);
		dtlsList.add(dtlsVO3);
		
		mapper.insertDtlsList(dtlsList);
		
		//단일 메뉴 test
//		mapper.insertDtls(dtlsVO2);
		log.info(dtlsVO1);
		
	}
	
	//TODO 핫딜 테스트
	@Test
	@Transactional
	public void testDelete() {
		//삭제할 핫딜 번호 
		Long htdlId = 5l;
		
		//삭제할 핫딜 존재하는 지 확인
		HtdlVO vo = mapper.findById(htdlId);
		Optional.ofNullable(vo).orElseThrow(IllegalArgumentException::new);
		
		
		//삭제하기 전 핫딜 갯수
		int beforeSize = mapper.getList().size();
		
		//삭제
		int count = mapper.delete(htdlId);
		int afterSize = mapper.getList().size();
		
		//검증
		assertTrue(count == 1);
		assertTrue(beforeSize - 1 == afterSize);
	}
	
	
	// �ʼ��Է°�
    private long hotdealId = 1;
    private String name = "�����Ʈ";
    private long storeId = 13;
    private double dcRate = 0.5;
    private String startTm = "13:00";
    private String endTm = "14:00";
    private int lmtPnum = 40;
    private int befPrice = 15000; 
    private int ddct = 7500;
    private int curPnum = 25;
    
    // �⺻��
    private String stusCd = "A";
    
    //���� �Է°�
    private String intro = "�ֵ� ���";
    
    
    // create
    @Test
    @Transactional
    @Rollback(false)
    public void insertTest1() {
    	HtdlVO htdl = new HtdlVO().builder()
				.htdlId(hotdealId)
				.name(name)
				.storeId(storeId)
				.dcRate(dcRate)
				.startTm(startTm)
				.endTm(endTm)
				.lmtPnum(lmtPnum)
				.befPrice(befPrice)
				.ddct(ddct)
				.curPnum(curPnum)
				.stusCd(stusCd)
				.build();
    	
    	List<HtdlVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	log.info("list size........................." + list.size());
    	
    	mapper.insert(htdl);

    	assertTrue(mapper.findAll().size() == bf +1);
    	
    	
    }
    
    // create
    @Test
    @Transactional
    @Rollback(false)
    public void insertSelectKeyTest1() {
    	HtdlVO htdl = new HtdlVO().builder()
				.name("돈까스")
				.storeId(storeId)
				.dcRate(dcRate)
				.startTm(startTm)
				.endTm(endTm)
				.lmtPnum(lmtPnum)
				.befPrice(befPrice)
				.ddct(ddct)
				.curPnum(curPnum)
				.stusCd(stusCd)
				.build();
    	
    	List<HtdlVO> list = mapper.findAll();
    	
    	int bf = list.size();
    	
    	
    	mapper.insertSelectKey(htdl);
    	
    	list = mapper.findAll();

    	assertTrue(mapper.findAll().size() == bf +1);
    	
    	assertTrue(list.get(list.size()-1).getHtdlId() == htdl.getHtdlId());
    	
    	log.info("�ֵ�........................."+htdl);
    	log.info("bf................................"+bf);
    	
    
    	
    	
    }
    
    // read
    // by store id
    @Test
    public void findByStoreIdTest1() {
    	

    	List<HtdlVO> list = mapper.findByStoreId(storeId);
    	
    	assertNotNull(list);
    	
    }
    
    // read
    // by store id and stus cd
    @Test
    public void findByStoreStusCdIdTest1() {
    	

    	List<HtdlVO> list = mapper.findByStoreIdStusCd(storeId, "A");
    	
    	assertNotNull(list);
    	
    }
    
    
    // read list
    @Test
    public void findAllTest1() {
    	List<HtdlVO> list = mapper.findAll();
    	
    	log.info(list);
    	
    	assertNotNull(list);

    	
    }
    
    
   
   
    // delete
    @Test
    public void deleteTest1() {
    	
    	
    	List<HtdlVO> list = mapper.findAll();
    	
    	HtdlVO htdl = list.get(list.size()-1);
    	
    	mapper.insert(htdl);
    	
    	htdl = list.get(list.size()-1);
    	
    	long id = htdl.getHtdlId();
    	
    	htdl = new HtdlVO().builder()
				.htdlId(id+1)
				.name(name)
				.storeId(storeId)
				.dcRate(dcRate)
				.startTm(startTm)
				.endTm(endTm)
				.lmtPnum(lmtPnum)
				.befPrice(befPrice)
				.ddct(ddct)
				.curPnum(curPnum)
				.build();
    	
    	mapper.insert(htdl);
    	
    	int result = mapper.delete(id+1);
    	
    	assertTrue(result == 1);
    }
	
	@Test
	public void testFindById() {
		
		//해당 핫딜 가져오기
		HtdlVO vo = mapper.findById(24l);
		//해당하는 핫딜이 존재하지 않을 때
		Optional.ofNullable(vo).orElseThrow(() -> new IllegalArgumentException("해당 핫딜은 존재하지 않습니다."));
		log.info(vo);
	}
	
	@Test
	public void testGetList() {
		
		//전체 핫딜 조회
		List<HtdlVO> lists = mapper.getList();
		
		lists.forEach(htdlVO -> log.info(htdlVO));
	}

	@Test
	public void testGetMainHtdlList() {
		
		List<HtdlVO> list = mapper.getMainHtdlList();
		list.forEach(vo-> log.info(vo));
	}
	
	@Test
	public void findHtdlWithRsltByStoreIdTest1() {
		
		Long storeId = 1L;
		int pageNum = 1;
		int amount = 5;
		Criteria cri = new Criteria(pageNum,amount);
		
		List<HtdlVO> list = mapper.findHtdlWithRsltByStoreId(storeId, cri);
		
		assertNotNull(list);
		list.stream().forEach(htdl -> {
			log.info("htdl : "+htdl);
			assertNotNull(htdl.getHtdlRslt());
			assertTrue(htdl.getStoreId().equals(storeId));
		});
		
		assertTrue(list.size() == amount);
		
	}
	
	@Test
	public void getHtdlTotalTest1() {
		
		Long storeId = 1L;
		int pageNum = 1;
		int amount = 5;
		Criteria cri = new Criteria(pageNum,amount);
		
		int result = mapper.getHtdlTotal(storeId, cri);
		
		log.info("result : "+result);
		
	}
	
	@Test
	public void getActHtdlWithDtlsTest1() {
		Long storeId = 13L;
		HtdlVO htdl = mapper.getActHtdlWithDtls(storeId);
		log.info("htdl : "+htdl);
		
	}
	
}
