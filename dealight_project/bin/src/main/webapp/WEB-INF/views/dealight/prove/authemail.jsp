<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@include file="../../includes/loginmodalHeader.jsp" %>
    <%@include file="../../includes/mainMenu.jsp" %>
    <%@include file="../../includes/loginModal.jsp" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <!-- 현수현수현수 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증페이지</title>
</head>
<body>
<h1>여기는 회원가입 전 이메일 인증 받는 페이지</h1>
<h2>5초만 기다려주세요....</h2>
<h4>본인 확인을 위하여 이메일을 입력하여 주세요</h4>
<div class="sendEmail">
	<form action="/dealight/prove/authemail" method="post" onsubmit="return validEmail()"> 
	<p>이메일<input type="email" name="email" id="email" placeholder="이메일을 입력하여 주세요"></p>
	<p><button type="submit" id="sendEmailbtn">이메일발송</button></p>
	<input type="hidden" id='num' value='<c:out value="${num}"/>'>
	<input type="hidden" id='authNum' value='<c:out value="${authNum}"/>'>
	</form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
//인증번호와 내가입력한 번호가 일치하지 않는다면 경고창
let num = document.getElementById("num");
let authNum = document.getElementById("authNum");
	if(num.value != "" || authNum.value != ""){
		if(num != authNum){
			alert("인증번호가 일치하지 않습니다.");
		}
	}
	
	function validEmail(){
	//이메일 유효성검사
	let jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	
		if($("#email").val() == ""){
			alert('이메일을 입력하여 주세요');
			$("#email").focus();
			return false;
		}
	
		if(!jEmail.test($("#email").val())){
			alert('이메일 형식에 맞지 않습니다');
			$("#email").val("");
			$("#email").focus();
			return false;
		} 
	}
</script>

</body>
</html>