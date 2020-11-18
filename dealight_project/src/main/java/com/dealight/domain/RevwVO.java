package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RevwVO {

	    // �����ȣ 
		@NonNull
	    private long id;

	    // �����ȣ 
		@NonNull
	    private long storeId;

	    // �����ȣ 
	    private long rsvdId;

	    // �����ù�ȣ 
	    private long waitSeq;

	    // ȸ�����̵� 
	    @NonNull
	    private String userId;

	    // ���䳻��
	    @NonNull
	    private String cnts;

	    // �����ۼ���¥
	    @NonNull
	    private Date regDt;

	    // ���� 
	    @NonNull
	    private double rating;

	    // ��۳���
	    @NonNull
	    private String replyCnts;

	    // ��۵�ϳ�¥
	    @NonNull
	    private Date replyRegDt;

}
