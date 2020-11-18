package com.dealight.domain;

import java.util.Date;

import com.dealight.domain.UserVO.Builder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BUserVO {
	
	// 사업자상세일련번호 
    private long brSeq;

    // 회원아이디 
    private String userId;

    // 매장번호 
    private long storeId;

    // 사업자등록번호 
    private String brno;

    // 사업자등록증사본사진 
    private String brPhotoSrc;

    // 사업자등록심사상태코드 
    private String brJdgStusCd;
    
    public static class Builder{

    	//필수 입력값
        private long brSeq;
        private String userId;
        private String brno;
        private String brPhotoSrc;
        private String brJdgStusCd;
        
        //선택 입력값
        private long storeId;

		// 필수 입력값
		public Builder(long brSeq, String userId, String brno, String brPhotoSrc){
			
			this.brSeq = brSeq;
			this.userId = userId;
			this.brno = brno;
			this.brPhotoSrc = brPhotoSrc;
			this.brJdgStusCd = "W";
			
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
			buser.brJdgStusCd = "W";
			buser.storeId = storeId;
			
			return buser;

		}
	}
}
