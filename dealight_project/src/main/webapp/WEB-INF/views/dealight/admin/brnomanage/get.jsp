<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">사업자등록관리</h6>
		</div>
		<div class="card-body">
			
			<form action="/dealight/admin/brnomanage/modify" method="post" id="modifyStus">
			<div class="card mb-4">
				<div class="card-header">심사번호</div>
				<input type="text" class="card-body" name="brSeq" value="${buser.brSeq }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">유저아이디</div>
				<input type="text" class="card-body" name="userId" value="${buser.userId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">대표자명</div>
				<input type="text" class="card-body" name="repName" value="${buser.repName }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeNm" value="${buser.storeNm }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">휴대전화</div>
				<input type="text" class="card-body" name="telno" value="${buser.telno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">사업장전화번호</div>
				<input type="text" class="card-body" name="storeTelno" value="${buser.storeTelno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">사업자등록번호</div>
				<input type="text" class="card-body" name="brno" value="${buser.brno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">심사상태</div>
				<input type="text" class="card-body" name="brJdgStusCd" value="${buser.brJdgStusCd }" readonly="readonly">
			</div>
			<div class="card mb-4">
			<input type="hidden" name="brPhotoSrc" value="${buser.brPhotoSrc }" readonly="readonly">
				<div class="card-header">사업자등록증 사진</div>
				<div class="file_body">
					<div class='uploadResult'>
						<ul>
						</ul>
					</div> <!-- uploadResult -->
				</div> 
				<div class='bigPictureWrapper'>
					<div class='bigPicture'>
					</div>
				</div>
			</div>
			<c:if test="${buser.brJdgStusCd == 'F' }">
			<div class="card mb-4">
				<div class="card-header">탈락사유</div>
				<textarea class="card-body"rows="3" name='reason' readonly="readonly"><c:out value="${buser.reason }"></c:out> </textarea>
			</div>
			</c:if>
			
			<div class="card mb-4" id="reason">
			</div>
			
			</form>
			<c:if test="${buser.brJdgStusCd == 'P' }">
				<div id="jdgBtns">
				<button onclick="failEvent()" class="btn btn-secondary">심사탈락</button>
				<button onclick="permitEvent()" class="btn btn-secondary">심사승인</button>
				</div>
			</c:if>	
			
			
			<div style="margin-top: 10px; ">
			<button data-oper="modify" class="btn btn-secondary">수정하기</button>
			<button data-oper="list" class="btn btn-secondary">목록으로</button>
			</div>
			

			<form action="/dealight/mypage/bizauth/modify" id="operForm" method="get">
				<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>">
				<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>">
				<input type="hidden" name="type" value="<c:out value='${cri.type }'/>">
				<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>">
				<input type="hidden" name="brSeq" id="brSeq" value="${buser.brSeq }">
			</form>
		</div>
		<!-- Default Card Example -->

	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

</div>
<!-- /.container-fluid -->

<script>

const modifyForm = $("#modifyStus");
const operForm = $("#operForm");
const reason = $("#reason");
const jdgBtns = $("#jdgBtns");

const failEvent = function(){
	
	let str = "";
	str +='<div class="card-header">탈락사유</div>';
	str +='<textarea class="card-body"rows="3" name="reason"></textarea>';
	reason.html(str);
	
	let btns = "";
	btns +='<button onclick="confirmEvent()"  class="btn btn-secondary">탈락</button>'
	btns +='<button onclick="cancleEvent()" class="btn btn-secondary">취소</button>'
	
	jdgBtns.empty();
	jdgBtns.html(btns);
}

const permitEvent = function(){
	$("input[name='brJdgStusCd']").val("C");
	reason.empty();
	modifyForm.submit();
}

const confirmEvent = function(){
	$("input[name='brJdgStusCd']").val("F");
	modifyForm.submit();
}

const cancleEvent = function(){
	let btns = "";
	btns +='<button onclick="failEvent()" class="btn btn-secondary">심사탈락</button>'
	btns +='<button onclick="permitEvent()" class="btn btn-secondary">심사승인</button>'
	
	reason.empty();
	jdgBtns.empty();
	jdgBtns.html(btns);
}

	window.onload = function() {
		(function(){
			let brPhotoSrc = (document.getElementsByName("brPhotoSrc")[0]).value;
			let srcObj = subSrc(brPhotoSrc);
			console.log(srcObj)
			
			let str = "";
			
			
			let fileCallPath = encodeURIComponent( "/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
			console.log(fileCallPath)
			str += "<li data-path='"+ srcObj["uploadPath"] +"'";
			str += "data-filename=\'"+ srcObj["fileName"] +"\'><div>";
			str += "<span>" + srcObj["realFileName"] +"</span><br>"
			str += "<img src='/display?fileName=" + fileCallPath + "'>";
			str += "</div>";
			str += "</li>";
			
			$(".uploadResult ul").html(str);
		})();
		
		
		
		//버튼 클릭 이벤트----
		
		
		
		$("button[data-oper='permit']").on("click", function(e){
			reason.remove();
		});
		
		
		$("button[data-oper='modify']").on("click", function(e){
			e.preventDefault;
			operForm.attr("action", "/dealight/admin/brnomanage/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			e.preventDefault;
			operForm.find("#brSeq").remove();
			operForm.attr("action", "/dealight/admin/brnomanage")
			operForm.submit();
		});
		
		const uploadUL = $(".uploadResult ul");
		
		$(".uploadResult").on("click","li", function(e){
			
			console.log("view image");
			
			var liObj = $(this);
			
			let path = encodeURIComponent( "/" + liObj.data("path")+"/" + liObj.data("filename"));
			
			
			showImage(path.replace(new RegExp(/\\/g), "/"));
			
		});
		
		//이미지창 닫기
		$(".bigPictureWrapper").on("click", function(e){
			
			$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
			setTimeout(function(){
				$(".bigPictureWrapper").hide();
			},1000);
			
		});
		
		function showImage(fileCallPath){
			alert(fileCallPath);
			
			$(".bigPictureWrapper").css("display", "flex").show();
			
			$(".bigPicture")
			.html("<img  width='500' height='800' src='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height:'100%'}, 1000);
		}
		
		
	}
	function subSrc(photoSrc){
		let srcObj = {};
		let index = photoSrc.lastIndexOf("/");
		
		srcObj["uploadPath"] = photoSrc.substring(0,index);
		srcObj["fileName"] = photoSrc.substring(index + 1);
		srcObj["realFileName"] = photoSrc.substring(photoSrc.lastIndexOf("_") + 1); 
		
		return srcObj;
	}
	
	
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>