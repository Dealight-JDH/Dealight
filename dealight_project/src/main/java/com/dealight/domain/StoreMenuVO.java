package com.dealight.domain;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.lang.Nullable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class StoreMenuVO {

	//매장 번호
	@NotNull
    private Long storeId;

    //메뉴 일련번호
	@NotNull
    private Long menuSeq;

    //가격
	@NotNull
    private int price;
    
    //메뉴 사진
	@Nullable
    private String imgUrl;
    
    //메뉴이름
	@NotBlank
    private String name;
	
    //등록 날짜
	@NotNull
    private Date regDate;
    
    //수정 날짜
	@NotNull
    private Date updateDate;
}
