<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 현중 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>
<%@include file="../includes/mainMenu.jsp" %> 
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBGR7CBhUjuiLLWGac5u4u_5yN7n6CWO8w&libraries=places&callback=initAutocomplete" defer></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/main.css" type ="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="/resources/js/Rater.js"></script>
</head>
<body>
    <div class="main-container flex-column">
        <div class="main-header">
            <div class="image-container flex-column">
                <div class="search-container">
                    <div class="search-header flex f14">
                        <div class="w-block select-bar" id="wait">
                            <b>줄서기</b>
                            <div class="under-bar" style="display: none;"></div>
                        </div>
                        <div class="w-block" id="reserve">
                            <b>예약하기</b>
                            <div class="under-bar" style="display: none;"></div>
                        </div>
                    </div>
                    <div>
                        <div class="search-bar flex">
                            <div class="search-item" style="min-width: 300px;">
                                <div class="ws-block" id="region">
                                    위치
	                                <div class="dropdown" id="pac-container">
											<input class="form-control2" id="pac-input" type="text" name="keyword" placeholder="현재위치">
	                                </div>
                                </div>
                            </div>
                            <div class="divider" ></div>
                            <div id="timebox" class="search-item" style="min-width: 200px; display:none;">
                                <div class="ws-block" id="time">
                                    시간
                                    <div class="dropdown">
                                        <div class="dropdown-select">
                                            <span class="select">시간을 입력하세요</span>
                                            <i class="fa fa-angle-down" style="font-size:30px;"></i>
                                        </div>
                                        <div class="dropdown-list" style="height:300px">
                                           
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="divider"></div>
                            
                            <div class="search-item">
                                <div class="ws-block" style="min-width: 150px;" id="pNum">
                                    인원 
                                    <div class="dropdown" style="width: 80%; margin-right:10px">
                                        <div class="dropdown-select">
                                            <span class="select">2명</span>
                                            <i class="fa fa-angle-down" style="font-size:30px"></i>
                                        </div>
                                        <div class="dropdown-list" style="height:230px">
                                            
                                        </div>
                                    </div>
                                </div>
                                <button id="searchBtn" class="search-btn flex" style="flex-basis: 50px;">
                                    <i class="fas fa-search" style="color: white;"></i>
                                </button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="middle-header">
            핫딜상품
        </div>
        <div class="middle-container flex">
        	<c:forEach var="htdl" items="${htdl }">
            <div class="card js-htdl0" data-htdlid="${htdl.htdlId }">
                <div class="card-lmtpnum">
                    <div class="card-elaptime">
                        HOT
                    </div>
                    <h4 style="margin:20px; padding:1px">선착순 ${htdl.lmtPnum }명</h4>
                </div>
                <div class="card-img">
                    <img src="/display?fileName=/<c:out value='${htdl.htdlImg }'/>" alt="" style="width: 100%; height: 320px; z-index: -1;">
                    <div class="card-img-top"></div>
                    <div class="card-dc">
                        <span> <fmt:formatNumber value="${htdl.dcRate}" type="percent" groupingUsed="false" /></span>
                    </div>
                    <div class="card-price card-afterPrice">
                        <span>₩${htdl.befPrice - htdl.ddct }</span>
                    </div>
                    <div class="card-price card-beforePrice">
                        <span>₩${htdl.befPrice}</span>
                    </div>
                </div>
                <div class="card-body">
                    <div class="card-rate">
                        <div class="card-rating" data-rate-value=2></div>
                        <div class="card-curpnum">
                            <span><i class="fas fa-fire"></i></span>
                            
                        </div>
                    </div>
                    <div class="card-title">
                        <h3>[${htdl.brch }] ${htdl.name }</h3>
                    </div>
                    <div class="card-menu">
                        메뉴:&nbsp;<span>${htdl.setName }</span>
                    </div>
                    <div class="card-intro">
                        <div style="width: 40px; align-self: flex-start;">소개 : </div><span>${htdl.intro }</span>
                    </div>
                </div>
            </div>
        	</c:forEach>
        </div>
    </div>
    <div id=curTime></div>
    <form action="/dealight/search/" id="searchForm" method="get">
    	
    	<input type="hidden" name="region" value="내 주변">
    	<input type="hidden" name="lat" value="37.570414">
    	<input type="hidden" name="lng" value="126.985320">
    	<input type="hidden" name="pNum" value="2">
    </form>
<%@include file="../includes/mainFooter.jsp" %>


<script>


const msg = "<c:out value= '${result}'/>";

     $(".card-rating").rate({
        max_value: 5,
        step_size: 0.5,
        initial_value: 3,
        selected_symbol_type: 'utf8_star', // Must be a key from symbols
        cursor: 'default',
        readonly: true,
    });
    //예약하기 클릭 이벤트
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
        $("#searchForm").find("input[name='time']").remove();
    });

    $(".w-block").on("mouseenter",function(e){
        $(this).children(".under-bar").show("slow")
    });
    
    $(".w-block").on("mouseleave",function(e){
        $(this).children(".under-bar").hide("slow")
    });
    
    window.onload=function(){
    	const form = $("#searchForm");
		initAutocomplete
    	$("#searchBtn").on("click", function(e){
    		form.submit();
    	})
    }
    //위치 검색 하드코딩!!!!
  	function initAutocomplete() {
		autocomplete = new google.maps.places.Autocomplete(
		(document.getElementById('pac-input')), {
			types : [ 'geocode' ],
			componentRestrictions : {
				country : 'kr'
			}
		});
		console.log(autocomplete)
		autocomplete.addListener('place_changed', fillInAddress);
	}
	function fillInAddress() {
		var place = autocomplete.getPlace();
		console.log(place.formatted_address);
		console.log('?');
		if(!place.formatted_address){
			alert("위치정보가 정확하지 않습니다.")
			$("#pac-input").val("");
			$("#searchForm").find("input[name='lat']").val(37.570414)
	   		$("#searchForm").find("input[name='lng']").val(126.985320)
			return;
		}
		
		let addr = encodeURIComponent(place.formatted_address)
		getLoc(addr,function(data){
			if(data.meta.total_count == 0 ){
				alert("동을 입력해주세요")
				$("#pac-input").val("");
				$("#searchForm").find("input[name='lat']").val(37.570414)
		   		$("#searchForm").find("input[name='lng']").val(126.985320)
				return;
			}
	   		let addr = data.documents[0].address_name;
	   		let region = addr.substring(addr.lastIndexOf(" ")+1);
	   		console.log(data.documents[0].x);
	   		console.log(data.documents[0].y);
	   		console.log(region)
	   		$("#searchForm").find("input[name='region']").val(region)
	   		$("#searchForm").find("input[name='lat']").val(data.documents[0].y)
	   		$("#searchForm").find("input[name='lng']").val(data.documents[0].x)
			
		})
		
	}
	
	function getLoc(addr, callback, error){
		$.ajax({
	        url:'https://dapi.kakao.com/v2/local/search/address.json?query='+addr,
	        type:'GET',
	        headers: {'Authorization' : 'KakaoAK e511e2ddb9ebfda043b94618389a614c'},
		  	success:function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
				
			}
		})
		
	}
	
	function getCurTime(){
		let today = new Date();   
		
		let hours = today.getHours(); // 시
		let minutes = today.getMinutes();  // 분
		
		if(minutes < 30){
			minutes = 30;
		}else{
			minutes = "00";
			hours += 1;
		}
		return hours+":"+minutes;
	}
	
    $(document).ready(function(){
    	
    	if(msg.length > 0 ){
    		alert(msg);
    	}
    	
    	//[사용자에게 보여질값, 실제 값]
	    
	    //셀렉박스에 넣어줄 요소들
	    
	    let timeValue = [["09:00","09:00"], ["09:30","09:30"],["10:00","10:00"],["10:30","10:30"],
	        ["11:00","11:00"],["11:30","11:30"],["12:00","12:00"],["12:30","12:30"],["13:00","13:00"],["13:30","13:30"],
	        ["14:00","14:00"],["14:30","14:30"],["15:00","15:00"],["15:30","15:30"],["16:00","16:00"],["16:30","16:30"],["17:00","17:00"],
	        ["17:30","17:30"],["18:00","18:00"],["18:30","18:30"],["19:00","19:00"],["19:30","19:30"],["20:00","20:00"],["20:30","20:30"],
	       	["21:00","21:00"],["21:30","21:30"],["22:00","22:00"]];
    	let timeValues = [];
    	let isValidTime = false
    	for(let i = 0; i < timeValue.length; i++){
    		if((timeValue[i])[1] == getCurTime()){
    			console.log((timeValue[i])[1])
    			isValidTime = true;
    		}
    		if(isValidTime){
    			timeValues.push(timeValue[i])
    		}
    	}
	    let pNumValues = [["1명", "1"], ["2명", "2"], ["3명","3"], ["4명","4"]];
	    //아이디값을 넣어줄 inpu태그의 name으로 지정할것
    	const region = $("#region");
	    const time = $("#time");
	    const pNum = $("#pNum");
    	const form = $("#searchForm");
    	
    	//(클릭이벤트를 걸어줄 요소, 셀렉박스 요소값, 선택값을 추가할 form)
    	selectEvent(time ,timeValues, form)
    	selectEvent(pNum ,pNumValues, form)
    	
    	$(".card").on("click", function(e){
    		self.location = "/dealight/hotdeal/get/" + $(this).data("htdlid")
    	})
    	
    });
    
	function selectEvent(dropdown, values, searchForm){
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
        	
        	console.log(searchForm.find("input[name='"+name+"']").length);
        	let inputTag = searchForm.find("input[name='"+name+"']");
        	if(inputTag.length == 0){
        		let str =""
        		str += "<input type='hidden' name='"+ name +"' value='" + $(this).data("value") + "'>"
        		searchForm.append(str);
        		
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
	   
    
    
</script>
</body>
</html>