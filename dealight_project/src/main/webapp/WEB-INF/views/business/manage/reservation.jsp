<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<h1>Business Reservation Page</h1>

<h2>예약</h2>

<h6>예약 번호: ${rsvd.id}</h6>
<h6>매장 번호: ${rsvd.storeId}</h6>
<h6>예약 회원 아이디: ${rsvd.userId}</h6>
<h6>핫딜 번호: ${rsvd.htdlId}</h6>
<h6>승인 번호: ${rsvd.aprvNo}</h6>
<h6>예약 인원: ${rsvd.pnum}</h6>
<h6>예약 시간: ${rsvd.time}</h6>
<h6>예약 상태: ${rsvd.stusCd}</h6>
<h6>예약 총 금액: ${rsvd.totAmt}</h6>
<h6>예약 총 수량: ${rsvd.totQty}</h6>
<h6>예약 작성 날짜: ${rsvd.inDate}</h6>

<h2>예약 상세</h2>
<c:if test="${not empty rsvd.rsvdDtlsList}">
<c:forEach items="${rsvd.rsvdDtlsList}" var="dtls">
<div>
=====================================
	<h6>예약 번호: <c:out value="${dtls.rsvdId}" /></h6>
	<h6>예약 상세 번호 : <c:out value="${dtls.rsvdSeq}" /></h6>
	<h6>예약 상세 메뉴 이름 : <c:out value="${dtls.menuNm}" /></h6>
	<h6>예약 상세 메뉴 수량 : <c:out value="${dtls.menuTotQty}" /></h6>
	<h6>예약 상세 메뉴 가격 : <c:out value="${dtls.menuPrc}" /></h6>
=====================================
</div>
</c:forEach>
</c:if>

<h2>예약 히스토리</h2>
<c:if test="${not empty rsvdList}">
<c:forEach items="${rsvdList}" var="bfRsvd">
=====================================
<h6>예약 번호: ${bfRsvd.id}</h6>
<h6>매장 번호: ${bfRsvd.storeId}</h6>
<h6>예약 회원 아이디: ${bfRsvd.userId}</h6>
<h6>핫딜 번호: ${bfRsvd.htdlId}</h6>
<h6>승인 번호: ${bfRsvd.aprvNo}</h6>
<h6>예약 인원: ${bfRsvd.pnum}</h6>
<h6>예약 시간: ${bfRsvd.time}</h6>
<h6>예약 상태: ${bfRsvd.stusCd}</h6>
<h6>예약 총 금액: ${bfRsvd.totAmt}</h6>
<h6>예약 총 수량: ${bfRsvd.totQty}</h6>
<h6>예약 작성 날짜: ${bfRsvd.inDate}</h6>
=====================================
</c:forEach>
</c:if>
</body>
</html>