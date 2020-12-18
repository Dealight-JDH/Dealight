
package com.dealight.task;


import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.dealight.domain.RsvdDtlsVO;
import com.dealight.domain.RsvdVO;
import com.dealight.domain.StoreImgVO;
import com.dealight.domain.StoreVO;
import com.dealight.domain.UserVO;
import com.dealight.domain.WaitVO;
import com.dealight.handler.ManageSocketHandler;
import com.dealight.mapper.RsvdDtlsMapper;
import com.dealight.mapper.RsvdMapper;
import com.dealight.mapper.StoreImgMapper;
import com.dealight.service.RsvdService;
import com.dealight.service.StoreService;
import com.dealight.service.UserService;
import com.dealight.service.WaitService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

/*
 * 
 *****[김동인] 
 * 
 */

@Log4j
@Component
@AllArgsConstructor
public class FileCheckTask {
	
	@Setter(onMethod_ = @Autowired)
	private StoreImgMapper storeImgMapper;
	
	@Setter(onMethod_ = @Autowired)
	private WaitService waitService;
	
	@Setter(onMethod_ = @Autowired)
	private UserService userService;
	
	@Setter(onMethod_ = @Autowired)
	private StoreService storeService;
	
	final static private String ROOT_FOLDER = "C:\\Users\\kjuio\\Desktop\\ex05\\";
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
		
	}
	
	// 새벽 2시가 되면 하루 전(sysdate-1)의 DB의 파일을 체크한다.
	//@Scheduled(cron="0 0 2 * * *")
	public void checkFiles() throws Exception{
		
		log.warn("Daily Image File Check Task run .....................");
		Date date = new Date();		
		log.warn("=========================================date : " + date);
		
		// file list in database
		List<StoreImgVO> fileList = storeImgMapper.getOldFiles();
		
		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get(ROOT_FOLDER, vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());
		
		
		// image file has thumnail file
		fileList.stream().filter(vo -> vo.isImage() == true)
			.map(vo -> Paths.get(ROOT_FOLDER, vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
			.forEach(p -> fileListPaths.add(p));
			
		log.warn("===========================================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		// files in yesterday directory
		File targetDir = Paths.get(ROOT_FOLDER, getFolderYesterDay())
				.toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("---------------------------------------------");
		for(File file : removeFiles) {
			
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
}
