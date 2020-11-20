<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 수빈 -->
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
	<h1>작성 가능한 리뷰</h1> <br />
	
	<button>
		<a href="written-list?userId=${userId }">
		내가 작성한 리뷰</a>
	</button> <br /> <br />

	<c:forEach items="${rsvdList }" var="rsvd">
		<br />
		회원아이디: <c:out value="${rsvd.userId }" /> <br />
		매장대표사진: <c:out value="${rsvd.store.repImg }" /> <br />
		예약번호: <c:out value="${rsvd.rsvdId }" /> <br />
		매장명: <c:out value="${rsvd.store.storeNm }" /> <br />
		예약날짜: <fmt:formatDate pattern="yyyy-MM-dd" value="${rsvd.regDate }" /> <br />
		예약인원: <c:out value="${rsvd.pnum }" /><br />
		예약메뉴: <c:out value="${rsvd.dtls.menuNm }" /> <br />
		예약메뉴수: <c:out value="${rsvd.dtls.menuTotQty }" /> <br />
		예약금액: <c:out value="${rsvd.totAmt }" />원 <br />

		<button class="myBtn">
			<a href="register/rsvd?userId=<c:out value="${rsvd.userId }" />&rsvdId=<c:out value="${rsvd.rsvdId }" />&waitId=-1">
				<!-- onclick="window.open(this.href,'','width=450, height=600'); return false;"> --> 
			리뷰 쓰기</a>
		</button>
		<br />
	</c:forEach>

	<c:forEach items="${waitList }" var="wait">
		<br />
		회원아이디: <c:out value="${wait.userId }" /> <br />
		매장대표사진: <c:out value="${wait.store.repImg }" /> <br />
		웨이팅번호: <c:out value="${wait.waitId }" /> <br />
		매장명: <c:out value="${wait.store.storeNm }" /> <br />
		웨이팅시간: <fmt:formatDate pattern="yyyy-MM-dd" value="${wait.waitRegTm }" /> <br />	
		웨이팅인원: <c:out value="${wait.waitPnum }" /> <br />
		
		<button class="myBtn">
			<a href="register/wait?userId=<c:out value="${wait.userId }" />&waitId=<c:out value="${wait.waitId }" />&rsvdId=-1">
			리뷰 쓰기</a>
		</button>
		<br />
	</c:forEach>
	
	<script>

	</script>
	
</body>
</html>