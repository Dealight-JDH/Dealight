<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 리스트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@include file="../../includes/mainMenu.jsp" %>
<h1>Business List Page</h1>

<h2>${userId}</h2>

<h2><a href="/dealight/business/register">등록하기</a></h2>

<c:forEach items="${storeList}" var="store">
============================================
	<a href='/dealight/business/manage/?storeId=${store.storeId}'><div>
	<h2>매장 이름 : <c:out value="${store.storeNm}" /></h2>
	<h2>매장 전화번호 : <c:out value="${store.telno}" /></h2>
	<h2>매장 소유자 아이디 : <c:out value="${store.bstore.buserId}" /></h2>
	<h2>매장 영업 시작 시간 : <c:out value="${store.bstore.openTm}" /></h2>
	<h2>매장 영업 종료 시간 : <c:out value="${store.bstore.closeTm}" /></h2>
	<h2>매장 오늘 예약 수 : <c:out value="${store.curRsvdNum}" /></h2>
	<h2>매장 현재 웨이팅 수 : <c:out value="${store.curWaitNum}" /></h2>
	<h2>매장 사진: <c:out value="${store.bstore.repImg}" /></h2>
	<img src='${store.bstore.repImg}'>
	
	</div></a>
============================================</br>
</c:forEach>
<img src="C:\\Users\\kjuio\\Desktop\\ex05\\2020\\11\\26\\s_5e11f89f-5c29-4f5e-b4d3-8022ba007f11_pat.png">
<script src="/resources/js/get_upload.js"></script>
</body>
<script>

</script>
</html>