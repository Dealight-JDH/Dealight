<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역</title>
<style>
	#rsvdWrapper {
		margin-left: 30px;
	}
	button {
	
		margin : 5px;
	}
	.pull-right {
		float : left;
	}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<h1>My Page Resrvation List</h1>

<div id="rsvdWrapper">
<h2>회원 아이디 : ${userId }</h2>

<h2>총 예약 횟수 : ${total}회</h2>


<c:if test="${empty rsvdList}">
	<h2>예약한 이력이 없습니다.</h2>
</c:if>

<c:if test="${not empty rsvdList}">
<h2>예약 리스트</h2>
<c:forEach items="${rsvdList}" var="rsvd">

<div>
====================================
<h3>예약 번호 : ${rsvd.rsvdId}</h3>
매장번호 : ${rsvd.storeId}</br>
날짜 : ${rsvd.time } </br>
인원 : ${rsvd.pnum }</br>
메뉴 : 
<c:forEach items="${rsvd.rsvdDtlsList}" var="rsvdDtls">
${rsvdDtls.menuNm}
</c:forEach>
</br>
결제금액 : ${rsvd.totAmt}</br>
결제수량 : ${rsvd.totQty}</br>
현재 예약 상태 : ${rsvd.stusCd}<br>
<button>예약 상세 보기</button>
<button>리뷰 쓰기</button>
</div>
</c:forEach>
</c:if>
</div>

<!-- pagination -->
<div class='pull-right'>
	<ul class='pagination'>

		<c:if test="${pageMaker.prev}">
			<li class='paginate_button previous'>
				<a href="${pageMaker.startPage - 1}">Previous</a>
			</li>
		</c:if>
		
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}">
				<a href="${num}">${num}</a>
			</li>
		</c:forEach>
		
		<c:if test="${pageMaker.next}">
			<li class='paginate_button next'>
				<a href="${pageMaker.endPage + 1}">Next</a>
			</li>
		</c:if>
	</ul>
</div>
<form id='actionForm' action="/dealight/mypage/reservation" method='get'>
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
	<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
</form>
<!-- end pagination -->

<script type="text/javascript">
$(document).ready(function() {
	
	let actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click", function(e) {
		
		e.preventDefault();
		
		console.log("page click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
}); /* document ready end*/

</script>
</body>
</html>