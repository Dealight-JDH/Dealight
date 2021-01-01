<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>
<link rel="stylesheet" href="/resources/css/fileupload.css">
<!-- Begin Page Content -->
<div class="container-fluid">
	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">매장 등록</h6>
		</div>
		<div class="card-body">
			<form id='regForm' action="/dealight/mypage/storemanage/register"  method="post">
			<div class="card mb-4">
				<div class="card-header">매장번호</div>
				<input type="text" class="card-body" name="storeId" value="">
			</div>
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeNm" value="">
			</div>
			<div class="card mb-4">
				<div class="card-header">전화번호</div>
				<input type="text" class="card-body" name="telno" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">유저 아이디</div>
				<input type="text" class="card-body" name="buserId" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">지점</div>
				<input type="text" class="card-body" name="brch" value="" >
			</div>
						<div class="card mb-4">
				<div class="card-header">영업시간</div>
				<div class="card-body">
				<input type="time" name="openTm" value="${store.bstore.openTm }" >-
				<input type="time" name="closeTm" value="${store.bstore.closeTm }" >
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">브레이크시간</div>
				<div class="card-body">
				<input type="time" name="breakSttm" value="${store.bstore.breakSttm }" >-
				<input type="time" name="breakEntm" value="${store.bstore.breakEntm }" >
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">라스트 오더</div>
				<input type="text" class="card-body" name="lastOrdTm" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">가게 휴무일</div>
				<input type="text" class="card-body" name="hldy" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">가게 소개</div>
				<input type="text" class="card-body" name="storeIntro" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">대표 메뉴</div>
				<input type="text" class="card-body" name="repMenu" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">가게 평균 시간</div>
				<input type="text" class="card-body" name="avgMealTm" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">수용 인원</div>
				<input type="text" class="card-body" name="acmPnum" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">주소</div>
				<input type="text" class="card-body" id="addr "name="addr" value="" >
				<input type="button" onClick="goPopup();" value="주소찾기"/><br>
				<label>상세주소</label><input type="text"  style="width:500px;" id="addrDetail"  name="addrDetail" /><br>
				<label>시도명</label><input type="text"  style="width:500px;" id="siNm"  name="siNm" /><br>
				<label>시군구명</label><input type="text"  style="width:500px;" id="sggNm"  name="sggNm" /><br>
				<label>읍면동명</label><input type="text"  style="width:500px;" id="emdNm"  name="emdNm" /><br>
				<label>위도</label><input type="text"  style="width:500px;" id="lat"  name="lat" /><br>
				<label>경도</label><input type="text"  style="width:500px;" id="lng"  name="lng" /><br>
				<div id="map"></div></br>
			</div>
			<div class="card mb-4">
				<div class="file_body">
	                        <div class="form_img">
		                        <label for="label_uploadfile">
				                    <i class="fas fa-arrow-circle-up"></i> 사진 첨부하기
				                </label>
	                            <input style='display:none;' type="file" id='label_uploadfile' name='uploadFile' multiple hidden='hidden'>
	                        </div> 
	                        <div class='uploadResult'>
	                            <ul></ul>
	                        </div> <!-- uploadResult -->
	                    </div>
	                    <!-- 
				<div class='bigPictureWrapper'>
				    <div class='bigPicture'>
				    </div>
				</div>
				 -->
			</div>
			
			<input name="n1SeatNo" value="0" type="number" hidden>
			<input name="n2SeatNo" value="0" type="number" hidden>
			<input name="n4SeatNo" value="0" type="number" hidden>
			<input name="seatStusCd" value="B" hidden>
			<input name="likeTotNum" value='0' hidden>
			<input name="revwTotNum" value='0' hidden>
			<input name="avgRating" value='0' hidden>
			<button id='btnSubmit' class="btn btn-secondary" data-oper="register" >등록하기</button>
		</form>
		</div>
		<!-- Default Card Example -->
	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->
</div>
<!-- /.container-fluid -->
<!-- 카카오 지도  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script>
    /* form 역할을 하는 엘리먼트를 선택한다. */
	const formObj = $("#modifyForm");
    /* 정규식으로 파일 형식을 제한한다. */
    const regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
    /*최대 파일 크기를 제어한다  */
	const maxSize = 5242880; /* 5MB */
	// add category ***페이지마다 변경 필요
	const category = 'storeImgs';
	// page type
	const pageType = "register";
	// storeId
	const storeId = null;
	// btn id
	const btnSubmit = "#btnSubmit";
	// isModal
	const isModal = false;
</script>
<script type="text/javascript" src="/resources/js/reg_file.js?ver=1"></script>
<script>
	window.onload = function() {

		const form = $("form");
		$('#btn  button').on("click",function(e){
			let operation = $(this).data('oper');
			
			if(operation ==='remove'){
				form.attr("action", "/dealight/admin/storemanage/delete");
				
			}else if(operation === 'list'){
				form.attr("action", "/dealight/admin/usermanage/").attr("method", "get");
				form.empty();
				
			} else {
				return;
			}
			
			formObj.submit();
		});
		
	}
	
	//주소 api
	function goPopup(){
		var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	}
	function jusoCallBack(roadAddrPart1,addrDetail,siNm,sggNm,emdNm){
		let regForm = document.querySelector("#regForm");
		
		regForm.addr.value = roadAddrPart1;
		regForm.addrDetail.value = addrDetail;
		regForm.siNm.value = siNm;
		regForm.sggNm.value = sggNm;
		regForm.emdNm.value = emdNm;
		//위도 경도를 가져온다.
		//kakaoApi GeoCode
		$.ajax({
	           url:'https://dapi.kakao.com/v2/local/search/address.json?query='+encodeURIComponent(roadAddrPart1),
	           type:'GET',
	           headers: {'Authorization' : 'KakaoAK e511e2ddb9ebfda043b94618389a614c'},
		  	   success:function(data){
		       console.log(data.documents[0].x);
		       regForm.lng.value = data.documents[0].x
		       regForm.lat.value = data.documents[0].y
		       console.log(data.documents[0].y);
		       
		   	let container = document.getElementById('map');
		   	container.style.display = 'block';
		   	container.style.width = '250px';
		   	container.style.height = '200px';
			let options = {
				center: new kakao.maps.LatLng(data.documents[0].y, data.documents[0].x),
				level: 3
			};
			
			let markerPosition  = new kakao.maps.LatLng(data.documents[0].y, data.documents[0].x);

			let map = new kakao.maps.Map(container, options);
			
			let marker = new kakao.maps.Marker({
					position: markerPosition
				});
			
			marker.setMap(map);
		       
		   },
		   error : function(e){
		       console.log(e);
		   }
		});
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>