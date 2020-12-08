<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웨이팅 내역</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
</head>
<body>
    <main class="mypage_wrapper">
        <%@include file="/WEB-INF/views/includes/mypageSidebar.jsp" %>
        <div class="mypage_content">
            <div class="content_head">
                <h2>웨이팅 내역<span>웨이팅 내역을 가져옵니다.</span></h2>
            </div>
            <div>
                	<h2>회원 아이디 : ${userId }</h2>
					<h2>현재 웨이팅 횟수 : ${curWaitCnt}회</h2>
					<h2>총 노쇼 횟수 : ${panaltyCnt}회</h2>
					<h2>총 웨이팅 횟수 : ${enterCnt}회</h2>
					<h2>총 웨이팅 횟수 : ${total}회</h2>
            </div>
            <div class="content_main">
				<div id="waitWrapper">
					<c:if test="${empty waitList}">
						<h2>웨이팅 이력이 없습니다.</h2>
					</c:if>
					
					<c:if test="${not empty waitList}">
					<h2>웨이팅 리스트</h2>
						<c:forEach items="${waitList}" var="wait">
							<div>
								====================================
								<h3>웨이팅 번호 : <span class="wait_id">${wait.waitId}</span></h3>
								<h5>매장번호 : <span class="store_id">${wait.storeId}</span></h5></br>
								날짜 : ${wait.waitRegTm } </br>
								인원 : ${wait.waitPnum }</br>
								이용자 전화번호 : ${wait.custTelno }</br>
								이용자 이름 : ${wait.custNm }</br>
								현재 웨이팅 상태 : ${wait.waitStusCd}<br>
								리뷰 상태 : <span class="revw_stus">${wait.revwStus }</span></br>
								<button class="btn_store_info">매장 정보 보기</button>
								<button class="btn_revw_reg">리뷰 쓰기</button>
							</div>
						</c:forEach>
					</c:if>
				</div>
            </div>
            <!-- pagination -->
			<div class='pull-right'>
				<ul class='pagination'>
			
					<c:if test="${pageMaker.prev}">
						<li class='paginate_button previous'>
							<a href="${pageMaker.startPage - 1}">Previous</a>
						</li>
					</c:if>
					
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					<c:if test="${pageMaker.next}">
						<li class='paginate_button next'>
							<a href="${pageMaker.endPage + 1}">Next</a>
						</li>
					</c:if>
				</ul>
			</div>
			<form id='actionForm' action="/dealight/mypage/wait" method='get'>
				<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
				<input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
			</form>
			<!-- end pagination -->
        </div>
    </main>
    
    <div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<ul class="revw_regForm"></ul>
			<ul class="store_info"></ul>
			<div id="map" style="width:500px;height:400px;"></div>
		</div>
	</div>

<script type="text/javascript" src="/resources/js/modal.js"></script>
<script type="text/javascript">
window.onload = function () {
	
    const userId = '${userId}',
	    revwRegFormUL = $(".revw_regForm"),
	    storeInfoUL = $(".store_info"),
	    btn_show_board = $("#btn_show_board")
	;
	    
	let container,options,map,mapContainer,mapOption,markerPosition,marker;
	
	let actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click", function(e) {
		
		e.preventDefault();
		
		console.log("page click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
    function getStoreInfo(param,callback,error){
       	
       	
       	let storeId = param.storeId;
       	
       	
       	$.getJSON("/dealight/mypage/reservation/store/"+ storeId +".json",
                   function(data){
                       if(callback){
                           callback(data);
                       }
                   }).fail(function(xhr,status,err){
                       if(error){
                           error();
                       }
           });
       };
       
       
       /* 출력 로직*/
       
       function showStoreInfo(storeId) {
       	
       	getStoreInfo({storeId : storeId}, store=>{
       		
       		let strStoreInfo = "";
       		if(!store)
       			return;
       		
       		strStoreInfo += "<h1>매장 정보</h1>";
       		strStoreInfo += "<img src='/display?fileName="+store.bstore.repImg+"'>";
       		strStoreInfo += "<li>매장 번호 : "+store.storeId+"</l1>";
       		strStoreInfo += "<li>매장 이름 : "+store.storeNm+"</l1>";
       		strStoreInfo += "<li>매장 번호 : "+store.telno+"</l1>";
       		strStoreInfo += "<li>매장 상태 : "+store.clsCd+"</l1>";
       		strStoreInfo += "<li>매장 관리자 아이디 : "+store.bstore.buserId+"</l1>";
       		strStoreInfo += "<li>매장 분점 : "+store.bstore.brch+"</l1>";
       		strStoreInfo += "<li>매장 대표 메뉴 : "+store.bstore.repMenu+"</l1>";
       		strStoreInfo += "<li>매장 착석 상태 : "+store.bstore.seatStusCd+"</l1>";
       		strStoreInfo += "<li>매장 영업 시작 시간 : "+store.bstore.openTm+"</l1>";
       		strStoreInfo += "<li>매장 영업 마감 시간 : "+store.bstore.closeTm+"</l1>";
       		strStoreInfo += "<li>매장 브레이크타임 시작 시간 : "+store.bstore.breakSttm+"</l1>";
       		strStoreInfo += "<li>매장 브레이크타임 종료 시간 : "+store.bstore.breakEntm+"</l1>";
       		strStoreInfo += "<li>매장 라스트오더 시간 : "+store.bstore.lastOrdTm+"</l1>";
       		strStoreInfo += "<li>매장 1인 테이블 수 : "+store.bstore.n1SeatNo+"</l1>";
       		strStoreInfo += "<li>매장 2인 테이블 수 : "+store.bstore.n2SeatNo+"</l1>";
       		strStoreInfo += "<li>매장 4인 테이블 수 : "+store.bstore.n4SeatNo+"</l1>";
       		strStoreInfo += "<li>매장 소개 : "+store.bstore.storeIntro+"</l1>";
       		strStoreInfo += "<li>매장 평균 식사 시간 : "+store.bstore.avgMealTm+"</l1>";
       		strStoreInfo += "<li>매장 휴무일 : "+store.bstore.hldy+"</l1>";
       		strStoreInfo += "<li>매장 수용 가능 인원 : "+store.bstore.acmPnum+"</l1>";
       		strStoreInfo += "<li>매장 주소 : "+store.loc.addr+"</l1>";
       		
       		modal.find("#map").css("display", "block");
       		
       		container = document.getElementById('map');
       		options = {
       					center : new kakao.maps.LatLng(store.loc.lat, store.loc.lng),
       					level : 3
       				};
       		map = new kakao.maps.Map(container, options);
       		mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       		mapOption = { 
       		    center: new kakao.maps.LatLng(store.loc.lat, store.loc.lng), // 지도의 중심좌표
       		    level: 3 // 지도의 확대 레벨
       		};
       		markerPosition  = new kakao.maps.LatLng(store.loc.lat, store.loc.lng);
       		marker = new kakao.maps.Marker({
       			position: markerPosition
       		});
       		marker.setMap(map);
       		
       		storeInfoUL.html(strStoreInfo);
       		
       	});
       	
       }
       
       /* 리뷰 등록 폼을 보여준다.*/
       function showRevwRegForm(storeId,userId,waitId){
    	   
    	let strRevwRegForm = "";    			
    			
    	getStoreInfo({storeId : storeId}, store=>{
    		
    		console.log("get store info..................");
       		
       		if(!store)
       			return;
       	
	       	
	       	strRevwRegForm += "<h1>리뷰 작성</h1>";
	       	strRevwRegForm += "<form id='revwRegForm' action='dsadasdas' method=''>";
	       	strRevwRegForm += "매장 번호 : <input name='storeId' value='"+store.storeId+"' readonly></br>";
	       	strRevwRegForm += "매장 이름 : <input name='storeNm' value='"+store.storeNm+"' readonly></br>";
	       	strRevwRegForm += "웨이팅 번호 : <input name='waitId' value='"+waitId+"' readonly></br>";
	       	strRevwRegForm += "회원 아이디 : <input name='userId' value='"+userId+"' readonly></br>";
	       	strRevwRegForm += "리뷰 내용 : <input type='textarea' name='cnts' id=''></br>";
	       	strRevwRegForm += "평점 : <input type='number' name='rating' id=''></br>";
	       	strRevwRegForm += "파일첨부 : <div class='file_body'>"; 
	       	strRevwRegForm += "<div class='form_img'><input id='js_upload' type='file' name='uploadFile' multiple></div>";
	       	strRevwRegForm += "<div class='uploadResult'><ul></ul></div></div>";
	       	strRevwRegForm += "<input name='prevPage' value='wait' id='' hidden>";
	       	strRevwRegForm += "<div class='bigPictureWrapper'><div class='bigPicture'></div></div>";
	       	strRevwRegForm += "</form>";
	       	strRevwRegForm += "<button id='submit_revwRegForm'>제출하기</button>";
	       	
	       	revwRegFormUL.html(strRevwRegForm);
	       	
	       	/* change() 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백함수를 동작시킨다.  */
			$("#js_upload").change(function(e){
				
				console.log("change..................");
				
				let cloneObj = $(".form_img").clone();
				
				let formData = new FormData();
				
				let inputFile = $("input[name='uploadFile']");
				
				let files = inputFile[0].files;
				
				// add category
				let category = 'revwImgs';
				
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
	       	
			let revwRegForm = $("#revwRegForm");
	    	
			/* 정규식으로 파일 형식을 제한한다. */
		    let regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
		    
		    /*최대 파일 크기를 제어한다  */
			let maxSize = 5242880; /* 5MB */
			
			/*업로드 결과를 보여준다. */
			function showUploadResult(uploadResultArr) {
				
				console.log("show upload result..................");
		        
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
		            
					uploadUL.append(str);
				});
		        
				
				
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
			};
			
			
		    
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
	    	
	    	$("#submit_revwRegForm").on("click", function(e) {
	    		
	    		e.preventDefault();
	    		
	    		let str = "";
	    		
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
       	
    		revwRegForm.attr("method","post");
    		revwRegForm.append(str);
    		revwRegForm.attr("action", "/dealight/mypage/review/register").submit();
    	});
    		
    	});
    			
    	
       };
       
   	let showRevwRegFormHandler =  function(e) {
       	let storeId = $(e.target).parent().find(".store_id").text(),
	   		waitId = $(e.target).parent().find(".wait_id").text(),
	   		revwStus = $(e.target).parent().find(".revw_stus").text();
       	
	    if(revwStus > 0) return;
		
       	showRevwRegForm(storeId,userId,waitId);
       	modal.css("display","block");
	}
   	
	let showStoreInfoHandler = function(e) {
    	let storeId = $(e.target).parent().find(".store_id").text()
    	
    	showStoreInfo(storeId);
    	modal.css("display","block");
	}
       
       /* 리뷰 등록 */
       $(".btn_revw_reg").on("click",showRevwRegFormHandler);
       
       /* 매장 상세 */
       $(".btn_store_info").on("click",showStoreInfoHandler);
	
}; /* document ready end*/

</script>
</body>
</html>