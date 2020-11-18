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
	
	// ����ڻ��Ϸù�ȣ 
    private long brSeq;

    // ȸ�����̵� 
    private String userId;

    // �����ȣ 
    private long storeId;

    // ����ڵ�Ϲ�ȣ 
    private String brno;

    // ����ڵ�����纻���� 
    private String brPhotoSrc;

    // ����ڵ�Ͻɻ�����ڵ� 
    private String brJdgStusCd;
    
    public static class Builder{

    	//�ʼ� �Է°�
        private long brSeq;
        private String userId;
        private String brno;
        private String brPhotoSrc;
        private String brJdgStusCd;
        
        //���� �Է°�
        private long storeId;

		// �ʼ� �Է°�
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
