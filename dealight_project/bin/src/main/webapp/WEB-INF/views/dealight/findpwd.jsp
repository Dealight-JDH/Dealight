<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
   <%@include file="../includes/loginmodalHeader.jsp" %>
    <%@include file="../includes/mainMenu.jsp" %>
    <%@include file="../includes/loginModal.jsp" %>
<!--  -->
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기~~</title>
</head>
<body>
<h1>비밀번호 찾기~~</h1>
<h2>5초만 기다려 주세요...</h2>
	<div class="form-group">
	<p>	아이디 <input type="text" id="userId" name="userId" placeholder="아이디를  입력하세요"></p>
	<p>	이메일 <input type="email" id="email" name="email" placeholder="이메일을  입력하세요"></p>
		<button type="submit" id="sendEmail">이메일발송</button>
	</div>
</body>
 <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

//1. 이메일 인증버튼 클릭시 이벤트발생
$(function(){
	$("#sendEmail").on("click", function(){
		let userId = $("#userId").val();
		let email = $("#email").val();
		
		$.ajax({
			type:"post",
			url: "/dealight/prove/sendpwd",
			//여러개의 데이터를 전송할때
			data:{"userId":$("#userId").val(), "email": $("#email").val()},

			success : function(data){
				if(email != "" || userId != ""){
					//data가 true면 이메일 발송 성공
					if(data){
				alert("이메일이 발송되었습니다.");
						
					}else{
						alert("이메일 또는 아이디가 일치하지 않습니다.");
						return false;
					}
					
				}else{
					alert("이메일 또는 아이디를 입력하여 주십시오.");
					return false;
				}
				}
		}) //ajax end
	})
	})

</script> 
</html>