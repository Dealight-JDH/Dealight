package com.dealight.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.HtdlRsltVO;
import com.dealight.domain.HtdlVO;
import com.dealight.mapper.BStoreMapper;
import com.dealight.mapper.HtdlMapper;

import lombok.extern.log4j.Log4j;

//jongwoo

@Service
@Log4j
public class HtdlTimeCheckService {

	@Autowired
	private HtdlMapper htdlMapper;
	@Autowired
	private BStoreMapper bStoreMapper;
	
	@Autowired
	private HtdlService service;
	
	private List<HtdlVO> lists = null;
	ScheduledThreadPoolExecutor exec = new ScheduledThreadPoolExecutor(3);
	
	@PostConstruct
	public void postConstruct() throws ParseException {
		
		//서버 구동시 한번만 조회하여 데이터 가져오기
		getList();
		log.info(Thread.currentThread().getName());
		log.info("------postConstruct");

		//스케쥴러 실행
		exec.scheduleAtFixedRate(new Runnable() {
			
			@Override
//			@Scheduled(fixedDelay = 1000)
			public void run() {
				// TODO Auto-generated method stub
				try {
					log.info("------check======");
					//서비스 시작
					service(lists);
					log.info("------check"+ Thread.currentThread().getName()+"---------");
				}catch(Exception e){
					e.printStackTrace();
					exec.shutdown();
				}
			}
			
		}, 0, 3, TimeUnit.SECONDS); 
		
	}
	
	@PreDestroy
	public void preDestroy() {
		log.info("============predestroy");
		try {
			exec.shutdown();
			if(!exec.awaitTermination(1, TimeUnit.SECONDS)) {
				log.info("아직 처리중인 작업 존재");
				exec.shutdownNow();
				log.info("작업 강제 종료");
				
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			exec.shutdownNow();
			
		}
		log.info("스케줄러 종료");
	}
	
	//핫딜을 등록할떄마다 리스트에 추가
	public void addHtdl(HtdlVO vo) {
		this.lists.add(vo);
	}

	@Transactional(readOnly = true)
	public void getList() {
		//전체 핫딜 리스트
		this.lists = new ArrayList<>(service.findAll());
	}
	
	@Transactional
	public void service(List<HtdlVO> lists) {
		
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd hh:mm");
			
		//전체 핫딜 리스트
		//List<HtdlVO> lists = htdlMapper.getList();
		
		//핫딜 시작시간	
		List<Date> startTmList = lists.stream()
										.map(vo -> {
											try {
												return format.parse(vo.getStartTm());
											} catch (Exception e) {
												// TODO Auto-generated catch block
												e.printStackTrace();
											}
											return null;
										})
										.collect(Collectors.toList());
	
		//startTmList.forEach(System.out::println);
		log.info("-----------");
		//핫딜 마감시간
		List<Date> endTmList = lists.stream()
										.map(vo -> {
											try {
												return format.parse(vo.getEndTm());
											} catch (ParseException e) {
												// TODO Auto-generated catch block
												throw new RuntimeException(e);
											}
										})
										.collect(Collectors.toList());
	//endTmList.forEach(System.out::println);
	
	
		
		//핫딜 상태 종료가 되어야 한다
		//종료(시간 마감, 인원 마감)
		//핫딜 결과 VO 생성
		//현재 시간
		long sysdateMillis =System.currentTimeMillis();
		Date sysdate = new Date(sysdateMillis);
		log.info("sysdate : " + sysdate);
		
		
		for(int i=0; i< startTmList.size(); i++) {
			
			// 핫딜 시작 전..
			if(isBeforeTime(startTmList.get(i), sysdate)) {
				
				log.info("======핫딜 시작 전======");
				log.info(lists.get(i).getHtdlId()+"번 핫딜 시작 전입니다.. " +lists.get(i).getStartTm());
				
				if(isStusCdCheck(lists.get(i).getStusCd(), "P")) {						
					lists.get(i).setStusCd("P");
					htdlMapper.update(lists.get(i));
					updateStoreHtdlStus(lists.get(i).getStoreId(), "P");
//					int update = bStoreMapper.updateHtdlStus(lists.get(i).getStoreId(), "P");
//					if(update == 1)
//						log.info("매장 핫딜 상태 변경");
					log.info("변화================="+lists.get(i).getHtdlId()+"번 핫딜 핫딜 예정");
				}
				
				
			}else if(isBetweenTime(startTmList.get(i), endTmList.get(i), sysdate)) {
				//핫딜 진행 중..
				log.info("======핫딜 진행중=======");
				log.info(lists.get(i).getHtdlId()+ "번 핫딜 진행중..."+lists.get(i).getStartTm()+" < "+ sysdate + " < " + lists.get(i).getEndTm()+"==========");
				
				if(isStusCdCheck(lists.get(i).getStusCd(), "A")) {
					
					lists.get(i).setStusCd("A");
					htdlMapper.update(lists.get(i));
					updateStoreHtdlStus(lists.get(i).getStoreId(), "A");
//					bStoreMapper.updateHtdlStus(lists.get(i).getStoreId(), "A");
					log.info("변화================="+lists.get(i).getHtdlId()+"번 핫딜 진행 시작!!");
						
				}
				
				//진행중인 상태에서 현재인원이 마감되었을 경우..
				if(isFinished(lists.get(i).getCurPnum(), lists.get(i).getLmtPnum())) {
					if(isStusCdCheck(lists.get(i).getStusCd(), "I")) {
						lists.get(i).setStusCd("I");
						htdlMapper.update(lists.get(i));
						updateStoreHtdlStus(lists.get(i).getStoreId(), "I");
//						bStoreMapper.updateHtdlStus(lists.get(i).getStoreId(), "I");
						log.info("변화==========" +lists.get(i).getHtdlId()+"번 핫딜 안원 마감");
						registerHtdlRsltVO(lists.get(i), htdlMapper, startTmList.get(i), sysdate);
					}
					
				}
			
			}else if(isAfterTime(endTmList.get(i), sysdate)) {
				//핫딜 종료..
				if(isStusCdCheck(lists.get(i).getStusCd(), "I")) {
					lists.get(i).setStusCd("I");
					htdlMapper.update(lists.get(i));
					updateStoreHtdlStus(lists.get(i).getStoreId(), "I");
//					bStoreMapper.updateHtdlStus(lists.get(i).getStoreId(), "I");
					log.info("변화================="+lists.get(i).getHtdlId()+"번 핫딜 시간 종료");
					registerHtdlRsltVO(lists.get(i), htdlMapper, startTmList.get(i), endTmList.get(i));
				}
					
				log.info("======핫딜 종료=======");
				log.info(lists.get(i).getStartTm()+", " + lists.get(i).getEndTm()+ " < " + sysdate );
				
			}
			
			
		}
		//List<Date> filterDate = startTmList.stream().filter(time -> time.before(sysdate)).collect(Collectors.toList());
		log.info("=================");
		//filterDate.forEach(System.out::println);
	
}
	
	
	//매장 핫딜 상태 변경
	public void updateStoreHtdlStus(Long storeId, String stusCd) {
		
		int update = bStoreMapper.updateHtdlStus(storeId, stusCd);
		if(update == 1) {
			
			log.info("매장 핫딜 상태 변경");
			return;
		}
		
		log.info("매장 핫딜 상태 실패");
	}
	//핫딜 상태 변화
	public boolean isStusCdCheck(String currStusCd, String eventStusCd) {
		return !(currStusCd.equals(eventStusCd));
	}
	
	//핫딜 결과 register
	public void registerHtdlRsltVO(HtdlVO htdlVO, HtdlMapper mapper, Date startTime, Date endTime)  {
		SimpleDateFormat format = new SimpleDateFormat("hh:mm:ss");
			htdlVO.setStusCd("I");
			mapper.update(htdlVO);
			
			log.info("핫딜이 마감되었습니다 감사합니다..");
			
			//핫딜 예약률
			int rsvdRate = (htdlVO.getCurPnum() * 100) / htdlVO.getLmtPnum();
			
			log.info("endTime TimeInMillis : "+endTime.getTime());
			log.info("startTIme TImeInMillis : " + startTime.getTime());
			
			//경과시간
			long diffSec = Math.abs(endTime.getTime() - startTime.getTime())/1000; 
			String elapTimeStr = (diffSec / 3600) + ":" + (diffSec % 3600 / 60) + ":" + (diffSec % 3600 % 60);
			Date result = null;
			try {
				result = format.parse(elapTimeStr);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			String elapTime = format.format(result);
			log.info("elapTm: " + elapTime);
			log.info("diffSec : "+diffSec);
			log.info("rsvdRage: " + rsvdRate);
			
			//핫딜 결과vo 생성
			HtdlRsltVO rsltVO = HtdlRsltVO.builder()
					.htdlId(htdlVO.getHtdlId())
					.storeId(htdlVO.getStoreId())
					.lastPnum(htdlVO.getCurPnum())
					.htdlLmtPnum(htdlVO.getLmtPnum())
					.rsvdRate(rsvdRate)
					.elapTm(elapTime).build();
			
			mapper.insertRslt(rsltVO);
		}
	
	//핫딜 시작 전 체크
	public boolean isBeforeTime(Date start, Date sysdate) {
		// TODO Auto-generated method stub
		
		return sysdate.before(start);
	}

	//핫딜 진행중 체크
	public boolean isBetweenTime(Date start, Date end, Date sysdate) {
		// TODO Auto-generated method stub
		return start.before(sysdate) && end.after(sysdate);
	}

	//핫딜 종료 체크
	public boolean isAfterTime(Date end, Date sysdate) {
		// TODO Auto-generated method stub
		return end.before(sysdate);
	}

	//현재인원 == 마감인원
	public boolean isFinished(int curPnum, int lmtPnum) {
		// TODO Auto-generated method stub
		return curPnum == lmtPnum;
	}


	
}
