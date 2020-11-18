<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웨이팅 상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>Business Waiting Page</h1>
===========================================
<h5>웨이팅 번호 : ${wait.id}</h5>
<h5>매장 번호 : ${wait.storeId}</h5>
<h5>회원 아이디 : ${wait.userId}</h5>
<h5>웨이팅 접수시간 : ${wait.waitRegTm}</h5>
<h5>웨이팅 인원 : ${wait.waitPnum}</h5>
<h5>웨이팅 고객 연락처 : ${wait.custTelno}</h5>
<h5>웨이팅 고객 이름 : ${wait.custNm}</h5>
<h5>웨이팅 상태 : ${wait.waitStusCd}</h5>
<h5>웨이팅 등록 날짜 : ${wait.inDate}</h5>
===========================================
<h2>현재 대기 순서 : ${order}번째</h2>
<h2>현재 예상 대기 시간 : ${waitTime}분</h2>
===========================================
</body>
</html>