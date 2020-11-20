<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.css-hotdeal {
	display: inline-block;
	margin: 40px;
}
.topnav{
}
.css-elapTime{
	color: red;
	font-weight: bold;
}
.css-hotdeal{
	border: 2px solid red; 
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


</style>
</head>
<body>

	<div class="topnav">
		<a class="active" href="#home">Home</a><br>
		<form action = "/dealight/hotdeal/register">
			<input type="number" min = "0" name = "storeId" placeholder="매장번호를 선택해주세요">
			<button type="submit" data-oper = 'register'>핫딜 등록</button>		
		</form>
		
		<button type="submit" data-oper = 'activate'>핫딜 진행중</button>
		<button type="submit" data-oper = 'pending'>핫딜 예정</button>
		
	</div>

	<h1>핫딜</h1>

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
	
	
	<!-- The Modal -->
	<div id="myModal" class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
	
	  <!-- Modal content -->
	  <div class="modal-content">
	    <div class="modal-header">
	    	선착순: <h4 class="modal-lmtPnum" id="lmtPnum"></h4><label>명</label><br>
	    	<h4 class="modal-name" id="htdlName"></h4><br>
	    </div>
	    
	    <div class="modal-body">
	    	<span class= 'modal-startTm' id="startTm"></span> &nbsp; - &nbsp; <span class= 'modal-endTm' id="endTm"></span><br>
	    	<span class= 'css-elapTime modal-elapTime' id="elapTime"></span><br>
	    	<h4 class="modal-dcRate" id="dcRate"></h4><br>
	    	<h4 class="modal-befPrice" id="befPrice"></h4><br>
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
	    	
	    </div>
	  </div>
	</div>

</body>
</html>

<script>

	var htdlUL = $(".hotdeal");
	var size = '<c:out value="${fn:length(lists)}"/>';
	var showListId = null;
	
	//모달
	var modal = $(".modal"),
		lmtPnum = $("#lmtPnum"),
		htdlName = $("#htdlName"),
		startTm = $("#startTm"),
		endTm = $("#endTm"),
		mElapTime = $("#elapTime"),
		dcRate = $("#dcRate"),
		befPrice = $("#befPrice"),
		afterPrice = $("#afterPrice"),
		avgRating = $("#avgRating"),
		revwTotNum = $("#revwTotNum"),
		menuName = $("#menuName"),
		intro = $("#intro");
	
	$(document).ready(function() {
	
		console.log("==="+size);
		//showList("A");
		showListStart("A");
		
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
			
			var operation = $(this).data("oper");
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
				showList("P");
				//showListStart("P");
			}else if(operation === 'activate'){
				//핫딜 진행중
					/* getList({stusCd: "A"}, function(list){
					for(var i=0, len = list.length || 0; i<len; i++){
						console.log(list[i]);
					}
					
				});  */
				
				htdlUL.empty();
				showListStart("A");
				//showList("A");
			}else if(operation === 'register'){
				$("form").submit();
			}
		});
				
	});
	
	
	
	//타이머 중지
	function stop(id){
		clearInterval(id);
	}
	
	//타이머 설정
	function showListStart(stusCd){
		showList(stusCd);
		showListId = setInterval(showList,1000, stusCd);
	}
	
	//경과시간 구하기
	function getElapTime(endTime){
		
		console.log("--------end-----"+ endTime);
		
		var date =new Date();
	    		
		//var endTime = endTimes[i].innerHTML;
		//console.log("endTime: " + endTime);
		//종료 시간 변환
		var fmtTime = new Date(endTime);
		console.log("fmtTime: " + fmtTime);
		
		//경과 시간
		var elapsedTime = (fmtTime.getTime() - date.getTime()) / 1000;
		
		console.log("=========="+elapsedTime);

		//경과 시간 시분초 구한다
		var elapsedSec = Math.floor((elapsedTime % 3600 % 60));
		var elapsedMin = Math.floor((elapsedTime % 3600 / 60));
		var elapsedHour = Math.floor((elapsedTime / 3600));
		
		console.log("hour: " +elapsedHour);
		console.log("m: " +elapsedMin);
		console.log("s: " +elapsedSec);
		
		//시분초 문자열 00:00:00
		var elapTime = [ (elapsedHour > 9 ? '' : '0')+ elapsedHour, ':',
						(elapsedMin > 9  ? '' : '0')+ elapsedMin, ':',
						(elapsedSec > 9  ? '' : '0')+ elapsedSec].join('');
								
		console.log("elapTime========"+elapTime);
		$(".js-elapTime1").html(elapTime);
		
		return elapTime;
	}
	
	

	//핫딜 리스트 보여주기
	function showList(param){
		
		getList({stusCd: param}, function(list){
			var str = "";
			
			//ajax 요청 list가 널이거나 0이면 ""
			if(list == null || list.length == 0){
				htdlUL.html("");
				return;
			}
			console.log(list.length);
			
			//list에 따른 핫딜 동적 생성
			for(var i =0, len = list.length || 0; i<len; i++){
				var elapTime = getElapTime(list[i].endTm);
				str += "<div class='css-hotdeal js-htdl"+i+"'>";
				/* str += "<div class='css-hotdeal js-htdl'>"; */
				str += "=========================================<br>"
				str += "남은 시간: <span class='js-elapTime css-elapTime'>"+elapTime+"</span><br>"
				str += "핫딜 번호: <span class='js-htdlId'>"+ list[i].htdlId+"</span><br>"
				str += "핫딜 이름: "+ list[i].name+"<br>"
				str += "핫딜 할인율: "+ list[i].dcRate * 100+"%"+"<br>"
				str += "핫딜 시작 시간: "+ "<span class= 'js-start'>"+list[i].startTm+"</span>"+"<br>"
				str += "핫딜 종료 시간: "+ "<span class= 'js-end'>"+list[i].endTm+"</span>"+"<br>"
				
				str += "메뉴: ";
				console.log("======="+ list[i].htdlDtls);
				console.log(list[i].dtlsList);
			
			//핫딜 메뉴 리스트 생성
			for(var j=0, dtlsLen = list[i].htdlDtls.length || 0; j<dtlsLen; j++){
				str += list[i].htdlDtls[j].menuName+" ";
				console.log(list[i].htdlDtls[j].menuName);
			}
				str +="<br>";
				console.log("========="+list[i].befPrice);
				console.log("========="+list[i].ddct);
				str += "핫딜 할인 전 가격: "+ list[i].befPrice+"<br>";
				str += "핫딜 할인 후 가격: "+ (list[i].befPrice - list[i].ddct)+"<br>";
				str += "핫딜 소개: "+ list[i].intro+"<br>";
				str += "핫딜 마감 인원: "+ list[i].lmtPnum+"<br>";
				str += "매장 평점 "+ list[i].storeEval.avgRating+"<br>";
				str += "리뷰 수 "+ list[i].storeEval.revwTotNum+"<br>";
				str += "=========================================";
				str +="</div>"
				
				
			}
			
			htdlUL.html(str);
			
			eventHtdlListener();
			
		});
	
	}
	
	//해당 핫딜을 ajax 요청을 통해 불러온다
	function getHtdl(param, callback, error){
		var htdlId = param.htdlId;
		
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
		var size = htdl.htdlDtls.length;		
		var str = [];
		
		console.log("===============showModal" + htdl.lmtPnum+"," + size);
		lmtPnum.text(htdl.lmtPnum);
		htdlName.text(htdl.name);
		startTm.text(htdl.startTm);
		endTm.text(htdl.endTm);
		
		var elapTime = getElapTime(htdl.endTm);
		console.log(elapTime+"===============elapTime");
		mElapTime.text(elapTime);
		dcRate.text(htdl.dcRate*100+"%");
		befPrice.text("₩"+htdl.befPrice);
		afterPrice.text("₩"+(htdl.befPrice - htdl.ddct));
		avgRating.text(htdl.storeEval.avgRating);
		revwTotNum.text(htdl.storeEval.revwTotNum);
		
		for(var i=0; i<size; i++){
			str.push(htdl.htdlDtls[i].menuName);
		}
		menuName.text(str.join(","));		
		
		intro.text(htdl.intro); 
		
		modal.show();
	}
	
	//핫딜 클릭(상세) 이벤트 등록
	function eventHtdlListener(){
		
		//생성된 핫딜에 클릭시 이벤트 생성
		for(var i = 0; i< size; i++){
		 $(".js-htdl"+i).on("click",function(){
			 console.log(this);
			 
			 //핫딜번호를 가져온다
			 var param = $(this).find(".js-htdlId").text();
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
		var stusCd = param.stusCd;
		console.log(stusCd);
		
		$.getJSON("/dealight/hotdeal/main/"+stusCd+".json", function(data){
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