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
<style type="text/css">
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
                    <div class="main_header_title">FAQ</div>
                    <div class="main_header_subtitle">자주 묻는 질문</div>
                </div>
            <div class="board-body flex-column">
                <div class="title">
                    <div style="margin-left: 40px;">
                        <c:choose>
							<c:when test="${faq.QClsCd eq 'C'}">
								일반
							</c:when>
							<c:when test="${faq.QClsCd eq 'W'}">
								웨이팅
							</c:when>
							<c:when test="${faq.QClsCd eq 'R'}">
								예약
							</c:when>
						</c:choose> 
						 : <c:out value="${faq.faqTitle }"/>
                    </div>
                    <div class="date">
                       no.<c:out value="${faq.faqId }"/> - <fmt:formatDate pattern="yyyy-MM-dd" 
                    							value="${faq.regdate }"/>
                    </div>

                </div>
                <div class="contents-wrapper flex-row">
                    <div class="userId">
                        <c:out value="${faq.adminId }"/>
                    </div>
                    <textarea class="faq-contents" readonly><c:out value="${faq.faqCnts }"/>                 
                    </textarea>
            	</div>
            	<button data-oper="list" style="align-self: flex-end;">목록</button>
            </div>
                <form id="operForm" action="/dealight/custservice/" method="get">
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
					<input type="hidden" name="amount" value="${cri.amount }">
					<input type="hidden" name="filterType" value="<c:out value='${cri.filterType }'/>">
					<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
				</form>
        </div>


</main>
<%@include file="/WEB-INF/views/includes/mainFooter.jsp" %>

</body>
</html>
<script>
window.onload =function(){
	
var operForm = $("#operForm");
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.submit();
	});
	
}

</script>