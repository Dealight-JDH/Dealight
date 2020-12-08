<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">사업자등록 수정</h1>
	<p class="mb-4">
		.....
	</p>

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">BrnoManage</h6>
		</div>
		<div class="card-body">
			<form action="/dealight/mypage/bizauth/register"  method="post">
				<div class="card mb-4">
					<div class="card-header">심사번호</div>
					<input type="text" class="card-body" name="brSeq">
				</div>
				<div class="card mb-4">
					<div class="card-header">유저아이디</div>
					<input type="text" class="card-body" name="userId">
				</div>
				<div class="card mb-4">
					<div class="card-header">대표자명</div>
					<input type="text" class="card-body" name="repName">
				</div>
				<div class="card mb-4">
					<div class="card-header">매장명</div>
					<input type="text" class="card-body" name="storeNm">
				</div>
				<div class="card mb-4">
					<div class="card-header">휴대전화</div>
					<input type="text" class="card-body" name="telno">
				</div>
				<div class="card mb-4">
					<div class="card-header">사업장전화번호</div>
					<input type="text" class="card-body" name="storeTelno">
				</div>
				<div class="card mb-4">
					<div class="card-header">사업자등록번호</div>
					<input type="text" class="card-body" name="brno">
				</div>
				
				<div class="card mb-4">
					<div class="card-header">심사상태</div>
					<select name="type" class="card-body">
      					<option value="P">
      					진행중
      					</option>
      					<option value="C">
      					심사통과
      					</option>
      					<option value="F">
      					심사탈락
      					</option>
      				</select>
				</div>
				<div class="card mb-4">
					<div class="card-header">탈락사유</div>
					<textarea class="card-body"rows="3" name='' > 
					</textarea>
				</div>
			</form>
			<div id="btn">
				<button class="btn btn-secondary" data-oper="register">등록하기</button>
				<button class="btn btn-secondary" data-oper="list" >목록으로</button>
			</div>
		</div>
		<!-- Default Card Example -->


	</div>

</div>
<!-- /.container-fluid -->
<script>
	window.onload = function() {

	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>