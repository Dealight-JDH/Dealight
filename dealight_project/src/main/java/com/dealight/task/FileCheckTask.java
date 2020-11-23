//package com.dealight.task;
//
//
//import java.io.File;
//import java.nio.file.Path;
//import java.nio.file.Paths;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.List;
//import java.util.stream.Collectors;
//import java.util.stream.IntStream;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.scheduling.annotation.Scheduled;
//import org.springframework.stereotype.Component;
//
//import com.dealight.domain.RsvdDtlsVO;
//import com.dealight.domain.RsvdVO;
//import com.dealight.domain.StoreImgVO;
//import com.dealight.domain.UserVO;
//import com.dealight.domain.WaitVO;
//import com.dealight.mapper.RsvdDtlsMapper;
//import com.dealight.mapper.RsvdMapper;
//import com.dealight.mapper.StoreImgMapper;
//import com.dealight.service.RsvdService;
//import com.dealight.service.UserService;
//import com.dealight.service.WaitService;
//
//import lombok.Setter;
//import lombok.extern.log4j.Log4j;
//
///*
// * 
// *****[김동인] 
// * 
// */
//
//@Log4j
//@Component
//public class FileCheckTask {
//	
//	@Setter(onMethod_ = @Autowired)
//	private RsvdService rsvdService;
//	
//	@Setter(onMethod_ = @Autowired)
//	private StoreImgMapper storeImgMapper;
//	
//	@Setter(onMethod_ = @Autowired)
//	private RsvdMapper rsvdMapper;
//	
//	@Setter(onMethod_ = @Autowired)
//	private RsvdDtlsMapper rsvdDtlsMapper;
//	
//	@Setter(onMethod_ = @Autowired)
//	private WaitService waitService;
//	
//	@Setter(onMethod_ = @Autowired)
//	private UserService userService;
//	
//	
//	final static private String ROOT_FOLDER = "C:\\Users\\kjuio\\Desktop\\ex05\\";
//	
//	private String getFolderYesterDay() {
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		
//		Calendar cal = Calendar.getInstance();
//		
//		cal.add(Calendar.DATE, -1);
//		
//		String str = sdf.format(cal.getTime());
//		
//		return str.replace("-", File.separator);
//		
//	}
//	
//	// 자동 웨이팅 생성기
//	//@Scheduled(cron ="0 * * * * *")
//	public void registerOnWait() throws Exception{
//		log.warn("Auto Online Wait Register Task run..................");
//		
//    	List<String> userIdList = new ArrayList<>();
//    	
//    	userIdList.add("kjuioq");
//    	userIdList.add("lim");
//    	userIdList.add("soo");
//    	userIdList.add("bin");
//    	userIdList.add("kim");
//    	userIdList.add("abc");
//    	
//    	List<Long> storeList = new ArrayList<>();
//    	
//    	storeList.add(1L);
//    	storeList.add(10L);
//    	storeList.add(13L);
//    	storeList.add(16L);
//    	storeList.add(18L);
//    	
//    	List<Integer> waitPnumList = new ArrayList<>();
//    	
//    	IntStream stream = IntStream.range(1,10);
//    	
//    	stream.forEach((i) -> {
//    		waitPnumList.add(i);
//    	});
//    	
//    	
//    	int userIdx = (int) (Math.random() * userIdList.size());
//    	int storeIdx = (int) (Math.random() * storeList.size());
//    	int pnumIdx = (int) (Math.random() * waitPnumList.size());
//    	
//        String userId = userIdList.get(userIdx);
//        Long storeId = storeList.get(storeIdx);
//        int waitPnum = waitPnumList.get(pnumIdx);
//        
//        UserVO user = userService.get(userId);
//    	
//    	WaitVO wait = new WaitVO().builder()
//    			.waitId(0L)
//    			.storeId(storeId)
//    			.userId(userId)
//    			.waitRegTm(new Date())
//    			.waitPnum(waitPnum)
//    			.custTelno(user.getTelno())
//    			.custNm(user.getName())
//    			.waitStusCd("W")
//    			.build();
//    	
//    	waitService.registerOnWaiting(wait);
//    	
//    	log.warn(wait);
//    	log.warn("=========================================wait 웨이팅 완료");
//		
//	}
//	
//<<<<<<< HEAD
//	// 자동 예약 생성기
//=======
//
//	// 자동 예약 생성기//
//>>>>>>> 59a0de7d033f2ce631d5f318effec181dd20fc13
//	//@Scheduled(cron="0 * * * * *")
//	public void registerRsvd() throws Exception{
//		log.warn("Auto Rsvd Register Task run .....................");
//		
//    	List<RsvdDtlsVO> list = new ArrayList<>();
//    	
//    	List<String> userIdList = new ArrayList<>();
//    	
//    	userIdList.add("kjuioq");
//    	userIdList.add("lim");
//    	userIdList.add("soo");
//    	userIdList.add("bin");
//    	userIdList.add("kim");
//    	userIdList.add("abc");
//    	
//    	List<String> menuList = new ArrayList<>();
//    	
//    	int userIdx = (int) (Math.random() * userIdList.size());
//    	
//    	List<Long> storeList = new ArrayList<>();
//    	
//    	storeList.add(1L);
//    	storeList.add(10L);
//    	storeList.add(13L);
//    	storeList.add(16L);
//    	storeList.add(18L);
//    	
//    	int storeIdx = (int) (Math.random() * storeList.size());
//    	
//    	List<String> timeList = new ArrayList<>();
//    	
//    	Calendar cal = Calendar.getInstance();
//    	cal.set(2020, 10, 23);
//    	
//    	List<Integer> hourList = new ArrayList<>();
//    	
//    	hourList.add(9);
//    	hourList.add(10);
//    	hourList.add(11);
//    	hourList.add(12);
//    	hourList.add(13);
//    	hourList.add(14);
//    	hourList.add(15);
//    	hourList.add(16);
//    	hourList.add(17);
//    	hourList.add(18);
//    	hourList.add(19);
//    	hourList.add(20);
//    	hourList.add(21);
//    	
//    	int hourIdx = (int) (Math.random() * hourList.size());
//    	
//    	List<Integer> minuteList = new ArrayList<>();
//    	
//    	minuteList.add(0);
//    	minuteList.add(30);
//    	
//    	int minuteIdx = (int) (Math.random() * minuteList.size());
//    	
//        long id = 6;
//        long storeId = 1;
//        String userId = "soo";
//        int pnum = 30;
//        String time = "09:30";
//        String stusCd;
//        int totAmt = 30;
//        int totQty = 30;
//    	
//    	//예약 상세 정보
//        long rsvdId = 9;
//        long rsvdtSeq = 22;
//        String menuNm = "떡볶이";
//        int menuTotQty = 5;
//        int menuPrc = 3000;
//        
//        long htdlId = 121;
//        
//        
//        userId = userIdList.get(userIdx);
//        storeId = storeList.get(storeIdx);
//    	cal.set(2020, 11, 23);
//    	cal.set(cal.HOUR_OF_DAY,hourList.get(hourIdx));
//    	cal.set(cal.MINUTE, minuteList.get(minuteIdx));
//    	
//    	SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy/MM/dd HH:mm:ss");
//        
//    	RsvdVO rsvd = new RsvdVO().builder()
//    			.rsvdId(id)
//    			.htdlId(htdlId)
//				.storeId(storeId)
//				.userId(userId)
//				.pnum(pnum)
//				.time(formatter.format(new Date(cal.getTimeInMillis())))
//				.totAmt(totAmt)
//				.totQty(totQty)
//				.stusCd("C")
//				.build();
//    	
//    	rsvdMapper.insertSelectKey(rsvd);
//    	
//    	rsvdId = rsvd.getRsvdId();
//    	
//    	log.warn(rsvd);
//    	
//
//    	RsvdDtlsVO rsvdDtls = new RsvdDtlsVO().builder()
//				.rsvdId(rsvdId)
//				.menuNm(menuNm)
//				.menuTotQty(menuTotQty)
//				.menuPrc(menuPrc)
//				.build();
//    	
//    	
//    	RsvdDtlsVO rsvdDtls2 = new RsvdDtlsVO().builder()
//				.rsvdId(rsvdId)
//				.menuNm("순대")
//				.menuTotQty(menuTotQty)
//				.menuPrc(menuPrc)
//				.build();
//    	
//    	
//    	RsvdDtlsVO rsvdDtls3 = new RsvdDtlsVO().builder()
//				.rsvdId(rsvdId)
//				.menuNm("튀김")
//				.menuTotQty(menuTotQty)
//				.menuPrc(menuPrc)
//				.build();
//    	
//    	list.add(rsvdDtls);
//    	list.add(rsvdDtls2);
//    	list.add(rsvdDtls3);
//    	
//    	log.warn(list);
//    	
//    	int result = rsvdDtlsMapper.insertRsvdDtls(list);
//    	
//    	
//    	log.warn(result);
//		log.warn("=========================================rsvd 예약 완료");
//	}
//
//<<<<<<< HEAD
////	@Scheduled(cron="0 10 * * * *")
//=======
//	//@Scheduled(cron="0 10 * * * *")
//>>>>>>> 59a0de7d033f2ce631d5f318effec181dd20fc13
//	public void checkFiles() throws Exception{
//		
//		log.warn("Image File Check Task run .....................");
//		Date date = new Date();		
//		log.warn("=========================================date : " + date);
//		
//		// file list in database
//		List<StoreImgVO> fileList = storeImgMapper.getOldFiles();
//		
//		// ready for check file in directory with database file list
//		List<Path> fileListPaths = fileList.stream()
//				.map(vo -> Paths.get(ROOT_FOLDER, vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
//				.collect(Collectors.toList());
//		
//		
//		// image file has thumnail file
//		fileList.stream().filter(vo -> vo.isImage() == true)
//			.map(vo -> Paths.get(ROOT_FOLDER, vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
//			.forEach(p -> fileListPaths.add(p));
//			
//		log.warn("===========================================");
//		
//		fileListPaths.forEach(p -> log.warn(p));
//		
//		// files in yesterday directory
//		File targetDir = Paths.get(ROOT_FOLDER, getFolderYesterDay())
//				.toFile();
//		
//		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
//		
//		log.warn("---------------------------------------------");
//		for(File file : removeFiles) {
//			
//			log.warn(file.getAbsolutePath());
//			file.delete();
//		}
//	}
//}
