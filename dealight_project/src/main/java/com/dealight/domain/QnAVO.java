package com.dealight.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnAVO {

	private long qnaId;
	private int qnaOrd;
	private String userId;
	private String qnaTitle;
	private String qnaCnts;
	private String qClsCd;
	private Date regdate;
	private Date updatedate;
}
