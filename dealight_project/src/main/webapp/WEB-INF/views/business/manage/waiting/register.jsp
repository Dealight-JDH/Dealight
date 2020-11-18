<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오프라인 웨이팅 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>Business Waiting Register Page</h1>

<form action="/business/manage/waiting/register?storeId=${storeId}" method="post">

	<label id="custNm">고객 이름</label>
	<input name="custNm"></br>
	
	<label id="custTelno">고객 연락처</label>
	<input name="custTelno"></br>
	
	<label id="waitPnum">웨이팅 인원</label>
	<input name="waitPnum"></br>

	<label id="curTime">현재시간</label>
	<input name="curTime" value="${curTime}" hidden>
	<h2>현재 시간 : ${curTime}</h2>
	
	<input name="storeId" value="${storeId}" hidden>

	<button type="submit">제출하기</button>
</form>
<div>
현재 웨이팅 인원 : ${curWaitNum}팀</br>
예상 대기 시간 : ${curWaitTime}분
</div>
</body>
</html>