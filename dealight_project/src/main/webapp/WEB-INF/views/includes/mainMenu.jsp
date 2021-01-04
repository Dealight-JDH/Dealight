<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
<!--  common  -->
<link rel="stylesheet" href="/resources/css/common.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/main_footer.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/main_header.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/alert_manager.css" type ="text/css" />
<link rel="shortcut icon" href="/resources/icon/favicon.png" type="image/x-icon">
<link rel="icon" href="/resources/icon/favicon.png" type="image/x-icon">
<!--  end common  -->

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- Add icon library -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>


.top {
	overflow: hidden;
	flex: 1;
	/* 비율을 1:1:1로 주기 */
	height: 35px;
	display: inline-block;
	z-index: 0;
}

.dropbtn {
	margin-top: 0;
	padding-left: 10px;
	border: none;
	outline: none;
	font-size: 30px;
	cursor: pointer;
	display: inline-block;
}

.dropdown {
	position: absolute;
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	min-width: 160px;
	z-index: 1;
	background-color: #f1f1f1;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

.dropdown-content a {
	display: block;
	padding: 3px;
	color: black;
	font-size: 15px;
	text-decoration: none;
}

.dropdown-content a:hover {
	background-color: crimson;
	color: white;
}

.dropbtn:hover .dropdown-content {
	display: block;
	z-index: 99;
}

.logo {
	margin-left: 40%;
	padding: 3px 8px;
	display: inline-block;
	height: 100%;
	text-align: center;
	font-size: 30px;
}

.logo-content {
	float: left;
}

.rightIcon {
	float: right;
	padding: 3px 8px;
	font-size: 28px;
}

.mydropbtn {
	color: white;
	z-index: 1;
}

.mydropdown {
	position: relative;
	display: inline-block;
}

.mydropdown-content {
	display: none;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.mydropdown-content a {
	color: black;
	font-size: 15px;
	padding: 3px 5px;
	text-decoration: none;
	display: block;
}

.mydropdown-content a:hover {
	background-color: #ddd;
}

.mydropdown:hover .mydropdown-content {
	display: block;
}

.middleDiv {
	width: 100%;
	height: 600px;
	position: relative;
}

.imgContainer {
	width: 100%;
	height: 100%;
	position: absolute;
}

.imgContainer img {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.searchBarDiv {
	border: 1px solid black;
	margin: 0 auto;
	margin-top: 100px;
	width: 40%;
	height: 100px;
	position: relative;
}

.topRow {
	border: 1px solid black;
	display: inline-block;
	width: 100%;
	height: 50%;
	background-color: white;
}

.topRowBar {
	border: 1px solid black;
	float: left;
	width: 33.33%;
	height: 100%;
}

.bottomRow {
	border: 1px solid black;
	display: block;
	position: absolute;
	top: 50%;
	width: 100%;
	height: 50%;
	background-color: white;
}

.bottomRowBar {
	border: 1px solid black;
	float: left;
	width: 80%;
	height: 100%;
}

.searchbtn {
	background-color: crimson;
	color: white;
	width: 20%;
	height: 100%;
	border: none;
}

.dealTitleDiv {
	border: 1px solid rgb(151, 151, 151);
	width: 80%;
	height: 50px;
	margin: 30px auto 0 auto;
}

.dealTitle {
	border: 1px solid black;
	width: 150px;
	height: 100%;
	display: inline-block;
}

.dealDiv {
	border: 1px solid black;
	width: 80%;
	height: 1200px;
	margin: auto;
	overflow: hidden;
}

.dealContainer {
	border: 1px solid black;
	display: inline-block;
	margin: 23px 30px;
	width: 28%;
	height: 350px;
}

.dealImg {
	border: 1px solid black;
	display: block;
	width: 100%;
	height: 70%;
}

.dealText {
	border: 1px solid black;
	display: block;
	width: 100%;
	height: 30%;
}

.footer {
	border: 1px solid black;
	width: 100%;
	height: 180px; 
	z-index: 1;
	cursor: pointer;
}

/* add style */



/* end added style*/


</style>
</head>
<body>
<header class="main_nav">
        <nav class="main_nav_left">
        	<a href='/dealight/dealight/'><div class="main_nav_logo"><img id="logo" src="/resources/icon/d2.png" alt=""></div></a>
        </nav>
        
        <nav class="main_nav_right">
            <div id="header_cur_wait"></div>
            <div class='nav_user_id_box'><c:if test="${userId != null}"> <span id="nav_user_id">${userName}님</span></c:if></div>
            <sec:authorize access="isAuthenticated()">
            	<sec:authorize access="hasRole('ROLE_USER')">
            	<div class="nav_reg_brno"><a href="/dealight/mypage/bizauth/list">사업자 등록</a></div>
            	</sec:authorize>
            </sec:authorize>
            <div class="account_btn">
            	<div class="account_icon_box">
            		<div class="account_menu"><i class="fas fa-bars"></i></div>
            		<div class="account_icon"><i class="fas fa-user-circle"></i></div>
            		<div class="account-dropdown-content">
						<div class="common_menu_cnts">
							<div class="account_cnts"><a href="/dealight/hotdeal/main">핫딜 찾기</a></div>
	        				<div class="account_cnts"><a href="/dealight/search/">매장 찾기</a></div>
	        			</div>
						<sec:authorize access="isAnonymous()">
								<div class="account_cnts"><a href="/dealight/login">로그인</a></div>
								<div class="account_cnts"><a href="/dealight/register">회원가입</a></div>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<sec:authorize access="hasRole('ROLE_USER')">
								<div class="account_cnts"><a href="/dealight/mypage/reservation">예약 내역</a></div> 
								<div class="account_cnts"><a href="/dealight/mypage/wait">웨이팅 내역</a></div>
								<div class="account_cnts"><a href="/dealight/mypage/review/">나의 리뷰</a></div>
								<div class="account_cnts"><a href="/dealight/mypage/like">찜 목록</a> </div>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_MEMBER')">								
								<div class="account_cnts"><a href="/dealight/business/">매장 관리</a></div>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">								
								<div class="account_cnts"><a href="/dealight/admin/main ">서비스 관리</a></div>
							</sec:authorize>
								<div class="account_cnts"><a href="/dealight/mypage/get">회원정보수정</a></div>
								<div class="account_cnts" onclick="submit(event)"><a href="/logout" >로그아웃</a></div>
						</sec:authorize>
					</div>
            	</div>
            </div>
        </nav>
    </header>
    
    <div class="alert manage_rsvd hide">
        <div class="alert_check_mark rsvd">
            <i class="fas fa-check-circle"></i>
        </div>
        <div class="alert_cnts_wrapper">
             <strong class="alert_tit">예약</strong>
             <span class="alert_msg">예약 관련 notification 입니다.</span>
        </div>
        <span class="alert_closebtn"><i class="fas fa-times"></i></span>  
    </div>
    <div class="alert manage_wait hide">
        <div class="alert_check_mark wait">
            <i class="fas fa-check-circle"></i>
        </div>
        
        <div class="alert_cnts_wrapper">
            <div class="alert_cnts_top">
                <strong class="alert_tit">웨이팅</strong>
            </div>
            <span class="alert_msg"><a>104번 웨이팅</a>이 등록되었습니다.</span>
        </div>
        <span class="alert_closebtn"><i class="fas fa-times"></i></span>  
      </div>
      <div class="alert manage_htdl hide">
        <div class="alert_check_mark htdl">
            <i class="fas fa-check-circle"></i>
        </div>
        <div class="alert_cnts_wrapper">
            <strong class="alert_tit">핫딜</strong>
            <span class="alert_senduser"></span>
            <span class="alert_msg">핫딜 관련 notification 입니다.</span>
            <span class="alert_dto"></span>
        </div>
        <span class="alert_closebtn"><i class="fas fa-times"></i></span>
        <div class="alert_btn_box"> 
            <button class='btnAcceptHtdl'>등록</button>
            <button class="alert_reject_btn">거절</button>
        </div>
      </div>
	
	<script>
	
	$(document).ready(function(){
		console.log("security user.....")
		console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}');

	});

	//로그아웃 폼 제출
	function submit(e){
		e.preventDefault();
		let body = $("body");
		let form = $("<form></form>");
		form.attr("action", "/dealight/logout");
		form.attr("method", "post");
		
		let csrfInput = $("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'>");
		form.append(csrfInput);
		form.appendTo(body);
		form.submit();
		
	}
	
	$("#logo").on("click",function(e){
		
		self.location.href="/dealight/dealight";
	});
	
	
 //1. 버튼을 누르면 모달창이 띄어지고, 배경 회색으로 변경
   function openModal(){
       document.getElementById('content').style.display='block';
       document.body.style.backgroundColor = "rgba(0,0,0,0.4)";

}

//2. X버튼을 누르면 모달창이 사라지고 원상복귀
   function closebtn(){
   document.getElementById('content').style.display='none';
   document.body.style.backgroundColor = "white";
}

//3. login상태에서 사람모양 클릭시 mypage(예약내역)로 이동
function goMypage(){
	 location.href="/dealight/mypage/reservation";

}

// '해당 매장'의 '웨이팅 리스트'를 가져온다.
function getWait(userId,callback,error) {
    
    let waitList = $.getJSON("/dealight/isCurWait/"+userId+".json",
        function(data){
                if(callback){
                    callback(data);
                }
            }).fail(function(xhr,status,err){
                if(error){
                    error();
                }
    });
    
    return waitList;
}

let header_userId = '${userId}';

if(header_userId.indexOf("@") > -1 ) $("#nav_user_id").text(header_userId.substr(0,header_userId.indexOf("@")) +"님");

getWait(header_userId,wait => {
	if(!wait)
		return
	let waitId = wait.waitId;
	let str = "";
	console.log(waitId);
	str += "<a href='/dealight/waiting/"+waitId+"' target='_blank'>현재 웨이팅 확인하기</a>"
	$("#header_cur_wait").html(str);
});

$(".account_cnts").on("click",(e) => {
	
	console.log(e.currentTarget);
	
	location.href = $(e.currentTarget).find("a").attr("href");
	
});

   </script>