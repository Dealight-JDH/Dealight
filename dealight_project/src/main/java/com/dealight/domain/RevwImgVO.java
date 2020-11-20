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
    private int revwId;

	// 사진일련번호 
	@NotNull
    private int imgSeq;
	
	// 사진주소
	@NotNull
    private String imgUrl = "";
    
    private Date regDate;
    private Date updateDate;

}
