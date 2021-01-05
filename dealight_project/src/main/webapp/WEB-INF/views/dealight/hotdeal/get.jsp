<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>

<style type="text/css">
	    * { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/

    margin  : 0;   /* 값이 0일 때는 단위 안씀. */
    border  : 0;
    padding : 0;
    font-family: 'Nanum Gothic', sans-serif;
    }

    /* div{
        border: 1px solid red;
    } */
    .nav_bar{
        display: flex;
        height: 60px;
        justify-content: center;
        align-items: center;
        color: black;
        font-weight: bold;
        font-size: 24px;
        background-color: white;
    }

    .main-container{
        display: flex;
        justify-content: center;
        min-width: 1050px;
        height: auto;
    }

    .hotdeal-container{
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 50%;
        height: 100%;
        margin-top: 25px;
    }

    .hotdeal-img{
        position: relative;
        padding: 0 8px 8px;
        width: 99%;
        height: 450px;
    }
    .hotdeal-img>img{
        width: 100%;
        height: 100%;
    }

    .hotdeal-detail-info{
        width: 100%;
        height: 200px;
        margin-top: 12px;
        margin-bottom: 16px;
        padding: 0 15px;
    }

    .hotdealInfo_restaurantName{
           font-size: 20px;
           font-weight: bold;
           color: #4f4f4f;
    }
    .hotdealDetail__restaurantIcon{
        width: 12px;
        height: 12px;
        margin-right: 4px;
        background-image: url("https://mp-seoul-image-production-s3.mangoplate.com/web/resources/eat_deal_restaurant-info-v2.svg");
        background-size: cover;
    }

    .hotdealDetail_restaurantBtn{
        display: flex;
        justify-content: center;
        width: 100px;
        margin-top: 12px;
        margin-left: 6px;
        padding: 3px 9px 3px 5px;
        border-radius: 8px;
        font-size: 12px;
        color: #7F7F7F;
        background-color: #F3F3F3;
    }

    .hotdealInfo_title{
        margin-top: 24px;
        margin-bottom: 6px;
        margin-left: 6px;
        font-size: 18px;
        line-height: 24px;
        font-weight: bold;
        color: #7F7F7F;
    }

    .hotdealInfo_elapTime{
        margin-top: 12px;
        margin-bottom: 6px;
        margin-left: 6px;
        font-size: 16px;
        line-height: 24px;
        font-weight: bold;
        color: black;
    }

    .hotdeal_elapTime{
        margin-left: 6px;
        /* color: red; */
        color:  #d32323;
        opacity: 0.9;
    }
    
    .hotdealInfo_priceInfo{
        display: flex;
        flex-direction: column;
        margin-left: 6px;
        align-items: flex-end;
    }

    .hotdealInfo_price{
        font-size: 14px;
        text-decoration: line-through;
        /* color: red; */
        color:  #d32323;
        opacity: 0.9;
    }

    .hotdealInfo-dcWrap{
        margin-right: 6px;
        letter-spacing: -4px;
    }

    .hotdealInfo_afterPrice{
        display: flex;
        flex-direction: row;
        justify-content: flex-end;
        align-items: center;
    }
    .hotdealInfo_dcRate{
        font-size: 24px;
        font-weight: bold;
        color:#9974FF;
        /* letter-spacing:px; */
    }

    .hotdealInfo_dcUnit{
        font-size: 24px;
        font-weight: bold;
        color:#9974FF;
        line-height: 1;
        letter-spacing: -0.7px;
    }

    .hottdealInfo_salesPrice{
        font-size: 24px;
        font-weight: bold;
        color:#4f4f4f;
        letter-spacing: 0;
        
    }
    .hotdealInfo_salesUnit{
        letter-spacing: -9px;
        font-weight: normal;
        color:#4f4f4f;
        /* margin-left: 4px; */

    }

    .hotdealDetail-separator{
        position: relative;
        display: block;
        width: 100%;
        height: 1px;
        margin: 32px 15px;
        background-color: #E9E9E9;
    }

    .hotdealDetail-AdditionalInfo{
        display: flex;
        flex-direction: column;
        width: 100%;
        height: 600px;
        margin-bottom: 40px;
    }

    .hotdealAdditionalInfo_section{
        width: 100%;
        margin-bottom: 30px;
    }
    .hotdealAdditionalInfo_title{
        margin-bottom: 12px;
        font-size: 15px;
        font-weight: bold;
        color: #4F4F4F;
    }

    .css-intro{
        font-size: 15px;
        margin-left: 20px;
        color:#7F7F7F;
    }
    .hotdealAdditionalInfo_menu{
        margin-bottom: 12px;
    }

    .hotdealDetail-btnContainer{
        /* align-items: flex-end; */
        display: flex;
        width: 50%;
        max-width: 790px;
        height: 60px;
        /* border: 1px solid red; */
        position: fixed;
        bottom: 0;
    }

    .hotdealDetail_btn{
        width: 100%;
        height: 100%;
        background-color: #d32323;
        opacity: 0.9;
        cursor: pointer;
        border-radius: 3px;
        outline: none;
        font-weight: 700;
        z-index: 1;
    }

    .hotdeal_btnMessage{
        font-size: 16px;
        color: white;
    }

    .discount_info{
        display: flex;
        position: absolute;
        bottom: 45px;
        left: 20px;
        right: 15px;
    }

    .discount_label{
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        position: absolute;
        height: 23px;
        line-height: 23px;
        padding: 0 8px;
        border-radius: 2px;
        font-size: 12px;
        letter-spacing: -0.3;
        font-weight: bold;
        color: white;
        background-color: rgba(0,0,0,0.2);
        
    }

    .css-fire{
        color: orange;
        font-size: 24px;
    }
    
    .reseaurant-btn{
    	cursor: pointer;
    	outline: none;
    }

</style>
</head>
<body>

<div class="main-container">

        <div class="hotdeal-container">
            
            <div class="hotdeal-img">
                <img src="/display?fileName=/<c:out value='${htdl.htdlImg }'/>" alt="">
                <div class="discount_info">
                    <span class="discount_label" style="opacity:1;">
                    <fmt:formatNumber value="${htdl.dcRate}" type='percent'/>할인</span>
                </div>
            </div>

            <div class="hotdeal-detail-info">
                <h1 class="hotdealInfo_restaurantName">[<c:out value="${htdl.brch }"></c:out>]
                <c:out value="${htdl.storeName }"></c:out>
                 </h1>
                
                <div class="hotdealDetail_restaurantBtn">
                <button type="button" class="reseaurant-btn js-restaurantBtn">
                    <i class="hotdealDetail__restaurantIcon"></i>
                    <span class="hotdealDetail__restaurantLabel">
                        식당 정보 보기
                    </span>
                    </button>
                </div>

                <p class="hotdealInfo_title">
                <c:if test="${htdl.setName ne null }">
                	<c:out value="${htdl.setName }"></c:out>
                </c:if>
                <c:if test="${htdl.setName eq null }">
                	<c:out value="${menu.menuName }"></c:out>
	                <%-- <c:forEach items="${htdl.htdlDtls }" var="menu">
	                	<c:out value="${menu.menuName }"></c:out>
	                </c:forEach> --%>
                </c:if>
                </p>

                <div class="hotdealInfo_elapTime">
                    <span class="js-elapTime">남은 시간 :</span><span class="hotdeal_elapTime">
                    	
                    </span>
                </div>

                <div class="hotdealInfo_priceInfo">
                    <span class="hotdealInfo_price">
                    ₩<fmt:formatNumber value="${htdl.befPrice }" pattern="#,###" /></span>
                </div>

                <div class="hotdealInfo_afterPrice">
                    <span class="hotdealInfo-dcWrap">
                        <span class="hotdealInfo_dcRate"><fmt:formatNumber value="${htdl.dcRate}" type='percent'/></span>
                        <!-- <span class="hotdealInfo_dcUnit">%</span> -->
                    </span>

                    <span class="hottdealInfo_salesPrice">
                    <span class="hotdealInfo_salesUnit">₩</span>
                    <fmt:formatNumber value="${htdl.befPrice-htdl.ddct }" pattern="#,###" />
                    </span>
                </div>


            </div>
            <!-- hotdeal-detail-info end-->

            <div class="hotdealDetail-separator"></div>


            <div class="hotdealDetail-AdditionalInfo">
                <div class="hotdealAdditionalInfo_section">
                    <h3 class="hotdealAdditionalInfo_title">식당 소개</h3>

                    <ul>
                        <li class="hotdealAdditionalInfo_intro css-intro"><c:out value="${htdl.storeIntro }"/></li>
                    </ul>

                </div>


                <div class="hotdealAdditionalInfo_section">
                    <h3 class="hotdealAdditionalInfo_title">핫딜 소개</h3>

                    <ul>
                        <li class="hotdealAdditionalInfo_menuIntro css-intro"><c:out value="${htdl.intro }"></c:out>
                        </li>
                    </ul>
                </div>

                <div class="hotdealAdditionalInfo_section">
                    <h3 class="hotdealAdditionalInfo_title">※ 유의사항 (꼭! 확인해주세요)</h3>

                    <ul>
                        <li class="css-intro">핫딜 당 1인 1매만 구매 가능합니다.</li>
                        <li class="css-intro">HOT딜 외에 다른 쿠폰 및 딜과 중복 사용 불가합니다.</li>
                        <li class="css-intro">구매 전 전용 지점을 꼭 확인해주세요.</li>
                        <li class="css-intro">방문 전 영업시간 및 휴무일 확인을 부탁드립니다.</li>
                        <li class="css-intro">시간을 준수해 주시기 바랍니다.</li>
                        <li class="css-intro">양도 및 재판매 불가합니다.</li>
                        
                    </ul>
                </div>


                <div class="hotdealAdditionalInfo_section">
                    <h3 class="hotdealAdditionalInfo_title">※ 환불 규정</h3>

                    <ul>
                        <li class="css-intro">사용 기간 내 환불 요청에 한해 구매 금액 전액 환불, 상품 사용 기간 이후 환불 요청 건은 수수료 10%를 제외한 금액 환불을 원칙으로 합니다.</li>
                        <li class="css-intro">환불 기간 연장은 불가합니다.</li>
                        <li class="css-intro">구매 후 1시간 이내 환불 요청: 100% 환불</li>
                        <li class="css-intro">구매 후 1시간 이후 환불 요청: 90% 환불</li>
                        <li class="css-intro">환불은 구매 시 사용하였던 결제수단으로 한불됩니다.</li>
                    </ul>
                </div>

                <div class="hotdealAdditionalInfo_section">
                    <h3 class="hotdealAdditionalInfo_title">문의</h3>

                    <ul>
                        <li class="css-intro">whddn528@naver.com</li>
                    </ul>
                </div>

            </div>
            <!--hotdealDetail-additionalInfo end-->

            <div class="hotdealDetail-btnContainer">
                <button class="hotdealDetail_btn js-dealBtn">
                    <!-- <span><i class="fas fa-fire"></i></span> -->
                    <span class="hotdeal_btnMessage btn_text">딜 하기</span></button>
            </div>


        </div>
    </div>
    
    
    
	
<%-- 		<label>핫딜 제목</label> <input class="form-control" name='title'
		 value='<c:out value="${vo.name}"/>' readonly='readonly'><br>
		
		<label>핫딜 메뉴</label> 
		<c:forEach items = "${vo.dtlsList }" var = "menu">
		<input class="form-control" name='title'
		 value='<c:out value="${menu.menuName}"/>' readonly='readonly'>
		</c:forEach><br>
		
		<label>할인율</label> <input class="form-control" name='dcRate' size='15'
		 value='<fmt:formatNumber value="${vo.dcRate * 100}" type="number"/>%' readonly='readonly'><br>
		
		<label>할인 적용전 가격</label> <input class="form-control" name='beforePrice'
		value='<c:out value="${vo.befPrice}"/>' readonly = 'readonly'><br>
		
		<label>할인 적용된 가격</label> <input class="form-control" name='afterPrice'
		value='<c:out value="${vo.befPrice - vo.ddct}"/>' readonly='readonly'><br>
		
	 	<label>핫딜 기간</label>
      	<fmt:parseDate var = "startDate" pattern="yy/MM/dd HH:mm" value="${vo.startTm }"></fmt:parseDate>
		<fmt:parseDate var = "endDate" pattern="yy/MM/dd HH:mm" value="${vo.endTm }"></fmt:parseDate>
		 
		 <input type="text" name="startTime" size = '30'
		value='<fmt:formatDate pattern = "yyyy/MM/dd a HH:mm " value="${startDate }"/> - <fmt:formatDate pattern = "a HH:mm" value="${endDate }"/>' readonly='readonly'><br>
      	 
		<label>핫딜 예약 손님 인원</label> <input class="form-control" name='rsvdPnum' 
		value='<c:out value="${vo.curPnum}"/>'readonly='readonly'><br>
		
		<label>핫딜마감인원:</label> <c:out value="${vo.lmtPnum}"/><br>
		<label>매장 평점:</label> <c:out value="${vo.storeEval.avgRating}"/><br>
		<label>리뷰 수:</label> <c:out value="${vo.storeEval.revwTotNum} "/><br>
		
    	<c:if test="${vo.intro ne null }">
		<label>핫딜 소개</label><br> 
		<textarea rows="3" cols="33" name='content' readonly="readonly">
    	<c:out value="${vo.intro }"/>
    	</textarea>
		</c:if>
		 --%>


<script>
	let showElapTimeId = null; // elapTime id
	let checkStusCdId = null;
	let htdlId = "<c:out value='${htdl.htdlId}'/>";
	let startTime = "<c:out value='${htdl.startTm}'/>";
	let endTime = "<c:out value='${htdl.endTm}'/>";
	let stusCd = "<c:out value='${htdl.stusCd}'/>";
	let storeId = "<c:out value='${htdl.storeId}'/>";
	const userId= "<c:out value="${userId}"/>" || null;
	let ishtdlPayHistory = false;
	
	let dealBtn = $(".js-dealBtn");
	$(document).ready(function(){
		
		//핫딜 구매이력 체크
		 if(userId != null){				 
			 param = htdlId;
			 isHtdlPayExistChecked({htdlId: param, userId: userId}, function(result){
				 console.log("===========hotdeal pay check: "+ result);
				 ishtdlPayHistory = result;
				 
				 console.log("=======history: " + ishtdlPayHistory);
				 if(!ishtdlPayHistory){
						dealBtn.find(".btn_text").text("🔥이미 구매하신 상품입니다.");
						dealBtn.css("background", "black");
						dealBtn.prop("disabled", true);
					} 
			 });
		 }
		
		 if(stusCd == 'P'){
				dealBtn.find(".btn_text").text("🔥오픈 예정입니다.");
				dealBtn.css("background", "orange");
				dealBtn.prop("disabled", true);
		}else if(stusCd == 'I'){
				dealBtn.find(".btn_text").text("🔥핫딜이 종료되었습니다");
				dealBtn.css("background", "black");
				dealBtn.prop("disabled", true);
		}else{
			dealBtn.find(".btn_text").text("🔥딜 하기");
			dealBtn.css("background", "red");
			dealBtn.prop("disabled", false);
		}
		

		$(".js-restaurantBtn").on("click", function(e){
			e.preventDefault();
			location.href = "/dealight/store/"+storeId;
		});
		
		//버튼 클릭시 매장 상세 페이지
		$(".js-dealBtn").on("click", function(e){
			e.preventDefault();
			let body = $("body");
			
			console.log("================htdlId: " + htdlId);
			//해당 핫딜번호,메뉴,가격 
			/* let htdlId = $("#mhtdlId").val(); */
			/* let htdlMenu = $("#menuName").text();
			let afterPrice = $("#afterPrice").text().substr(1); */
			
			//폼 만들기
			let form = $("<form></form>");
			form.attr("action", "/dealight/store/"+storeId);
			form.attr("method", "get");
			//요청 폼 입력
			/* let storeIdInput = $("<input type='hidden' value='"+ storeId +"' name='storeId'>"); */
			let htdlIdInput = $("<input type='hidden' value='"+ htdlId +"' name='htdlId'>");
			/* let clsCdInput = $("<input type='hidden' value='B' name='clsCd'>"); */
		    //form.append(storeIdInput);
		    form.append(htdlIdInput);
		    /* form.append(clsCdInput); */
		    form.appendTo(body);
		    //전송
		    form.submit();
		})
		
		 
		console.log("=========htdlId: " + htdlId);
		/* checkStusCdStart(htdlId); */
		
		if(stusCd === 'A'){
			/* showHtdlElapTime(endTime, null); */
			showElapTimeStart();
		}else if(stusCd === 'P'){
			showElapTimeStart();
			/* showHtdlElapTime(endTime, startTime); */
			/* checkStusCdStart(htdlId); */
		}
		
		/* checkStusCd(htdlId); */
		/* getStusCd({htdlId: htdlId}, function(result){
			console.log("=============result: " + result);
		}); */
		
	});
	
	function checkStusCdStart(param){
		console.log("======param:" + param);
		checkStusCdId = setInterval(checkStusCd, 1000, param);
	}
	
	//핫딜 상태 체크
	function checkStusCd(param){
		console.log("param htdlId : " + param);
		
		getStusCd({htdlId: param}, function(result){
			
			console.log("=======result: " + result);
			console.log("========================result: " + result);

			if(stusCd != result){
				stusCd = result;
				location.reload();
			}
		});
	}
		
	function getStusCd(param, callback, error){
			let htdlId = param.htdlId;
			console.log("ajax before param: " + htdlId);

			$.get("/dealight/hotdeal/get/stuscd/"+htdlId, function(data){
				console.log("========ajax comlete");
				if(callback){
					callback(data)
				}
			}).fail(function(xhr,status, err){
				if(error){
					err();
				}
			});  
			
		}
	//핫딜 경과시간
	function showHtdlElapTime(endTime, startTime){
		
		let elapTime = getElapTime(endTime, startTime);
		/* $(".js-elapTime1").html(elapTime); */
		return elapTime;
	}
	
	function getElapTime(endTime, startTime){
		console.log("--------end-----"+ endTime);
		
		//종료 시간 변환
		let fmtTime = new Date(endTime);
		console.log("fmtTime: " + fmtTime);
		let date = null;
		
		if(startTime != null)
			date = new Date(startTime);
		else 
			date =new Date();
		
	    		
		//var endTime = endTimes[i].innerHTML;
		//console.log("endTime: " + endTime);
		
		console.log("==================시간계산 startTime: " + startTime);
			
		if(fmtTime.getTime() - date.getTime()<=0){
			return "00:00:00";
		}
		//경과 시간
		let elapsedTime = (fmtTime.getTime() - date.getTime()) / 1000;
		
		console.log("=========="+elapsedTime);
	
		//경과 시간 시분초 구한다
		let elapsedSec = Math.floor((elapsedTime % 3600 % 60));
		let elapsedMin = Math.floor((elapsedTime % 3600 / 60));
		let elapsedHour = Math.floor((elapsedTime / 3600));
		
		console.log("hour: " +elapsedHour);
		console.log("m: " +elapsedMin);
		console.log("s: " +elapsedSec);
		
		//시분초 문자열 00:00:00
		let elapTime = [ (elapsedHour > 9 ? '' : '0')+ elapsedHour, ':',
						(elapsedMin > 9  ? '' : '0')+ elapsedMin, ':',
						(elapsedSec > 9  ? '' : '0')+ elapsedSec].join('');
								
		console.log("elapTime========"+elapTime);
		return elapTime;
	}
	
	//핫딜 경과시간 카운트 다운
	function showElapTimeStart(){
		showElapTimeId = setInterval(countElapTime, 1000);
	}
	
	function countElapTime(){
		//1초씩 카운트 다운
		if(stusCd === 'A'){			
			let countElapTime = getElapTime(endTime, null);
			//card-elaptime 출력
			$(".hotdeal_elapTime").text(countElapTime);
			if(countElapTime === "00:00:00"){
				stusCd = 'I';
				//css 변경
				dealBtn.find(".btn_text").text("🔥핫딜이 종료되었습니다.");
				dealBtn.css("background", "black");
				dealBtn.prop("disabled", true);
			}
			
		}else if(stusCd === 'P'){
			let countElapTime = getElapTime(startTime, null);
			
			$(".js-elapTime").html("시작까지 남은 시간:");
			$(".hotdeal_elapTime").text(countElapTime);
			if(countElapTime === "00:00:00"){
				stusCd = 'A';
				//css 변경
				$(".js-elapTime").html("남은 시간:");
				dealBtn.find(".btn_text").text("🔥딜 하기");
				dealBtn.css("background", "red");
				dealBtn.prop("disabled", false);
			}
		}
	}
	
	/* function countElapTime(){
		//1초씩 카운트 다운
		if(stusCd === 'A'){			
			let countElapTime = getElapTime(endTime, null);
			//card-elaptime 출력
			$(".hotdeal_elapTime").text(countElapTime);
			if(countElapTime === "00:00:00"){
				stusCd = 'I';
				//css 변경
				dealBtn.find(".btn_text").text("🔥핫딜이 종료되었습니다.");
				dealBtn.css("background", "black");
				dealBtn.prop("disabled", true);
			}
		}	
	} */
	
	//핫딜 구매이력 체크
	 function isHtdlPayExistChecked(param, callback, error){
			let userId = param.userId;
			let htdlId = param.htdlId;
			console.log("======userId : " + userId);
			console.log("======htdlId : " + htdlId);
			
			$.getJSON("/dealight/reservation/htdlcheck/"+userId+"/"+htdlId+".json",
					function(data){
				if(callback){
					callback(data);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	
	
	


</script>



</body>
</html>