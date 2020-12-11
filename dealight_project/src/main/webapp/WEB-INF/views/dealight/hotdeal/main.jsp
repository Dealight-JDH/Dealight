<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<style>
.css-hotdeal {
	display: inline-block;
	margin: 45px;
	border: 2px solid red;
	
}

.topnav{
}
.css-elapTime{
	color: red;
	font-weight: bold;
}


/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 15% from the top and centered */
  padding: 20px;
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* The Close Button */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
h4{
	display: inline-block;
}

.text-center {
      text-align: center;
}
.css-btn{
     background-color: #EB0000;
     color: white;
     width: 350px;
     height: 40px;
     border-radius: 6px;
     border-style: hidden;
     font-size: 16px;
}
.hotdeal-search{
	text-align: center;
}

.hotdeal_locationFilterLabel{
	margin-right: 6px;
    font-size: 14px;
    line-height: 16px;
    color: #FF0000;
    }

</style>
</head>
<body>
<h1>핫딜</h1>



	<div class="topnav">
		<form action = "/dealight/hotdeal/register">
			<input type="number" min = "0" name = "storeId" placeholder="매장번호를 선택해주세요">
			<button type="submit" data-oper = 'register'>핫딜 등록</button>		
		</form>
		
		<button type="submit" data-oper = 'activate'>핫딜 진행중</button>
		<button type="submit" data-oper = 'pending'>핫딜 예정</button>
	</div>

	<div class="hotdeal-search">
		<span class="icon"></span>
		<button class="hotdeal_locationFilterBtn">
		<span class="hotdeal_locationFilterLabel">지역</span>
		</button>
		<input type="text" style="width:60px;height:20px;">
		
	</div>

	<div class="hotdeal">
	<%-- <c:forEach items="${lists}" var="htdl" varStatus="status">
		<div class="css-hotdeal js-htdl<c:out value="${status.index}"/>">
			=========================================<br> 핫딜 번호:
			<c:out value="${htdl.htdlId}" />
			<br> 핫딜 이름:
			<c:out value="${htdl.name}" />
			<br> 핫딜 할인율:
			<fmt:parseNumber integerOnly="true" value="${htdl.dcRate * 100}" />
			%<br> 핫딜 시작 시간:
			<c:out value="${htdl.startTm}"></c:out>
			<br> 핫딜 종료 시간:
			<c:out value="${htdl.endTm}" />
			<br> 메뉴:
			<c:forEach items="${htdl.dtlsList}" var="detail" varStatus="status">
				<c:out value="${detail.menuName}" />,
			</c:forEach>
			<br>
			<c:if test="${htdl.intro ne null}">
			핫딜 소개: <c:out value="${htdl.intro}" />
				<br>
			</c:if>
			핫딜마감인원:
			<c:out value="${htdl.lmtPnum}" />
			<br> 매장 평점:
			<c:out value="${htdl.storeEval.avgRating}" />
			<br> 리뷰 수:
			<c:out value="${htdl.storeEval.revwTotNum} " />
			<br> =========================================<br>
		</div>
	</c:forEach> --%>
	</div>
	

	
	<div class="panel-footer">
		
	</div>

	
	<!-- The Modal -->
	<div id="myModal" class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
	
	  <!-- Modal content -->
	  <div class="modal-content">
	  <span class="close">&times;</span>
	    <div class="modal-header">
	    	선착순: <h4 class="modal-lmtPnum" id="lmtPnum"></h4><label>명</label><br>
	    	<h4 class="modal-name" id="htdlName"></h4><br>
	    	<input type="hidden" id="mhtdlId" name = "htdlId">
	    </div>

	    <div class="modal-body">
	    <div class="modal-htdlImg">
	    </div>
	    	<span class= 'modal-startTm' id="startTm"></span> &nbsp; - &nbsp; <span class= 'modal-endTm' id="endTm"></span><br>
	    	<span class= 'css-elapTime modal-elapTime' id="elapTime"></span><br>
	    	<h4 class="modal-dcRate" id="dcRate"></h4><br>
	    	<span class="modal-befPrice" id="befPrice" style="text-decoration:line-through; color:#999999;">
	    	</span>
	    	<br>
	    	<h4 class="modal-afterPrice" id="afterPrice"></h4><br>
	    	<h4 class="modal-avgRating" id="avgRating"></h4><br>
	    	<h4 class="modal-revwTotNum" id="revwTotNum"></h4><br>
	    	<h4 class="modal-menuName" id="menuName"></h4><br>
	    	<h4 class="modal-intro" id="intro"></h4><br>
	    </div>
	    
	    <div class="modal-footer">
	    	<h3 style="color: red; font-weight: bold;">※ 유의 사항</h3>
	    	<ul>
	    		<li>1인 1매만 구매 가능합니다.</li>
	    		<li>구매 전 전용 지점을 확인해주세요.</li>
	    		<li>시간을 준수해 주시기 바랍니다.</li>
	    		<li>양도 및 재판매 불가합니다.</li>
	    	</ul>
	    	<h3 style="color: red; font-weight: bold;">※ 환불 규정</h3>
	    	<ul>
	    		<li>사용 기간 내 환불 요청에 한해 구매 금액 전액 환불, 상품 사용 기간 이후 환불 요청 건은 수수료 10%를 제외한 금액 환불을 원칙으로 합니다.</li>
	    		<li>환불 기간 연장은 불가합니다.</li>
	    		<li>구매 후 1시간 이내 환불 요청: 100% 환불</li>
	    		<li>구매 후 1시간 이후 환불 요청: 90% 환불</li>
	    	</ul>
	    	
	   		<br>
	    <div class="text-center">	
        		<button type="submit" class="css-btn js-dealBtn">딜 하기</button>	    		
      	</div>
	    </div>
	  </div>
	</div>

	<script>
	let htdlUL = $(".hotdeal"); //핫딜
	let size = '<c:out value="${fn:length(lists)}"/>'; //진행중인 핫딜 갯수

	let showListId = null; //setInterval id
	let showElapTimeId = null; // elapTime id
	let pageNum = 1;
	let htdlPageFooter = $(".panel-footer"); //핫딜 페이지
	
	//모달
	let modal = $(".modal"),
		/* htdlId = $("#mhtdlId"), */
		htdlImg = $(".modal-htdlImg"),
		lmtPnum = $("#lmtPnum"), //제한 인원
		htdlName = $("#htdlName"), //핫딜 이름
		startTm = $("#startTm"), //시작 시간
		endTm = $("#endTm"), //종료 시간
		mElapTime = $("#elapTime"), //경과 시간
		dcRate = $("#dcRate"), //할인율
		befPrice = $("#befPrice"), //할인 전 가격
		afterPrice = $("#afterPrice"), //할인 후 가격
		avgRating = $("#avgRating"), //평점
		revwTotNum = $("#revwTotNum"), //리뷰수
		menuName = $("#menuName"), //메뉴이름
		intro = $("#intro"); //핫딜 소개
	
	let storeId = 0; //매장번호
	let paramStusCd = "A"; //핫딜 상태코드
	
	$(document).ready(function() {
		
		console.log("==="+size);
		//showList(paramStusCd);
		showListStart(paramStusCd, pageNum); //1초마다 핫딜 리스트를 그린다
		
		/* for(var i=0; i< size; i++){
			$(".js-htdl"+i).on('click', function(){
				console.log("aaaa"+i);
			});
		} */
		
		/* $(".js-htdl0").on('click',function(){
			console.log("aaaa");
		}); */
		

		$("button").on("click", function(e){
			e.preventDefault();
			
			let operation = $(this).data("oper");
			console.log(operation);
			
			//핫딜 예정
			if(operation === 'pending'){
				 /* getList({stusCd: "P"}, function(list){
					for(var i=0, len = list.length || 0; i<len; i++){
						console.log(list[i]);
						console.log(list[i].dtlsList);	
					}	
				}); */ 
				stop(showListId);
				htdlUL.empty();
				paramStusCd = "P";
				showList(paramStusCd, pageNum);
				//showListStart("P",pageNum);
			}else if(operation === 'activate'){
				//핫딜 진행중
					/* getList({stusCd: "A"}, function(list){
					for(var i=0, len = list.length || 0; i<len; i++){
						console.log(list[i]);
					}
					
				});  */
				
				stop(showListId);
				htdlUL.empty();
				paramStusCd = "A";
				showListStart(paramStusCd, pageNum);
				//showList("A");
			}else if(operation === 'register'){
				$("form").submit();
			}
		});
		
		//모달 닫기
		$(".close").on("click", function(){
			clearInterval(showElapTimeId);
			mElapTime.html("");
			modal.hide();
		});
		
		//딜 하기 클릭 시 매장 상세로 이동한다
		$(".js-dealBtn").on("click", function(e){
			e.preventDefault();
			let body = $("body");
			
			//해당 핫딜번호,메뉴,가격 
			let htdlId = $("#mhtdlId").val();
			let htdlMenu = $("#menuName").text();
			let afterPrice = $("#afterPrice").text().substr(1);
			//폼 만들기
			let form = $("<form></form>");
			form.attr("action", "/dealight/store");
			form.attr("method", "get");
			//요청 폼 입력
			let storeIdInput = $("<input type='hidden' value='"+ storeId +"' name='storeId'>");
			let htdlIdInput = $("<input type='hidden' value=''"+ htdlId +"' name='htdlId'>");
			let clsCdInput = $("<input type='hidden' value='B' name='clsCd'>");
		    form.append(storeIdInput);
		    form.append(clsCdInput);
		    /* form.append(htdlIdInput); */
		    form.appendTo(body);
		    //전송
		    form.submit();
		    
		});
		
		//페이지 번호 클릭 시
		htdlPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			
			console.log("page click");
			
			//클릭한 페이지 번호
			let targetPageNum = $(this).attr("href");
			
			pageNum = targetPageNum;
			//setInterval 중지
			stop(showListId);
			console.log("====="+paramStusCd);
			//핫딜 리스트 그리기
			showListStart(paramStusCd, pageNum);
			window.scrollTo(0,0);
		});
				
	});

	//타이머 중지
	function stop(id){
		clearInterval(id);
	}
	
	//타이머 설정
	function showListStart(stusCd, pageNum){
		//showList(stusCd, pageNum);
		showListId = setInterval(showList, 1000, stusCd, pageNum);
	}
	
	//경과시간 카운트다운
	function showElapTimeStart(elapTime){
		showElapTimeId = setInterval(getModalElapTime, 1000, elapTime);
	}
	
	//모달 경과시간
	function getModalElapTime(endTime, startTime){
		
		let elapTime = getElapTime(endTime, startTime);
		mElapTime.html(elapTime);
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
	
	
	
	//핫딜 리스트 보여주기
	function showList(param, page){
		
		getList({stusCd: param, page: page || 1},
			function(data){
			console.log("list: " + JSON.stringify(data.lists));
			console.log("data: " + JSON.stringify(data));
			//console.log("listDtls: " + JSON.stringify(data.lists[0].htdlDtls));
	
			//ajax 요청 list가 널이거나 0이면 ""
			if(data.lists == null || data.lists.length == 0){
				htdlUL.html("");
				return;
			}
			
			//페이지가 -1이면 첫페이지
			if(page == -1){
				pageNum = 1;
				showListStart(param, pageNum);
				return;
			}
			console.log(data.lists.length);
			
			//핫딜 동적생성
			let str = htdlHtml(data.lists);
			htdlUL.html(str);
			//핫딜 페이지
			showHtdlPage(data.total);
			eventHtdlListener(data.lists.length);
			
		});
	
	}
	
	//핫딜 페이지 그리기
	function showHtdlPage(listCnt){
		let endNum = Math.ceil(pageNum / 10.0) * 10;
		let startNum = endNum - 9;
		
		let prev = startNum != 1;
		let next =false;
		
		//끝번호 * 9 이 리스트갯수보다 더 많을 때
		if(endNum * 9 >= listCnt){
			endNum = Math.ceil(listCnt/9.0);
		}
		//끝번호 * 10보다 많을 때
		if(endNum * 10 < listCnt){
			next = true;
		}
		
		let pageStr = "<div><ul class='pagination'>";
		if(prev){
			pageStr+="<li ><a href='"+(startNum - 1)+"'>Previous</a></li>";
		}
		
		for(let i = startNum; i<=endNum; i++){
			
			let active = pageNum == i ? "active":"";
			pageStr += "<li "+active+" '><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			pageStr += "<li><a href='"+(endNum+1)+"'>Next</a></li>";
		}
		
		pageStr+="</ul></div>";
		//console.log(pageStr);
		htdlPageFooter.html(pageStr);
	}
	
	//핫딜 그리기
	function htdlHtml(list){
		let str = "";
		
		//list에 따른 핫딜 동적 생성
		for(let i =0, len = list.length || 0; i<len; i++){
			/* let elapTime = getElapTime(list[i].endTm); */
			let elapTime = "";
			if(list[i].stusCd === 'A')
				elapTime = showHtdlElapTime(list[i].endTm, null);
			else
				elapTime = showHtdlElapTime(list[i].endTm, list[i].startTm);
			
			let fileCallPath = null;
			let srcObj = null;
			console.log("hotdeal : " + JSON.stringify(list[i]));
			console.log("hotdeal image: " + list[i].htdlImg);
			if(list[i].htdlImg != null){
				let htdlPhotoSrc = list[i].htdlImg;
				srcObj = subSrc(htdlPhotoSrc);
				fileCallPath = encodeURIComponent("/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
				
				console.log("================핫딜 이미지: " + htdlPhotoSrc);
			}
			
			str += "<div class='css-hotdeal js-htdl"+i+"'>";
			/* str += "<div class='css-hotdeal js-htdl'>"; */
			str += "=========================================<br>"
			
			if(fileCallPath != null && srcObj != null){				
				str += "<div class='uploadResult'>";
				str += "<ul>";
				str += "<li data-path='"+ srcObj["uploadPath"] +"'";
				str += " data-filename=\'"+ srcObj["fileName"] +"\'><div>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str += "</li>";
				str += "</ul></div>";
			}
			
			str += "남은 시간: <span class='js-elapTime css-elapTime'>"+elapTime+"</span><br>"
			str += "핫딜 번호: <span class='js-htdlId'>"+ list[i].htdlId+"</span><br>"
			str += "핫딜 이름: "+ list[i].name+"<br>"
			/* str += "<img src='<spring:url value='/resources/img/testimg.png'/>' width='300px' height='250px'>" */
			str += "핫딜 할인율: "+ list[i].dcRate * 100+"%"+"<br>"
			str += "핫딜 시작 시간: "+ "<span class= 'js-start'>"+list[i].startTm+"</span>"+"<br>"
			str += "핫딜 종료 시간: "+ "<span class= 'js-end'>"+list[i].endTm+"</span>"+"<br>"
			
			str += "메뉴: ";
			console.log("======="+ list[i].htdlDtls);
			console.log(list[i].htdlDtls);
		
		//핫딜 메뉴 리스트 생성
		for(let j=0, dtlsLen = list[i].htdlDtls.length || 0; j<dtlsLen; j++){
			str += list[i].htdlDtls[j].menuName+" ";
			console.log(list[i].htdlDtls[j].menuName);
		}
			str +="<br>";
			console.log("========="+list[i].befPrice);
			console.log("========="+list[i].ddct);
			str += "핫딜 할인 전 가격: <span style='text-decoration:line-through; color:#999999;'>"+ list[i].befPrice+"</span><br>";
			str += "핫딜 할인 후 가격: "+ (list[i].befPrice - list[i].ddct)+"<br>";
			str += "핫딜 소개: "+ list[i].intro+"<br>";
			str += "핫딜 마감 인원: "+ list[i].lmtPnum+"<br>";
			str += "매장 평점 "+ list[i].storeEval.avgRating+"<br>";
			str += "리뷰 수 "+ list[i].storeEval.revwTotNum+"<br>";
			str += "=========================================";
			str +="</div>"
		}
		return str;
	}
	
	//이미지 url 파일경로 나누기
	function subSrc(PhotoSrc){
		let srcObj = {};
	
		let index = PhotoSrc.lastIndexOf("/");
		console.log("photo index ============" + index);			
		
		srcObj["uploadPath"] = PhotoSrc.substring(0,index);
		console.log("photoSrc: " + PhotoSrc.substring(0,index));
		srcObj["fileName"] = PhotoSrc.substring(index + 1);
		
		return srcObj;
	}
	
	//해당 핫딜을 ajax 요청을 통해 불러온다
	function getHtdl(param, callback, error){
		let htdlId = param.htdlId;
		
		console.log("htdlId: "+ htdlId);
		
		$.get("/dealight/hotdeal/get/"+htdlId+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status, err){
			if(error){
				error();
			}
		});  
	}
	
	
	//모달 띄우기
	 function showModal(htdl){
		 let size = htdl.htdlDtls.length;		
		 let str = [];
		 
		 if(htdl.stusCd === 'A'){
			showElapTimeStart(htdl.endTm);			 
		 }
		 else{
			 clearInterval(showElapTimeId);
			 getModalElapTime(htdl.endTm, htdl.startTm);
		 }
		
		 //핫딜 이미지(uuid+fileName)
		 let filePath = htdl.htdlImg;
		 console.log(filePath+"modal filePath==============")
		 
		 //원본 이미지 파일 경로
		 let fileCallPath = encodeURIComponent("/"+ filePath);
		 console.log("========fileCallPath1: " + fileCallPath);
		 //섬네일 파일 경로
		 /* let srcObj = subSrc(filePath);
		 let thumnailfileCallPath = encodeURIComponent("/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
		 console.log("=========fileCallPath: " + fileCallPath); */
		 
		 /* let fileCallPath = path.replace(new RegExp(/\\/g), "/"); */

		//핫딜 번호
		let htdlNum = htdl.htdlId;
		 
		htdlImg.html("<img src='/display?fileName="+ fileCallPath+ "'>");
		storeId = htdl.storeId;
		console.log("============storeId: "+storeId);
		console.log("=========htdlNum: "+htdlNum);
		console.log("===============showModal" + htdl.lmtPnum+"," + size);
		//제한 인원, 핫딜 이름, 시작시간, 마감시간
		lmtPnum.text(htdl.lmtPnum);
		htdlName.text(htdl.name);
		startTm.text(htdl.startTm);
		endTm.text(htdl.endTm);
		
		//경과시간,할인율,할인전후가격,평균평점,리뷰수
		let elapTime = getElapTime(htdl.endTm);
		
		console.log(elapTime+"===============elapTime");
		/* htdlId.val(htdlNum); */
		$("#mhtdlId").val(htdlNum);
		
		dcRate.text(htdl.dcRate*100+"%");
		befPrice.text("₩"+htdl.befPrice);
		afterPrice.text("₩"+(htdl.befPrice - htdl.ddct));
		avgRating.text(htdl.storeEval.avgRating);
		revwTotNum.text(htdl.storeEval.revwTotNum);
		
		for(let i=0; i<size; i++){
			str.push(htdl.htdlDtls[i].menuName);
		}
		menuName.text(str.join(","));		
		
		intro.text(htdl.intro); 
		const dealBtn = $(".js-dealBtn");
		if(htdl.stusCd !== 'A'){
			dealBtn.text("🔥오픈 예정입니다.");
			dealBtn.prop("disabled", true);
		}else{
			dealBtn.text("🔥딜 하기");
			dealBtn.prop("disabled", false);
		}
		
		modal.show();
	}
	
	 //핫딜 클릭(상세) 이벤트 등록
	function eventHtdlListener(size){
		
		//생성된 핫딜에 클릭시 이벤트 생성
		for(let i = 0; i< size; i++){
		 $(".js-htdl"+i).on("click",function(){
			 console.log(this);
			 
			 //핫딜번호를 가져온다
			 let param = $(this).find(".js-htdlId").text();
			 console.log($(this).find(".js-htdlId").text());
			 
			 getHtdl({htdlId: param}, function(result){
				 console.log("핫딜 get.."+ JSON.stringify(result));
				 
				 //모달에 값 전달하기
				 showModal(result);
			 });
		 });
		}
	}

	//핫딜 ajax 요청
	function getList(param, callback, error){
		let stusCd = param.stusCd;
		let page = param.page || 1;
		console.log(stusCd);
		console.log("======page: "+ page);
		
		$.getJSON("/dealight/hotdeal/main/"+stusCd+"/"+page+".json",
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

