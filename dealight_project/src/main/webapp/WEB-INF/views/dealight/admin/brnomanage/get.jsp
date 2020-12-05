<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
		</div>
		<div class="card-body">
			
			<div class="card mb-4">
				<div class="card-header">심사번호</div>
				<input type="text" class="card-body" name="brSeq" value="${buser.brSeq }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">유저아이디</div>
				<input type="text" class="card-body" name="userId" value="${buser.userId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">대표자명</div>
				<input type="text" class="card-body" name="repName" value="${buser.repName }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeNm" value="${buser.storeNm }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">휴대전화</div>
				<input type="text" class="card-body" name="telno" value="${buser.telno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">사업장전화번호</div>
				<input type="text" class="card-body" name="storeTelno" value="${buser.storeTelno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">사업자등록번호</div>
				<input type="text" class="card-body" name="brno" value="${buser.brno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">심사상태</div>
				<input type="text" class="card-body" name="brno" value="${buser.brJdgStusCd }" readonly="readonly">
			</div>
			
			<button data-oper="modify" class="btn btn-secondary">수정하기</button>
			<button data-oper="list" class="btn btn-secondary">목록으로</button><br>
			

			<form action="/dealight/mypage/bizauth/modify" id="operForm" method="get">
				<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>">
				<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
				<%-- <input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
				<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>"> --%>
				<input type="hidden" id="brSeq" name="brSeq" value="${buser.brSeq }">
			</form>
		</div>
		<!-- Default Card Example -->


	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	<form action="#" method="get" id="actionForm">
		<input type="hidden" id="brSeq" name="brSeq" value="">

	</form>
</div>
<!-- /.container-fluid -->
<script>
	window.onload = function() {

		const operForm = $("#operForm");
		
		
		//버튼 클릭 이벤트----
		$("button[data-oper='modify']").on("click", function(e){
			
			operForm.attr("action", "/dealight/admin/brnomanage/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/dealight/admin/brnomanage")
			operForm.submit();
		});
	
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>