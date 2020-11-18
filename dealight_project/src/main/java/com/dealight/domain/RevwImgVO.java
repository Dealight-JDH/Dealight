package com.dealight.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RevwImgVO {

    // 리뷰번호 
    private int revwId;

    // 사진일련번호 
    private int imgSeq;

    // 사진주소
    private String imgUrl = "";
    
    private Date regDate;
    private Date updateDate;

}
