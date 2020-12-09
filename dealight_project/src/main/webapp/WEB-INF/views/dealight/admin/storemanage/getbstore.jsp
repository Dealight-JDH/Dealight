<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">매장정보조회</h6>
		</div>
		<div class="card-body">
			
			<div class="card mb-4">
				<div class="card-header">매장번호</div>
				<input type="text" class="card-body" name="storeId" value="${store.storeId }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">매장명</div>
				<input type="text" class="card-body" name="storeNm" value="${store.storeNm }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">전화번호</div>
				<input type="text" class="card-body" name="telno" value="${store.telno }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">대표메뉴</div>
				<input type="text" class="card-body" name="repMenu" value="${store.bstore.repMenu }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">영업시간</div>
				<div class="card-body">
				<input type="time" name="openTm" value="${store.bstore.openTm }" readonly="readonly">-
				<input type="time" name="closeTm" value="${store.bstore.closeTm }" readonly="readonly">
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">브레이크시간</div>
				<div class="card-body">
				<input type="time" name="breakSttm" value="${store.bstore.breakSttm }" readonly="readonly">-
				<input type="time" name="breakEntm" value="${store.bstore.breakEntm }" readonly="readonly">
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">주소</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.loc.addr }" readonly="readonly">
				<div id="map" style="width:200px;height:200px;"></div>
			</div>
			<div class="card mb-4">
				<div class="card-header">평점</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.avgRating }" readonly="readonly">
			</div>
			<div class="card mb-4">
				<div class="card-header">리뷰수</div>
				<input type="text" class="card-body" name="storeIntro" value="${store.eval.revwTotNum }" readonly="readonly">
			</div>
			
			<c:if test="${not empty store.imgs}">
				<div class="card mb-4">
				<div class="card-header">매장 사진</div>
						<input class="store_id" hidden value="${store.storeId}">
						<ul class='store_imgs'></ul>
				</div>
			</c:if>
			
			<button data-oper="modify" class="btn btn-secondary">수정하기</button>
			<button data-oper="list" class="btn btn-secondary">목록으로</button><br>
			

			<form action="#" id="operForm" method="get">
				<input type="hidden" name="storeId" value="${store.storeId }">
				<input type="hidden" name="clsCd" value="${store.clsCd }">
			</form>
		</div>
		<!-- Default Card Example -->


	</div>
	<!-- Basic Card Example -->
	<!-- DataTales Example -->

	
</div>
<!-- /.container-fluid -->
<script>
	window.onload = function() {

		const operForm = $("#operForm");
		
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
		
		
		//버튼 클릭 이벤트----
		$("button[data-oper='modify']").on("click", function(e){
			
			operForm.attr("action", "/dealight/admin/storemanage/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#userId").remove();
			operForm.attr("action", "/dealight/admin/storemanage")
			operForm.submit();
		});
	
	/* get review img (즉시실행함수)*/
	    (function(){
	        
	    		let store_id = document.getElementsByClassName("store_id");
	    		
	    		let storeId = store_id[0].value;
	    		
	    		console.log("store id : " + storeId);
	    		
	            $.getJSON("/dealight/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
	                
	            	console.log('getJSON success');
	            	
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
	                
	                    console.log("str revw img : " + strStoreImgs);
		                $(".store_imgs").html(strStoreImgs);
	                
	            }); // end getjson
	    	})(); // end function
	}; // end load
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>