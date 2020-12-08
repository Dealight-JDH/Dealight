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
			<h6 class="m-0 font-weight-bold text-primary">일반회원정보조회</h6>
		</div>
		<div class="card-body">
			
			<div class="card mb-4">
				<div class="card-header">아이디</div>
				<input type="text" class="card-body" name="userId" value="${user.userId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">이름</div>
				<input type="text" class="card-body" name="name" value="${user.name }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">이메일</div>
				<input type="text" class="card-body" name="email" value="${user.email }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">비밀번호</div>
				<input type="text" class="card-body" name="pwd" value="${user.pwd }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">전화번호</div>
				<input type="text" class="card-body" name="telno" value="${user.telno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">생년월일</div>
				<input type="text" class="card-body" name="brdt" value="${user.brdt }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">성별</div>
				<input type="text" class="card-body" name="sex" value="${user.sex }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">소셜로그인</div>
				<input type="text" class="card-body" name="snsLginYn" value="${user.snsLginYn }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">회원코드</div>
				<input type="text" class="card-body" name="clsCd" value="${buser.clsCd }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">패널티여부</div>
				<input type="text" class="card-body" name="pmStus" value="${buser.pmStus }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">패널티횟수</div>
				<input type="text" class="card-body" name="pmCount" value="${buser.pmCount }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">패널티기간</div>
				<input type="text" class="card-body" name="pmExpi" value="${buser.pmExpi }" readonly="readonly">
			</div>
			
			<button data-oper="modify" class="btn btn-secondary">수정하기</button>
			<button data-oper="list" class="btn btn-secondary">목록으로</button><br>
			

			<form action="/dealight/mypage/" id="operForm" method="get">
				<input type="hidden" id="userId" name="userId" value="${user.userId }">
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
			
			operForm.attr("action", "/dealight/admin/usermanage/user/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#userId").remove();
			operForm.attr("action", "/dealight/admin/usermanage/user")
			operForm.submit();
		});
	
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>