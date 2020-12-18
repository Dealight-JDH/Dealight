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
			
			<form id="postForm" action="/dealight/admin/htdlmanage/modify" method="post">
			<div class="card mb-4">
				<div class="card-header">핫딜번호</div>
				<input type="text" class="card-body" name="htdlId" value="${htdl.htdlId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">핫딜이름</div>
				<input type="text" class="card-body" name="name" value="${htdl.name }" >
			</div>
			
			<div class="card mb-4">
				<div class="card-header">메뉴 수정</div>
				
				<c:if test="${htdl.stusCd eq 'P' }">
					<div class="card-body">
					
					<div>
					<c:forEach items="${menuLists }" var="menu" varStatus="status">
						<input type="checkbox" id="menu<c:out value="${status.count}"/>"
							class="js-menu" value="${menu.price }">
							<label for="menu<c:out value="${status.count}"/>">${menu.name }</label>
					</c:forEach>					
				
					</div>
					</div>
				</c:if>
			</div>
			<div class="card mb-4">
				<div class="card-header">할인율</div>
				
				<c:if test="${htdl.stusCd eq 'P' }">
					<div class="card-body">
					
					<select id="dcRate" name="dcRate">
						<option value="">--</option>
						<option value="10">10%</option>
						<option value="20">20%</option>
						<option value="30">30%</option>
						<option value="40">40%</option>
						<option value="50">50%</option>
					</select>
					</div>
				</c:if>
				
				<c:if test="${htdl.stusCd ne 'P' }">
					<%-- <input type="text" class="card-body" name="dcRate" value='<fmt:formatNumber value="${htdl.dcRate}" type='percent'/>' readonly="readonly"> --%>
					<input type="text" class="card-body" name="dcRate" value='<fmt:formatNumber value="${htdl.dcRate}" type='percent'/>' readonly="readonly">
				</c:if>
			
				<%-- <input type="number" name="dcRate" value='<fmt:formatNumber value="${htdl.dcRate}" type='percent'/>'> --%>
			</div>
			<div class="card mb-4">
				<div class="card-header">할인 전 가격</div>
				<input type="text" class="card-body" id="befPrice" name="befPrice" value="${htdl.befPrice }원" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">할인 차감 가격</div>
				<input type="text" class="card-body" id="ddct" name="ddct" value="${htdl.ddct}원" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">할인 후 가격</div>
				<input type="text" class="card-body" id="afterPrice"  value="${htdl.befPrice - htdl.ddct }원" readonly="readonly">
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
			    
				<input type="time" name="startTm" value="${startTime}">-
				<input type="time" name="endTm" value="${endTime }">
				</div>
			</div>

			<c:if test="${htdl.stusCd eq 'A' }">
			<div class="card mb-4">
				<div class="card-header">현재인원</div>
				<div class="card-body">
				<input type="text" style="width: 50px" value="${htdl.curPnum }명" readonly="readonly">
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
				
				<div class="card-body">
				<input type="number" name="lmtPnum" style="width: 50px" min="0" value="${htdl.lmtPnum }명">
				</div>
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
				<input type="text" class="card-body" name="intro" value="${htdl.intro }">
			</div>
			<div class="card mb-4">
				<div class="card-header" id="curMenu">핫딜 메뉴</div>
				
				<c:forEach items="${htdl.htdlDtls }" var="htdlDtls" varStatus="status">
					<input type="hidden" name="htdlDtls[${status.index}].htdlSeq" value="${htdlDtls.htdlSeq }">
					<input type="text" class="card-body" id="menuName${status.index }" name="htdlDtls[${status.index}].menuName" value="${htdlDtls.menuName }" readonly="readonly">
					<input type="text" class="card-body" id="menuPrice${status.index }" name="htdlDtls[${status.index}].menuPrice" value="${htdlDtls.menuPrice }" readonly="readonly">
				</c:forEach>
			</div>
			
			
			
			<button data-oper="modify" class="btn btn-primary">수정하기</button>
			<button data-oper="end" class="btn btn-warning">종료하기</button>
			<button data-oper="remove" class="btn btn-danger">삭제하기</button>
			<button data-oper="get" class="btn btn-secondary">뒤로가기</button>
			<br>
			
			<input type="hidden" name="stusCd" value="${htdl.stusCd }">
			
		</form>
		</div>
		<!-- Default Card Example -->
		
			<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								
							</div>
							<div class="modal-body">처리가 완료되었습니다</div>
							<div class="modal-footer">
							<button type="button" id="btn-yes" class="btn btn-primary">네</button>
							<button type="button" class="btn btn-default"
									data-dismiss="modal">아니오</button>
								
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->

	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	
</div>

<script>

let formObj = $("#postForm");
let stusCd = "<c:out value='${htdl.stusCd}'/>";
let size = '<c:out value="${fn:length(htdl.htdlDtls)}"/>';
let menuLists = $(".js-menu");
//할인 적용 전/후 가격
let befPrice = $("#befPrice").val();
let total = 0;
let rate = 0;
$(document).ready(function(){
	
	
	if(stusCd === 'P'){
		$("#curMenu").html("현재 핫딜 메뉴");
		
		let checkedArr = initCheckArr();
		console.log("checkedArr : " + checkedArr);
		//메뉴에 따른 가격 선택
		for (let i = 0; i < menuLists.length; i++) {
			
			$(".js-menu").eq(i).click(function() {
				
				$("#befPrice").val("");
				$("#ddct").val("");
				$("#afterPrice").val("");
				console.log($(this).val());
				menuCheck($(this).val(), i, checkedArr);
				
				//하나도 선택되지 않았을 때 초기화
				let result = notAllSelectCheck(checkedArr);
				
				if(result){
					console.log("not all select");
					total = 0;
				}
			});
			
			
		}
	}
	
	
	//버튼 클릭시
	$("button").on("click", function(e){
		e.preventDefault();
		let operation = $(this).data("oper");
		
		if(operation === 'get'){
			
			let htdlIdTag = formObj.find("input[name='htdlId']").clone();
			let stusCdTag = formObj.find("input[name='stusCd']").clone();
			formObj.empty();
			
			formObj.append(htdlIdTag);
			formObj.append(stusCdTag);
			
			formObj.attr("action", "/dealight/admin/htdlmanage/get");
			formObj.attr("method", "get");
			formObj.submit();
		}else if(operation === 'end'){
			$(".modal-body").html("핫딜을 종료시키겠습니까");
			$("#myModal").modal("show");
			$("#btn-yes").on("click", function(){
				let htdlIdTag = formObj.find("input[name='htdlId']").clone();
				let stusCdTag = formObj.find("input[name='stusCd']").clone();
				
				formObj.empty();
				$("#myModal").modal("hide");
				
				formObj.append(htdlIdTag);
				formObj.append(stusCdTag);
				
				formObj.attr("action", "/dealight/admin/htdlmanage/end");
				formObj.attr("method", "post");
				formObj.submit();
				
			})
		}else if(operation === 'remove'){
			$(".modal-body").html("정말로 삭제하시겠습니까?");
			
			$("#myModal").modal("show");
			
			$("#btn-yes").on("click", function(){
				let htdlIdTag = formObj.find("input[name='htdlId']").clone();
				let stusCdTag = formObj.find("input[name='stusCd']").clone();
				formObj.empty();
				$("#myModal").modal("hide");
				
				formObj.append(htdlIdTag);
				formObj.append(stusCdTag);
				
				formObj.attr("action", "/dealight/admin/htdlmanage/remove");
				formObj.attr("method", "post");
				formObj.submit();
				
				console.log("====");
			})
			
		}else if(operation === 'modify'){
			
			if(stusCd != 'P'){			
				inputParsing();
				formObj.submit();
			}
			//inputParsing();
			//기존 핫딜메뉴 제거
			for(let i=0; i<size; i++){
				$("#menuName"+i).remove();
				$("#menuPrice"+i).remove();
			}
			
			for(let i =0; i< $(".js-menu").length; i++){
				//체크된 라벨 input 추가
				if($(".js-menu").eq(i).is(":checked")){		
					console.log(i+"================");
					 formObj.append("<input type='hidden' name='htdlDtls["+i+"].menuName' value='"+ $("label[for='menu"+(i+1)+"']").text()+"'>");
					 formObj.append("<input type='hidden' name='htdlDtls["+i+"].menuPrice' value='"+ $("#menu"+(i+1)).val()+"'>");
						
				}
			}
			
			formObj.submit();
				
		}
		
		/* for(let i=0; i<size; i++){
			console.log(i);
			/* let priceValue = $("#menuPrice["+i+"]").val();
			console.log("======="+ priceValue);
			$("#menuPrice["+i+"]").val(priceValue.substring(0, priceValue.length-1)); */
		//}
		

		
	});
	
	//할인율 변화
	$("#dcRate").change(function(){
		rate = $(this).val()/100;
		console.log("change: " + rate);
		
		console.log(befPrice);
		//"원 제거"
		let len = befPrice.length;
		let total = Number(befPrice.substring(0, len-1));
		console.log(total);
		getAfterPrice(total, rate);
	});
	
	
});

//input value파싱
function inputParsing(){
	
	let dcRate = $("input[name='dcRate']");
	let dcRateValue = dcRate.val();
	console.log(typeof dcRateValue);
	dcRateValue = dcRateValue.substring(0, dcRateValue.length-1);
	dcRateValue /= 100;
	dcRate.val(dcRateValue);
	console.log(dcRateValue);
	
	//할인율, 핫딜전가격,차감,현재인원,마감인원 문자열 자르기
	let befPrice = $("input[name='befPrice']");
	let befValue = befPrice.val();
	befValue = befValue.substring(0, befValue.length-1);
	befPrice.val(befValue);
	console.log(befValue);
	
	let ddct = $("input[name='ddct']");
	let ddctValue = ddct.val();
	ddctValue = ddctValue.substring(0, ddctValue.length-1);
	ddct.val(ddctValue);
	console.log(ddctValue);
	
}
//체크박스 not allSelect 확인
function notAllSelectCheck(checkedArr){
	let count = 0;
	
	//확인
	for (let i = 0; i < menuLists.length; i++) {
		
		if(checkedArr[i] === false){
			count++;
			console.log(checkedArr[i]);
			console.log("count : " + count);			
		}
		if(count === checkedArr.length)
			return true;	
	}
	return false;
}
//체크박스 확인 초기화
function initCheckArr(){
	let checkedArr = [];
	
	//체크되지 않으면 배열에 저장
	for (let i = 0; i < menuLists.length; i++) {
		if(!menuLists.eq(i).is(":checked")){
			checkedArr.push(false);
		}
	}
	return checkedArr;
}
//메뉴 체크
function menuCheck(price, idx, checkedArr) {

	if (menuLists.eq(idx).is(":checked")){		
		total += Number(price);
		checkedArr[idx] = true;
	}
	else{
		total -= Number(price);
		checkedArr[idx] = false;
	}
	
	$("#befPrice").val(total);
	getAfterPrice(total, rate);
}


//할인 적용한 가격 계산
function getAfterPrice(total, rate) {
	
	let ddct = (total * rate);
	let price = total - ddct;
	console.log("ddct: " + ddct);
	console.log("price: " + price);
	
	$("#ddct").val(ddct);
	$("#afterPrice").val(price);
}

</script>

<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>