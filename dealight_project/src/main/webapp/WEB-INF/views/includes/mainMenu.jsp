<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.dealight.domain.UserVO"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- Add icon library -->
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<%

UserVO user = (UserVO)session.getAttribute("user");
String loginState = "";
String display = ""; //로그인 전에 로그아웃 메뉴 숨기기
//세션에 로그인 정보가 담겼다면 로그인 모달창 비활성화
if(user != null){
	   loginState = "onclick=\"goMypage()\"";
}else{
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
} */

.top {
   border: 1px solid black;
   overflow: hidden;
   flex: 1;
   /* 비율을 1:1:1로 주기 */
   
   display: inline-block;
   z-index:0;
}

.dropbtn {
   padding-top: 3px;
   padding-left: 10px;
   border: none;
   outline: none;
   font-size: 30px;
   cursor: pointer;
}

.dropdown {
   position: relative;
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

.main {
   border: 1px solid black;
   margin: 0 auto;
   margin-top: 50px;
   height: 1000px;
   width: 800px;
}

.summary-container {
   border: 1px solid black;
   height: 100px;
   width: 100%;
   margin-bottom: 50px;
   display: flex;
}

.summary-count {
   border: 1px solid black;
   height: 100%;
   width: 50%;
   flex: 1;
}

.receipt-container {
   border: 1px solid black;
   height: 200px;
   width: 100%;
   display: flex;
   /* flex-direction: row; */
   overflow: hidden;
}

.receipt-content:nth-child(1) {
   border: 1px solid black;
   flex-basis: 30%;
}

.receipt-content:nth-child(2) {
   border: 1px solid black;
   flex-basis: 50%;
}

.receipt-content:nth-child(3) {
   border: 1px solid black;
   flex-basis: 20%;
}

.register-revwbtn {
   height: 15%;
   width: 100%;
   border: none;
   text-align: center;
   background-color: crimson;
   color: white;
}

.receipt-content-info {
   border: 1px solid black;
   height: 100%;
   width: 100%;
}

.receipt-content:nth-child(1) .receipt-img {
   height: 100%;
   width: 100%;
   overflow: hidden;
   /* align-items: center; */
   /* justify-content: center; */
}

.revw-modal-container {
   border: 1px solid black;
   width: 100%;
   height: 100%;
   display: none;
   position: fixed;
   z-index: 1;
   padding-top: 10%;
   left: 0;
   top: 0;
   overflow: auto;
   background-color: rgb(0, 0, 0);
   background-color: rgba(0, 0, 0, 0.4);
}

.revw-modal-box {
   border: 1px solid black;
   height: 90%;
   width: 33%;
   margin: auto;
   display: flex;
   flex-direction: column;
   background-color: #fefefe;
}

.revw-modal-content:nth-child(1) {
   border: 1px solid black;
   flex-grow: 3;
}

.revw-modal-content:nth-child(2) {
   border: 1px solid black;
   flex-grow: 8;
}

.revw-modal-content:nth-child(3) {
   border: 1px solid black;
   flex-grow: 1;
   text-align: center;
}

.revw-modal-content:nth-child(4) {
   border: 1px solid black;
   flex-grow: 1;
   text-align: center;
}

.rating {
   border: 1px solid black;
   height: 35%;
   width: 100%;
   text-align: center;
}

.star-rating {
   border: 1px solid black;
   height: 40%;
   width: 100%;
}

.revw-text {
   border: 1px solid black;
   height: 60%;
   width: 100%;
}

.revw-text-form {
   border: 1px solid black;
   height: 80%;
   width: 90%;
}

.revw-attach-imgbtn {
   height: 55%;
   width: 30%;
   border: none;
   background-color: gray;
   color: white;
}

.revwbtn {
   height: 55%;
   width: 20%;
   border: none;
   margin: 0 6%;
   text-align: center;
   background-color: crimson;
   color: white;
   
   
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
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.mydropdown-content a {
  color: black;
  font-size: 5px;
  padding: 3px 5px;
  text-decoration: none;
  display: block;
}

 .mydropdown-content a:hover {background-color: #ddd;}

.mydropdown:hover .mydropdown-content {display: block;}





</style>
</head>

<body>
   <div class="top-container" >
      <div class="topDiv" id="topDiv">
         <div class="top" style="height: 50px">
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