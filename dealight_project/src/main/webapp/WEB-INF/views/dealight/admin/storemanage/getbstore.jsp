<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">매장정보조회</h6>
		</div>
		<div class="card-body">
			
			<div class="card mb-4">
				<div class="card-header">매장번호</div>
				<input type="text" class="card-body" name="storeId" value="${store.storeId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeNm" value="${store.storeNm }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">전화번호</div>
				<input type="text" class="card-body" name="telno" value="${store.telno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">대표메뉴</div>
				<input type="text" class="card-body" name="repMenu" value="${store.bstore.repMenu }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">영업시간</div>
				<div class="card-body">
				<input type="time" name="openTm" value="${store.bstore.openTm }" readonly="readonly">-
				<input type="time" name="closeTm" value="${store.bstore.closeTm }" readonly="readonly">
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">브레이크시간</div>
				<div class="card-body">
				<input type="time" name="breakSttm" value="${store.bstore.breakSttm }" readonly="readonly">-
				<input type="time" name="breakEntm" value="${store.bstore.breakEntm }" readonly="readonly">
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">주소</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.loc.addr }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">평점</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.avgRating }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">리뷰수</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.revwTotNum }" readonly="readonly">
			</div>
			
			
			
			<button data-oper="modify" class="btn btn-secondary">수정하기</button>
			<button data-oper="list" class="btn btn-secondary">목록으로</button><br>
			

			<form action="#" id="operForm" method="get">
				<input type="hidden" name="storeId" value="${store.storeId }">
				<input type="hidden" name="clsCd" value="${store.clsCd }">
			</form>
		</div>
		<!-- Default Card Example -->


	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	
</div>
<!-- /.container-fluid -->
<script>
	window.onload = function() {

		const operForm = $("#operForm");
		
		
		//버튼 클릭 이벤트----
		$("button[data-oper='modify']").on("click", function(e){
			
			operForm.attr("action", "/dealight/admin/storemanage/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#userId").remove();
			operForm.attr("action", "/dealight/admin/storemanage")
			operForm.submit();
		});
	
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>