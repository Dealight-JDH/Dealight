<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	<p class="mb-4">
		DataTables is a third party plugin that is used to generate the demo
		table below. For more information about DataTables, please visit the <a
			target="_blank" href="https://datatables.net">official DataTables
			documentation</a>.
	</p>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>심사번호</th>
							<th>아이디</th>
							<th>매장명</th>
							<th>상태</th>
							<th>등록날짜</th>
							<th>수정날짜</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>심사번호</th>
							<th>아이디</th>
							<th>매장명</th>
							<th>상태</th>
							<th>등록날짜</th>
							<th>수정날짜</th>
						</tr>
					</tfoot>
					<tbody>
						<c:forEach items="${list }" var="buser">
							<tr>
								<td><c:out value="${buser.brSeq }" /></td>
								<td><c:out value="${buser.userId }" /></td>
								<td><a class="move" href='<c:out value="${buser.brSeq}"/>'>
										<c:out value="${buser.storeNm }" />
								</a></td>
								<c:choose>
									<c:when test="${buser.brJdgStusCd eq 'C'}">
										<td>심사완료</td>
									</c:when>
									<c:when test="${buser.brJdgStusCd eq 'W'}">
										<td>심사대기중</td>
									</c:when>
									<c:when test="${buser.brJdgStusCd eq 'P'}">
										<td>심사진행중</td>
									</c:when>
									<c:when test="${buser.brJdgStusCd eq 'F'}">
										<td>심사탈락</td>
									</c:when>
								</c:choose>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${buser.regdate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${buser.updatedate }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
</div>
<form  method="get" id="actionForm">
	<input type="hidden" id="brSeq" name="brSeq" value="" >
	
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
			if(parseInt(result)>0){
				alert("새 게시글을 등록하셨습니다.\n 심사번호는 " + parseInt(result) + "번 입니다.")
			}
			if(result == "success"){
				alert("처리가 완료되었습니다.")
			}
		}
		//게시글클릭이벤트
		$('.move').on("click", function(e){
			e.preventDefault();
			formObj.find("input[name='brSeq']").val($(this).attr('href'))
			formObj.attr("action", "/dealight/admin/brnomanage/get");
			
			formObj.submit();
		});
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>