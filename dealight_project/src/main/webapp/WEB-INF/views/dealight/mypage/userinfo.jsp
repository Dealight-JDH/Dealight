<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../includes/mainMenu.jsp" %> 
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--     <%@include file="../includes/menubar.jsp" %> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UserInfo</title>
</head>
<body>
<h3>환영합니다.</h3>

<p>아이디  :<c:out value = "${user.userId }"/></p>
<p>이름     :<c:out value = "${user.name }"/></p>
<p>이메일  :<c:out value = "${user.email }"/></p>
</body>
</html>