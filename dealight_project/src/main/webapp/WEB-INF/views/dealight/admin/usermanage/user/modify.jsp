<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">회원정보 수정</h1>
	<p class="mb-4">
		.....
	</p>

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">BrnoManage</h6>
		</div>
		<div class="card-body">
			<form action="/dealight/mypage/usermanage/user/modify"  method="post">
				<div class="card mb-4">
				<div class="card-header">아이디</div>
				<input type="text" class="card-body" name="userId" value="${user.userId }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">이름</div>
				<input type="text" class="card-body" name="name" value="${user.name }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">이메일</div>
				<input type="text" class="card-body" name="email" value="${user.email }" 
>
			</div>
			<div class="card mb-4">
				<div class="card-header">비밀번호</div>
				<input type="text" class="card-body" name="pwd" value="${user.pwd }">
			</div>
			<div class="card mb-4">
				<div class="card-header">전화번호</div>
				<input type="text" class="card-body" name="telno" value="${user.telno }">
			</div>
			<div class="card mb-4">
				<div class="card-header">생년월일</div>
				<input type="text" class="card-body" name="brdt" value="${user.brdt }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">성별</div>
				<input type="text" class="card-body" name="sex" value="${user.sex }">
			</div>
			<div class="card mb-4">
				<div class="card-header">소셜로그인</div>
				<input type="text" class="card-body" name="snsLginYn" value="${user.snsLginYn }">
			</div>
			<div class="card mb-4">
				<div class="card-header">회원코드</div>
				<input type="text" class="card-body" name="clsCd" value="${buser.clsCd }">
			</div>
			<div class="card mb-4">
				<div class="card-header">패널티여부</div>
				<input type="text" class="card-body" name="pmStus" value="${buser.pmStus }">
			</div>
			<div class="card mb-4">
				<div class="card-header">패널티횟수</div>
				<input type="text" class="card-body" name="pmCount" value="${buser.pmCount }">
			</div>
			<div class="card mb-4">
				<div class="card-header">패널티기간</div>
				<input type="text" class="card-body" name="pmExpi" value="${buser.pmExpi }">
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

</div>
<!-- /.container-fluid -->
<script>
	window.onload = function() {

		const formObj = $("form");
		$('#btn  button').on("click",function(e){
			let operation = $(this).data('oper');
			
			if(operation ==='remove'){
				formObj.attr("action", "/dealight/admin/usermanage/user/delete");
				
			}else if(operation === 'list'){
				formObj.attr("action", "/dealight/admin/usermanage/").attr("method", "get");
				formObj.empty();
				
			}
			
			formObj.submit();
		});
	
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>