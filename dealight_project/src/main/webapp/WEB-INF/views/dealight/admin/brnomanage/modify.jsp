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
			<form action="/dealight/admin/brnomanage/modify"  method="post">
				<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>">
				<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
				<input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
				<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
			
				<div class="card mb-4">
					<div class="card-header">심사번호</div>
					<input type="text" class="card-body" name="brSeq" value="${buser.brSeq }">
				</div>
				<div class="card mb-4">
					<div class="card-header">유저아이디</div>
					<input type="text" class="card-body" name="userId" value="${buser.userId }">
				</div>
				<div class="card mb-4">
					<div class="card-header">대표자명</div>
					<input type="text" class="card-body" name="repName" value="${buser.repName }">
				</div>
				<div class="card mb-4">
					<div class="card-header">매장명</div>
					<input type="text" class="card-body" name="storeNm" value="${buser.storeNm }">
				</div>
				<div class="card mb-4">
					<div class="card-header">휴대전화</div>
					<input type="text" class="card-body" name="telno" value="${buser.telno }">
				</div>
				<div class="card mb-4">
					<div class="card-header">사업장전화번호</div>
					<input type="text" class="card-body" name="storeTelno" value="${buser.storeTelno }">
				</div>
				<div class="card mb-4">
					<div class="card-header">사업자등록번호</div>
					<input type="text" class="card-body" name="brno" value="${buser.brno }">
				</div>
				
				<div class="card mb-4">
					<div class="card-header">심사상태</div>
					<select name="type" class="card-body" >
      					<option value="P"
      						<c:out value="${buser.brJdgStusCd eq 'P'?'selected':'' }"/>>
      					진행중
      					</option>
      					<option value="C"
      						<c:out value="${buser.brJdgStusCd eq 'C'?'selected':'' }"/>>
      					심사통과
      					</option>
      					<option value="F"
      						<c:out value="${buser.brJdgStusCd eq 'F'?'selected':'' }" />>
      					심사탈락
      					</option>
      				</select>
				</div>
				<div class="card mb-4" id="reason">
					<c:if test="${buser.brJdgStusCd eq 'F'}">
						<div class="card-header">탈락사유</div>
						<textarea class="card-body"rows="3" name='' > 
							<c:out value="${buser.reason }"/>
						</textarea>
					</c:if>
				</div>
				<input type="hidden" name="brPhotoSrc" value="${buser.brPhotoSrc }" readonly="readonly">
				

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
				formObj.attr("action", "/dealight/admin/brnomanage/remove");
				
			}else if(operation === 'list'){
				formObj.attr("action", "/dealight/admin/brnomanage/").attr("method", "get");
				formObj.empty();
				
			}
			
			formObj.submit();
		});
		
		const reason = $("#reason");
		$("select[name='type']").on("change",function(){
			if($(this).val()=='F'){
				let str = "";
				str +='<div class="card-header">탈락사유</div>';
				str +='<textarea class="card-body"rows="3" name="reason"></textarea>';
				reason.html(str);
			}else{
				reason.empty();
			}
		})
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>