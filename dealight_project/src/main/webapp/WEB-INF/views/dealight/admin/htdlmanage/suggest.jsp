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
           <h6 class="m-0 font-weight-bold text-primary">핫딜 제안</h6>
       </div>
       <div class="card-body">
           <div class="table-responsive">
               <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                   <thead>
                       <tr>
                           <th>매장명</th>
                           <th>지난 예약률(7일)</th>
                           <th>핫딜 예약률</th>
                           <th>제안 가능 여부</th>
                       </tr>
                   </thead>
                   <tbody>
                   
                      <c:forEach items="${lists }" var="list">
							<tr>
								<td>
								<a class="move" href='<c:out value="${list.storeId}"/>'>
										<c:out value="${list.name }" /></a></td>
								<td><c:out value="${list.rsvdRate }"/>%</td>
								<td><c:out value="${list.htdlRate }"/>%</td>
								<td>
								<%-- <button id="regBtn" type="button" value="${list.storeId}"
										 data-oper ='possible' class="btn btn-success">제안 가능</button> --%>
								<c:choose>
									<c:when test="${list.suggestChecked eq true }">
										<button id="regBtn" type="button" value="${list.storeId}"
										 data-oper ='possible' class="btn btn-success">제안 가능</button>
           
									</c:when>
									<c:when test="${list.suggestChecked eq false }">
										 <button id="regBtn" type="button" data-oper ='impossible' class="btn btn-danger">제안 불가</button>
									</c:when>
								</c:choose>
								</td>
								
							</tr>
						</c:forEach>
                   </tbody>
               </table>
           </div>
       </div>
   </div>
</div>
<form  method="get" id="actionForm">
	<input type="hidden" name="storeId" value="" >
</form>
<script>

	let formObj = $("#actionForm");
	
	$(document).ready(function(){
		
		let msg = "<c:out value='${result}'/>";
		
		if(msg.length >0){
			alert(msg);
		}
		
		$("button").on("click", function(e){
			
			e.preventDefault();
			
			let operation = $(this).data("oper");
			
			if(operation === 'possible'){
				let storeId = $(this).val();
				console.log("=====btn click: " + $(this).val());
				
				formObj.find("input[name='storeId']").val(storeId);
				formObj.attr("action", "/dealight/admin/htdlmanage/sugregister");
				formObj.submit();
			}
			
		});
	});
	
		


</script>



<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>