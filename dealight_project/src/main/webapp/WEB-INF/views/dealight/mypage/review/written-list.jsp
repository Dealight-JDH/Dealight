<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- Add icon library -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
	<h1>내가 작성한 리뷰</h1> <br />
	
	<button>
		<a href="writable-list?userId=${userId }">
		작성 가능한 리뷰</a>
	</button> <br /> <br />

	내가 작성한 리뷰 수: ${countRevw } <br />
	내가 방문한 매장 수: ${countStore } <br /> <br />

	<div class="writtenRevw">
	
		<c:forEach items="${written }" var="written">
			리뷰사진: <c:out value="${written.img.imgUrl }" /> <br />
			 매장명: <c:out value="${written.storeNm }" /> <br />
			평점: <c:out value="${written.rating }" /> <br />
			리뷰작성날짜: <c:out value="${written.regDt }" /> <br />
			리뷰내용: <c:out value="${written.cnts }" /> <br /> <br />
		</c:forEach>
	</div>
	
	<!-- 매장의 리뷰 답변 업데이트해야 함 -->
	
</body>
</html>