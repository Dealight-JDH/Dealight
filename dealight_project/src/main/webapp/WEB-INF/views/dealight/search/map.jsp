<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../../includes/mainMenu.jsp" %> 
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/selectbox.css" type ="text/css" />
<link rel="stylesheet" href="/resources/css/map.css" type ="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="/resources/js/Rater.js"></script>
<style type="text/css">
	div{
		 /* border: 1px black solid;  */
	}
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
</head>
<body>
    <div class="map-main-container">

        <div class="child-left left-container flex-column">
            <div class="child-full search-container flex-column">
                <div class="search-header-container flex">
                    <div class="search-header">
                        내 주변 음식점
                    </div>
                    <div class="selectbox flex">
                       <div class="label flex center" id="sortType">
	                        <div style="width: 40px; margin-top:2px">정렬</div>
	                        <div class="dropdown" style="display:inline-block; ">
	                            <div class="dropdown-select">
	                                <span class="select f14">거리순</span>
	                                <i class="fa fa-angle-down" style="font-size:20px"></i>
	                            </div>
	                            <div class="dropdown-list large-list m0">
	                               
	                            </div>
	                        </div>
	                    </div>
                    </div>
                </div>
                <div class="filter-container">
                    <div class="searchtype-container">
                        <div class="searchtype flex m-r16" id="wait">
                            <div class="p-l16">
                                줄서기
                            </div>
                            <div class="searchtype-img">
                                <i class='fas fa-user-plus fa-4x' style='color:#f43939;'></i>
                            </div>
                        </div>
                        <div class="searchtype flex" id="reserve">
                            <div class="p-l16">
                                예약하기
                            </div>
                            <div class="searchtype-img">
                                <i class='fas fa-utensils fa-4x' style='color:#f43939; padding-left: 20px;'></i>
                            </div>
                        </div>
                    </div>
                    <div class="m-b16">

                        <div class="filter flex">
                            <div class="filter-item filter-select"  id="filter">
                                <i class="fas fa-sliders-h"></i> Filter
                            </div>
                            <div class="filter-item filter-select" id="openStore" data-select="true">
                                <i class="fas fa-store-alt"></i> 영업중인매장
                            </div>
                        </div>

                        <form id="searchFilter" action="#" class="filter-items flex-column"style="display:none;">
                            <div class="column flex">
                            	<div class="selectbox flex">
			                       <div class="label flex center" id="sortPriority">
				                        <div style="width: 100px; margin-top:2px">우선정렬</div>
				                        <div class="dropdown" style="display:inline-block;min-width:150px;">
				                            <div class="dropdown-select">
				                                <span class="select f14">--</span>
				                                <i class="fa fa-angle-down" style="font-size:20px"></i>
				                            </div>
				                            <div class="dropdown-list large-list m0" style="width:100%">
				                               
				                            </div>
				                        </div>
				                    </div>
			                    </div>
                               
                                <div class="level">
                                    <input type="range" min="0" max="4" list="num" name="distance" />
                                    <datalist id="num">
                                        <option value="0.3" label="0.3km"/>
                                        <option value="0.5" label="0.5km"/>
                                        <option value="1" label="1km"/>
                                        <option value="3" label="3km"/>
                                        <option value="5" label="5km"/>
                                    </datalist>
                                </div>
                            </div>
                            <div class="column flex start">
                                <div class="filter-item" data-select="false">
                                    분위기 있는 곳
                                </div>
                                <div class="filter-item" data-select="false">
                                    밥먹는곳
                                </div>
                                <div class="filter-item" data-select="false">
                                    모임하기 좋은곳
                                </div>
                            </div>
                            <div class="cloumn flex end">
                                <button class="btn confirm" type="button" id="filterBtn">
                                    적용하기
                                </button>
                                <button class="btn cancle" type="button" onclick="closeFilter()">
                                    닫기
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <form id="searchForm" action="#">
                    <div class="search-bar flex center">
                            <div class="search-item" >
                                <div class="ws-block" id="region">
                                    <div>위치</div> 
                                    <div class="dropdown">
                                        <div class="dropdown-select">
                                            <span class="select m4 f16">내 위치</span>
                                            <i class="fa fa-angle-down" style="font-size:20px"></i>
                                        </div>
                                        <div class="dropdown-list">
                                           
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="divider" ></div>
                            <div class="search-item" id="timebox" style="display:none;">
                                <div class="ws-block" id="time"> 
                                    <div>시간</div> 
                                    <div class="dropdown">
                                        <div class="dropdown-select">
                                            <span class="select m4 f16">13시 30분</span>
                                            <i class="fa fa-angle-down" style="font-size:20px;"></i>
                                        </div>
                                        <div class="dropdown-list">
                                           
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="divider"></div>
                            
                            <div class="search-item">
                                <div class="ws-block" id="pNum">
                                    <div>인원</div> 
                                    <div class="dropdown" style="width: 70%; margin-right:10px">
                                        <div class="dropdown-select">
                                            <span class="select m4 f16">2명</span>
                                            <i class="fa fa-angle-down" style="font-size:20px"></i>
                                        </div>
                                        <div class="dropdown-list">
                                            
                                        </div>
                                    </div>
                                </div>
                                <button id="searchBtn" class="search-btn flex" style="flex-basis: 50px;">
                                    <i class="fas fa-search" style="color: white;"></i>
                                </button>
                            </div>

                        </div>
                    </form>
            </div>
            <div class="child-full" id="storeList">
                
            </div>
            <div id="pagination">
			</div>
        </div>
        <div class="child-right">
            <div class="map-container">
                <diV>
                    <div class="map" id="map">
                    </div>
                    <div style="display:flex; position:absolute;bottom:10px;left:150px;z-index:10;font-size:12px;">
						<button class="filter-item filter-select" onclick="moveToUser()" >내위치보기</button> 
	 					<button class="filter-item filter-select" onclick="searchMap()">현재위치애서 검색하기</button>
 					</div>
                </diV>
            </div>
        </div>
    </div>
    <form action="/search/" method="get" id="actionForm">
        <input type="text" name="pageNum" value="1">
        <input type="text" name="amount" value="10">
        <input type="text" name="lat" value="37.570414">
        <input type="text" name="lng" value="126.985320">
        <input type="text" name="distance" value="0.5">
        <input type="text" name="sortType" value="D">
        <input type="text" name="sortPriority" value="">
        <input type="text" name="openStore" value="true">
    </form>
</body>
<%@include file="/WEB-INF/views/includes/mainFooter.jsp" %>
<!-- 리스트 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e7b9cd1679ce3dedf526e66a6c1a860"></script>
<script type="text/javascript">
	//페이지가 시작된다.
	const searchButton = document.getElementById("#searchButton");
	const searchFilter = document.forms["searchFilter"];
	const list = document.getElementById("storeList");
	let actionForm = document.forms["actionForm"];
	let lat = actionForm.elements["lat"]
	let lng = actionForm.elements["lng"]
	let userLatLng = new kakao.maps.LatLng(lat.value, lng.value)
	let userId = '<c:out value="${userId}"/>' || null;
	let map = "";
	let markers=[];
	let overlays=[];
	

	//ajax로 리스트를 불러온다. cri, storeList ,paging관련 변수들이 다 넘어온다.
	//많아진다면 모듈로 뺴자
	function getList(callback,error){
		console.log("getList")
		$.ajax({
			type : 'get',
			url : '/dealight/getlist',
			contentType : "application/json; charset=utf-8",
			data : getObjToForm(actionForm),
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
				
			}
		});
		
	}
	
	//form data를 obj로 바꿔준다.
	function getObjToForm(form){
		let obj = Object();
		for(let i = 0 ; i < form.length ; i++){
			obj[form[i].name] = form[i].value;
			//console.log("key:" + form[i].name)
			//console.log("value:" + form[i].value)
		}
		obj["userId"] = userId;
		return obj;
	}
	
	
	window.onload = function(){
		//지도생성
		initMap();
		console.log("init")
		//메인에서 넘어오는 정보들 날짜, 인원, 검색어, 해시태그
		//검색정보를 받아온다. ( 인원, 시간, 지역, 해시태그)
		//매장메인을 보여준다.
		showMain();
		
		 //filter 토글버튼 이벤트
	    $("#filter").on("click", function(e){
	        console.log("click");
	        $(".filter-items").toggle('slow');
	    });

	    //아이템 클릭 이벤트
	    $(".filter-items .filter-item").on("click",function(e){
	        if($(this).attr("id")){
	            return;
	        }
	        if($(this).data("select")===true){
	            $(this).removeClass("filter-select");
	            $(this).data("select", false)
	        }else{
	            $(this).addClass("filter-select");
	            $(this).data("select", true)
	        }

	    });
	    
	    //영업중인매장(하드코딩......)
	    $("#openStore").on("click",function(e){
	    	let openStore = $(this).data("select")
	    	let result = true
	        if(openStore ===true){
	            $(this).removeClass("filter-select");
	            $(this).data("select", false)
	            result = false
	        }else{
	            $(this).addClass("filter-select");
	            $(this).data("select", true)
	        }
			actionForm.elements["openStore"].value = result ;
			showMain();
	    });
	    
	    
	 	//[사용자에게 보여질값, 실제 값]
	    let item1 = ["거리순", "D"];
	    let item2 = ["좋아요", "H"];
	    let item3 = ["평점순","R"];
	    let item4 = ["리뷰순","T"];
	    
	    //셀렉박스에 넣어줄 요소들
	    let sortValues = [["거리순", "D"], ["좋아요", "H"], ["평점순","R"], ["리뷰순","T"]];
	    let pNumValues = [["1명", "1"], ["2명", "2"], ["3명","3"], ["4명","4"]];
	    let priorityValues = [["--",""],["핫딜매장우선보기", "H"], ["식사가능매장우선보기", "S"], ["웨이팅있는매장보기","W"], ["예약가능매장보기","R"]];
	    let timeValues = [["09:00","09:00"], ["09:30","09:30"],["10:00","10:00"],["10:30","10:30"],
	        ["11:00","11:00"],["11:30","11:30"],["12:00","12:00"],["12:30","12:30"],["13:00","13:00"],["13:30","13:30"],
	        ["14:00","14:00"],["14:30","14:30"],["15:00","15:00"],["15:30","15:30"],["16:00","16:00"],["16:30","16:30"],["17:00","17:00"],
	        ["17:30","17:30"],["18:00","18:00"],["18:30","18:30"],["19:00","19:00"],["19:30","19:30"]];
    	//(클릭이벤트를 걸어줄 요소, 셀렉박스 요소값, 선택값을 추가할 form)
    	selectEvent($("#sortType") ,sortValues,  $("#actionForm"))
	    //정렬기준
	    $(".dropdown-list__item").on("click", function(e){
	    	console.log("change")
			showMain();
	    });
    	selectEvent($("#sortPriority"), priorityValues,  $("#searchFilter"))
    	const searchForm = $("#searchForm")
    	selectEvent($("#region") ,priorityValues, searchForm)
    	selectEvent($("#time") ,timeValues, searchForm)
    	selectEvent($("#pNum") ,pNumValues, searchForm)
	}
	
	function initMap(){
		let container = document.getElementById('map');
		let options = { center: userLatLng, level: 5 };
		map = new kakao.maps.Map(container, options);
		
		
		//지도위에 컨트롤러 생성하기
		map.addControl( new kakao.maps.ZoomControl(), kakao.maps.ControlPosition.TOPRIGHT);
		
		// 마커를 생성합니다
		let user = new kakao.maps.Marker({
		    position: userLatLng
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		user.setMap(map);
	}
	
	//searchFilter에 click이벤트를 등록한다.
	$("#filterBtn").on("click", function(e){
		e.preventDefault();
		let distance = searchFilter["distance"];
		console.log("searchBtn Click");
		
		//searchFilter의 내용을 actionForm에 적용시킨다.
		//정렬조건 적용
		//actionForm.elements["sortType"].value = searchFilter["sortType"].value
		//오픈매장보기 적용
		//actionForm.elements["openStore"].value = searchFilter["openStore"].checked;
		//우선순위 적용
		actionForm.elements["sortPriority"].value = $("#searchFilter").find("input[name='sortPriority']").val();
		//검색반경 적용
		actionForm.elements["distance"].value = distance.list.options[distance.value].value;
		//paging의 pageNum을 1로 변경
		actionForm.elements["pageNum"].value = 1;
		$(".filter-items").hide('slow');
		//showMain(); 호출
		showMain();
	})
	
	$("#searchBtn").on("click",function(e){
		e.preventDefault();
		
	})
	
	function searchMap(){
		var latlng = map.getCenter(); 
	   	console.log()
		lat.value = latlng.getLat();
		lng.value = latlng.getLng();
		
	    showMain();
	    
	}
		
	let storeId = '<c:out value="${store.storeId}"/>';
	//핫딜관련 로직
	function getHtdl(storeId, callback, error){
		
		
		$.getJSON("/dealight/store/htdl/get/"+storeId+".json", function(data){
			if(callback){
				callback(data);
			}
			
		}).fail(function(xhr,status, err){
			if(error){
				error();
			}
		});
	}
	
			//ajax통신을 한다.데이터만 받아오고 끝낸다.
			//확인하고 
			//처리하고 
			//하나씩 처리
			//분리시킨다.
			//문서를 계속 업데이트하면서 고쳐라
			//최대한 쪼개라 다시합쳐라!!!!! 급하게하는 습관없에자
			
			
	//mainPage를 불러오는 함수
	function showMain(){
		//let scroll = document.getElementById("storeList");
		//scroll.scrollTop = 0;
		console.log("showMain")
		//입력 작업 출력(응집) 
		getList(function(pageDTO){
			
			//페이지 목록을 출력한다.
			showList(pageDTO);
			
			//지도에 마커표시를한다.
			showMap(pageDTO.storeList);
		});
		
		$(document).scrollTop(0);
		
	}
	
	function showMap(storeList){
		
		//기존마커 삭제
		deleteMaker();
		//검색결과 체크
		if(storeList.length==0 || storeList == null){
			return;				
		}
		//지도의 레벨과 범위를 정해주는 변수
		//이거 잘 생각해보자 뭔가 어색해 이방법.......(모든 마커가 보이게 하려고 하는 방법인데 뭔가 더 좋은 방법이 없을까??)
		const bounds = new kakao.maps.LatLngBounds();
		const imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		
		let positions = [];
		
		for(let i = 0; i<storeList.length; i++) {
			let storeLatLng =new kakao.maps.LatLng(storeList[i].lat, storeList[i].lng)
			
			let marker =new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: storeLatLng, // 마커를 표시할 위치
		        image : new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(24, 35))// 마커 이미지
		    });
			let src = "/display?fileName=" + storeList[i].repImg;
			let content = '<div class="wrap wrap'+i+'" data-storeid="'+storeList[i].storeId+'" style="display:none">' + 
            '    <div class="info">' + 
            '        <div class="title" style="background-color:#f43939; color:white; opacity:0.9;">' +storeList[i].storeNm+
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="img">' +
            '                <img src="'+ src +'" width="73" height="70">' +
            '           </div>' + 
            '            <div class="desc">' 
            if(storeList[i].seatStusCd == 'R'){
            	content +='<span style="padding:2px; margin:5px"><i class="fas fa-user-clock" style="color:red"></i></span>현재 2명이 대기중이에요~'
			}
			if(storeList[i].seatStusCd == 'Y'){
				content +='<span style="padding:2px; margin:5px"><i class="fas fa-user-clock" style="color:coral"></i></span> 서두르세요 몇 자리 안남았어요~'
			}
			if(storeList[i].seatStusCd == 'G'){
				content +='<span style="padding:2px; margin:5px"><i class="fas fa-user-clock" style="color:green"></i></span> 바로 식사가능해요~'
			}
			if(storeList[i].seatStusCd == 'B'){
				content +='영업중이 아니에요.....'
			}
            
			content +='                <div class="jibun ellipsis">'+storeList[i].addr+'</div>' + 
            '                <div><b>대표메뉴 : </b>'+ storeList[i].repMenu + '</div>' + 
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';
			
		    //let infoStore = new kakao.maps.InfoWindow({
		    //    content: "<div class='filter-item' data-storeid='"+storeList[i].storeId+"'>"+storeList[i].storeNm+"</div>" // 인포윈도우에 표시할 내용
		    //});
		    let infoStore = new kakao.maps.CustomOverlay({
		        content: content,
		        map: map,
		        position: marker.getPosition()
		    });
		    
			addMarkerEvent(marker,infoStore,i,storeList[i].storeId);
			
		    markers.push(marker);
		    
		    //지도범위를 설정해주는 메서드
			bounds.extend(storeLatLng);
			bounds.extend(getOpposition(storeLatLng));
		}
		
		map.setBounds(bounds);
		
	}
	
	//s_를 잘라내는 함수
	function subSrc(photoSrc){
		let srcObj = {};
		let index = photoSrc.lastIndexOf("/");
		
		srcObj["uploadPath"] = photoSrc.substring(0,index);
		srcObj["fileName"] = photoSrc.substring(index + 1);
		srcObj["realFileName"] = photoSrc.substring(photoSrc.indexOf("_") + 1); 
		//console.log("realFilename : " +photoSrc.substring(photoSrc.indexOf("_") + 1))
		let fileCallPath = encodeURIComponent( "/"+ srcObj["uploadPath"] +"/"+ srcObj["realFileName"]); //원본
		return "/display?fileName=" + fileCallPath;
	}
	//매장목록을 출력하는 함수
	function showList(pageDTO){
		let str = "";
		list.innerHTML="";
		const storeList = pageDTO.storeList;
		console.log(storeList);
		if(storeList==null || storeList.length==0){
			list.innerHTML = "검색결과가 없습니다."
			return;
		}
		//console.log(storeList)
		for( let i=0, len=storeList.length||0; i<len; i++){
			let src ='';
			//console.log(storeList[i].repImg)
			if(storeList[i].repImg != null){
				let storePhotoSrc = storeList[i].repImg
				src = "/display?fileName=" + storePhotoSrc;
				
				//console.log("================store 이미지: " + fileCallPath);
			}else{
				//대체사진 등록
				src = "https://via.placeholder.com/200x200"
			}
			
			if(storeList[i].like ==true){
				likeIcon = "fas fa-heart"
			}else{
				likeIcon = "far fa-heart"
			}
			
			//str += "<a href='/dealight/store/"+storeList[i].storeId+" '>"
			str +='<div class="store-card flex-column" data-storeid="'+storeList[i].storeId+'">'
			str +='<div class="flex">'
			str +='<div class="img-container" style="margin-right:20px">'
			str +='<img src="' +src + '" style="width:100%" ></div>'
			str +='<div class="deatial-container flex-column" >'
			str +='<div class="search-header flex">'
			str += storeList[i].storeNm
			//like - gk
			str +='<div  class="like" data-storeid="'+storeList[i].storeId+'" data-like="'+ storeList[i].like +'">'
			str +='<i class="'+ likeIcon +'" style="color:red"></i></div>'
			
			
			str +='<span class="f14">'+storeList[i].likeTotNum+'</span></div>'
			str +='<div class="flex rating-box">'
			str +='<div class="rating" data-rate-value="'+ storeList[i].avgRating +'"></div>'
			str +='<div class="f14">'+storeList[i].revwTotNum+'('+storeList[i].avgRating+')</div></div>'
			str +='<div class="f14 m-tb2">'
			str +='<span style="padding:2px; margin:5px"><i class="fas fa-store-alt"></i></span>'
			str +='<b >매장영업시간 : </b>'+ storeList[i].openTm + "~" + storeList[i].closeTm + '</div>'
			str +='<div class="f14 m-tb2">'
			str +='<span style="padding:2px; margin:5px; margin-right:12px"><i class="fas fa-utensils"></i></span>'
			str +='<b>대표메뉴 : </b>'+ storeList[i].repMenu + "</div>";
			str +='<div class="m-tb2">'
			if(storeList[i].seatStusCd == 'R'){
				str +='<span style="padding:2px; margin:5px"><i class="fas fa-user-clock" style="color:red"></i></span>현재 2명이 대기중이에요~'
			}
			if(storeList[i].seatStusCd == 'Y'){
				str +='<span style="padding:2px; margin:5px"><i class="fas fa-user-clock" style="color:coral"></i></span> 서두르세요 자리가 얼마안남았어요~'
			}
			if(storeList[i].seatStusCd == 'G'){
				str +='<span style="padding:2px; margin:5px"><i class="fas fa-user-clock" style="color:green"></i></span> 바로 식사가능해요~'
			}
			if(storeList[i].seatStusCd == 'B'){
				str +='영업중이 아니에요.....'
			}
			str +='</div><div class="btns felx">'
			if(storeList[i].htdlStusCd == "A"){
				str += '<button class="btn-big htdlBtn" data-storeid="'+storeList[i].storeId+'">핫딜중</button>'; 
			}
			if(storeList[i].htdlStusCd == "P"){
				str += '<button class="btn-big">핫딜예정</button>'
			}
			if(storeList[i].seatStusCd == "R"){
				str += '<button class="btn-big">줄서기</button>' 
			}
			str += '</div></div></div>'
			str += '<div class="htdl flex htdl'+storeList[i].storeId+'" data-storeid="'+storeList[i].storeId+'" style="display:none"></div>'//</a>'
			str += '</div>'
		}
		list.innerHTML = str;
		
		//매장이동이벤트
		$(".store-card").on("click", function(e){
			location.href = "/dealight/store/"+ $(this).data("storeid");
		})
		
		//좋아요 이벤트
		$(".like").on("click", function(e){
			e.stopPropagation();
			let storeId = $(this).data("storeid");
			let like = $(this).data("like");
			console.log(like);
			console.log(storeId)
			if(!isLogin()){
				alert("로그인을 해주세요");
				return;
			}
			//하드코딩.........제발...
			if(like === true){
				let str="<i class='far fa-heart' style='color:red;'/></i>";
				$(this).empty().append(str);
				$(this).data("like", false);
				removeLike({userId:"<c:out value='${userId}'/>",storeId:storeId});
				console.log($(this).next()[0].innerHTML)
				$(this).next()[0].innerHTML = $(this).next()[0].innerHTML-1
			}
			if(like === false){
				let str="<i class='fas fa-heart' style='color:red;'/></i>";
				$(this).empty().append(str);
				$(this).data("like", true)
				addLike({userId:"<c:out value='${userId}'/>",storeId:storeId});
				console.log($(this).next())
				$(this).next()[0].innerHTML = $(this).next()[0].innerHTML-0+1
				alert("찜목록에 추가했습니다.")
			}
			
		})
		
		$(".rating").rate({
		    max_value: 5,
		    step_size: 0.5,
		    initial_value: 3,
		    selected_symbol_type: 'utf8_star', // Must be a key from symbols
		    cursor: 'default',
		    readonly: true,
		});
		
		//핫딜버튼
		$(".htdlBtn").on("click", function(e){
			e.stopPropagation();
			let storeId = $(this).data("storeid")
			console.log($(this).data("isLoaded"))
			let isLoaded = $(this).data("isLoaded") || null;
			if(isLoaded ==null){
				
				getHtdl(storeId,function(htdl){
					//핫딜 창을 만들어야한다.
					console.log(htdl);
					console.log(storeId);
					src = "/display?fileName=" + htdl.htdlImg;
					let str ='';
	                str+='<div class="card-img">'
	                str+='<img src="'+src+'" alt="" style="width: 200px; height: 200px; z-index: 0;">'
					str+='<div class="card-img-top"></div>'
					str+='<div class="card-dc">'
					str+='<span>'+htdl.dcRate * 100+'%</span>'
					str+='</div>'
					str+='<div class="card-price card-afterPrice">'
					str+='<span>₩'+htdl.befPrice +'</span>'
					str+='</div>'
					str+='<div class="card-price card-beforePrice">'
					str+='<span>₩'+(htdl.befPrice - htdl.ddct) +'</span>'
					str+='</div>'
					str+='</div>'
					str+='<div class="deatial-container flex-column m-l16" style="width: 100%;">'
					str+='<div class="card-title">'
					str+='<h3>['+htdl.brch +'] '+htdl.name +'</h3>'
					str+='</div>'
					str+='<div class="card-menu">'
					str+='메뉴:&nbsp;<span>디저트 콤보 1인 세트</span>'
					str+='</div>'
					str+='<div class="card-intro">'
					str+='<div style="width: 40px; align-self: flex-start;">소개 : </div><span>'+htdl.intro +'</span>'
					str+='</div>'
					str+='</div>'
					
					$(".htdl"+storeId)[0].innerHTML = str;
				});
					$(this).data("isLoaded",true)
			}
			
			$(".htdl"+storeId).toggle();
		});
		
		//페이징처리
		showPaging(pageDTO)
		
	}// end showList
	
	function isLogin(){
		let userId = "<c:out value='${userId}'/>"
		if(userId ==='' || userId === null){
			return false
		}
		return true;
	}
	
	
	
	function addLike(params,callback,error){
    	let storeId = params.storeId,
    		userId = params.userId;
        $.ajax({
            type:'post',
            url:'/dealight/mypage/like/add/'+userId+'/'+storeId,
            contentType : "application/json",
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }               
            }
        });
		
	}
	
	function removeLike(params,callback,error) {
    	
    	let storeId = params.storeId,
    		userId = params.userId;
    	
        $.ajax({
            type:'delete',
            url:'/dealight/mypage/like/remove/'+userId+'/'+storeId,
            data : {'userId' : userId, 'storeId':storeId},
            contentType : "application/json",
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }               
            }
        });
        
    }
	
	//페이징 처리를 하는 함수.
	function showPaging(pageDTO){
		
		let str = "";
		const paging = document.getElementById("pagination");
		
		if(pageDTO.prev){
			str += "<a href='"+(pageDTO.startPage -1)+"'>Previous </a>"
		}
		for(let i = pageDTO.startPage;i<pageDTO.endPage+1;i++){
			str += (pageDTO.cri.pageNum == i ?"<":"");
			str += "<a href='"+ i +"' >"+i+" </a> ";
			str += (pageDTO.cri.pageNum == i ?">":"");
		}
		if(pageDTO.next){
			str += "<a href='"+(pageDTO.endPage + 1)+"'>Next </a>";
		}
		
		paging.innerHTML = str;
		//a태그 관련 이벤트는 a태그가 생성될때 등록해준다.
		$("#pagination a").on("click", addPageEventHandler);
		
	}
	
	//페이지 번호클릭시 발생이벤트
	function addPageEventHandler(e){
		
		e.preventDefault();
		//actionForm에 내용을 업데이트한다.
		actionForm.elements["pageNum"].value = this.attributes["href"].value;
		//해당페이지에 해당하는 ajax통신을 요청한다.
		showMain();	
	
	}
	
	//마커들을 가지고있는 배열
	function deleteMaker(){
		for(let i =0; i<markers.length; i++){
			markers[i].setMap(null)
			overlays[i]=null
		}
	}	
	
	
	function getOpposition(storeLatLng){
		const diffLat = lat.value - storeLatLng.getLat();
		const diffLng = lng.value - storeLatLng.getLng();
		
		return new kakao.maps.LatLng(Number(lat.value) + diffLat, Number(lng.value) + diffLng);
	}
	
	function addMarkerEvent(marker,infoStore,i,storeId){
		//console.log(i);
	    //let store = document.getElementById("storeList");
		
		kakao.maps.event.addListener(marker, 'mouseover', function() {
	
			$(".wrap"+i).show()
	           list.childNodes[i].style.backgroundColor="#bbb";
	        
	    });
		
		kakao.maps.event.addListener(marker, 'mouseout', function() {
	
			$(".wrap"+i).hide()
	           list.childNodes[i].style.backgroundColor="white";
	        
	    });
		
		kakao.maps.event.addListener(marker, 'click', function() {
			console.log("click")
			let target = $(".htdl"+storeId)
			$(document).scrollTop(target.offset().top -500)
			
	
	    });
	
	    
	}
	
	function moveToUser() {
	    // 이동할 위도 경도 위치를 생성합니다 
	    // 현재 내위치로가 경로필요
	    var moveLatLon = new kakao.maps.LatLng(37.570414, 126.98532);
	    map.setLevel(3);
	    map.panTo(moveLatLon);            
	}        
	
	function closeFilter(){
	    //처음 필터조건을 기억하고 닫기버튼을 누르면 초기조건으로 되돌리고 닫아야한다.
	    $(".filter-items").hide('slow');
		
	}
	
	function selectEvent(dropdown, values, form){
	    const list = dropdown.find(".dropdown-list");
	    const selectValue =dropdown.find(".select");
	   	let name = dropdown.attr("id");
		
	    //셀렉박스 클릭 이벤트
        dropdown.on('click', function(e){
        	e.stopPropagation();
			list.css("opacity","1")
	    	
	    	if(list.css("visibility") ==="visible"){
	    		list.css("visibility","")
	    		return
	    	}
	        list.css("visibility","visible");
        });
	    
	    //셀렉박스 외부 클릭시 이벤트
        $(document).click(function(){
        	list.css("visibility","") 
        });
        
      	//select 아이템 추가
        let str = addItem(values);
        list.append(str);
        
        //셀렉박스 요소 선택 이벤트
        dropdown.find(".dropdown-list__item").on("click", function(e){
        	//클릭시 셀렉박스에 내용 반영
            selectValue.html($(this).html());
        	
        	let inputTag = form.find("input[name='"+name+"']");
        	console.log(inputTag);
        	console.log($(this).data("value"))
        	if(inputTag.length == 0){
        		let str =""
        		str += "<input type='hidden' name='"+ name +"' value='" + $(this).data("value") + "'>"
        		form.append(str);
        		
        		return;
        	}
        	//간단하게 form 요소만 변경(기존에 있어야함)
            inputTag.val($(this).data("value"));
        	
        });
        
      	//select 아이템 추가 함수
        function addItem(values){
           let str ="";
           for(let index in values){
           		str += "<div class='dropdown-list__item' data-value='"+(values[index])[1]+"'>"+(values[index])[0]+"</div>";
           }
           return str;
        		
        }
      	
   	};
	$("#reserve").on("click", function(e){
    	
        $(this).addClass("select-bar");
        
        $(this).prev().removeClass("select-bar")
        //시간 셀렉박스를 보여준다.
        $("#timebox").show("slow");
    });
    
    $("#wait").on("click", function(e){
    	
        $(this).addClass("select-bar");
        
        $(this).next().removeClass("select-bar")
        
        //시간 셀렉바스를 숨긴다.
        $("#timebox").hide("slow");
        
        //form에서 time을 지워준다.
        $("#form").find("input[name='time']").remove();
    });

    
    
    
</script>
</body>
</html>