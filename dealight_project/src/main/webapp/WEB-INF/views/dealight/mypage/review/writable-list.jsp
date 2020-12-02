<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 수빈 -->
<%@ include file="../../../includes/mainMenu.jsp" %>
<%@ include file="../../../includes/mypageSidebar.jsp" %>		
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- Add icon library -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
<style>

.writable-main {
	margin-top: 80px;
	left: 500px;
	height: 100%;
	width: 800px;
	display: inline-block;
	overflow: auto;
}

</style>
</head>

<body>
	<h2>유저 아이디 : ${userId}</h2>
	<h2>예약 가능한 리스트</h2>
	
	<div class="writable-main">	
	
		<c:if test="${empty dtoList}">
			리뷰 가능한 항목이 없습니다.
		</c:if>
		
		<c:if test="${not empty dtoList}">
			<c:forEach items="${dtoList }" var="dto">
			==================================================
				<h5>매장번호 : ${dto.storeId}</h5>
				<h5>회원 아이디 : ${dto.userId}</h5>
				<h5>시간 : ${dto.time}</h5>
				<h5>리뷰 상태 : ${dto.revwStus}</h5>
				<c:if test="${not empty dto.rsvd }">
					<h2>예약</h2>
					<h5>예약 번호 : ${dto.rsvd.rsvdId}</h5>
					<h5>핫딜 번호 : ${dto.rsvd.htdlId}</h5>
					<h5>승인 번호 : ${dto.rsvd.aprvNo}</h5>
					<h5>예약 인원 : ${dto.rsvd.pnum}</h5>
					<h5>예약 상태 : ${dto.rsvd.stusCd}</h5>
					<h5>예약 총 금액 : ${dto.rsvd.totAmt}</h5>
					<h5>예약 총 수량 : ${dto.rsvd.totQty}</h5>
				</c:if>
				<c:if test="${not empty dto.wait }">
					<h2>웨이팅</h2>
					<h5>웨이팅 번호: ${dto.wait.waitId}</h5>
					<h5>웨이팅 인원: ${dto.wait.waitPnum}</h5>
					<h5>손님 이름: ${dto.wait.custNm}</h5>
					<h5>손님 번호: ${dto.wait.custTelno}</h5>
					<h5>웨이팅 상태: ${dto.wait.waitStusCd}</h5>
				</c:if>
			</c:forEach>
		</c:if>
	
	</div>
	
</body>
</html>