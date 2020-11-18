package com.dealight.mapper;

import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
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
import com.dealight.domain.HtdlVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RsvdMapperTests {


	@Autowired
	private RsvdMapper mapper;
	//TODO 예약 상세 테스트
	
	@Test
	public void getDaySeq() {
		Long daySeq = mapper.getDaySeqRsvd();
		
		log.info("===="+ daySeq);
	}
	
	
	@Test
	@Transactional
	public void testDeleteDtls() {
		//예약 삭제시 같이 삭제되어야 한다
		
		//삭제할 예약 번호 
		Long rsvdId = 12l;
		
		//삭제할 핫딜 존재하는 지 확인
		RsvdVO vo = mapper.findById(rsvdId);
		Optional.ofNullable(vo).orElseThrow(IllegalArgumentException::new);
		
		
		//삭제하기 전 예약 갯수
		int beforeSize = mapper.getList().size();
		
		//예약 삭제
		int count = mapper.delete(rsvdId);
		int afterSize = mapper.getList().size();

		//예약 상세 삭제
		int countDtls = mapper.deleteDtls(rsvdId);
		
		//검증		
		assertTrue(count == 1);
		assertTrue(countDtls == 3);
		assertTrue(beforeSize - 1 == afterSize);
		
		
	}
	
	@Test
	@Transactional
	public void testUpdateDtls() {
		//수정할 예약 vo 가져오기
		Long rsvdId = 13l;
		RsvdVO existVO = mapper.findById(rsvdId);
		//수정할 목록
		String menuNm = "돈까스";
		int menuTotQty = 2;
		int menuPrc = 6000;
		
	}
	
	@Test
	@Transactional
	public void testinsertDtls() {
		List<RsvdDtlsVO> dtlsList = new ArrayList<>();
		//예약 VO 생성
		RsvdVO vo = RsvdVO.builder()
							.storeId(3l)
							.userId("whddn528")
							.aprvNo(202011073583l)
							.pnum(2)
							.time("18:00")
							.stusCd("C")
							.totAmt(20000)
							.totQty(8)
							.build();
		
		mapper.insertSelectKey(vo);
		
		//등록된 예약번호 가져오기
		Long sequence = mapper.getSeqRsvd();

		RsvdDtlsVO dtlsVO1 = RsvdDtlsVO.builder()
										.rsvdId(sequence)
										.menuNm("김밥")
										.menuTotQty(3)
										.menuPrc(2000)
										.build();
		
		RsvdDtlsVO dtlsVO2 = RsvdDtlsVO.builder()
										.rsvdId(sequence)
										.menuNm("떡볶이")
										.menuTotQty(3)
										.menuPrc(3000)
										.build();
		
		RsvdDtlsVO dtlsVO3 = RsvdDtlsVO.builder()
										.rsvdId(sequence)
										.menuNm("순대")
										.menuTotQty(2)
										.menuPrc(2500)
										.build();
		dtlsList.add(dtlsVO1);
		dtlsList.add(dtlsVO2);
		dtlsList.add(dtlsVO3);
		
//		mapper.insertDtls(dtlsVO1);
		mapper.insertDtlsList(dtlsList);
		
		List<RsvdDtlsVO> list = mapper.findDtlsById(sequence);
		list.forEach(dtls -> log.info(dtls));
		
	}
	//TODO 예약 테스트
	@Test
	@Transactional
	public void testDelete() {
		//삭제할 예약번호
		Long deleteId = 2l;
		
		int count = mapper.delete(deleteId);
		
		assertTrue(count == 1);
	}
	@Test
	public void testUpdate() {
		Long id = 4l;
		Long htdlId = 3l;
		Long aprvNo = 202011075392l;
		int pnum = 4;
		String time = "14:00";
		String stusCd = "C";
		//수정할 예약vo
		RsvdVO updateVO = RsvdVO.builder()
								.rsvdId(id)
								.htdlId(htdlId)
								.aprvNo(aprvNo)
								.pnum(pnum)
								.time(time)
								.stusCd(stusCd)
								.build();
		int count = mapper.update(updateVO);
		
		//검증
		assertTrue(count == 1);
		
		RsvdVO updatedVO = mapper.findById(id);		
		assertTrue(updatedVO.getHtdlId() == htdlId);
		assertTrue(updatedVO.getAprvNo().compareTo(aprvNo) == 0);
		assertTrue(updatedVO.getPnum()== pnum);
		assertTrue(updatedVO.getTime().equals(time));
		assertTrue(updatedVO.getStusCd().equals(stusCd));
		
	}
	@Test
	public void testFindById() {
		//해당 예약 id
		Long id = 3l;
		String userId = "whddn528";
		
		RsvdVO vo = mapper.findById(id);
		
		log.info(vo);
		
	}
	@Test
	public void testGetList() {
		List<RsvdVO> list = mapper.getList();
		
		list.forEach(vo -> log.info(vo));
	}
	
	@Test
	public void testInsert() {
		
		//예약 VO 생성
		RsvdVO vo = RsvdVO.builder()
							.storeId(2l)
							.userId("whddn528")
							.aprvNo(20201111l)
							.pnum(4)
							.time("12:00")
							.stusCd("L")
							.totAmt(20000)
							.totQty(2)
							.build();
		
		mapper.insertSelectKey(vo);
		
	}
	
}
