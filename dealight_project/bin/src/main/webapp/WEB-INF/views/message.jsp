<!-- 동인 추가 -->

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
result : ${result}
<a href='/dealight/business/manage?storeId='${storeId}>매장으로 돌아가기</a>
</body>
</html>
