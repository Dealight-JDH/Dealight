package com.dealight.task;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.dealight.domain.RsvdTimeDTO;
import com.dealight.service.PymtService;
import com.dealight.service.RsvdService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
@RequiredArgsConstructor
public class RsvdTask {

	private final RsvdService service;
	private final PymtService pymtService;
	
	//새벽 12시마다 결제 취소 delete
	@Scheduled(cron = "0 0 0 * * *")
	public void cancelRemove() {
		log.info("pymt cancel list remove...");
		pymtService.removeCancelAll();
	}
	
	//새벽 2시마다 예약 가능 테이블 초기화
	//@Scheduled(cron = "0 0 2 * * *")
	//@Scheduled(cron = "0 * * * * *")
	//@Scheduled(cron = "0 * * * * *")
//	@Transactional
	public void initRsvdAvail() {
	
		log.info("rsvd avail init.....");
		service.removeRsvdAvail();
		service.initRsvdAvail();
	}
	
	//매일 9-20시까지 30분 마다 실행하여 상태 체크 및 변경
	@Scheduled(cron = "0 0/30 9,20 * * *")
	//@Scheduled(cron = "0 * * * * *")
	public void checkRsvdStus() {
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		long sysdateMillis = System.currentTimeMillis();
		Date sysdate = new Date(sysdateMillis);
		
		log.warn("======================");
		log.warn("rsvd stus check.......");
		log.warn("=====================");
		
		List<RsvdTimeDTO> currRsvdList = service.getCurrRsvdList();
		
		log.info("current rsvd list: " + currRsvdList);
		
		if(currRsvdList.size()>0 && currRsvdList != null) {
			
			//현재시간보다 이전인 예약 시간 리스트에 담기
			List<RsvdTimeDTO> lastRsvdList =  currRsvdList.stream().filter(rsvd -> {
				try {
					return format.parse(rsvd.getTime()).before(sysdate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return false;
			}).collect(Collectors.toList());
			
			
			log.info("change rsvd stus List" + lastRsvdList);
			
			
			//과거 예약 상태 변경
			for(RsvdTimeDTO dto : lastRsvdList) {
				dto.setStusCd("L");
				boolean result = service.modifyStusCd(dto.getRsvdId(), dto.getStusCd());
				
				if(result)
					log.info(dto.getRsvdId()+ "번 예약번호가 과거예약으로 변경되었습니다.");
				else
					log.info("예약 상태 변경 실패!");
			}
		}
		
	}
}
