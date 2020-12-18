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
        <%@include file="/WEB-INF/views/includes/custservicemenu.jsp" %>

        <div class="box-container flex-column">
            <div class="board-header flex-column">
                <div style="margin-left: 30px;">
                    QnA
                </div>
            </div>
            <div class="board-body flex-column">
                <form role="form" action="/dealight/custservice/modifyqna" method="post">
                <div class="contents-wrapper flex-column">
                    	
					<label>번호<input type="text" name="qnaId" value='<c:out value="${qna.qnaId}"/>'></label>
					<label>제목<input type="text" name="qnaTitle" value='<c:out value="${qna.qnaTitle}"/>'></label>
	                <label>글쓴이<input type="text" name="userId" value='<c:out value="${qna.userId }"/>' ></label>
	                <textarea rows="13" name="qnaCnts" class="faq-contents"><c:out value="${qna.qnaCnts }"/></textarea>
					<label>RegDate</label><input name="regdate"
						value='<fmt:formatDate pattern="yyyy-MM-dd" value="${qna.regdate }"/>' readonly="readonly">
					<label>updateDate</label><input name="updatedate"
						value='<fmt:formatDate pattern="yyyy-MM-dd" value="${qna.updatedate }"/>' readonly="readonly">
            	</div>
               	<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>">
				<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
				<input type="hidden" name="filterType" value="<c:out value='${cri.filterType }'/>">
				<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
            	<input type="hidden" name="qnaOrd" value='<c:out value="${qna.qnaOrd}"/>'>
            	<input type="hidden" name="qClsCd" value='<c:out value="${qna.QClsCd}"/>'>
            	<div style="align-self: flex-end;">
            		<button type="submit" data-oper='modify'>
						Modify
					</button>
					<button type="submit" data-oper='remove'>
						Remove
					</button>					
					<button type="submit" data-oper='list'>
						List
					</button>
				</div>
				</form>
            </div>
        </div>


</main>
</body>
</html>
<script>
window.onload =function(){
	
	const formObj = $("form");	
	
	$('button').on("click", function(e){
		
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			
			formObj.attr("action", "/dealight/custservice/removeqna");
			
		} else if(operation === 'list'){
			//move to list
			formObj.attr("action", "/dealight/custservice/getqna").attr("method", "get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='filterType']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			let qnaIdTag = $("input[name='qnaId']").clone();
			
			formObj.empty();
			
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
			formObj.append(qnaIdTag);
		}
		formObj.submit();
	});
}

</script>