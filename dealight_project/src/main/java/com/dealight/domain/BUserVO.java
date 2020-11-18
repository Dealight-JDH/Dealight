package com.dealight.domain;

import java.util.Date;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BUserVO {
	
    private Long brSeq;

    private String userId;

    private Long storeId;

    private String brno;

    private String brPhotoSrc;

    private String brJdgStusCd;
    
    public static class Builder{

        private long brSeq;
        private String userId;
        private String brno;
        private String brPhotoSrc;
        private String brJdgStusCd;
        
        private long storeId;

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
