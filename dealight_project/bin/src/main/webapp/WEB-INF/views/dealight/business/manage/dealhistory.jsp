<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 핫딜 히스토리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
	main{
		margin : 30px auto;
		width:1050px;
	}
	</style>
</head>
<body>
<main>
	<h1>Business Hotdeal History Page</h1>
	
	<h2>현재 진행중 핫딜</h2>
	
	<c:if test="${empty curList}">
	
	<h2>현재 진행중인 핫딜이 없습니다!🤣</h2>
	
	</c:if>
	
	<c:if test="${not empty curList}">
	<c:forEach items="${curList}" var="htdl">
		--------------------------------------------------------
		<div>
		<h5>핫딜 이름 : <c:out value="${htdl.name}" /></h5>
		<h5>핫딜 할인률 : <c:out value="${htdl.dcRate}" /></h5>
		<h5>핫딜 시작 시간 : <c:out value="${htdl.startTm}" /></h5>
		<h5>핫딜 마감 시간 : <c:out value="${htdl.endTm}" /></h5>
		<h5>핫딜 제한 인원 : <c:out value="${htdl.lmtPnum}" /></h5>
		<h5>핫딜 소개 : <c:out value="${htdl.intro}" /></h5>
		<h5>핫딜 이전 가격 : <c:out value="${htdl.befPrice}" /></h5>
		<h5>핫딜 차감 비용 : <c:out value="${htdl.ddct}" /></h5>
		<h5>핫딜 현재 인원 : <c:out value="${htdl.curPnum}" /></h5>
		<h5>핫딜 현재 상태 : <c:out value="${htdl.stusCd}" /></h5>
		</div>
		-------------------------------------------------------- <br>
	</c:forEach>
	</c:if>
	
	<h2>핫딜 히스토리</h2>
	
	<c:if test="${empty htdlList}">
	
	<h2>핫딜을 하신 이력이 없습니다!</h2>
	
	</c:if>
	<c:if test="${not empty curList}">
	<c:forEach items="${htdlList}" var="htdl">
		--------------------------------------------------------
		<div>
		<h5>핫딜 이름 : <c:out value="${htdl.name}" /></h5>
		<h5>핫딜 할인률 : <c:out value="${htdl.dcRate}" /></h5>
		<h5>핫딜 시작 시간 : <c:out value="${htdl.startTm}" /></h5>
		<h5>핫딜 마감 시간 : <c:out value="${htdl.endTm}" /></h5>
		<h5>핫딜 제한 인원 : <c:out value="${htdl.lmtPnum}" /></h5>
		<h5>핫딜 소개 : <c:out value="${htdl.intro}" /></h5>
		<h5>핫딜 이전 가격 : <c:out value="${htdl.befPrice}" /></h5>
		<h5>핫딜 차감 비용 : <c:out value="${htdl.ddct}" /></h5>
		<h5>핫딜 현재 인원 : <c:out value="${htdl.curPnum}" /></h5>
		<h5>핫딜 현재 상태 : <c:out value="${htdl.stusCd}" /></h5>
		</div>
		--------------------------------------------------------
	</c:forEach>
	</c:if>
</main>
<%@include file="../../../includes/mainFooter.jsp" %>
</body>
</html>