<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="/WEB-INF/views/includes/adminHeader.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	

	<div class="card shadow mb-4" style="width: 100%;">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">매장정보조회</h6>
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
				<div class="card-header">영업 시작 시간</div>
				<input type="text" class="card-body" name="openTm" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">영업 종료 시간</div>
				<input type="text" class="card-body" name="closeTm" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">브레이크 시작 시간</div>
				<input type="text" class="card-body" name="breakSttm" value="" >
			</div>
			<div class="card mb-4">
				<div class="card-header">브레이크 종료 시간</div>
				<input type="text" class="card-body" name="breakEntm" value="" >
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
				<div class="card-header">사진 첨부하기</div>
				<div class="file_body">
					<div class="form_img">
						<input type="file" name='uploadFile' multiple>
					</div> 
					<div class='uploadResult'>
						<ul></ul>
					</div> <!-- uploadResult -->
				</div>
				<div class='bigPictureWrapper'>
				    <div class='bigPicture'>
				    </div>
				</div>
			</div>
			
			<input name="n1SeatNo" value="0" type="number" hideen>
			<input name="n2SeatNo" value="0" type="number" hidden>
			<input name="n4SeatNo" value="0" type="number" hidden>
			<input name="seatStusCd" value="B" hidden>
			<input name="likeTotNum" value='0' hidden>
			<input name="revwTotNum" value='0' hidden>
			<input name="avgRating" value='0' hidden>
			<button class="btn btn-secondary" data-oper="register" >등록하기</button>
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

	window.onload = function() {

		const formObj = $("form");
		$('#btn  button').on("click",function(e){
			let operation = $(this).data('oper');
			
			if(operation ==='remove'){
				formObj.attr("action", "/dealight/admin/storemanage/delete");
				
			}else if(operation === 'list'){
				formObj.attr("action", "/dealight/admin/usermanage/").attr("method", "get");
				formObj.empty();
				
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
		/* form 역할을 하는 엘리먼트를 선택한다. */
		let formObj = $("#regForm");
	    
	    /* submit 타입의 버튼을 제어한다.*/
	    
		$("button[type='submit']").on("click", function(e){
	        
	        /* 기존 기능은 제한한다.*/
			e.preventDefault();
			
			console.log("submit clicked");
			
			console.log("form"+formObj);
			
			$("#repImg")
			
			let str = "";
	        
	        /* 업로드 결과 화면에 업로드 결과를 작성해준다.*/
	        /* jquery의 foreach문 */
			$(".uploadResult ul li").each(function(i, obj) {
				
				let jobj = $(obj);
				
				str += "<input type='hidden' name='imgs["+i+"].fileName' value='" + jobj.data("filename")+"'>";
				str += "<input type='hidden' name='imgs["+i+"].uuid' value='" + jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='imgs["+i+"].uploadPath' value='" + jobj.data("path")+"'>";
				str += "<input type='hidden' name='imgs["+i+"].image' value='" + jobj.data("type")+"'>";
				if(i === 0){
				str += "<input type='hidden' name='repImg' value='" + jobj.data("path").replace(new RegExp(/\\/g),"/") +"/"+ "s_"+ jobj.data("uuid") +"_"+ jobj.data("filename")+"'>";
					
				}
				
			});
	        	
			
	        /*위에서 작성한 글을 form에 추가하고 제출한다. */
			formObj.attr("method", "post");
			formObj.append(str).submit();
			
		});
	    
	    /* 정규식으로 파일 형식을 제한한다. */
	    let regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
	    
	    /*최대 파일 크기를 제어한다  */
		let maxSize = 5242880; /* 5MB */
	    
	    /*업로드 결과를 보여준다. */
		function showUploadResult(uploadResultArr) {
	        
	        /**업로드 된게 없으면 그대로 반환 */
			if(!uploadResultArr || uploadResultArr.length == 0){return; }
	        
	        /*업로드 결과를 보여줄 ul를 선택 */
			let uploadUL = $(".uploadResult ul");
			
			let str = "";
	        
	        /*업로드 결과를 보여준다. */
			$(uploadResultArr).each(function(i,obj){
	            
	            /* 만일 파일이 이미지 형식이면 */
	            /* data에 path,uuid,filename,type을 각각 저장한다. */
				if(obj.image) {
					let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					let originPath = obj.uploadPath + "\\" + obj.uuid +"_" + obj.fileName;
					
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li data-path='" + obj.uploadPath +"'";
					str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
					str += "><a href=\"javascript:showImage(" + originPath + ")\">" + "<div>";
					str += "<span>" + obj.fileName +"</span>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div></a>";
					str += "<button type ='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
					str += "</li>";
	                /* 만일 파일이 이미지 형식이 아니면 */
	                /* default img를 보여준다. */
				} else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

					str += "<li "
					str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'><a href='/download?fileName=" + fileCallPath + "'>" + "<div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</a></div>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
					str += "</li>";
				}
			});
	        
			uploadUL.append(str);
		}
	    
	    /*파일 valid check */
		function checkExtension(fileName, fileSize) {
	        
	        /*파일 사이즈를 체크한다. */
	        if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			/*파일 형식을 체크한다. */
			if(regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		
	    
	    /* change() 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백함수를 동작시킨다.  */
		$("input[type='file']").change(function(e){
			
			let cloneObj = $(".form_img").clone();
			
			let formData = new FormData();
			
			let inputFile = $("input[name='uploadFile']");
			
			console.log("input file[name uploadFile] : "+inputFile);
			
			let files = inputFile[0].files;
			
			console.log("files : "+files);
			
			// add category
			let category = 'storeImgs';
			
			for(let i = 0; i < files.length; i++){
				
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
	            }
	            /* uploadFile 이라는 변수명에 파일 배열(스프링에서는 MultipartFile[]로 받는다)을 달아서보낸다. */
				formData.append("uploadFile", files[i]);
	            // add category
				formData.append("category", category);
			}
			
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
	            contentType : false, 
	            data: formData,
	            type: 'POST',
				dataType : 'json',
				success : function(result) {
				    console.log(result);
				    showUploadResult(result); // 업로드 결과 처리 함수
				    $(".form_img").html(cloneObj.html()); // 첨부파일 개수 초기화
				}
				
				
			})
			
		});
	    
	    /* 업로드 결과를 누르면 해당 파일을 제거한다.  */
		$(".uploadResult").on("click", "button", function(e) {
			
			let targetFile = $(this).data("file");
			
			console.log(targetFile);
			
			let type = $(this).data("type");
			
			console.log(type);
			
			let targetLi = $(this).closest("li");
			
			console.log(targetLi);
			
			$.ajax({
				url : '/deleteFile',
				data : {fileName : targetFile, type:type},
				dataType : 'text',
				type : 'POST',
				success : function(result) {
					alert(result);
					targetLi.remove();
				}
			}); // $.ajax
		});
	    
	    
	    $(".uploadResult").on("click", "li", function(e){
	        
	        let liObj = $(this);
	        
	        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
	        
	        if(liObj.data("type")){
	            
	            showImage(path.replace(new RegExp(/\\/g), "/"));
	        } else {
	            //download
	            self.location = "/download?fileName=" + path
	        }
	    });
		
		function showImage(fileCallPath) {
			
			alert(fileCallPath);
			
			$(".bigPictureWrapper").css("display","flex").show();
			
			$(".bigPicture")
			.html("<img src='/display?fileName=" +encodeURI(fileCallPath) + "'>")
			.animate({width:'100%',height:'100%'},1000);
			
			
		}// end show image
		
		$(".bigPictureWrapper").on("click",function(e){
			$(".bigPicture").animate({width:'0%',height:'0%'},1000);
			setTimeout(()=>{
				$(this).hide();
			}, 1000);
		});
	}
</script>
<%@include file="/WEB-INF/views/includes/adminFooter.jsp"%>