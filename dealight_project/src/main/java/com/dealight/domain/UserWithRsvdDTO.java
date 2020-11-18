package com.dealight.domain;

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
public class UserWithRsvdDTO {
	
	// ȸ�����̵� 
		private String userId;

		// ȸ���̸� 
		private String name;

		// ȸ����й�ȣ 
		private String pwd;

		// ȸ���̸��� 
		private String email;

		// ȸ����ȭ��ȣ 
		private String telno;

		// ������� 
		private String brdt;

		// ���� 
		private String sex;

		// ȸ�������ʻ��� 
		private String photoSrc;

		// �Ҽȷα��ο��� 
		private String snsLginYn = "N";

		// ȸ�������ڵ� 
		private String clsCd = "C";

		// �г�Ƽȸ������ 
		private String pmStus = "N";

		// �г�ƼȽ�� 
		private int pmCnt = 0;

		// �г�Ƽ�������� 
		private Date pmExpi;
		// composition
		private List<RsvdDtlsVO> rsvdDtlsList;
		
	    // �����ȣ 
		@NonNull
	    private Long id;

	    // �����ȣ
		@NonNull
	    private Long storeId;


	    // �ֵ���ȣ 
	    private Long htdlId;

	    // �������ι�ȣ 
	    private int aprvNo;

	    // �����ο�
	    @NonNull
	    private int pnum;

	    // ����ð�
	    @NonNull
	    private String time;

	    // ��������ڵ�
	    @NonNull
	    @Builder.Default
	    private String stusCd = "P";

	    // �����Ѿ�
	    @NonNull
	    private int totAmt;

	    // �Ѹ޴�����
	    @NonNull
	    private int totQty;
	    
	    private Date inDate;

}
