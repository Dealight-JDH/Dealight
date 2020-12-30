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
<%@include file="../includes/mainMenu.jsp" %> 
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
                            줄서기
                            <div class="under-bar" style="display: none;"></div>
                        </div>
                        <div class="w-block" id="reserve">
                            예약하기
                            <div class="under-bar" style="display: none;"></div>
                        </div>
                    </div>
                    <div>
                        <div class="search-bar flex">
                            <div class="search-item" style="min-width: 300px;">
                                <div class="ws-block" id="region">
                                    위치
                                    <div class="dropdown">
                                        <div class="dropdown-select">
                                            <span class="select">내 위치</span>
                                            <i class="fa fa-angle-down" style="font-size:30px"></i>
                                        </div>
                                        <div class="dropdown-list">
                                           
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="divider" ></div>
                            <div id="timebox" class="search-item" style="min-width: 200px; display:none;">
                                <div class="ws-block" id="time">
                                    시간
                                    <div class="dropdown">
                                        <div class="dropdown-select">
                                            <span class="select">13시 30분</span>
                                            <i class="fa fa-angle-down" style="font-size:30px;"></i>
                                        </div>
                                        <div class="dropdown-list">
                                           
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
                                        <div class="dropdown-list">
                                            
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
                    <h4>선착순 ${htdl.lmtPnum }명</h4>
                </div>
                <div class="card-img">
                    <img src="/display?fileName=/<c:out value='${htdl.htdlImg }'/>" alt="" style="width: 100%; height: 320px; z-index: -1;">
                    <div class="card-img-top"></div>
                    <div class="card-dc">
                        <span> <fmt:formatNumber value="${htdl.dcRate}" type="percent" groupingUsed="false" /></span>
                    </div>
                    <div class="card-price card-afterPrice">
                        <span>₩${htdl.befPrice }</span>
                    </div>
                    <div class="card-price card-beforePrice">
                        <span>₩${htdl.befPrice - htdl.ddct }</span>
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
    <form action="/dealight/search/" id="searchForm" method="get">
    	<input type="hidden" name="region" value="user">
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
    	$("#searchBtn").on("click", function(e){
    		
    		form.submit();
    	})
    }
</script>
<script>
    
    $(document).ready(function(){
    	
    	if(msg.length > 0 ){
    		alert(msg);
    	}
    	
    	//[사용자에게 보여질값, 실제 값]
	    let item1 = ["내 위치", "a"];
	    let item2 = ["종로구", "b"];
	    let item3 = ["평양","c"];
	    let item4 = ["화성","d"];
	    
	    //셀렉박스에 넣어줄 요소들
	    let values = [item1, item2, item3, item4];
	    let timeValues = [["09:00","09:00"], ["09:30","09:30"],["10:00","10:00"],["10:30","10:30"],
	        ["11:00","11:00"],["11:30","11:30"],["12:00","12:00"],["12:30","12:30"],["13:00","13:00"],["13:30","13:30"],
	        ["14:00","14:00"],["14:30","14:30"],["15:00","15:00"],["15:30","15:30"],["16:00","16:00"],["16:30","16:30"],["17:00","17:00"],
	        ["17:30","17:30"],["18:00","18:00"],["18:30","18:30"],["19:00","19:00"],["19:30","19:30"]];
	    let pNumValues = [["1명", "1"], ["2명", "2"], ["3명","3"], ["4명","4"]];
	    //아이디값을 넣어줄 inpu태그의 name으로 지정할것
    	const region = $("#region");
	    const time = $("#time");
	    const pNum = $("#pNum");
    	const form = $("#searchForm");
    	
    	//(클릭이벤트를 걸어줄 요소, 셀렉박스 요소값, 선택값을 추가할 form)
    	selectEvent(region ,values, form)
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