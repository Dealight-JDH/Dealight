package com.dealight.domain;

/*
 * 
 * 동인 추가 VO
 * 
 */

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AllStoreVO {
	
	
    private Long storeId;
    private String storeNm;
    private String telno;
    private String clsCd;
    private String seatStusCd;
    private String openTm;
    private String closeTm;
    private String buserId;
    private String breakSttm;
    private String breakEntm;
    private String lastOrdTm;
    private int n1SeatNo;
    private int n2SeatNo;
    private int n4SeatNo;
    private String storeIntro;
    private int avgMealTm;
    private String hldy; 
    private int acmPnum;
	private String addr;
	private double lt;
	private double lo;
    private String park;
    private String nokids;
    private String pg;
    private String wifi;
    private String pet;
    private String smoke;
	private double avgRating;
	private int revwTotNum;
	private int likeTotNum;
	
	// comopisition
	//private StoreVO store;
    
    // composition
    //private BStoreVO bstore;
	
    
    // composition
    //private StoreLocVO loc;
    
    // compoisition
    //private StoreOptionVO option;
    
    // compoisition
    private List<RevwVO> revwList;
 
    // composition
    private List<MenuVO> menuList;
    
    //private StoreEvalVO eval;
    
    // composition
    private List<StoreImgVO> imgs;

    // composition
    private List<StoreTagVO> tagList;
    /*
    
    // composition
    private List<StoreEvalVO> evalList;
    
    
     */
    
/*
    private long storeId;
    private String storeNm;
    private String telno;
    private String clsCd; 
    private String park;
    private String nokids;
    private String pg;
    private String wifi;
    private String pet;
    private String smoke;
	private String addr;
	private int lt;
	private int lo;
    private long id;
    private String cnts;
    private Date regDt; 
    private double rating;
    private String replyCnts;
    private Date replyRegDt;
    private long rsvdId;
    private long waitId;
	private String userId;
    private String seatStusCd;
    private String openTm;
    private String closeTm;
    private String buserId;
    private String breakSttm;
    private String breakEntm;
    private String lastOrdTm;
    private int n1SeatNo;
    private int n2SeatNo;
    private int n4SeatNo;
    private String storeIntro;
    private int avgMealTm;
    private String hldy; 
    private int acmPnum;
  
 
    private String tagNm; 
    private long menuSeq;
    private int price;
    private String name; 
    private String recoMenu;
    private long imgSeq;
	private String imgUrl;
	private double avgRating;
	private int revwTotNum;
	private int likeTotNum;
*/
}
