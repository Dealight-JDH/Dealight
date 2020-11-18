package com.dealight.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;

public class AllStoreVOTests {

    private long storeId = 13;
    private String storeNm = "��������";
    private String telno = "010-2737-5157";
    private String clsCd = "I";
    // �����ȣ 

    // �ؽ��±��̸� 
    private String tagNm = "�н�";
    // �����ȣ 
    private String park = "Y";
    private String nokids = "Y";
    private String pg = "N";
    private String wifi = "N";
    private String pet = "N";
    private String smoke = "N";
	private String addr = "�ּ�";
	private double lat = 90;
	private double lng = 30;
	private long imgSeq = 1;
	private String imgUrl = "/a.jpg";
	private double avgRating = 4.5;
	private int revwTotNum = 5;
	private int likeTotNum = 25;
	// �ʼ� �Է°�
    private long id = 1;
    private String cnts = "�ʹ� ���־��~";
    private String regDt = "20201113"; 
    private double rating = 5.5;
    private String replyCnts = "�� �����ּ���~";
    private String replyRegDt = "20201107";
    
    // ���� �Է°�
    private long rsvdId = 1;
    private long waitId = 1;
	// �ʼ� �Է°�
    private long menuSeq = 1;
    private int price = 5000;
    private String name = "���"; 
    private String recoMenu;

    //���� �Է°�
	private String userId = "kjuioq";
	
    private String seatStusCd;
    private String openTm = "09:30";
    private String closeTm = "21:30";
    
    private String buserId = "kjuioq";
    private String breakSttm = "15:00";
    private String breakEntm = "16:00";
    private String lastOrdTm = "21:00";
    private int n1SeatNo = 8;
    private int n2SeatNo = 10;
    private int n4SeatNo = 5;
    private String storeIntro = "�ȳ�?";
    private int avgMealTm = 30;
    private String hldy = "�Ͽ���"; 
    private int acmPnum = 40;
    
    @Test
    public void test() {
    	
    }
    
	// 2. ��� �Է°� �׽�Ʈ
	@Test
	public void AllStoreDTOGenerateTest() {
		
		StoreVO store = new StoreVO().builder()
				.storeId(storeId)
				.storeNm(storeNm)
				.telno(telno)
				.clsCd(clsCd)
				.build();
    	StoreTagVO stag = new StoreTagVO().builder()
    			.storeId(storeId)
    			.tagNm(tagNm)
    			.build();
		StoreOptionVO sopt = new StoreOptionVO.StoreOptionVOBuilder()
				.park(park)
				.nokids(nokids)
				.pg(pg)
				.wifi(wifi)
				.pet(pet)
				.smoke(smoke)
				.storeId(storeId)
				.build();
		StoreLocVO sloc = new StoreLocVO.StoreLocVOBuilder()
				.addr(addr)
				.lat(lat)
				.lng(lng)
				.storeId(storeId)
				.build();
		StoreImgVO simg = new StoreImgVO.StoreImgVOBuilder()
				.storeId(storeId)
				.imgSeq(imgSeq)
				.build();
		StoreEvalVO seval = new StoreEvalVO.StoreEvalVOBuilder()
				.storeId(storeId)
				.avgRating(avgRating)
				.revwTotNum(revwTotNum)
				.likeTotNum(likeTotNum)
				.build();
		RevwVO review = new RevwVO.RevwVOBuilder()
				.revwId(id)
				.storeId(storeId)
				.userId(userId)
				.cnts(cnts)
				.regDt(regDt)
				.rating(rating)
				.replyCnts(replyCnts)
				.replyRegDt(replyRegDt)
				.rsvdId(rsvdId)
				.waitId(waitId)
				.build();
		MenuVO menu = new MenuVO.MenuVOBuilder()
				.storeId(storeId)
				.menuSeq(menuSeq)
				.price(price)
				.name(name)
				.build();
		LikeVO like = new LikeVO.LikeVOBuilder()
				.storeId(storeId)
				.userId(userId)
				.build();
		BStoreVO bstore = new BStoreVO.BStoreVOBuilder()
				.storeId(storeId)
				.openTm(openTm)
				.closeTm(closeTm)
				.breakSttm(breakSttm)
				.breakEntm(breakEntm)
				.lastOrdTm(lastOrdTm)
				.n1SeatNo(n1SeatNo)
				.n2SeatNo(n2SeatNo)
				.n4SeatNo(n4SeatNo)
				.storeIntro(storeIntro)
				.avgMealTm(avgMealTm)
				.hldy(hldy)
				.acmPnum(acmPnum)
				.build();
		
		List<MenuVO> menuList = new ArrayList();
		menuList.add(menu);
	    
		List<StoreEvalVO> evalList = new ArrayList();
		evalList.add(seval);
	    
	    List<StoreImgVO> imgs = new ArrayList();
	    imgs.add(simg);
		
	    List<StoreTagVO> tagList = new ArrayList();
	    tagList.add(stag);
	    
	    List<RevwVO> revwList = new ArrayList();
	    revwList.add(review);
	    
	    AllStoreVO allStore = new AllStoreVO().builder()
	    		.imgs(imgs)
	    		.menuList(menuList)
	    		.revwList(revwList)
	    		.tagList(tagList)
				.storeNm(storeNm)
				.telno(telno)
				.clsCd(clsCd)
				.park(park)
				.nokids(nokids)
				.pg(pg)
				.wifi(wifi)
				.pet(pet)
				.smoke(smoke)
				.addr(addr)
				.lat(lat)
				.lng(lng)
				.storeId(storeId)
				.avgRating(avgRating)
				.revwTotNum(revwTotNum)
				.likeTotNum(likeTotNum)
				.storeId(storeId)
				.openTm(openTm)
				.closeTm(closeTm)
				.breakSttm(breakSttm)
				.breakEntm(breakEntm)
				.lastOrdTm(lastOrdTm)
				.n1SeatNo(n1SeatNo)
				.n2SeatNo(n2SeatNo)
				.n4SeatNo(n4SeatNo)
				.storeIntro(storeIntro)
				.avgMealTm(avgMealTm)
				.hldy(hldy)
				.acmPnum(acmPnum)
	    		.build();
	    	
	    
		
		/*
		AllStoreVO allStore = new AllStoreVO().builder()
				.storeNm(storeNm)
				.telno(telno)
				.clsCd(clsCd)
				.tagNm(tagNm)
				.park(park)
				.nokids(nokids)
				.pg(pg)
				.wifi(wifi)
				.pet(pet)
				.smoke(smoke)
				.addr(addr)
				.lt(lt)
				.lo(lo)
				.imgSeq(imgSeq)
				.imgUrl(imgUrl)
				.storeId(storeId)
				.avgRating(avgRating)
				.revwTotNum(revwTotNum)
				.likeTotNum(likeTotNum)
				.id(id)
				.userId(userId)
				.cnts(cnts)
				.regDt(regDt)
				.rating(rating)
				.replyCnts(replyCnts)
				.replyRegDt(replyRegDt)
				.rsvdId(rsvdId)
				.waitId(waitId)
				.menuSeq(menuSeq)
				.price(price)
				.name(name)
				.userId(userId)
				.storeId(storeId)
				.openTm(openTm)
				.closeTm(closeTm)
				.breakSttm(breakSttm)
				.breakEntm(breakEntm)
				.lastOrdTm(lastOrdTm)
				.n1SeatNo(n1SeatNo)
				.n2SeatNo(n2SeatNo)
				.n4SeatNo(n4SeatNo)
				.storeIntro(storeIntro)
				.avgMealTm(avgMealTm)
				.hldy(hldy)
				.acmPnum(acmPnum)
				.build();
		*/
		System.out.println(allStore);
		
	}
	
}
