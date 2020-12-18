<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">핫딜관리페이지</h1>
	<p class="mb-4">
	</p>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
       <div class="card-header py-3">
           <h6 class="m-0 font-weight-bold text-primary"><button id="regBtn" type="button" data-oper ='active' class="btn btn-default" >실시간 핫딜</button> <button id="regBtn" type="button" data-oper ='pending' class="btn btn-default">예정인 핫딜</button>
           <button id="regBtn" type="button" data-oper ='inactive' class="btn btn-default">마감된 핫딜</button></h6>
       </div>
       <div class="card-body">
           <div class="table-responsive">
               <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                   <thead>
                       <tr>
                           <th>핫딜번호</th>
                           <th>핫딜이름</th>
                           <th>매장명</th>
                           <th>핫딜시간</th>
                           <th>등록일자</th>
                       </tr>
                   </thead>
                   <tbody>
                      <c:forEach items="${lists }" var="htdl">
							<tr>
								<td>
								<a class="move" href='<c:out value="${htdl.htdlId}"/>'>
										<c:out value="${htdl.htdlId }" /></a></td>
								<td><c:out value="${htdl.htdlName }" /></td>
								<td><c:out value="${htdl.name }" /></td>
								<td><c:out value="${htdl.time }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${htdl.regDate }" /></td>
							</tr>
						</c:forEach>
                   </tbody>
               </table>
           </div>
       </div>
   </div>
</div>
<form  method="get" id="actionForm">
	<input type="hidden" name="htdlId" value="" >
	<input type="hidden" name="stusCd" value="" >
</form>
<script>

	let stusCd = '<c:out value="${stusCd}"/>';
	let formObj = $("#actionForm");
	$(document).ready(function(){
	
		let msg = "<c:out value='${result}'/>";
		
		checkAlert(msg);
		history.replaceState({},null, null);
		
		
		function checkAlert(msg){
			if(msg === '' || history.state){
				return;
			}
			
			if(msg.length > 0){
				alert(msg);
			}
			
		}
		
		//핫딜 상태 버튼 클릭
		$("button").on("click",function(e){
			e.preventDefault();
			
			let operation = $(this).data("oper");
			
			if(operation === 'active'){
				stusCd = 'A';
				location.href='/dealight/admin/htdlmanage/'+stusCd;
			}else if(operation === 'pending'){
				stusCd = 'P';
				location.href='/dealight/admin/htdlmanage/'+stusCd;
				
			}else{
				stusCd = 'I';
				location.href='/dealight/admin/htdlmanage/'+stusCd;
				
			}
			
			console.log(operation);
			console.log(stusCd);
			console.log("click");
		});
		
		//핫딜 정보 조회
		$(".move").on("click", function(e){
			e.preventDefault();
			
			formObj.find("input[name='htdlId']").val($(this).attr('href'));
			formObj.find("input[name='stusCd']").val(stusCd);
			formObj.attr("action", "/dealight/admin/htdlmanage/get");
			
			formObj.submit();
		});
	})

</script>



<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>