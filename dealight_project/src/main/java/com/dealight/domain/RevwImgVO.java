package com.dealight.domain;
// 수빈
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RevwImgVO {
	
	// 리뷰번호 
	@NotNull
    private Long revwId;

	// 사진일련번호 
	@NotNull
    private Long imgSeq;
	
	String fileName;
	String uuid;
	String uploadPath;
	boolean image;
	private String rep;
	
    private String regdate;
    private String updatedate;

}
