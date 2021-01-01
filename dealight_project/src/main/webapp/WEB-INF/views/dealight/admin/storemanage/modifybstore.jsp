<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>
<link rel="stylesheet" href="/resources/css/fileupload.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<script src="/resources/js/Rater.js"></script>
<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">매장정보수정</h6>
		</div>
		<div class="card-body">
			<form id="modifyForm" action="/dealight/admin/storemanage/modify"  method="post">
					<input name="clsCd" value="${store.clsCd}" hidden>
					<input name="brch" value="${store.bstore.brch}" hidden }>
					<input name="addr" value="${store.loc.addr }" hidden>
					<input name="lat" value="${store.loc.lat}" hidden>
					<input name="lng" value="${store.loc.lng}" hidden>
			<div class="card mb-4">
				<div class="card-header">매장번호</div>
				<input type="text" class="card-body" name="storeId" value="${store.storeId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeNm" value="${store.storeNm }">
			</div>
			<div class="card mb-4">
				<div class="card-header">전화번호</div>
				<input type="text" class="card-body" name="telno" value="${store.telno }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">대표메뉴</div>
				<input type="text" class="card-body" name="repMenu" value="${store.bstore.repMenu }" >
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
				<div class="card-header">라스트 오더 시간</div>
				<input type="text" class="card-body" name="lastOrdTm" value="${store.bstore.lastOrdTm}" >
			</div>
			<div class="card mb-4">
				<div class="card-header">1인 테이블 개수</div>
				<input type="text" class="card-body" name="n1SeatNo" value="${store.bstore.n1SeatNo}" >
			</div>
			<div class="card mb-4">
				<div class="card-header">2인 테이블 개수</div>
				<input type="text" class="card-body" name="n2SeatNo" value="${store.bstore.n2SeatNo}" >
			</div>
			<div class="card mb-4">
				<div class="card-header">4인 테이블 개수</div>
				<input type="text" class="card-body" name="n4SeatNo" value="${store.bstore.n4SeatNo}" >
			</div>
			<div class="card mb-4">
				<div class="card-header">매장소개</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.loc.addr }" >
			</div>
			<div class="card mb-4">
				<div class="card-header">매장 평균 식사 시간</div>
				<input type="text" class="card-body" name="avgMealTm" value="${store.bstore.avgMealTm}" >
			</div>
			<div class="card mb-4">
				<div class="card-header">매장 휴무일</div>
				<input type="text" class="card-body" name="hldy" value="${store.bstore.hldy}" >
			</div>
			<div class="card mb-4">
				<div class="card-header">매장 수용인원</div>
				<input type="text" class="card-body" name="acmPnum" value="${store.bstore.acmPnum}" >
			</div>
			<div class="card mb-4">
				<div class="card-header">매장 위치</div>
				<input type="text" class="card-body" name="lastOrdTm" value="${store.loc.addr}" >
				<div id="map" style="width:200px;height:200px;"></div>
			</div>
			<div class="card mb-4">
				<div class="card-header">평점</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.avgRating }" readonly>
				<div class='rating' data-rate-value='${store.eval.avgRating }'></div>
			</div>
			<div class="card mb-4">
				<div class="card-header">리뷰수</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.revwTotNum }" readonly>
			</div>
			<div class="card mb-4">
				<div class="card-header">찜 수</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.likeTotNum }" readonly>
			</div>
			<div class="card mb-4">
				<div class="card-header">현재 착석 상태</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.bstore.seatStusCd}" readonly >
			</div>
				<div class="card mb-4">
				<div class="card-header">매장 사진 첨부</div>
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
						<!-- <div class='bigPictureWrapper'>
							<div class='bigPicture'>
							</div>
						</div>
						 -->
				</div>
		</form>
		<div id="btn">
				<button class="btn btn-secondary" data-oper="modify" id="btnSubmit">수정하기</button>
				<button class="btn btn-secondary" data-oper="suspend">영업중단</button>
				<button class="btn btn-secondary" data-oper="list" >목록으로</button>
			</div>
		</div>
		<!-- Default Card Example -->


	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	
</div>
<!-- /.container-fluid -->
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
	const pageType = "modify";
	// storeId
	const storeId = ${store.storeId};
	// btn id
	const btnSubmit = "#btnSubmit";
	// isModal
	const isModal = false;
</script>
<script type="text/javascript" src="/resources/js/reg_file.js?ver=1"></script>
<script>
	/* Rater.js 로직*/
	$(".rating").rate({
	    max_value: 5,
	    step_size: 0.5,
	    initial_value: 3,
	    selected_symbol_type: 'utf8_star', // Must be a key from symbols
	    cursor: 'default',
	    readonly: true,
	});
	window.onload = function() {
		
		let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		let options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(${store.loc.lat}, ${store.loc.lng}), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};

		let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = { 
		    center: new kakao.maps.LatLng(${store.loc.lat}, ${store.loc.lng}), // 지도의 중심좌표
		    level: 3 // 지도의 확대 레벨
		};


		//마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(${store.loc.lat}, ${store.loc.lng}); 

		//마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position: markerPosition
		});

		//마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		//아래 코드는 지도 위의 마커를 제거하는 코드입니다
		//marker.setMap(null);    

		const form = $("form");
		$('#btn  button').on("click",function(e){
			let operation = $(this).data('oper');
			
			if(operation ==='suspend'){
				if(confirm("정말로 중단시키겠습니까?"))
					form.attr("action", "/dealight/admin/storemanage/suspend");
				else
					return;
				
			}else if(operation === 'list'){
				form.attr("action", "/dealight/admin/storemanage/").attr("method", "get");
				form.empty();
			} else {
				return;
			}
			
			form.submit();
		});
		
		/* get review img (즉시실행함수)*/
	    (function(){
	        
	    		let store_id = document.getElementsByClassName("store_id");
	    		
	    		console.log("store id : " + store_id);
	    	
	    		let storeId = store_id[0].value;
	    		
	            $.getJSON("/dealight/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
	                
	                let strStoreImgs = "";
	                
	                $(imgs).each(function(i, img){
	                	
	                    if(img.image) {
	                    	
	                        let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
	                        strStoreImgs += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
	                            + img.fileName +"'data-type='" + img.image+"'><div>";
	                        strStoreImgs += "<img src='/display?fileName=" + fileCallPath+"'>";
	                        strStoreImgs += "</li>";
	                        
	                    } else {
	                        
	                    	strStoreImgs += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
	                                +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
	                        strStoreImgs += "<span>" + img.fileName+"</span><br/>";
	                        strStoreImgs += "<img src='/resources/img/attach.png'>";
	                        strStoreImgs += "</div>";
	                        strStoreImgs += "</li>";
	                    }
	                    
	                });
	                    console.log("strStoreImgs : " + strStoreImgs);
		                $(".store_imgs").html(strStoreImgs);
	                
	                
	            }); // end getjson
	    	})(); // end function
		
	
	};
	
	
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>