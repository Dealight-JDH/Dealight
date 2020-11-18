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
public class RevwImgVO {

    // 리뷰번호 
    private int revwId;

    // 사진일련번호 
    private int imgSeq;

    // 사진주소
    private String imgUrl = "";
    
    private Date regdate;
    private Date updatedate;

}
