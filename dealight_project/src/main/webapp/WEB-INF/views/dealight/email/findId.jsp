<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@include file="../../includes/loginmodalHeader.jsp" %>
    <%@include file="../../includes/mainMenu.jsp" %>
    <%@include file="../../includes/loginModal.jsp" %>
    
    <!-- 현수현수현수 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 페이지~</title>
</head>
<body>
<h1>아이디 찾기 페이지</h1>
<h3>다소 느립니다...버튼 누르고 5초만 기다려주세용..</h3>
<div>
<p>이메일<input type="email" name="email" id="email" placeholder="이메일을 입력하세요"></p>
<p><button type="submit" id="sendEmail">이메일발송</button></p>
</div>
<a href = "/dealight/dealight">홈으로</a>
</body>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
//1. 이메일 인증버튼 클릭시 이벤트발생
$(function(){
	$("#sendEmail").on("click", function(){
		
		let email = $("#email").val();
		if(email == ""){
			alert("이메일을 입력하여 주십시오.");
			return false;
		}
		let send = {'email' : email}
		$.ajax({
			type:"post",
			url: "/dealight/email/sendId",
			data: send,
			success : function(data){
					//data가 true면 이메일 발송 성공
					if(data){
						alert("이메일이 발송되었습니다.");
						
					}else{
						alert("이메일이 일치하지 않습니다.");
						return false;
					}
					
				}
		}) //ajax end
	})
	})

</script>
</html>