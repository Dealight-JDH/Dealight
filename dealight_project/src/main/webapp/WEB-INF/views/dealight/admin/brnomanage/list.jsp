<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>
<style>
 ul{
        display: flex;
        flex-direction: row;
    }
    li{
        /* display: flex;
        flex-direction: row; */
        list-style: none;
        /* outline: 1px solid red; */
    }
    .pagination a{
        color: black;
        padding: 8px 16px;
        border-radius: 5px;
        border: 1px solid #ddd;
        text-decoration: none;
    }
    .pagination a.active{
        background-color: buttonshadow;
        border-radius: 5px;
        color: white;
    }
    .pagination a:hover:not(.active){
        background-color: #ddd;
    } 
</style>
<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">사업자등록관리페이지</h1>
	<p class="mb-4">
	</p>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<a href="/dealight/admin/brnomanage">
				<h6 class="m-0 font-weight-bold text-primary">사업자등록</h6>
			</a>
			<button id="regBtn" type="button" class="btn btn-default">사업 등록하기</button>
		</div>
		<div class="card-body">
			<div >
					<!-- ajax처리하고싶다. -->
					<label>보기</label>
					<select name="amount" id="amount">
						<option value="5"
     						<c:out value="${pageMaker.cri.amount == 5?'selected':'' }"/>>
     						5개씩
     					</option>
						<option value="10"
     						<c:out value="${pageMaker.cri.amount == 10?'selected':'' }"/>>
     						10개씩
     					</option>
						<option value="20"
     						<c:out value="${pageMaker.cri.amount == 20?'selected':'' }"/>>
     						20개씩
     					</option>
					</select>
				<table class="table table-bordered" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>심사번호</th>
							<th>아이디</th>
							<th>매장명</th>
							<th>상태</th>
							<th>등록날짜</th>
							<th>수정날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="buser">
							<tr>
								<td><c:out value="${buser.brSeq }" /></td>
								<td><c:out value="${buser.userId }" /></td>
								<td><a class="move" href='<c:out value="${buser.brSeq}"/>'>
										<c:out value="${buser.storeNm }" />
								</a></td>
								<c:choose>
									<c:when test="${buser.brJdgStusCd eq 'C'}">
										<td>심사완료</td>
									</c:when>
									<c:when test="${buser.brJdgStusCd eq 'P'}">
										<td>심사진행중</td>
									</c:when>
									<c:when test="${buser.brJdgStusCd eq 'F'}">
										<td>심사탈락</td>
									</c:when>
								</c:choose>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${buser.regdate }" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${buser.updatedate }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<form id="searchForm" action="/dealight/admin/brnomanage" method="get">
					<label>검색</label>
     				<select name="type">
     					<option value=""
     						<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>
     					--
     					</option>
     					
     					<option value="I"
     						<c:out value="${pageMaker.cri.type eq 'I'?'selected':'' }"/>>
     					아이디
     					</option>
     					
     					<option value="S"
     						<c:out value="${pageMaker.cri.type eq 'S'?'selected':'' }"/>>
     					가게이름
     					</option>
     					
     					<option value="R"
     						<c:out value="${pageMaker.cri.type eq 'R'?'selected':'' }" />>
     					대표자명
     					</option>
     				</select>
     				<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>" />
     				<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum }'/>"/>
     				<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount }'/>"/>
     				<button class="btn btn-default">Search</button>
               </form>
			</div>
			<div class="col-sm-12 col-md-7">
			<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                	<ul class="pagination"style="margin: 10px">
                		
                		<c:if test="${pageMaker.prev }">
                			<li> <a href="'+ (pageDTO.startPage - 1) +'" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                		</c:if>
                		
                		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                				<li><a href="${num }" ${ pageMaker.cri.pageNum ==num?'class="active"':''} >${num }</a></li>
                		</c:forEach>
                		
                		<c:if test="${pageMaker.next }">
                			<a href="'+(pageDTO.endPage + 1)+'" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                		</c:if>
                		
                	</ul>
                </div>
			</div>
		</div>
	</div>
	
</div>
<form  method="get" id="actionForm">
	<input type="hidden" name="brSeq" value="" >
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type }'/>">
	<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>">
	
</form>
<!-- /.container-fluid -->
<script>
	window.onload = function(){
		
		let formObj = $("#actionForm")
		let result = '<c:out value="${result}"/>';
		checkResult()
		
		history.replaceState({},null,null);
		//게시글 등록메세지
		function checkResult(){
			console.log("checkResult....");
			if(result === '' || history.state){
				return;
			}
			if(parseInt(result)>0){
				alert("새 게시글을 등록하셨습니다.\n 심사번호는 " + parseInt(result) + "번 입니다.")
			}
			if(result == "success"){
				alert("처리가 완료되었습니다.")
			}
		}
		$('#amount').on('change',function(e){
			formObj.find("input[name='amount']").val($(this).val())
			formObj.attr("action", "/dealight/admin/brnomanage");
			
			formObj.submit();
		})
		
		$("#regBtn").on("click", function(){
			self.location = "/dealight/admin/brnomanage/register";
			
		});
		//게시글클릭이벤트
		$('.move').on("click", function(e){
			e.preventDefault();
			formObj.find("input[name='brSeq']").val($(this).attr('href'))
			formObj.attr("action", "/dealight/admin/brnomanage/get");
			
			formObj.submit();
		});
		//페이징처리
		
		$(".pagination a").on("click", function(e){
			
			e.preventDefault();
			
			console.log('click');
			
			formObj.find("input[name='pageNum']").val($(this).attr("href"));
			formObj.submit();
		});
		//검색이벤트 처리
		const searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요.");
				return false;
			}
				
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
			
		});
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>