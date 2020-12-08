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
			<form action="/dealight/mypage/storemanage/modifybstore"  method="post">
			<div class="card mb-4">
				<div class="card-header">매장번호</div>
				<input type="text" class="card-body" name="storeId" value="${store.storeId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeNm" value="${store.storeNm }">
			</div>
			<div class="card mb-4">
				<div class="card-header">전화번호</div>
				<input type="text" class="card-body" name="telno" value="${store.telno }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">대표메뉴</div>
				<input type="text" class="card-body" name="repMenu" value="${store.bstore.repMenu }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">영업시간</div>
				<div class="card-body">
				<input type="time" name="openTm" value="${store.bstore.openTm }" >-
				<input type="time" name="closeTm" value="${store.bstore.closeTm }" >
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">브레이크시간</div>
				<div class="card-body">
				<input type="time" name="breakSttm" value="${store.bstore.breakSttm }" >-
				<input type="time" name="breakEntm" value="${store.bstore.breakEntm }" >
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">주소</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.loc.addr }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">평점</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.avgRating }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">리뷰수</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.revwTotNum }" >
			</div>
		</form>
			
			
			
		<div id="btn">
				<button class="btn btn-secondary" data-oper="modify" >수정하기</button>
				<button class="btn btn-secondary" data-oper="remove">삭제하기</button>
				<button class="btn btn-secondary" data-oper="list" >목록으로</button>
			</div>
		</div>
		<!-- Default Card Example -->


	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	
</div>
<!-- /.container-fluid -->
<script>
	window.onload = function() {

		const formObj = $("form");
		$('#btn  button').on("click",function(e){
			let operation = $(this).data('oper');
			
			if(operation ==='remove'){
				formObj.attr("action", "/dealight/admin/storemanage/delete");
				
			}else if(operation === 'list'){
				formObj.attr("action", "/dealight/admin/storemanage/").attr("method", "get");
				formObj.empty();
				
			}
			
			formObj.submit();
		});
	
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>