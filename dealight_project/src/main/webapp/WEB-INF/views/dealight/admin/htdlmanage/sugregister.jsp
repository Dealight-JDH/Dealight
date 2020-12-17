<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">핫딜제안</h6>
		</div>
		
		<form action="/dealight/admin/htdlmanage/sugregister" id="operForm" method="post">
		<div class="card-body">
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeName" value="${suggestStore.name }" readonly="readonly">
			</div>
			
			<div class="card mb-4">
				<div class="card-header">핫딜이름</div>
				<input type="text" class="card-body" name="htdlName">
			</div>

			<div class="card mb-4">
				<div class="card-header">핫딜시간</div>
				<div class="card-body">
				
				<input type="time" name="startTm">-
				<input type="time" name="endTm">
				</div>
			</div>
			
			<div class="card mb-4">
				<div class="card-header">제안 인원</div>
				<input type="number" min="0" class="card-body" name="lmtPnum">
			</div>

			
			<button data-oper="possible" class="btn btn-success">제안하기</button>
			<button data-oper="suggest" class="btn btn-secondary">뒤로가기</button><br>
			
			<input type="hidden" name="storeId" value="${suggestStore.storeId }">
			<input type="hidden" name="buserId" value="${suggestStore.buserId }">
		</div>
		</form>
		<!-- Default Card Example -->


	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	
</div>

<script>

	let formObj = $("#operForm");
	let userId = '<c:out value="${suggestStore.buserId }"/>';
	
	$(document).ready(function(){
		console.log(userId);
		$("button").on("click", function(e){
			
			e.preventDefault();
			
			let operation = $(this).data("oper");
			
			if(operation === 'possible'){
				
				console.log(formObj.find("input[name='storeName']").val());
				formObj.find("input[name='storeName']").remove();
				formObj.submit();
				
			}else if(operation === 'suggest'){
				location.href="/dealight/admin/htdlmanage/suggest";
			}
			
			
		})		
	});

</script>

<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>