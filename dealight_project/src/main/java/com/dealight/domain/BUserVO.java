package com.dealight.domain;

import java.util.Date;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

/*
 * 
 *****[김동인] ,현중 
 * 
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BUserVO {
	//사업자상세 일련번호
    private Long brSeq;
    //회원아이디
    private String userId;
    //매장번호
    private Long storeId;
    //사업자등록번호
    private String brno;
    //사업자등록증사본사진
    private String brPhotoSrc;
    //사업자등록심사상태코드
    private String brJdgStusCd="P";
    //매장명
    private String storeNm;
    //매장전화번호
    private String telno;
    //휴대전화번호
    private String storeTelno;
    //대표자명
    private String repName;
    //탈락사유
    private String reason;
    
    
 	private Date regdate;
 	private Date updatedate;
    
    public static class Builder{

    	//필수매개변수
        private long brSeq;
        private String userId;
        private String brno;
        private String brPhotoSrc;
        private String brJdgStusCd;
        private String storeNm;
        private String telno;
        private String storeTelno;
        
        private long storeId;

		public Builder(long brSeq, String userId, String brno, String brPhotoSrc, String storeNm, String telno, String storeTelno){
			
			this.brSeq = brSeq;
			this.userId = userId;
			this.brno = brno;
			this.brPhotoSrc = brPhotoSrc;
			this.brJdgStusCd = "W";
			this.storeNm = storeNm;
			this.telno = telno;
			this.storeTelno = storeTelno;
			
		}

		public Builder setStoreId(long storeId){

			this.storeId = storeId;

			return this;
		}



		public BUserVO build(){

			BUserVO buser = new BUserVO();

			buser.brSeq = brSeq;
			buser.userId = userId;
			buser.brno = brno;
			buser.brPhotoSrc = brPhotoSrc;
			buser.brJdgStusCd = brJdgStusCd;
			buser.storeId = storeId;
			buser.storeNm = storeNm;
			buser.telno = telno;
			buser.storeTelno = storeTelno;
			
			return buser;

		}
	}
}
