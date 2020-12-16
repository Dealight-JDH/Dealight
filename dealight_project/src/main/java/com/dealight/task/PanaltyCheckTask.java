package com.dealight.task;

import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.dealight.domain.UserVO;
import com.dealight.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
@AllArgsConstructor
public class PanaltyCheckTask {
	
	private UserService userService;
	
	// 새벽 2시가 되면 일주일 내(sysdate - 7)의 패널티 상태를'Y' -> 'N'로 변경한다.
	//@Scheduled(cron="0 * * * * *")
	public void checkPanaltyDuration() throws Exception {
		
		log.warn("Daily Check Panalty Duration Task run .....................");
		
		int upNum = userService.checkPanaltyDuration();
		
		List<UserVO> userList = userService.getList();
		
		userList.stream().forEach(user -> {
			log.info("user panalty check " +user.getUserId()+" : "+userService.isCurPanalty(user.getPmExpi()));
		});
		
		log.warn("=========================================초기화 웨이팅 : " + upNum);
		
	}

}
