<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜 목록</title>
<style>
	#likeWrapper {
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
<h1>My Page Like List</h1>

<div id="likeWrapper">
<h2>회원 아이디 : ${userId }</h2>

<h2>총 찜 횟수 : ${total}회</h2>


<c:if test="${empty likeList}">
	<h2>찜을 한 이력이 없습니다.</h2>
</c:if>

<c:if test="${not empty likeList}">
<h2>찜 목록</h2>
<c:forEach items="${likeList}" var="like">

<div>
====================================
<h3>찜 매장 : ${like.storeId}</h3>
<h3>찜 등록날짜 : ${like.regdate}</h3>
<button>매장 상세 보기</button>
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
<form id='actionForm' action="/dealight/mypage/like" method='get'>
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