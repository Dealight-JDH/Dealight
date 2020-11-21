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
<title>Insert title here</title>
</head>
<script>
let authNum = ${authNum};
if(authNum != "" ){
alert('이메일을 발송하였습니다. 인증 번호를 확인 후 입력해주세요');
}
</script>
<body>
<h4>인증번호를 입력해 주세요</h4>
<div id = "sendAuth" >
		<form action="/dealight/prove/auth" method="post">
		<p>인증번호<input type="text" id="num" name="num" placeholder="인증번호를 입력하여 주세요"></p>
		<input type='hidden' name = "authNum" value="<c:out value = '${authNum }' />">
		<input type="hidden" name = "email" value="<c:out value = '${email }' />">
		<p><button type="submit" >인증번호 확인</button></p>
		</form>
		
	</div>
</body>
</html>