<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">사업자등록관리페이지</h1>
	<p class="mb-4">
	</p>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
       <div class="card-header py-3">
           <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
       </div>
       <div class="card-body">
           <div class="table-responsive">
               <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                   <thead>
                       <tr>
                           <th>아이디</th>
                           <th>이름</th>
                           <th>이메일</th>
                           <th>전화번호</th>
                           <th>생년월일</th>
                           <th>소셜로그인</th>
                           <th>패널티여부</th>
                           <th>회원상태</th>
                           <th>가입일자</th>
                           <th>수정일자</th>
                       </tr>
                   </thead>
                   <tbody>
                      <c:forEach items="${list }" var="user">
							<tr>
								<td><a class="move" href='<c:out value="${user.userId}"/>'>
										<c:out value="${user.userId }" />
								</a></td>
								<td><c:out value="${user.name }" /></td>
								<td><c:out value="${user.email }" /></td>
								<td><c:out value="${user.telno }" /></td>
								<td><c:out value="${user.brdt }" /></td>
								<td><c:out value="${user.snsLginYn }" /></td>
								<td><c:out value="${user.pmStus }" /></td>
								<c:choose>
									<c:when test="${user.clsCd eq 'C'}">
										<td>일반회원</td>
									</c:when>
									<c:when test="${user.clsCd eq 'B'}">
										<td>사업자회원</td>
									</c:when>
									<c:when test="${user.clsCd eq 'A'}">
										<td>관리자</td>
									</c:when>
									<c:when test="${user.clsCd eq 'W'}">
										<td>탈퇴회원</td>
									</c:when>
								</c:choose>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${user.regDate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${user.updateDate }" /></td>
							</tr>
						</c:forEach>
                   </tbody>
               </table>
           </div>
       </div>
   </div>
	
</div>
<form  method="get" id="actionForm">
	<input type="hidden" name="userId" value="" >
</form>
<!-- /.container-fluid -->
<script>
	window.onload = function(){
		
		let formObj = $("#actionForm")
		let result = '<c:out value="${result}"/>';
		checkResult()
		
		history.replaceState({},null,null);
		//게시글 등록메세지
		function checkResult(){
			console.log("checkResult....");
			if(result === '' || history.state){
				return;
			}
			
			if(result == "success"){
				alert("처리가 완료되었습니다.")
			}
		}
		//게시글클릭이벤트
		$('.move').on("click", function(e){
			e.preventDefault();
			formObj.find("input[name='userId']").val($(this).attr('href'))
			formObj.attr("action", "/dealight/admin/usermanage/user/get");
			
			formObj.submit();
		});
		
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>