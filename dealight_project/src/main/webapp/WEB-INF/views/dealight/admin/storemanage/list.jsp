<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">매장관리페이지</h1>
	<p class="mb-4">
	</p>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
       <div class="card-header py-3">
           <h6 class="m-0 font-weight-bold text-primary">매장목록 <button id="regBtn" type="button" class="btn btn-default">매장 등록하기</button></h6>
       </div>
       <div class="card-body">
           <div class="table-responsive">
               <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                   <thead>
                       <tr>
                           <th>매장번호</th>
                           <th>매장명</th>
                           <th>전화번호</th>
                           <th>매장분류</th>
                           <th>등록일자</th>
                       </tr>
                   </thead>
                   <tbody>
                      <c:forEach items="${list }" var="store">
							<tr>
								<td><a class="move" data-cls="${store.clsCd }" href='<c:out value="${store.storeId}"/>'>
										<c:out value="${store.storeId }" />
								</a></td>
								<td><c:out value="${store.storeNm }" /></td>
								<td><c:out value="${store.telno }" /></td>
								<c:choose>
									<c:when test="${store.clsCd eq 'N'}">
										<td>일반매장</td>
									</c:when>
									<c:when test="${store.clsCd eq 'B'}">
										<td>사업자매장</td>
									</c:when>
								</c:choose>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${store.regdate }" /></td>
							</tr>
						</c:forEach>
                   </tbody>
               </table>
           </div>
       </div>
   </div>
	
</div>
<form  method="get" id="actionForm">
	<input type="hidden" name="storeId" value="" >
	<input type="hidden" name="clsCd" value="" >
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
		$("#regBtn").on("click", function(){
			
			self.location = "/dealight/admin/storemanage/registerbstore";
			
		});
		
		//게시글클릭이벤트
		const table = document.getElementById("dataTable")
		const tableClick = function(e){
			e.preventDefault();
			let cls = $(this).data("cls");
			console.log(cls)
			
			formObj.find("input[name='storeId']").val($(this).attr('href'));
			formObj.find("input[name='clsCd']").val(cls);
			formObj.attr("action", "/dealight/admin/storemanage/get");
			
			formObj.submit();
		}
		
		$('.move').on("click", tableClick);
		
		const mutationObserver = new MutationObserver(function() { 
			console.log("change")
			$('.move').on("click", tableClick);
			
		});
		
		const option = { 
						childList: true, 
						subtree: true
					}
		//감지 시작
		mutationObserver.observe(table, option);


		
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>