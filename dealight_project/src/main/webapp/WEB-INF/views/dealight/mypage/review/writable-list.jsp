<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 수빈 -->
<%@ include file="../../../includes/mainMenu.jsp" %>
<%@ include file="../../../includes/mypageSidebar.jsp" %>		
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

// 로그인이 안된 상태면 메인페이지로 넘어가게
let msg = '${msg}';
	if(msg != ""){
        alert(msg);
        location.href = '/dealight/dealight';
     }
</script>

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
	<div class="writable-main">	
		<h1>작성 가능한 리뷰</h1> <br />
		
		<button>
			<a href="written-list">
			내가 작성한 리뷰</a>
		</button> <br /> <br />
	
		<c:if test="${empty rsvdList }">
			<p>작성 가능한 예약내역이 없습니다.</p>
		</c:if>
		
		<c:if test="${not empty rsvdList }">
			<c:forEach items="${rsvdList }" var="rsvd">
				<br />
				회원아이디: <c:out value="${rsvd.userId }" /> <br />
				매장대표사진: <c:out value="${rsvd.bstore.repImg }" /> <br />
				예약번호: <c:out value="${rsvd.rsvdId }" /> <br />
				매장명: <c:out value="${rsvd.store.storeNm }" /> <br />
				예약날짜: <fmt:formatDate pattern="yyyy-MM-dd" value="${rsvd.regdate }" /> <br />
				예약인원: <c:out value="${rsvd.pnum }" /><br />
				예약메뉴: <c:out value="${rsvd.dtls.menuNm }" /> <br />
				예약메뉴수: <c:out value="${rsvd.dtls.menuTotQty }" /> <br />
				예약금액: <c:out value="${rsvd.totAmt }" />원 <br />
		
				<button class="myBtn">
					<a href="register/rsvd?rsvdId=<c:out value="${rsvd.rsvdId }" />&waitId=-1">
						<!-- onclick="window.open(this.href,'','width=450, height=600'); return false;"> --> 
					리뷰 쓰기</a>
				</button> <br />
			</c:forEach>
		</c:if>
	
		<c:if test="${empty waitList }">
			<p>작성 가능한 웨이팅내역이 없습니다.</p>
		</c:if>
		
		<c:if test="${not empty waitList }">
			<c:forEach items="${waitList }" var="wait"> <br />
				
				회원아이디: <c:out value="${wait.userId }" /> <br />
				매장대표사진: <c:out value="${wait.bstore.repImg }" /> <br />
				웨이팅번호: <c:out value="${wait.waitId }" /> <br />
				매장명: <c:out value="${wait.store.storeNm }" /> <br />
				웨이팅시간: <fmt:formatDate pattern="yyyy-MM-dd" value="${wait.waitRegTm }" /> <br />	
				웨이팅인원: <c:out value="${wait.waitPnum }" /> <br />
				
				<button class="myBtn">
					<a href="register/wait?waitId=<c:out value="${wait.waitId }" />&rsvdId=-1">
					리뷰 쓰기</a>
				</button>
				<br />
			</c:forEach>
		</c:if>
	</div>
</div>
	
</body>
</html>