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
			<h6 class="m-0 font-weight-bold text-primary">핫딜정보조회</h6>
			<c:choose>
				<c:when test="${htdl.stusCd eq 'A'}">
					<p>(진행중)</p>
				</c:when>
				<c:when test="${htdl.stusCd eq 'P'}">
					<p>(예정)</p>
				</c:when>
				<c:when test="${htdl.stusCd eq 'I'}">
					<p>(마감)</p>
				</c:when>
			</c:choose>
		</div>
		<div class="card-body">
			
			<div class="card mb-4">
				<div class="card-header">핫딜번호</div>
				<input type="text" class="card-body" name="htdlId" value="${htdl.htdlId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">핫딜이름</div>
				<input type="text" class="card-body" name="name" value="${htdl.name }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">할인율</div>
				<input type="text" class="card-body" name="dcRate" value='<fmt:formatNumber value="${htdl.dcRate}" type='percent'/>' readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">할인 전 가격</div>
				<input type="text" class="card-body" name="befPrice" value="${htdl.befPrice }원" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">할인 차감 가격</div>
				<input type="text" class="card-body" name="ddct" value="${htdl.ddct }원" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">할인 후 가격</div>
				<input type="text" class="card-body" name="afterPrice" value="${htdl.befPrice - htdl.ddct }원" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">핫딜시간</div>
				<div class="card-body">
				<c:set var = "startTm" value = "${htdl.startTm }"/>
			    <c:set var = "length" value = "${fn:length(startTm)}"/>
			    <c:set var = "startTime" value = "${fn:substring(startTm, length -5, length)}" />
			    <c:set var = "endTm" value = "${htdl.endTm }"/>
			    <c:set var = "length" value = "${fn:length(startTm)}"/>
			    <c:set var = "endTime" value = "${fn:substring(endTm, length -5, length)}" />
			    
				<input type="time" name="startTm" value="${startTime}" readonly="readonly">-
				<input type="time" name="endTm" value="${endTime }" readonly="readonly">
				</div>
			</div>

			<c:if test="${htdl.stusCd eq 'A' }">
			<div class="card mb-4">
				<div class="card-header">현재인원</div>
				<div class="card-body">
				<input type="text" name="curPnum" value="${htdl.curPnum }명" readonly="readonly">
				</div>
			</div>
			</c:if>
			
			<c:if test="${htdl.stusCd eq 'I' }">
			<div class="card mb-4">
				<div class="card-header">구매인원</div>
				<div class="card-body">
				<input type="text" name="lastPnum" value="${htdl.htdlRslt.lastPnum }명" readonly="readonly">
				</div>
			</div>
			</c:if>
			
			<div class="card mb-4">
				<div class="card-header">마감인원</div>
					<c:choose>
				<c:when test="${htdl.stusCd eq 'I'}">
					<div class="card-body">
					<input type="text" name="lmtPnum" value="${htdl.htdlRslt.htdlLmtPnum }명" readonly="readonly">
					</div>
				</c:when>
				<c:otherwise>
					<div class="card-body">
					<input type="text" name="lmtPnum" value="${htdl.lmtPnum }명" readonly="readonly">
					</div>
				</c:otherwise>
			</c:choose>
				
			</div>
			
			<c:if test="${htdl.stusCd eq 'I' }">
			<div class="card mb-4">
				<div class="card-header">구매율</div>
				<div class="card-body">
				<input type="text" name="rsvdRate" value="${htdl.htdlRslt.rsvdRate }%" readonly="readonly">
				</div>
			</div>
			</c:if>
			
			<c:if test="${htdl.stusCd eq 'I' }">
			<div class="card mb-4">
				<div class="card-header">경과시간</div>
				<div class="card-body">
				<input type="text" name="elapTm" value="${htdl.htdlRslt.elapTm }" readonly="readonly">
				</div>
			</div>
			</c:if>
			
			<div class="card mb-4">
				<div class="card-header">소개</div>
				<input type="text" class="card-body" name="htdlIntro" value="${htdl.intro }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">핫딜 메뉴</div>
				<c:forEach items="${htdl.htdlDtls }" var="htdlDtls">
					<input type="text" class="card-body" name="menuName" value="${htdlDtls.menuName }" readonly="readonly">
					<input type="text" class="card-body" name="menuPrice" value="${htdlDtls.menuPrice }원" readonly="readonly">
				</c:forEach>
			</div>
			
			
			
			
			<button data-oper="modify" class="btn btn-secondary">수정하기</button>
			<button data-oper="list" class="btn btn-secondary">목록으로</button><br>
			

			<form action="/dealight/admin/htdlmanage/modify" id="operForm" method="get">
				<input type="hidden" name="htdlId" value="${htdl.htdlId }">
				<input type="hidden" name="stusCd" value="${htdl.stusCd }">
			</form>
		</div>
		<!-- Default Card Example -->


	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	
</div>

<script>

	let formObj = $("#operForm");
	
	
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
		
		
		$("button").on("click", function(e){
			
			e.preventDefault();
			
			let operation = $(this).data("oper");
			
			if(operation === 'list'){
				
				let stusCd = formObj.find("input[name='stusCd']").val();
				location.href="/dealight/admin/htdlmanage/"+stusCd;
				return;
			}
			
			formObj.submit();
			
		})		
	});

</script>

<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>