<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<link rel="stylesheet" href="/resources/css/custservice.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                <div class="title">
                    <div style="margin-left: 40px;">
                        <c:choose>
							<c:when test="${list[0].QClsCd eq 'C'}">
								일반
							</c:when>
							<c:when test="${list[0].QClsCd eq 'W'}">
								웨이팅
							</c:when>
							<c:when test="${list[0].QClsCd eq 'R'}">
								예약
							</c:when>
						</c:choose> 
						 : <c:out value="${list[0].qnaTitle }"/>
                    </div>
                    <div class="date">
                       no.<c:out value="${list[0].qnaId }"/> - <fmt:formatDate pattern="yyyy-MM-dd" 
                    							value="${list[0].regdate }"/>
                    </div>

                </div>
                <c:forEach var="qna" items="${list}">
                <div class="contents-wrapper flex-row">
                    <div class="userId">
                        <c:out value="${qna.userId }"/>
                    </div>
                    <div>
                    	<div class="flex-column" style="align-items: flex-end;">
                    		<fmt:formatDate pattern="yyyy-MM-dd" value="${qna.regdate }"/>
                    		<!-- 메뉴바로 뺴야함!!!!!!!!! 아이디체크해서 글쓴이만 활성화 -->
                    		<c:if test="${userId eq qna.userId }">
	                    		<button data-oper="modify" data-ord="${qna.qnaOrd }">수정하기</button>
                    		</c:if>
                    	</div>
	                    <div class="faq-contents" >${qna.qnaCnts}</div>
                    </div>
            	</div>
                </c:forEach>
                
                	<form action="/dealight/custservice/registerqna" method="post" class="contents-wrapper flex-row" id="reply">
	                    <div class="userId">
	                    	 <c:out value="${userId }"/>
	                    </div>
	                    <div>
	                    	<div class="flex-column" style="align-items: flex-end;">
	                    		<button data-oper="registerReply" >등록하기</button>
	                    	</div>
							<textarea rows="13" name="qnaCnts" class="faq-contents"></textarea>
	                    </div>
						<input type="hidden" name="qnaTitle" value="${list[0].qnaTitle }">
						<input type="hidden" name="qClsCd" value="${list[0].QClsCd }">
						<input type="hidden" name="qnaId" id="qnaId" value="${list[0].qnaId }">
	                  	<input type="hidden" name="userId" value='<c:out value="${userId }"/>' >
                 	</form>
                
            	<button data-oper="register" style="align-self: flex-end;">답글쓰기</button>
            	<button data-oper="list" style="align-self: flex-end;">목록</button>
            </div>
                <form id="operForm" action="/dealight/custservice/modifyqna" method="get">
					<input type="hidden" name="qnaId" id="qnaId" value="${list[0].qnaId }">
					<input type="hidden" name="qnaOrd" id="qnaOrd" value="">
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
					<input type="hidden" name="filterType" value="<c:out value='${cri.filterType}'/>">
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
				</form>
        </div>


</main>
<%@include file="/WEB-INF/views/includes/mainFooter.jsp" %>

</body>
</html>
<script>
window.onload =function(){
	
	const operForm = $("#operForm");
	const replyForm = $("#reply");
	replyForm.hide();
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#qnaId").remove();
		operForm.find("#qnaOrd").remove();
		operForm.attr("action", "/dealight/custservice/qnalist")
		operForm.submit();
	});
	
	$("button[data-oper='register']").on("click", function(e){
		replyForm.toggle()		
	});
	
	$("button[data-oper='registerReply']").on("click", function(e){
		replyForm.submit();
	});
	
	
	$("button[data-oper='modify']").on("click", function(e){
		let operation = $(this).data("oper");
		let ord = $(this).data("ord");
		console.log(operation)
		console.log(ord)
		
		operForm.find("#qnaOrd").val(ord);
		
		operForm.submit();
	})
	
	
}

</script>