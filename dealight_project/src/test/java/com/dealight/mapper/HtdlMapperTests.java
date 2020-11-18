package com.dealight.mapper;

import static org.junit.Assert.assertTrue;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import com.dealight.domain.HtdlDtlsVO;
import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class HtdlMapperTests {

	@Autowired
	private HtdlMapper mapper;
	
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
	@Test
	@Transactional
	public void testInsertRslt() throws ParseException {
		
		//핫딜 상태 종료가 되어야 한다
		//종료(시간 마감, 인원 마감)
		//핫딜 결과 VO 생성
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd hh:mm");
		//SimpleDateFormat format1 = new SimpleDateFormat("hh:mm:ss");
		
		//00번 핫딜 종료(시간 마감)
		HtdlVO htdlVO = mapper.findById(6l);
				
		Date startTM = format.parse(htdlVO.getStartTm());
		Date endTM = format.parse(htdlVO.getEndTm());
		log.info("============" + startTM);
		log.info("============" + endTM);
		
		Calendar startTime = Calendar.getInstance();
		startTime.setTime(startTM);
		
		Calendar endTime = Calendar.getInstance();
		endTime.setTime(endTM);
		
		log.info("============" + startTime);
		log.info("============" + endTime);
		
		Calendar sysdate = Calendar.getInstance();
		
		
		
		log.info(sysdate.getTime());
		log.info("sysdate======== " + sysdate);
		
		
		if(sysdate.before(startTime)) {
			
			log.info("핫딜 시작 전입니다..!!!!");
			htdlVO.setStusCd("P");
			mapper.update(htdlVO);
		}else if(startTime.before(sysdate) && endTime.after(sysdate)){
		
			//핫딜 상태 변경
			htdlVO.setStusCd("A");
			mapper.update(htdlVO);
			log.info("현재 핫딜 진행중입니다..!!!!!");
			HtdlVO updatedVO = mapper.findById(3l);
			if(updatedVO.getStusCd().equals("A")) {
				
				//인원 마감
				if(htdlVO.getCurPnum() == htdlVO.getLmtPnum()) {
					//핫딜 상태 비활성화
					htdlVO.setStusCd("I");
					mapper.update(htdlVO);
					
					log.info("핫딜이 마감되었습니다 감사합니다..");
					
					//핫딜 예약률
					int rsvdRate = (htdlVO.getCurPnum() * 100) / htdlVO.getLmtPnum();
					
					log.info("endTime TimeInMillis : "+endTime.getTimeInMillis());
					log.info("startTIme TImeInMillis : " + startTime.getTimeInMillis());
					
					//경과시간
					long diffSec = Math.abs(sysdate.getTimeInMillis() - startTime.getTimeInMillis())/1000;
					String elapTime = (diffSec / 3600) + ":" + (diffSec % 3600 / 60) + ":" + (diffSec % 3600 % 60);
					
					log.info("elapTm: " + elapTime);
					log.info("diffSec : "+diffSec);
					log.info("rsvdRage: " + rsvdRate);
					
					//핫딜 결과vo 생성
					HtdlRsltVO rsltVO = HtdlRsltVO.builder()
							.htdlId(htdlVO.getHtdlId())
							.storeId(1l)
							.lastPnum(htdlVO.getCurPnum())
							.htdlLmtPnum(htdlVO.getLmtPnum())
							.rsvdRate(rsvdRate)
							.elapTm(elapTime).build();
					
					mapper.insertRslt(rsltVO);
				}
			}
			
		}else if(sysdate.after(endTime)) {
			//시간 마감
			//핫딜 상태 비활성화
			htdlVO.setStusCd("I");
			mapper.update(htdlVO);
			
			log.info("핫딜이 종료되었습니다 감사합니다..");
			
			//핫딜 예약률
			int rsvdRate = (htdlVO.getCurPnum() * 100) / htdlVO.getLmtPnum();
			
			log.info("endTime TimeInMillis : "+endTime.getTimeInMillis());
			log.info("startTIme TImeInMillis : " + startTime.getTimeInMillis());
			
			//경과시간
			long diffSec = (endTime.getTimeInMillis() - startTime.getTimeInMillis())/1000;
			String elapTime = (diffSec / 3600) + ":" + (diffSec % 3600 / 60) + ":" + (diffSec % 3600 % 60);
			
			log.info("elapTm: " + elapTime);
			log.info("diffSec : "+diffSec);
			log.info("rsvdRage: " + rsvdRate);
			
			//핫딜 결과vo 생성
			HtdlRsltVO rsltVO = HtdlRsltVO.builder()
									.htdlId(htdlVO.getHtdlId())
									.storeId(1l)
									.lastPnum(htdlVO.getCurPnum())
									.htdlLmtPnum(htdlVO.getLmtPnum())
									.rsvdRate(rsvdRate)
									.elapTm(elapTime).build();
			
			mapper.insertRslt(rsltVO);
			
			
		}
		
		
		
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
	
	@Test
	public void testUpdate() {

		//수정할 핫딜 vo 가져오기
		Long htdlId = 1l;
		HtdlVO existVO = mapper.findById(htdlId);
		//수정할 목록
		String name = "update hotdeal name1";
		double dcRate = 0.2;
		String startTm = "20/11/07 13:00";
		String endTm = "20/11/07 14:00";
		int lmtPnum = 20;
		String intro = "사이드 메뉴 하나 서비스로 드려요~";
		int ddct = (int)(existVO.getBefPrice() * dcRate);
		
		//수정할 핫딜 vo생성
		HtdlVO updateVO = HtdlVO.builder()
				.htdlId(htdlId)
				.name(name)
				.storeId(1l)
				.dcRate(dcRate)
				.startTm(startTm)
				.endTm(endTm)
				.lmtPnum(lmtPnum)
				.intro(intro)
				.befPrice(3000)
				.ddct(ddct).curPnum(20).stusCd("I").build();
		
		//핫딜 수정
		int count = mapper.update(updateVO);
		
		
		HtdlVO updatedVO = mapper.findById(1l);
		//검증
		assertTrue(count == 1);
		
		assertTrue(updatedVO.getName().equals(name));
		assertTrue(updatedVO.getDcRate() ==  dcRate);
		assertTrue(updatedVO.getStartTm().equals(startTm));
		assertTrue(updatedVO.getEndTm().equals(endTm));
		assertTrue(updatedVO.getDdct() == ddct);
		
		
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
	public void testInsert() {
		
		//핫딜 VO 생성
		HtdlVO vo = HtdlVO.builder()
							.name("new hotdeal name3")
							.storeId(4l)
							.dcRate(0.2)
							.startTm("16:00")
							.endTm("17:00")
							.lmtPnum(30)
							.befPrice(3000)
							.ddct(600).curPnum(0).stusCd("P").build();
		//insert
		mapper.insertSelectKey(vo);
		
		log.info(vo);
	}
}
