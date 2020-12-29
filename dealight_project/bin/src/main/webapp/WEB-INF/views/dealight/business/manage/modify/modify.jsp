<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 수정</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0f892675ba.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/manage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script src="/resources/js/Rater.js"></script>
<style>
	.file_body img {
	
	width : 100px;
	height : 100px;
	
	}
	main{
		margin : 30px auto;
		width:1050px;
		height:auto;
	}
	.selected_img{
		border : 4px red solid;
	}
	#modify_board{
	 	width: 100%;
        height: 95%;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: flex-start;
        overflow-y:scroll;
        overflow-x: hidden;
    }
    
    /*modify_noti*/
    .modify_noti{
      width:98%;
	  padding: 10px;
	  background-color: #f44336;
	  color: white;
	}
	
	.modify_noti_closebtn {
	  margin-left: 15px;
	  color: white;
	  font-weight: bold;
	  float: right;
	  font-size: 22px;
	  line-height: 20px;
	  cursor: pointer;
	  transition: 0.3s;
	}
	
	.modify_noti_closebtn:hover {
	  color: black;
	}
	/* modify form 수정 */
	.modify_tit {
	        height: 5%;
            width: 80%;
            font-size: 16px;
            font-weight: bold;
            margin-left: 15px;
            padding-top: 15px;
            padding-bottom:10px;
            border-bottom: 1px solid #eeeeef;
    }
    .modify_input_wrapper{
    	margin:20px 0;
    	width: 70%;
    	padding-bottom : 20px;
    }
    .border{
    	width:100%;
    	margin-left:15px;
    	padding-bottom : 20px;
    	border-bottom: 1px solid #eeeeef;
    }
    .modify_la_in{
    	margin-bottom : 10px;
    	margin-left: 15px;
    	width:100%;
    	display:flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    }
    .modify_la_in > label{
    	width:20%;
    	height: 100%;
    	display: flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    }
    .modify_la_in > input{
    	width:30%;
    	height: 100%;
    	display: flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    	padding : 3px 5px;
    }
    .modify_la_in .custom_select {
    	border : 1px rgba(118, 118, 118) solid;
    	margin : 0;
    	width: 15%;
    	height: 100%;
    	display: flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    	padding : 3px 5px;
    }
    .custom_select select {
    	width: 100%;
    	border: 0;
    	margin: 0;
    	padding: 0;	
    }
    #btnSubmit{
    	margin-left: 15px;
    	align-self: flex-start;
        background-color: #d32323b6;
        color: white;
        border: 0px;
        border-radius: 3px;
        font-size: 15px;
        font-weight: bold;
        width: 150px;
        height: 40px;
        cursor: pointer;
    }
    #btnSubmit:hover{
    	opacity: 0.7;
    }
   	.modify_form_wrapper{
   		width: 100%;
   	}
   	.modify_loc_wrapper{
   		border-top: 1px solid #eeeef;	
   		width: 100%;
   		margin-left: 15px;
   	}
   	.modify_loc_wrapper > div {
   		margin-bottom: 10px;
   	
   	}
   	.modify_eval_wrapper{
   		width:100%;
   		margin : 20px 15px;
   		display: flex;
   		flex-direction: column;
   		justify-content: flex-start;
   		align-items: flex-start;
   	}
    .modify_eval_wrapper > div{
    	margin : 5px 5px;
    }
    
    .modify_eval_info{
    	display: flex;
    	flex-direction: row;
    	justify-content: flex-start;
    	align-items: center;
    }
    .modify_eval_info > div {
    	margin-right: 10px;
    }
    /* revw */
    /* revw reg wrapper */
    	.revw_wrapper{
		    margin-top: 20px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            width: 100%;
            padding: 20px 0;
		}

        .revw_reg_wrapper{
            border: 1px solid #eeeeef;
            display: flex;
        	flex-direction: column;
        	justify-content: flex-start;
            align-items: center;
            align-self : center;
            width: 95%;
            height: 85%;
        }
        .revw_reg_wrapper > div {
            /*border:  1px black solid;*/
            margin: 5px 0;
        }
        .revw_reg_wrapper .revw_store_info{
        	margin-top: 20px;
        }
        .revw_store_info{
            width: 90%;
            display: flex;
        	flex-direction: row;
        	justify-content: space-between;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
        }
        #revwRegForm{
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .revw_rate_wrapper{
            width: 90%;
            
        }
        .revw_cnts_textarea{
            width: 100%;
            height: 90%;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
        }
        .revw_cnts_textarea textarea{
            resize: none;
            height: 150px;
            width: 90%;
            padding: 15px;
            border-radius: 3px;
            border-color: #eeeeef;
        }
        .revw_rsvd_id{
            font-size: 12px;
            align-self: flex-end;
            color: rgba(0, 0, 0, 0.52);
            margin-right: 3px;
        }
        #revwRegForm > div{
            margin: 5px 0;
        }
        .revw_btn_box{
            width: 90%;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
        }
        .revw_btn_box > button {
            cursor: pointer;
        }
        .revw_btn_box > button:hover{
            opacity: 0.7;
        }
        #submit_revwRegForm{
            align-self: flex-start;
            background-color: #d32323b6;
            color: white;
            border: 0px;
            border-radius: 3px;
            font-size: 15px;
            font-weight: bold;
            width: 150px;
            height: 40px;
        }
        .modal_wrapper_revw_reg{
            display: flex;
        	flex-direction: column;
        	justify-content: flex-start;
            align-items: center;
            width: 100%;
            height: 85%;

        }
        .modal_top_revw{
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }
        .revw_info_wrapper{
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .revw_info_wrapper > div{
            margin: 5px 0;
        }
        .revw_info_wrapper > div:last-child{
        	margin-bottom: 20px;
        }
        /* revw info*/
        .revw_img_box{
            width: 90%;
            height: 100px;
            overflow: hidden;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: flex-start;
            flex-wrap: wrap;
        }
        .revw_img_box img {
            width: 80px;
        }
        .revw_img_wrapper{
            width: 90%;
            padding: 0 20px;

        }
        .reply_wrapper {
            width: 90%;
            height: 90%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .reply_item{
            background-color:#9595953a;
            resize: none;
            height: 70px;
            width: 90%;
            padding: 15px;
            border-radius: 3px;
            border: 1px solid #eeeeef;
            margin-bottom: 15px;
        }
        .reply_cnts_wrapper{
            font-size: 14px;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
        }
        .reply_cnts{
        	width:70%;
            padding : 10px 0 0 30px;
            font-size: 12px;
            
        }
        .reply_item_icon {
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
            font-size: 14px;
            font-weight: bold;
        }
        .reply_item_icon * {
            margin-right: 15px;
        }
        .reply_item_icon i{
            transform: rotate(180deg);
        }
        .reply_item_date{
            font-size: 12px;
            font-weight: normal;
        }
        .btn_reg_reply{
        	width: 100px;
        	padding:10px;
        	border: 1px #eeeeef solid;
        	border-radius:3px;
        	align-self: flex-end;
        	height: 50px;
        	cursor: pointer;
        }
        .btn_reg_reply:hover{
        	opacity: 0.7;
        }
        .modify_imgs_tit{
        
        	margin-left:15px;
        	font-weight: bold;
        	margin-bottom: 20px;
        }
        .modify_imgs_wrapper{
        	margin-left:15px;
        }
        .modify_revws_tit{
        margin-left:15px;
        	font-weight: bold;
        	margin-bottom: 20px;
        }
</style>
</head>
<body>
<%@include file="../../../../includes/manage_nav.jsp" %>
	<div id="modify_board">
		<c:if test="${msg != null }">
			<div class="modify_noti">
		  		<span class="modify_noti_closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
		  		<strong>${msg}</strong>
			</div>
		</c:if>
		
		<div class="modify_tit">매장 정보 수정</div>
		
		<div class="modify_form_wrapper">
		
		<form id="modifyForm" action="/dealight/business/manage/modify" method="post">
		
			<input name="storeId" value="${allStore.storeId}" hidden>
			<input name="clsCd" value="${allStore.clsCd}" hidden>
			<input name="brch" value="${allStore.brch}" hidden }>
			<input name="repMenu" value="${allStore.repMenu}" hidden }>
			<input name="addr" value="${allStore.addr }" hidden>
			<input name="lat" value="${allStore.lat}" hidden>
			<input name="lng" value="${allStore.lng}" hidden>
			<input name="avgRating" value="${allStore.avgRating }" hidden>
			<input name="revwTotNum" value="${allStore.revwTotNum }" hidden>
			<input name="likeTotNum" value="${allStore.likeTotNum }" hidden>
			<input name="seatStusCd" value="${allStore.seatStusCd }" hidden>
			<div class="modify_input_wrapper">
				<div class="modify_la_in">
					<label id="storeNm">매장명</label>
					<input name="storeNm" value="${allStore.storeNm}" readonly></br>
				</div>
				<div class="modify_la_in">
					<label id="telno">전화번호</label>
					<input name="telno" value="${allStore.telno}" required></br>
				</div>
				<div class="modify_la_in">
					<label id="buserId">사업자 회원 아이디</label>
					<input name="buserId" value="${allStore.buserId}" readonly></br>
				</div>
				<div class="modify_la_in">
					<label>시작시간</label>
					<!-- <input name="openTm" value="${allStore.openTm}" required> -->
					<div class='custom_select'>
	                     <select  id="openTm">
	                     </select>
	                 </div>
				</div>
				<div class="modify_la_in">
					<label>마감시간</label>
					<!-- <input name="closeTm" value="${allStore.closeTm}" required> -->
					<div class='custom_select'>
	                     <select  id="closeTm">
	                        <option value=""></option>
	                     </select>
	                </div>
				</div>
				<div class="modify_la_in">
					<label>브레이크타임시작시간</label>
					<!-- <input name="breakSttm" value="${allStore.breakSttm}"> -->
					<div class='custom_select'>
	                     <select  id="breakSttm">
	                     </select>
	                 </div>
				</div>
				<div class="modify_la_in">
					<label>브레이크타임마감시간</label>
					<!-- <input name="breakEntm" value="${allStore.breakEntm}"> -->
					<div class='custom_select'>
	                     <select  id="breakEntm">
	                     </select>
	                 </div>
				</div>
				<div class="modify_la_in">
					<label>라스트오더 시간</label>
					<!-- <input name="lastOrdTm" value="${allStore.lastOrdTm}"></br> -->
					<div class='custom_select'>
	                     <select  id="lastOrdTm">
	                     </select>
	                 </div>
				</div>
					<input hidden name="n1SeatNo" value="${allStore.n1SeatNo}">
					<input hidden name="n2SeatNo" value="${allStore.n2SeatNo}">
					<input hidden name="n4SeatNo" value="${allStore.n4SeatNo}">
				<div class="modify_la_in">
					<label id="storeIntro">매장소개</label>
					<input name="storeIntro" value="${allStore.storeIntro}" required></br>			
				</div>
				<div class="modify_la_in">
					<label id="avgMealTm">매장평균식사시간</label>
					<input name="avgMealTm" value="${allStore.avgMealTm}" readonly></br>
				</div>
				<div class="modify_la_in">
					<label id="hldy">매장휴무일</label>
					<input name="hldy" value="${allStore.hldy}"></br>
				</div>
				<div class="modify_la_in">
					<label id="acmPnum">매장수용인원</label>
					<input name="acmPnum" value="${allStore.acmPnum}"></br>
				</div>
				<button id="btnSubmit" type="submit">수정하기</button>
				<div class="border"></div>
			</div>
		<div class="modify_loc_wrapper">
			<div id="map" style="width:200px;height:200px;"></div>
			<div>
				<span>${allStore.addr }</span>
			</div>
		</div>
		<div class="modify_eval_wrapper">
			<div class='rating' data-rate-value='${allStore.avgRating }'></div>
			<div class="modify_eval_info">
				<div>
					<span>평균 평점</span>
					<span>${allStore.avgRating }</span>
				</div>
				
				<div>
					<span>리뷰 총 개수</span>
					<span>${allStore.revwTotNum }</span>
				</div>
				<div>
					<span>좋아요 합계</span>
					<span>${allStore.likeTotNum }</span>
				</div>
			</div>
		</div>
		<div class="modify_imgs_tit">
			사진 리스트
		</div>
		<div class="modify_imgs_wrapper">
			<div class="file_body">
				<div class="form_img">
					<input type="file" name='uploadFile' multiple>
				</div> 
				<div class='uploadResult'>
					<ul>
					</ul>
				</div> <!-- uploadResult -->
			</div> 
				<div class='bigPictureWrapper'>
					<div class='bigPicture'>
					</div>
				</div>
		</div>
		</form>
		
		
		<div class="modify_revws_tit">
			리뷰 리스트
		</div>
		<c:if test="${not empty revwList}">
			                <div class="revw_wrapper">
							<c:forEach items="${revwList}" var="revw">
										<div class='modal_top_revw'>
											<div class='revw_reg_wrapper'>
												<div class='revw_store_info'>
													<div class='revw_store_name'>${revw.userId}</div>
													<div class='revw_rsvd_id'>
														<span>리뷰 등록 날짜 : ${revw.regdate}</span>
													</div>
												</div>
												<div class='revw_info_wrapper' action='/dealight/mypage/review/register' method='post'>
													<div class='revw_rate_wrapper'>
														<div class='rating' data-rate-value='"+revw.rating+"'></div>
													</div>
													<div class='revw_cnts_textarea'>
														<textarea cols='30' row='20' name='cnts' readonly>${revw.cnts}</textarea>
													</div>
													<input name='rating' id='rate_input' hidden>
													<c:if test="${revw.imgs != null}">
														<div class='revw_img_box'>
															<div class='revw_img_wrapper'>
														<c:forEach items="${revw.imgs}" var="img">
															<c:if test="${img.fileName != null}">
																<img src='/display?fileName=${img.uploadPath}/s_${img.uuid}_${img.fileName}'>
															</c:if>
														</c:forEach>
														</div>
														</div>
													</c:if>
													<c:if test="${revw.replyCnts != null}">
														<div class='reply_wrapper'>
															<div class='reply_item'>
																<div class='reply_item_icon'>
																	<i class='fas fa-reply'></i>
																	<div class='reply_item_name'>${revw.storeNm}</div>
																	<div class='reply_item_date'>${revw.replyRegDt}</div>
																</div>
															<div class='reply_cnts_wrapper'>
																<div class='reply_cnts'>
																	<textarea class='reply_item_name' cols='30' row='20' name='cnts' readonly>${revw.replyCnts}</textarea>
																</div>
															</div>
														</div>
														</div>
													</c:if>
													<c:if test="${revw.replyCnts == null}">
														<div class='reply_wrapper'>
															<div class='reply_item'>
																<div class='reply_item_icon'>
																	<i class='fas fa-reply'></i>
																	<div class='reply_item_name'>${revw.storeNm}</div>
																</div>
															<div class='reply_cnts_wrapper'>
																<div class='reply_cnts'>
																	<textarea class='reply_item_name' placeholder="답글 내용을 입력해주세요." cols='30' row='20' name='cnts'></textarea>
																</div>
																<button class="btn_reg_reply" >답글 달기</button>
															</div>
														</div>
														</div>
														
													</c:if>
													<input name="revwId" value="${revw.revwId}" hidden>
												</div>
											</div>
										</div>
	                        	</c:forEach>
			                </div>
                        </c:if>
		</div>
	</div>
			<!-- 
		<c:if test="${not empty menuList}">
		<c:forEach items="${menuList}" var="menu">
		<input name="menuSeq" value="${menu.menuSeq}" hidden>
			<input name="price" value="${menu.price }" hidden>
			<input name="imgUrl" value="${menu.imgUrl}" hidden>
			<input name="name" value="${menu.name }" hidden>
			<input name="recoMenu" value="${menu.recoMenu }" hidden>
		</c:forEach>
		</c:if>
		<c:if test="${not empty tagList}">
		<h2>태그 리스트</h2>
		<c:forEach items="${tagList}" var="tag">
		=====================================</br>
		해시 태그 이름 : ${tag.tagNm }</br>
		</c:forEach>
		</c:if>
		 -->
<%@include file="../../../../includes/manage_nav_bot.jsp" %>
<script src="/resources/js/clock.js"></script>
<script>
writeTimeBar = function () {
	
	let openTm = '${allStore.openTm}',
		closeTm = '${allStore.closeTm}',
		breakSttm = '${allStore.breakSttm}',
		breakEntm = '${allStore.breakEntm}',
		lastOrdTm = '${allStore.lastOrdTm}'
		;
	
	console.log("open tm : "+openTm);
	console.log("close tm : "+closeTm);
	console.log("breake st tm : "+breakSttm);
	console.log("break en tm : "+breakEntm);
	console.log("last ord tm : "+lastOrdTm);
		
    timeArr = ['입력 전','09:00','09:30','10:00','10:30','11:00','11:30','12:00','12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00','16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00'];
    strTime = "";
    strTime += "<select>";
    for(let i = 1; i <= 27; i++){
        strTime += "<option value='"+timeArr[i]+"'>"+timeArr[i]+"</option>";
    }
    strTime += "</select>";
    
	document.querySelector("#openTm").innerHTML = strTime;
	document.querySelector("#closeTm").innerHTML = strTime;
	document.querySelector("#breakSttm").innerHTML = strTime;
	document.querySelector("#breakEntm").innerHTML = strTime;
	document.querySelector("#lastOrdTm").innerHTML = strTime;
	
	
	$("#openTm option[value='"+openTm+"']").attr("selected","selected");
    $("#closeTm option[value='"+closeTm+"']").attr("selected","selected");
    $("#breakSttm option[value='"+breakSttm+"']").attr("selected","selected");
    $("#breakEntm option[value='"+breakEntm+"']").attr("selected","selected");
    $("#lastOrdTm option[value='"+lastOrdTm+"']").attr("selected","selected");
    
    let strInput = "";
    strInput += "<input type='text' id='inputOpenTm' name='openTm' value='"+openTm+"' hidden>";
    strInput += "<input type='text' id='inputCloseTm' name='closeTm' value='"+closeTm+"' hidden>";
    strInput += "<input type='text' id='inputBreakSttm' name='breakSttm' value='"+breakSttm+"' hidden>";
    strInput += "<input type='text' id='inputBreakEntm' name='breakEntm' value='"+breakEntm+"' hidden>";
    strInput += "<input type='text' id='inputLastOrdTm' name='lastOrdTm' value='"+lastOrdTm+"' hidden>";
    
    $("#modifyForm").append(strInput);
    
    
    $("#openTm").change(() => {
    	let target = document.getElementById("openTm");	
		$("#inputOpenTm").val(target.options[target.selectedIndex].text);
    });
    $("#closeTm").change(() => {
    	let target = document.getElementById("closeTm");	
		$("#inputCloseTm").val(target.options[target.selectedIndex].text);
    });
    $("#breakSttm").change(() => {
    	let target = document.getElementById("breakSttm");	
		$("#inputBreakSttm").val(target.options[target.selectedIndex].text);
    });
    $("#breakEntm").change(() => {
    	let target = document.getElementById("breakEntm");	
		$("#inputBreakEntm").val(target.options[target.selectedIndex].text);
    });
    $("#lastOrdTm").change(() => {
    	let target = document.getElementById("lastOrdTm");	
		$("#inputLastOrdTm").val(target.options[target.selectedIndex].text);
    });
}
writeTimeBar();

const storeId = ${storeId};

showTime(); // 현재 시간을 보여주는 코드
setInterval(showTime, 1000); // 매초 update

// '매장'의 정보를 가져온다.
function getStore(param,callback,error) {
    
    let storeId = param.storeId;

    $.getJSON("/dealight/business/manage/board/store/"+storeId+".json",
            function(data){
                if(callback){
                    callback(data);
                }
            }).fail(function(xhr,status,err){
                if(error){
                    error();
                }
    });
}

function showStoreInfo (storeId){
	
	getStore({storeId : storeId}, function (store) {
        let strStoreInfo = "";
        if(store == null){
        	storeInfoDiv.html("");
            return;
        }
        
        /*착석 상태*/
        let colors = document.getElementsByClassName("btn_seat_stus");
        for(let i = 0; i < colors.length; i++){
        	if(colors[i].dataset.color[0] === store.bstore.seatStusCd)
        		colors[i].className += " curStus";
        }
	})
};

showStoreInfo(storeId);

//매장의 착석 상태 코드를 변경한다.
function putChangeStatusCd(params,callback,error) {
	
	let storeId = params.storeId,
		seatStusCd = params.seatStusCd;
	
    $.ajax({
        type:'put',
        url:'/dealight/business/manage/board/seat/'+storeId+'/'+seatStusCd,
        data : {},
        contentType : "application/json",
        success : function(result, status, xhr) {
            if(callback) {
                callback(result);
            }
        },
        error : function(xhr, status, er) {
            if(error) {
                error(er);
            }               
        }
    });
    
    }

let changeSeatStusHandler = function(e) {
	
    e.preventDefault();
    
    let color = "";

    let param = {};
    param.storeId = storeId;
    
    if(e.target.dataset.color) param.seatStusCd = e.target.dataset.color[0];
    if(e.target.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.dataset.color[0];
    if(e.target.parentNode.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.parentNode.dataset.color[0];
    
    //param.seatStusCd = e.target.dataset.color[0];
    $(".btn_seat_stus").removeClass("curStus");
    e.target.className += " curStus";
    
	putChangeStatusCd(param, function(result){
    	showStoreInfo(param.storeId);
	});
}
/* 매장 착석 상태 처리*/
$(".btn_seat_stus").on("click",changeSeatStusHandler);
</script>
<script>
    /* form 역할을 하는 엘리먼트를 선택한다. */
	const formObj = $("#modifyForm");
    /* 정규식으로 파일 형식을 제한한다. */
    const regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
    /*최대 파일 크기를 제어한다  */
	const maxSize = 5242880; /* 5MB */
	// add category ***페이지마다 변경 필요
	const category = 'storeImgs';
	// page type
	const pageType = "modify";
	// storeId
	//const storeId = ${store.storeId};
	// btn id
	const btnSubmit = "#btnSubmit";
	// isModal
	const isModal = false;
</script>
<script type="text/javascript" src="/resources/js/reg_file.js?ver=1"></script>
<script type="text/javascript">
let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(${allStore.lat}, ${allStore.lng}), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(${allStore.lat}, ${allStore.lng}), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};


//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(${allStore.lat}, ${allStore.lng}); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//아래 코드는 지도 위의 마커를 제거하는 코드입니다
//marker.setMap(null);    

let getRevw = function (params,callback,error) {
	
	let revwId = params.revwId;
	console.log("getRevw....................." + revwId);
	
	$.getJSON("/dealight/business/manage/review/"+revwId+".json",
    		function(data) {
    			if(callback) {
    				callback(data);
    			}
    	}).fail(function(xhr,status,err){
    		if(error) {
    			error();
    		}
    	});
};

let regReply = function (params,callback,error){
	
	let replyCnts = params.replyCnts,
		revwId = params.revwId;
	
	console.log("reg reply....................." + revwId);
	
	$.ajax({
	    type:'put',
	    url:'/dealight/business/manage/review/reply',
	    data : JSON.stringify({replyCnts:replyCnts,revwId : revwId}),
	    contentType : "application/json",
	    success : function(result, status, xhr) {
	        if(callback) {
	            callback(result);
	        }
	    },
	    error : function(xhr, status, er) {
	        if(error) {
	            error(er);
	        }               
	    }
	});
};

let regReplyHandler = function (e) {
	
	console.log("reg reply.....................");
	
	e.preventDefault();
	
	let inputRevwId = $(e.target).parent().parent().parent().parent().find("input[name='revwId']"),
		inputReplyCnts = $(e.target).parent().find(".reply_item_name"),
		inputReplyRegDt = $(e.target).parent().parent().parent().parent().find("input[name='replyRegDt']"),
		btnRegReply = $(e.target).parent().parent().find(".btn_reg_reply")
		;
		
	let revwId = inputRevwId.val(),
		replyCnts = inputReplyCnts.val();
	
	console.log("revwId : " +revwId +", replyCnts : " + replyCnts);
	
	regReply({revwId:revwId,replyCnts:replyCnts}, () => {
		
				getRevw({revwId:revwId}, revw => {
		
					console.log("revw.replyCnts : " + revw.replyCnts);
					console.log("revw.replyRegDate : " + revw.replyRegDt);
					
					inputReplyCnts.val(revw.replyCnts);
					inputReplyCnts.attr("readonly","readonly");
					btnRegReply.css("display","none");
					inputReplyRegDt.val(revw.replyRegDt);
					console.log("reg reply complete");
		
				});
		});
	
};

	$(".btn_reg_reply").on("click",regReplyHandler);
	
	/* Rater.js 로직*/
    $(".rating").rate({
        max_value: 5,
        step_size: 0.5,
        initial_value: 3,
        selected_symbol_type: 'utf8_star', // Must be a key from symbols
        cursor: 'default',
        readonly: true,
    });

</script>
<%@include file="../../../../includes/mainFooter.jsp" %>
</body>
</html>