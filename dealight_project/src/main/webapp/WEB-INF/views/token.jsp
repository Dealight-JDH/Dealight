<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
<h2>Rest Template Result</h2>
result : ${result}</br></br>
access_token : ${access_token}</br>


<a href="/message?access_token=${access_token }">메시지 보내기</a>


</body>
</html>
