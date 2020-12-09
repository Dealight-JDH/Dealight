<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">매장관리페이지</h1>
	<p class="mb-4">
	</p>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
       <div class="card-header py-3">
           <h6 class="m-0 font-weight-bold text-primary">매장목록 <button id="regBtn" type="button" class="btn btn-default">매장 등록하기</button></h6>
       </div>
       <div class="card-body">
           <div class="table-responsive">
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
               <table class="table table-bordered"  width="100%" cellspacing="0">
                   <thead>
                       <tr>
                           <th>매장번호</th>
                           <th>매장명</th>
                           <th>전화번호</th>
                           <th>매장분류</th>
                           <th>등록일자</th>
                       </tr>
                   </thead>
                   <tbody>
                      <c:forEach items="${storeList }" var="store">
							<tr>
								<td><a class="move" data-cls="${store.clsCd }" href='${store.storeId}'>
										<c:out value="${store.storeId }" />
								</a></td>
								<td><c:out value="${store.storeNm }" /></td>
								<td><c:out value="${store.telno }" /></td>
								<c:choose>
									<c:when test="${store.clsCd eq 'N'}">
										<td>일반매장</td>
									</c:when>
									<c:when test="${store.clsCd eq 'B'}">
										<td>사업자매장</td>
									</c:when>
								</c:choose>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${store.regdate}" /></td>
							</tr>
						</c:forEach>
                   </tbody>
               </table>
           </div>
       </div>
   </div>
	
</div>
<form id="searchForm" action="/dealight/admin/storemanage" method="get">
					<label>검색</label>
     				<select name="type">
     					<option value=""
     						<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>
     					--
     					</option>
     					
     					<option value="S"
     						<c:out value="${pageMaker.cri.type eq 'S'?'selected':'' }"/>>
     						가게이름
     					</option>
     					<option value="I"
     						<c:out value="${pageMaker.cri.type eq 'I'?'selected':'' }"/>>
     					아이디
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
<form  method="get" id="actionForm">
	<input type="hidden" name="storeId" value="" >
	<input type="hidden" name="clsCd" value="" >
	<input type="hidden" name="brSeq" value="" >
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type }'/>">
	<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>">
</form>
<!-- /.container-fluid -->
			<div class="col-sm-12 col-md-7">
			<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
                	<ul class="pagination">
                		
                		<c:if test="${pageMaker.prev }">
                			<li class="paginate_button page-item previous">
                				<a href="${pageMaker.startPage - 1 }">Previous</a>
                			</li>
                		</c:if>
                		
                		<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                			<li class="paginate_button page-item ${pageMaker.cri.pageNum == num ? 'active':'' }">
                				<c:if test="${num == pageMaker.cri.pageNum }">[</c:if>
								<a href='${num }' > ${ num} </a> 
                				<c:if test="${num == pageMaker.cri.pageNum }">]</c:if>
                			</li>
                		</c:forEach>
                		
                		<c:if test="${pageMaker.next }">
                			<li class="paginate_button next page-item">
                				<a href="${pageMaker.endPage + 1 }">Next</a>
                			</li>
                		</c:if>
                		
                	</ul>
                </div>
			</div>
<script>
	window.onload = function(){
		
		let formObj = $("#actionForm")
		let result = '<c:out value="${result}"/>';
		
		$("#regBtn").on("click", function(){
			
			self.location = "/dealight/admin/storemanage/registerbstore";
			
		});
		
		//게시글클릭이벤트
		const table = document.getElementById("dataTable")
		const tableClick = function(e){
			e.preventDefault();
			let cls = $(this).data("cls");
			console.log(cls)
			
			formObj.find("input[name='storeId']").val($(this).attr('href'));
			formObj.find("input[name='clsCd']").val(cls);
			formObj.attr("action", "/dealight/admin/storemanage/get");
			
			formObj.submit();
		};
		
		$('#amount').on('change',function(e){
			formObj.find("input[name='amount']").val($(this).val())
			formObj.attr("action", "/dealight/admin/storemanage");
			
			formObj.submit();
		});
		
		
		$('.move').on("click", tableClick);
		
		//페이징처리
		$(".paginate_button a").on("click", function(e){
			
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