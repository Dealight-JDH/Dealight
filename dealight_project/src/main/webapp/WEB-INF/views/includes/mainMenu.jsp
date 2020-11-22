<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.dealight.domain.UserVO"%>

<!-- 현수현수현수 -->

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- Add icon library -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<%
	UserVO user = (UserVO) session.getAttribute("user");
String loginState = "";
String display = ""; //로그인 전에 로그아웃 메뉴 숨기기
//세션에 로그인 정보가 담겼다면 로그인 모달창 비활성화
if (user != null) {
	loginState = "onclick=\"goMypage()\"";
} else {
	loginState = "onclick=\"openModal()\"";
	display = "none";
}
%>

<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	padding: 0;
	border: 0;
	font-family: Arial, Helvetica, sans-serif;
}
/* .topDiv {
   border: 1px solid black;
   width: 100%;
   height: 100px;
   display: flex;
   /* 자식에 영향 주기 위한 설정 */
/* 자식인 inline-block들을 가운데정렬
            justify-content: center; */
}
* /
.top {
	border: 1px solid black;
	overflow: hidden;
	flex: 1;
	/* 비율을 1:1:1로 주기 */
	height: 100%;
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
	padding: 10px 12px;
	color: black;
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
	font-size: 5px;
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
	border: 1px solid black;
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

.mydropbtn {
  color: white;
  z-index: 1;
  cursor: pointer;
}


</style>
</head>

<body>

   <div class="top-container" >
      <div class="topDiv" id="topDiv">
         <div style ="height:35px"class="top">
            <div class="dropdown">
               <button class="dropbtn">
                  <i class="fas fa-bars" color="black"></i>
                  <div class="dropdown-content">
                     <a href="#">핫딜 찾기</a> <a href="#">매장 찾기</a>
                  </div>
               </button>
            </div>
            <!--end dropdown-->
         
            <div class="logo">
               <div class="logo-content">
                  <a href="/dealight/dealight" style="text-decoration: none"> <i
                     class="fas fa-circle" color="red" style="font-size: 20px"></i> <i
                     class="fas fa-circle" color="yellow" style="font-size: 20px"></i>
                     <i class="fas fa-circle" color="green" style="font-size: 20px"></i>
                  </a>
               </div>
               <div class="logo-content">
                  <a href="/dealight/dealight" class="dealight" color="black"
                     style="text-decoration: none">Dealight</a>
               </div>
            </div>
            <!--end logo-->
            <!--이 icon들은 굳이 div로 안 나눠도 될듯?-->
            <div class="rightIcon">
               <a href="#"><i class="fas fa-question-circle" color="black"></i></a>
		    
            </div>
            <div class="rightIcon">
               <a href="#"><i class="fas fa-bell" color="black"></i></a>
            </div>
            
            <div class="rightIcon">
               <div class="mydropdown">
    <%-- <button class="mydropbtn" id="openModal" type="button" <%=loginState%>"> 사람이모지~~</button> --%>
    <a class="mydropbtn" id="openModal"  <%=loginState%>"><i class="fas fa-user"  color="black"></i></a>
    
    <div class="mydropdown-content">
       <a href="/dealight/mypage/reservation">예약내역(미구현)</a>
      <a href="#waiting/list">웨이팅(미구현)</a>
      <a href="#review">나의리뷰(미구현)</a>
      <a href="#like">좋아요(미구현)</a> 
      <a href="/dealight/mypage/modify">회원정보수정</a>
      <a href="/dealight/logout" style="display:<%=display %>">로그아웃</a>
    </div>
  </div>
    
         </div>
         
   </div>
   </div>
   </div>
   <script>
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
   </script>
