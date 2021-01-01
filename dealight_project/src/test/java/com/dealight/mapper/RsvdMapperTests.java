package com.dealight.mapper;


import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.BStoreVO;
import com.dealight.domain.Criteria;
import com.dealight.domain.RsvdAvailVO;
import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdTimeDTO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.RsvdWithStoreDTO;
import com.dealight.domain.UserWithRsvdDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class RsvdMapperTests {
	@Autowired
	private RsvdMapper mapper;
	
	@Autowired
	private BStoreMapper bMapper;
	//TODO 예약 상세 테스트
	
	@Test
	public void testSelectStoreWithAcmpnum() {
		BStoreVO vo = bMapper.selectStoreWithAcmPnum(103l);
		
		log.info("============VO: " + vo);
	}
	@Test
	public void testFindLastWeekRsvdRateListByStoreId() {
		
		//List<RsvdWithStoreDTO> vo = bMapper.findLastWeekRsvdRateListByStoreId();
		List<RsvdWithStoreDTO> vo = bMapper.findLastWeekRsvdPnum(7);
		vo.forEach(a -> log.info(a));
	}
	
	@Test
	public void testCheckExistHtdl() {
		String userId = "whddn528";
		Long htdlId = 13l;
		int count = mapper.checkExistHtdl(userId, htdlId);
		
		log.info("htdl exist count: " + count);
	}
	
	@Test
	public void updateRsvdAvail() {
		log.info("update rsvdAvail...");
		Long storeId = 3l; 
		RsvdAvailVO availVO = mapper.findRsvdAvailByStoreId(storeId);
		
		//예약 가능인원 수정
		availVO.setEighteen(8);
		mapper.updateRsvdAvail(availVO);
		
		RsvdAvailVO resultVO = mapper.findRsvdAvailByStoreId(availVO.getStoreId());
		
		log.info("update result : " + resultVO);
		
	}
	@Test
	public void getRsvdAvailList() {
		log.info("get rsvd Avail list....");
		List<RsvdAvailVO> list = mapper.getRsvdAvailList();
		
		list.forEach(avail -> log.info("get avail List... "+ avail));
		
	
	}
	@Test
	public void findRsvdAvail() {
		log.info("select rsvdAvail...");
		
		Long storeId = 3l;
		RsvdAvailVO findVO = mapper.findRsvdAvailByStoreId(storeId);
		
		log.info("find availVO : " + findVO);
		
	}
	
	@Test
	public void deleteRsvdAvail() {
		log.info("delete rsvdAvail..");
		mapper.deleteRsvdAvail();
	}
	
	@Test
	public void insertRsvdAvail() {
		
		log.info("insert rsvdAvail...");
		RsvdAvailVO rAvailability = RsvdAvailVO.builder()
											.storeId(1l).nine(10).nineHalf(10).ten(10).tenHalf(10).eleven(10).elevenHalf(10)
											.twelve(10).twelveHalf(10).thirteen(10).thirteenHalf(10).fourteen(10).fourteenHalf(10)
											.fifteen(10).fifteenHalf(10).sixteen(10).sixteenHalf(10).seventeen(10).seventeenHalf(10)
											.eighteen(10).eighteenHalf(10).nineteen(10).nineteenHalf(10)
											.build();
		mapper.insertRsvdAvail(rAvailability);
		
	}
	
	
	@Test
	public void findCurrRsvd() {
		
		List<RsvdTimeDTO> list = mapper.findCurrRsvd();
		
		list.forEach(rsvd -> log.info("======" + rsvd));
	}
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
							.aprvNo("202011073583l")
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
		String aprvNo = "202011075392l";
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
							.aprvNo("20201111l")
							.pnum(4)
							.time("12:00")
							.stusCd("L")
							.totAmt(20000)
							.totQty(2)
							.build();
		
		mapper.insertSelectKey(vo);
		
	}
	
	
    private Long id = 6L;
    private Long storeId = 13L;
    private String userId = "kjuioq";
    private int pnum = 30;
    private String time = "09:30";
    private String stusCd = "b";
    private int totAmt = 30;
    private int totQty = 30;
    
    private long htdlId = 10;
    private int aprvNo = 1111;
    
    
    // create
    
    
    // read
    @Test
    public void findTest1() {
    	

    	RsvdVO rsvd = mapper.findById(id);
    	
    	assertNotNull(rsvd);
    }
    
    // read
    @Test
    public void findByUserIdTest1() {
    	

    	List<RsvdVO> list = mapper.findByUserId(userId);
    	
    	assertNotNull(list);
    }
    
    
    
    // read list
    // find by store
    @Test
    public void findRsvdListByStoreTest1() {
    	List<RsvdVO> list = mapper.findByStoreId(storeId);
    	
    	log.info(list);
    	
    	assertNotNull(list);
    	
    	list.forEach((rsvd) -> {
    		assertTrue(rsvd.getStoreId() == storeId);
    	});

    	
    }
    
    // read list
    // find by store and stus_cd
    @Test
    public void findRsvdListByStoreAndStusCdTest1() {
    	
    	String curStus = "P";
    	
    	List<RsvdVO> list = mapper.findByStoreIdAndCurStus(storeId, curStus);
    	
    	log.info(list);
    	
    	assertNotNull(list);
    	
    	list.forEach((rsvd) -> {
    		assertTrue(rsvd.getStoreId() == storeId);
    		assertTrue(rsvd.getStusCd().equals(curStus));
    	});

    	
    }
    
    // read list
    // find by store and today
//    @Test
//    public void findRsvdListByStoreTodayTest1() {
//
//    	
//    	LocalDate currentDate = LocalDate.now();
//    	
//    	log.info(currentDate);
//    	
//    	DateTimeFormatter dateTimeForMatter = DateTimeFormatter.ofPattern("yyyyMMdd");
//    	
//    	String today = currentDate.format(dateTimeForMatter);
//    	
//    	log.info("today............................." + today);
//    	
//    	List<RsvdVO> list = mapper.findByStoreIdToday(storeId, today);
//    	
//
//    	log.info(list);
//    	
//    	assertNotNull(list);
//    	
//		String pattern = "yyyyMMdd";
//		
//		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
//    	
//    	list.forEach((rsvd) -> {
//    		assertTrue(rsvd.getStoreId() == storeId);
//    		assertTrue(simpleDateFormat.format(rsvd.getRegDate()).equals(today));
//    	});
//    	 
//    	
//    }
    
    // read list
    // find by store and date
    @Test
    public void findRsvdListByStoreAndDateTest1() {
    	
    	String date = "20201107";
    	storeId = 13L;
    	
    	List<RsvdVO> list = mapper.findByStoreIdAndDate(storeId, date);

    	log.info("list................................................"+list);
    	
    	assertNotNull(list);
    	
    	
    	list.forEach((rsvd) -> {
    		assertTrue(rsvd.getStoreId() == storeId);
    		assertTrue(rsvd.getRegdate().equals(date));
    	});
    	 
    	
    }
    
    // read list
    // find by store and user
    @Test
    public void findRsvdListByStoreAndUserTest1() {
    	List<RsvdVO> list = mapper.findByStoreIdAndUserId(13, "kjuioq");
    	
    	log.info(list);
    	
    	assertNotNull(list);

    }
    
    // read list
    // find menu cnt by store and date 
    @Test
    public void findMenuCntByStoreIdAndDateTest() {
    	
    	List<HashMap<String,Object>> map =  mapper.findMenuCntByStoreIdAndDate(101, "20201110");
    	
    	log.info(map);
    	
    	HashMap<String,Integer> hash = new HashMap<String, Integer>();
    	

    	
    	map.stream().forEach((m) -> {
    		log.info("test............"+m.get("MENU_NM"));
    		log.info("test............"+m.get("COUNT(*)"));
    		hash.put((String) m.get("MENU_NM"), Integer.parseInt(m.get("COUNT(*)").toString()));
    		
    	});
    	
    	//hash.put((String) m.get("MENU_NM"),(Integer) m.get("COUNT(*)"));
    	
    	log.info(hash);
    		
    }
    
    // read list
    // find menu cnt by store and date 
    @Test
    public void findUserByStoreIdAndDateAndStusTest1() {
    	
    	storeId = 101L;
    	
    	List<UserWithRsvdDTO> map =  mapper.findUserByStoreIdAndDate(storeId, "20201115");
    	
    	log.info(map);
    	
    }
    
    // update
    @Test
    public void updateTest1() {
    	
    	id = 24L;
    	
    	RsvdVO rsvd = new RsvdVO().builder()
    			.rsvdId(id)
				.storeId(storeId)
				.userId(userId)
				.htdlId(htdlId)
				.pnum(pnum)
				.time("����")
				.totAmt(totAmt)
				.totQty(totQty)
				.stusCd("C")
				.build();
    	
    	String bf = mapper.findById(id).getTime();

    	int result = mapper.update(rsvd);
    	
    	assertTrue(result == 1);
    	
    	rsvd = mapper.findById(id);
    	
    	assertTrue(!bf.equals(rsvd.getTime()));
    	
    	rsvd.setTime(bf);
    	
    	result = mapper.update(rsvd);
    	
    	assertTrue(result == 1);
    }
    
    // delete
    @Test
    public void deleteTest1() {
    	
    	int result = mapper.delete(id);
    	
    	assertTrue(result == 1);
    	
    }
    
    @Test
    public void findRsvdByRsvdIdWithDtlsTest1() {
    	
    	long rsvdId = 151;
    	
    	RsvdVO rsvd = mapper.findRsvdByRsvdIdWithDtls(rsvdId);
    	
    	assertNotNull(rsvd);
    	
    	log.info(rsvd);
    	
    }
    
    @Test
    public void findLastWeekRsvdListByStoreIdTest1() {
    	
    	
    	long storeId = 101;
    	
    	List<RsvdVO> list = mapper.findLastWeekRsvdListByStoreId(storeId);
    	
    	assertNotNull(list);
    	
    	log.info(list);
    	
    }
    
    @Test
    public void findRsvdListWithPagingByUserIdTest1() {
    	
    	userId = "kjuioq";
    	Criteria cri = new Criteria(1,3);
    	
    	List<RsvdVO> list = mapper.findRsvdListWithPagingByUserId(userId, cri);
    	
    	list.stream().forEach((rsvd) -> {
    		
    		log.info("rsvd : " + rsvd);
    	});
    	
    	log.info("list size : "+list.size());
    	
    }
    
    @Test
    public void findRsvdListWithPagingAndDtlsByUserIdTest1() {
    	
    	userId = "aaaa";
    	Criteria cri = new Criteria(1,3);
    	
    	List<RsvdVO> list = mapper.findRsvdListWithPagingAndDtlsByUserId(userId, cri);
    	
    	list.stream().forEach((rsvd) -> {
    		
    		log.info("rsvd : " + rsvd);
    		log.info("rsvd dtls list : " + rsvd.getRsvdDtlsList());
    	});
    	
    	log.info("list size : "+list.size());
    	
    }

    @Test
    public void getRsvdTotalCountTest1() {
    	
    	userId = "kjuioq";
    	Criteria cri = new Criteria(1,3);
    	
    	int last = mapper.getRsvdCount(userId, cri, "L");
    	int complete = mapper.getRsvdCount(userId, cri, "C");
    	int panalty = mapper.getRsvdCount(userId, cri, "P");
    	int total = mapper.getRsvdTotalCount(userId, cri);
    	
    	log.info("last........................."+last);
    	log.info("complete........................."+complete);
    	log.info("panalty........................."+panalty);
    	log.info("total........................."+total);
    	
    }

}
