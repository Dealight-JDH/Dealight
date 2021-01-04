package com.dealight.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
@AllArgsConstructor
public class WaitCheckTask {
	
	private WaitService waitService;
	
	// 새벽 2시가 되면 하루 전(sysdate -1)의 웨이팅을'W' -> 'E'로 변경한다.
	@Scheduled(cron="0 0 0 * * *")
	public void waitInit() throws Exception {
		
		log.warn("Daily Wait Initialization Task run .....................");
		
		int upNum = waitService.waitInit();
		
		log.warn("=========================================초기화 웨이팅 : " + upNum);
		
	}

}
