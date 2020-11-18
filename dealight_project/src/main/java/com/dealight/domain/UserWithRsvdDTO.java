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
	
		private String userId;

		private String name;

		private String pwd;

		private String email;

		private String telno;

		private String brdt;

		private String sex;

		private String photoSrc;

		private String snsLginYn = "N";

		private String clsCd = "C";

		private String pmStus = "N";

		private int pmCnt = 0;

		private Date pmExpi;
		// composition
		private List<RsvdDtlsVO> rsvdDtlsList;
		
		@NonNull
	    private Long rsvdId;

		@NonNull
	    private Long storeId;

	    private Long htdlId;

	    private int aprvNo;

	    @NonNull
	    private int pnum;

	    @NonNull
	    private String time;

	    @NonNull
	    @Builder.Default
	    private String stusCd = "P";

	    @NonNull
	    private int totAmt;

	    @NonNull
	    private int totQty;
	    
	    private Date inDate;

}
