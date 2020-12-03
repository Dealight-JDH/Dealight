<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../../includes/mainMenu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역</title>
<link rel="stylesheet" href="/resources/css/mypage.css?ver=1" type ="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<style>
	/* The Modal (background) */
        .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content/Box */
        .modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 80%; /* Could be more or less, depending on screen size */
        }

        /* The Close Button */
        .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .close:hover,
        .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
        
        /* The Delete Button*/
        .btn_delete {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .btn_delete:hover,
        .btn_delete:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
</style>
</head>
<body>
    <main class="mypage_wrapper">
        <div class="mypage_menu_nav">
            <h2 class="tit_nav">마이 페이지</h2>
            <div class="inner_nav">
                <ul class="menu_list">
                    <li><a href="/dealight/mypage/reservation">예약 내역</a></li>
                    <li><a href="/dealight/mypage/wait">웨이팅 내역</a></li>
                    <li><a href="/dealight/mypage/review/">나의 리뷰</a></li>
                    <li><a href="/dealight/mypage/like">찜 목록</a></li>
                    <li><a href="/dealight/mypage/modify">회원 정보 수정</a></li>
                </ul>
            </div>
        </div>
        <div class="mypage_content">
            <div class="content_head">
                <h2>예약 내역<span>지난 예약 내역을 가져옵니다.</span></h2>
            </div>
            <div>
                	<h2>회원 아이디 : ${userId }</h2>
					<h2>현재 예약 횟수 : ${curCnt}회</h2>
					<h2>총 지난 예약 횟수 : ${last}회</h2>
					<h2>총 예약 횟수 : ${total}회</h2>
            </div>
            <div class="content_main">
				<div id="rsvdWrapper">
					<c:if test="${empty rsvdList}">
						<h2>예약한 이력이 없습니다.</h2>
					</c:if>
					
					<c:if test="${not empty rsvdList}">
					<h2>예약 리스트</h2>
						<c:forEach items="${rsvdList}" var="rsvd">
							<div>
								====================================
								<h5>예약 번호 : <span class="rsvd_id">${rsvd.rsvdId}</span></h5>
								<h5>매장번호 : <span class="store_id">${rsvd.storeId}</span></h5></br>
								날짜 : ${rsvd.time } </br>
								인원 : ${rsvd.pnum }</br>
								메뉴 : 
								<c:forEach items="${rsvd.rsvdDtlsList}" var="rsvdDtls">
								${rsvdDtls.menuNm}
								</c:forEach>
								</br>
								결제금액 : ${rsvd.totAmt}</br>
								결제수량 : ${rsvd.totQty}</br>
								현재 예약 상태 : ${rsvd.stusCd}</br>
								리뷰 상태 : <span class="revw_stus">${rsvd.revwStus }</span></br>
								<button class="btn_rsvd_dtls">예약 상세 보기</button>
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
			<form id='actionForm' action="/dealight/mypage/reservation" method='get'>
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
			<ul class="rsvdDtls"></ul>
			<ul class="userRsvdList"></ul>
			<ul class="revw_regForm"></ul>
			<ul class="store_info"></ul>
			<div id="map" style="width:500px;height:400px;"></div>
		</div>
	</div>

<script type="text/javascript">
$(document).ready(function() {
	
	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
		modal.find("#map").html("");
		modal.find("#map").css("display", "none");
	});
	
	modal.find("#map").css("display", "none");
	
	/*
	 모달이 아닌 화면을 클릭하면 모달이 종료가 되어야 하는데 그렇지 않음.
	*/
	window.onclick = function(event) {
		  if (event.target == modal) {
			  modal.css("display","none");
			  modal.find("ul").html("");
		  }
	};
	
    const userRsvdListUL = $(".userRsvdList"),
	    rsvdDtlsUL = $(".rsvdDtls"),
	    userId = '${userId}',
	    revwRegFormUL = $(".revw_regForm"),
	    storeInfoUL = $(".store_info")
	;
	    
	let container,options,map,mapContainer,mapOption,markerPosition,marker;
	
	/* 페이징 로직*/
	let actionForm = $("#actionForm");
	
	$(".paginate_button a").on("click", function(e) {
		
		e.preventDefault();
		
		console.log("page click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
    /*get 함수*/
	// 예약의 '예약상세'를 가져온다.
    function getRsvdDtls(param,callback,error) {
    	
    	let rsvdId = param.rsvdId;
    	
    	$.getJSON("/dealight/business/manage/board/reservation/dtls/" + rsvdId + ".json",
    		function(data) {
    			if(callback) {
    				callback(data);
    			}
    	}).fail(function(xhr,status,err){
    		if(error) {
    			error();
    		}
    	});
    	
    }
	
    // 사용자의 '해당 매장'의 '예약 리스트'를 가져온다.
	function getUserRsvdList(param,callback,error) {
      	
      	let storeId = param.storeId,
      		userId = param.userId;
      	
      	//console.log(storeId);
      	//console.log(userId);
      	
      	$.getJSON("/dealight/business/manage/board/reservation/list/" + storeId +"/" + userId + ".json",
      		function(data) {
      			if(callback) {
      				callback(data);
      			}
      	}).fail(function(xhr,status,err){
      		if(error) {
      			error();
      		}
       	});
       	
       };
     
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
    /*
	유저의 예약 히스토리를 보여준다.

	*/
	function showUserRsvdList(storeId,userId,selRsvdId){
		
		getUserRsvdList({storeId:storeId,userId:userId}, function(userRsvdList){
			
			let strUserRsvdList = "";
			if(!userRsvdList)
				return;
			
			strUserRsvdList += "<h1>예약 히스토리</h1>";
			userRsvdList.forEach(rsvd => {
				strUserRsvdList += "========================================";
				strUserRsvdList += "<li>예약 번호 : "+rsvd.rsvdId+"</li>"; 
	            strUserRsvdList += "<li>매장번호 : "+ rsvd.storeId + "</li>";
	            strUserRsvdList += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
	            strUserRsvdList += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
	            strUserRsvdList += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
	            strUserRsvdList += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
	            strUserRsvdList += "<li>예약 시간 : "+ rsvd.time + "</li>";
	            strUserRsvdList += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
	            strUserRsvdList += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
	            strUserRsvdList += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
	            strUserRsvdList += "<li>예약 등록 날짜 : "+ rsvd.regdate + "</li>";
			});
			
			userRsvdListUL.html(strUserRsvdList);
			
			showRsvdDtls(selRsvdId);
			
		})
	};
	
	/*
	예약 상세를 보여준다.
	*/
	function showRsvdDtls(rsvdId){
		
		getRsvdDtls({rsvdId:rsvdId}, function(rsvd){
			
			let strRsvdDtls = "";
			if(!rsvd)
				return;
			
			strRsvdDtls += "<h1>해당 유저 예약 상세</h1>"
			strRsvdDtls += "<li>예약 번호 :" + rsvd.rsvdId +"</li>";
			strRsvdDtls += "<li>매장 번호 :" + rsvd.storeId +"</li>";
			strRsvdDtls += "<li>회원 아이디 : " + rsvd.userId +"</li>";
			strRsvdDtls += "<li>핫딜 번호 : " + rsvd.htdlId +"</li>";
			strRsvdDtls += "<li>승인 번호 : " + rsvd.aprvNo +"</li>";
			strRsvdDtls += "<li>예약 인원 : " + rsvd.pnum +"</li>";
			strRsvdDtls += "<li>예약 시간 : " + rsvd.time +"</li>";
			strRsvdDtls += "<li>예약 상태 : " + rsvd.stusCd +"</li>";
			strRsvdDtls += "<li>예약 총 가격 : " + rsvd.totAmt +"</li>";
			strRsvdDtls += "<li>예약 총 수량 : " + rsvd.totQty +"</li>";
			strRsvdDtls += "<li>예약 등록 날짜 : " + rsvd.regdate +"</li>";
			let cnt = 1;
			rsvd.rsvdDtlsList.forEach(dtls => {
				strRsvdDtls += "==============================";
				strRsvdDtls += "<li>상세 순서 [" + cnt +"]</li>";
				strRsvdDtls += "<li>예약 상세 번호 : " + dtls.rsvdSeq +"</li>";
				strRsvdDtls += "<li>예약 메뉴 이름 : " + dtls.menuNm +"</li>";
				strRsvdDtls += "<li>메뉴 가격 : " + dtls.menuPrc +"</li>";
				strRsvdDtls += "<li>메뉴 총 개수 : " + dtls.menuTotQty +"</li>";
				cnt += 1;
			})
			
			rsvdDtlsUL.html(strRsvdDtls);
			
		})
	};
	
    /* 리뷰 등록 폼을 보여준다.*/
    function showRevwRegForm(storeId,userId,rsvdId){
 	   
 	let strRevwRegForm = "";    			
 			
 	getStoreInfo({storeId : storeId}, store => {
 		
 		console.log("get store info..................");
    		
    		if(!store)
    			return;
    	
	       	
	       	strRevwRegForm += "<h1>리뷰 작성</h1>";
	       	strRevwRegForm += "<form id='revwRegForm' action='dsadasdas' method=''>";
	       	strRevwRegForm += "매장 번호 : <input name='storeId' value='"+store.storeId+"' readonly></br>";
	       	strRevwRegForm += "매장 이름 : <input name='storeNm' value='"+store.storeNm+"' readonly></br>";
	       	strRevwRegForm += "예약 번호 : <input name='rsvdId' value='"+rsvdId+"' readonly></br>";
	       	strRevwRegForm += "회원 아이디 : <input name='userId' value='"+userId+"' readonly></br>";
	       	strRevwRegForm += "리뷰 내용 : <input type='textarea' name='cnts' id=''></br>";
	       	strRevwRegForm += "평점 : <input type='number' name='rating' id=''></br>";
	       	strRevwRegForm += "파일첨부 : <div class='file_body'>"; 
	       	strRevwRegForm += "<div class='form_img'><input id='js_upload' type='file' name='uploadFile' multiple></div>";
	       	strRevwRegForm += "<div class='uploadResult'><ul></ul></div></div>";
	       	strRevwRegForm += "<input name='prevPage' value='reservation' id='' hidden>";
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
				
				for(let i = 0; i < files.length; i++){
					
					if(!checkExtension(files[i].name, files[i].size)) {
						return false;
		            }
		            /* uploadFile 이라는 변수명에 파일 배열(스프링에서는 MultipartFile[]로 받는다)을 달아서보낸다. */
					formData.append("uploadFile", files[i]);
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
	
	
	/* 이벤트 등록 */
    /*매장의 예약 리스트 보여주기*/
    $(".btn_rsvd_dtls").on("click", e => {
    	
    	console.log($(e.target).parent().find(".store_id").text());

    	let rstoreId = $(e.target).parent().find(".store_id").text(),
    		selRsvdId = $(e.target).parent().find(".rsvd_id").text(),
    		ruserId = '${userId}';
    		
    	
    	modal.css("display","block");

    	showUserRsvdList(rstoreId, ruserId, selRsvdId);
    	
    });
	
    /* 리뷰 등록 */
    $(".btn_revw_reg").on("click", e => {
    	
    	let storeId = $(e.target).parent().find(".store_id").text(),
    		rsvdId = $(e.target).parent().find(".rsvd_id").text(),
    		revwStus = $(e.target).parent().find(".revw_stus").text();
           	
        if(revwStus > 0) return;
    	
    	modal.css("display","block");
    	showRevwRegForm(storeId,userId,rsvdId);
    	
    	//$("#waitRegForm").submit();        		
    	
    });
    
    /* 매장 상세 */
    $(".btn_store_info").on("click", e => {
    	
    	let storeId = $(e.target).parent().find(".store_id").text()
    	
    	modal.css("display","block");
    	showStoreInfo(storeId);
    	
    	//$("#waitRegForm").submit();        		
    	
    });
    
    
	
	
	
}); /* document ready end*/



</script>
</body>
</html>