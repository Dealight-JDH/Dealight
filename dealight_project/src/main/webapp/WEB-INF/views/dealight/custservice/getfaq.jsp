<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="stylesheet" href="/resources/css/custservice.css" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
 <main id="main-container" class="flex-column">
        <nav class="sidebar">
            <div class="sidebar-header">
                <div style="margin-left: 10px">
                    고객센터
                </div>
            </div>
            <div class="sidebar-body flex-column">

                <div class="menu select">
                    <div class="menu-child">
                        FAQ
                    </div>
                    
                </div>
                <div class="menu">
                    <div class="menu-child">
                        QnA
                    </div>
                </div>
            </div>
        </nav>
        <script type="text/javascript">
        
        </script>

        <div class="box-container flex-column">
            <div class="board-header flex-column">
                <div style="margin-left: 30px;">
                    FAQ
                </div>
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