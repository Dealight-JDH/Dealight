<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div style="text-align: center">
	${user.userId }
	${user.id }
	${user.name }
	<c:if test="${user.nickName != null}">
		${user.nickName }
	</c:if>
</div>


<form action ="/login" method = "post">
	<input type="hidden" name="username" value="${user.userId }">
	<input type="hidden" name="password" value="${user.id }">
	
	<input type='submit' value="메인">
</form>
</body>
</html>