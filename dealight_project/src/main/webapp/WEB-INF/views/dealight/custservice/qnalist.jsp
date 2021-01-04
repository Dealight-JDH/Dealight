<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<link rel="stylesheet" href="/resources/css/custservice.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<style>
.mypage_main_sub > div{
	width : 100%;
}
.btn_like_cancel{
	color : tomato;
	cursor: pointer;
}
.btn_like_cancel:hover{
	opacity: 0.7;
}
</style>
</head>
<body>

	<main>
        <div class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/custserviceSidebar.jsp" %>

		<div class="box-container flex-column">
			<div class="mypage_main_header">
                    <div class="main_header_title">QnA</div>
                    <div class="main_header_subtitle">궁금한 점을 물어보세요.</div>
                </div>
			<div class="board-body flex-column">
				<div class="contents-wrapper flex-column">
					<c:if test="${pageDTO.total == 0 }">
						<h3>검색결과가 없습니다.</h3>
					</c:if>
					<c:forEach var="qna" items="${list }">
						<a href='<c:out value="${qna.qnaId}"/>' class="move">
							<div class="content-wrapper">
								<div class="content">
									<div class="content-head">
										<c:choose>
											<c:when test="${qna.QClsCd eq 'C'}">
											일반
										</c:when>
											<c:when test="${qna.QClsCd eq 'W'}">
											웨이팅
										</c:when>
											<c:when test="${qna.QClsCd eq 'R'}">
											예약
										</c:when>
										</c:choose>
									</div>
									<div class="content-body">
										<c:out value="${qna.qnaTitle }"></c:out>
									</div>
								</div>
							</div>
						</a>
					</c:forEach>

				</div>
				<div
					style="display: flex; justify-content: space-between; align-items: baseline; align-self: stretch;">
					<button id="register" style="white-space: nowrap;">문의하기</button>
					<form action="/dealight/custservice/qnalist" class="search"
						id="searchForm">
						<label> 카테고리 <select name="filterType">
								<option value="A"
									<c:out value="${(pageDTO.cri.filterType eq 'A' or pageDTO.cri.filterType == null)?'selected':'' }"/>>
									전체</option>
								<option value="C"
									<c:out value="${pageDTO.cri.filterType eq 'C' ?'selected':'' }"/>>
									일반</option>

								<option value="W"
									<c:out value="${pageDTO.cri.filterType eq 'W'?'selected':'' }"/>>
									웨이팅</option>

								<option value="R"
									<c:out value="${pageDTO.cri.filterType eq 'R'?'selected':'' }" />>
									예약</option>
						</select>
						</label> 
						<label style="margin-left: 5px;"> 검색 
							<input type="text" name="keyword" value="<c:out value='${pageDTO.cri.keyword }'/>" />
							<button>검색하기</button>
						</label> 
						<input type="hidden" name="pageNum" value="<c:out value='${pageDTO.cri.pageNum }'/>" />
						<input type="hidden" name="amount" value="<c:out value='${pageDTO.cri.amount }'/>" />
					</form>
					
				</div>
				<div class="pagination">
					<c:if test="${pageDTO.prev }">
						<li class="pagination-item"><a
							href="${pageDTO.startPage - 1 }">Previous</a></li>
					</c:if>

					<c:forEach var="num" begin="${pageDTO.startPage }"
						end="${pageDTO.endPage }">
						<li
							class="pagination-item ${pageDTO.cri.pageNum == num ? 'select':'' }">
							<a href="${num }">${num }</a>
						</li>
					</c:forEach>

					<c:if test="${pageDTO.next }">
						<li class="pagination-item next "><a
							href="${pageDTO.endPage + 1 }">Next</a></li>
					</c:if>
				</div>
				<form id="actionForm" action="/dealight/custservice/qnalist"
					method="get">
					<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
					<input type="hidden" name="filterType" value="<c:out value='${pageDTO.cri.filterType }'/>"> 
					<input type="hidden" name="keyword" value="<c:out value='${pageDTO.cri.keyword }'/>">
				</form>
			</div>

		</div>
	</main>

<%@include file="/WEB-INF/views/includes/mainFooter.jsp" %>

</body>

</html>
<script>
	window.onload = function() {

		$(".move").on("click", function(e) {
			e.preventDefault();
			actionForm.append("<input type='hidden' name='qnaId' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "/dealight/custservice/getqna");
			actionForm.submit();
		});

		const actionForm = $("#actionForm");

		$(".pagination-item a").on("click", function(e) {

			e.preventDefault();

			console.log('click');

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		const searchForm = $("#searchForm");

		$("#searchForm button").on("click", function(e) {

			/* if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			} */
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요.");
				return false;
			} 

			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();

			searchForm.submit();

		});
		
		$("#register").on("click", function(e){
			self.location = "/dealight/custservice/registerqna";
		})

	}
</script>