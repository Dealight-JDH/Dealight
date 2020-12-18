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
                <form role="form" action="/dealight/custservice/registerqna" method="post">
                <div class="contents-wrapper flex-column">
                    	카테고리
                        <select name="qClsCd">
                            <option value="C"
          						<c:out value="${pageDTO.cri.filterType eq 'C' ?'selected':'' }"/>>
          					일반
          					</option>
          					
          					<option value="W"
          						<c:out value="${pageDTO.cri.filterType eq 'W'?'selected':'' }"/>>
          					웨이팅
          					</option>
          					
          					<option value="R"
          						<c:out value="${pageDTO.cri.filterType eq 'R'?'selected':'' }" />>
          					예약
          					</option>
                        </select>
						 <label>제목<input type="text" name="qnaTitle"></label>
                       	<label>글쓴이<input type="text" name="userId" value='<c:out value="${userId }"/>' ></label>
	                    <textarea rows="13" name="qnaCnts" class="faq-contents"></textarea>
            	</div>
            	<button type="submit" style="align-self: flex-end;">등록하기</button>
				</form>
            </div>
        </div>


</main>
</body>
</html>
<script>
window.onload =function(){
	
	const formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		let qnaId = $("input[name='qnaId']")
		console.log("submit clicked!");
		e.preventDefault();
		if(qnaId.val() === ""){
			qnaId.val(0);
		}
		
		formObj.submit();
	});
}

</script>