<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script src="/resources/js/Rater.js"></script>
<style>
	
	* { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/

    margin  : 0;   /* 값이 0일 때는 단위 안씀. */
    border  : 0;
    padding : 0;
    font-family: 'Nanum Gothic', sans-serif;
    }

    body{
        background-color: whitesmoke;
    }

    /* div{
        border: 1px solid red;
    } */
    
/*     .nav-bar{
        display: flex;
        
        height: 60px;
        justify-content: center;
        border: 1px solid red;
        align-items: center;
        background-color: #d32323;
        color: white;
    } */

    .main-container{
        display: flex;
        /* position: relative; */
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-width: 1050px;
        height: auto;
        padding-bottom: 36px;
        
    }
    

    .search-container{
        display: flex;
        width: 95%;
        height: 80px;
        flex-direction: row;
        justify-content: center;
        /* position: absolute; */
        align-items: center;
        margin-top: 20px;
        /* margin: 16px 40px 10px 150px; */
        padding: 6px 0px;
    }

    .search-wrap{
        display: flex;
        position: relative;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        width: 60%;
        height: 100%;
    }

    .search-form{
        display: flex;
        width: 80%;
        /* height: 70%; */
        border: 1px solid rgb(221, 221, 221);
        color: rgb(34,34,34 );
        height: 66px;
        position: relative;
        border-radius: 32px;
        box-shadow: rgba(0, 0, 0, 0.15) 0px 16px 32px, rgba(0, 0, 0, 0.1) 0px 3px 8px;
        background-color: rgb(247, 247, 247);
        /* border: 1px solid red; */
    }

    .css-regionLabel{
        display: block;
        cursor: pointer;
        /* position: absolute; */
        /* top:6px;
        left: 30px; */
        width: 100%;
        /* height: 68px; */
        /* margin: 20px 30px; */
        border-radius: 32px;
        padding: 15px 30px;


        /* background-clip: padding-box;
        border: 1px solid transparent;
        border-radius: 32px;
        bottom: 0;
        content:"";
        left: 0;
        position: absolute;
        right: 0;
        top: 0;
        z-index: 0; */

    }

    /* .css-regionLabel:after{
        background-clip: padding-box;
        border: 1px solid transparent;
        border-radius: 32px;
        bottom: 0;
        content:"";
        left: 0;
        position: absolute;
        right: 0;
        top: 0;
        z-index: 0;
    }  */

    .select-regionLabel{
        display: block;
        cursor: pointer;
        
        border-radius: 32px !important;
        /* padding: 6px 0; */
        position: absolute !important;
        background-clip: padding-box !important;
        border: 1px solid rgb(255,255,255);
        border-radius: 32px;
        padding: 15px 30px;
        /* padding: 6px 30px; */
        background-color: rgb(255,255,255);
        box-shadow: rgb(0,0,0,0.2) 0 6px 20px;
        z-index: 1;
    }

    .select-startTimeLabel{
        display: block;
        cursor: pointer;
        
        border-radius: 32px !important;
        /* padding: 6px 0; */
        position: absolute !important;
        background-clip: padding-box !important;
        border: 1px solid rgb(255,255,255);
        border-radius: 32px;
        padding: 15px 15px;
        /* padding: 6px 30px; */
        background-color: rgb(255,255,255);
        box-shadow: rgb(0,0,0,0.2) 0 6px 20px;
        z-index: 1;
    }


    .select-endTimeLabel{
        display: block;
        cursor: pointer;
        
        border-radius: 32px !important;
        /* padding: 6px 0; */
        position: absolute !important;
        background-clip: padding-box !important;
        border: 1px solid rgb(255,255,255);
        border-radius: 32px;
        padding: 15px 15px;
        /* padding: 6px 30px; */
        background-color: rgb(255,255,255);
        box-shadow: rgb(0,0,0,0.2) 0 6px 20px;
        z-index: 1;
    }


    /* .select-label:after{
        background-clip: padding-box;
        border: 1px solid rgb(255,255,255);
        border-radius: 32px;
        padding: 14px 32px;
        background-color: rgb(255,255,255);
        box-shadow: rgb(0,0,0,0.2) 0 6px 20px;
        z-index: 3;

    } */

    
    .hotdeal-container{
        display: flex;
        width: 85%;
        height: auto;
        /* position: absolute; */
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: center;
        align-content: center;
        margin-top: 30px;
        /* left: 33px; */
    }

    .hotdealState-wrap{
       	display: flex;
        align-items: center;
        align-items: flex-end;
        width: 100%;
        height: 40px;
        margin-top: 20px;
        margin-left: 30px;
        /* margin-bottom: 10px; */
        /* border: 1px solid red; */
    }

    /* .region-input{
        display: flex;
        align-items: center;
        position: absolute;
        width: 30%;
        height: 80%;
        left: 115px;
    } */

    .css-region{
        display: flex;
        position: relative;
        align-items: center;
        width: 100%;
        height: 100%;
        /* border: 1px solid red; */
    }

    .label-region{
        line-height: 16px;
        font-weight: 800;
        font-size: 12px;
        padding-bottom: 2px;
        /* padding-bottom: 2px; */
    }

    .css-label:hover {
	    background-color: rgba(0, 0, 0, 0.1);
    }

    .region-box{
        display: flex;
        width: 205px;
        height: 100%;
    }

    .startTime-box{
        display: flex;
        width: 180px;
        height: 100%;
        /* border: 1px solid red; */
    }

    .css-startTime{
        display: flex;
        position: relative;
        align-items: center;
        width: 100%;
        height: 100%;
        /* border: 1px solid red; */
    }

    .css-startTimeLabel{
        display: block;
        cursor: pointer;
        width: 100%;
        border-radius: 32px;
        padding: 15px 0 15px 30px;
        /* border: 1px solid red; */
    }

    .endTime-box{
        display: flex;
        width: 180px;
        height: 100%;
        /* border: 1px solid red; */
    }
    
    .css-endTime{
        display: flex;
        position: relative;
        align-items: center;
        width: 80%;
        height: 100%;
        /* border: 1px solid red; */
        
    }

    .css-endTimeLabel{
        display: block;
        cursor: pointer;
        width: 63%;
        border-radius: 32px;
        padding: 15px 30px;
        /* border: 1px solid red; */
    }

    .time-input{
        display: flex;
        align-items: center;
        position: absolute;
        width: 30%;
        height: 80%;
        left: 350px;
    }

    /* .search-btn{
        position: absolute;
        width: 10%;
        height: 80%;
        padding-top: 22px;
        left: 590px;
    } */

    .css-border{
        border-radius: 4px 0 0 4px;
    }

    .css-input{
        position: absolute;
        margin: 6px;
        padding: 10px 12px;
        width: 95%;
        height: 40px;
        /* border: 1px solid black; */
        background: #fff;
        box-sizing: border-box;
        box-shadow: 0px 0px 3px 1px silver;
    }

    .css-select{
        position: absolute;
        margin: 6px;
        padding: 10px 12px 10px 30px;
        width: 95%;
        height: 40px;
        /* border: 1px solid black; */
        background: #fff;
        box-sizing: border-box;
        box-shadow: 0px 0px 3px 1px silver;
        /* overflow:scroll; */
        
    }
    .css-select:focus{
        top: 8px;
        height: 80px;
    }

    .css-input>input{
        /* z-index: 1; */
        background: transparent;
        width: 100%;
        height: 22px;
        font-size: 16px;
        overflow: hidden;
        outline: none;
        /* border: 1px solid black; */
        /* box-sizing: border-box; */
    }

    .btn-search{
        /* border-radius: 0 4px 4px 0;
        background: #f43939; */
        width: 30px;
        height: 35px;
        outline: none;
        
    }

    .search-btn>span{
        display: flex;
        border-radius: 0 4px 4px 0;
        background: #f43939;
        justify-content: center;
        align-items: center;
        width: 40px;
        height: 32px;
        padding: 5px;
        
    }

    .card{
        position: relative;
        width: 30%;
        height: 30%;
        /* height: 480px; */
        margin: 10px 10px;
        /* margin: 16px; */
        overflow: hidden;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
        padding: 4px;
        transition: 0.3s;
    }

    .card:hover{
        box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
    }

    /* .card-body{

    } */

    .card-lmtpnum{
        display: flex;
        /* flex-direction: row; */
        position: relative;
    }

    .card-elaptime{
        /* width: 70px; */
        width: 100%;
        height: 20px;
        padding: 3px;
        color: #d32323;
        font-weight: bold;
    }

    .card-lmtpnum>h4{
        position: absolute;
        right: 0;
        top: 2px;
        margin-left: 3px;
        margin-bottom: 3px;
        padding: 3px;
        /* z-index: 1; */
    }
    .card-title{
        display: flex;
        padding: 3px;
        align-items: center;
        height: 40px;
        background-color: #FBF0F0;
        /* background: #d32323; */
        /* color: white; */
        color: black;
    }
    
    .card-menu{
        display: flex;
        padding: 6px;
        align-items: center;
        font-weight: bold;
    }

    .card-intro{
        display: flex;
        padding: 6px;
        align-items: center;
        font-size: 12px;
    }

    .card-rating{
        display: flex;
        flex-direction: row;
        /* position: relative; */
        padding: 3px;
        font-size: 24px;
        color: #F29F05;
        
    }

    .card-curpnum{
        position: absolute;
        display: flex;
        /* position: absolute; */
        right: 0;
        
    }

    .opacity{
        background-color: #FFFFFF;
        opacity: 0.4;
    }
    
    .arrow-box{
        visibility: hidden;
        display: flex;
        justify-content: center;
        /* flex-direction: row; */
        /* justify-content: flex-start; */
        /* align-items: flex-start; */
        width: 75px;
        height: 50px;
        background-color: #ffffff;
        color:  #d32323;
        text-align: center;
        font-size: 14px;
        font-weight : bold;
        border-radius: 6px;
        padding: 10px 15px;
        box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.700);
        /* Position the dealight_tooltip */
        position: absolute;
        top : 25px;
        right: 8px;
        z-index: 1;
    }

    span:hover{
        opacity: 0.7;
    }

    span:hover + p.arrow-box{
        visibility: visible;
        opacity: 1;
    }

    .card-rate{
        display: flex;
        position: relative;
        flex-direction: row;

    }
    .card-curpnum>span{
        display: flex;
        justify-content: center;
        align-items: center;
        width: 24px;
        height: 24px;
    }

    .card-img{
        display: flex;
        position: relative;
        width: 100%;
        height: 320px;

    }

    .card-img-top{
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: linear-gradient(to top, rgba(0,0,0,0.4) 0%, transparent);
    }

    .card-dc{
        display: flex;
        justify-content: center;
        align-items: center;
        position: absolute;
        background: #D32323;
        border-radius: 3px;
        width: 45px;
        height: 25px;
        left: -2px;
        bottom: 10px;
        z-index: 1;
    }

    .card-dc>span{
        font-weight: bold;
        color:  white;
    }

    .card-price{
        display: flex;
        justify-content: center;
        align-items: center;
        position: absolute;
        /* background: #ffffff; */
        border-radius: 3px;
        z-index: 1;
    }

    .card-beforePrice{
        width: 70px;
        height: 20px;
        right: 0;
        bottom: 35px;
        /* font-size: 14px; */
        text-decoration: line-through;
        color: white; 
    }

    .card-afterPrice{
        width: 80px;
        height: 35px;
        color:  whitesmoke;

        font-weight: 900;
        font-size: 19px;
        right: 5px;
        bottom: 0;

        /* font-weight: bold;
        font-size: 18px;
        right: 0;
        bottom: 0; */
    }

    .panel-footer{
        display: flex;
        width: 100%;
        height: 200px;
        position: absolute;
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: center;
        align-content: center;
        bottom: -200px;
        /* margin-top: 60px; */
        /* left: 33px; */
    }

    ul{
        display: flex;
        flex-direction: row;
    }

    li{
        /* display: flex;
        flex-direction: row; */
        list-style: none;
        /* outline: 1px solid red; */
    }
    .pagination a{
        color: black;
        padding: 8px 16px;
        border-radius: 5px;
        border: 1px solid #ddd;
        text-decoration: none;
    }

    .pagination a.active{
        background-color: #d32323;
        border-radius: 5px;
        color: white;
    }

    .pagination a:hover:not(.active){
        background-color: #ddd;
    }

    .panel-footer1{
        margin-top: 50px;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        width: 100%;
        height: 100px;
    }

    .time-input>span{
        position: absolute;
        left: 10px;
        top: 20px;
        z-index: 1;
    }

    /* .hotdeal-wrapper{
        display: flex;
        width: 100%;
        position: absolute;
        height: auto;
        margin-top: 10px;
    } */

    #region_input{
        outline: none;
        background: none;
    }

    #startTime_input{
        outline: none;
        background: none;
    }

    #endTime_input{
        outline: none;
        background: none;
    }

    .search-btn{
        display: flex;
        position: absolute;
        
        border-radius: 24px;
        height: 48px;
        width: 48px;
        align-self: center;
        justify-content: center;
        align-items: center;
        background-color: #f43939;
        left: 590px;
        outline: none;
        cursor: pointer;

    }

    .divider{
        height: 10px;
        border: 1px gray solid;
        align-self: center;
    }

    .dropdown {
        width: 100%;
        position: relative;
    }

    .dropdown-list {
        opacity: 1;
        visibility: visible;
    }
    .dropdown-select {
        padding-top: 6px;
        border-radius: 20px;
        width: 100%;
        height: 10px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        font-size: 18px;
        cursor: pointer;
    }
    .dropdown-list {
        border-radius: 14px;
        background-color: white;
        position: absolute;
        width: 100%;
        top: 120%;
        left: 0;
        right: 0;
        opacity: 0;
        height: 80px;
        visibility: hidden;
        transition: opacity 0.2s linear, visibility 0.2s linear;
        overflow: scroll;
        z-index : 10;
    }
    .dropdown-list__item {
        z-index : 10;
        margin: 10px;
        padding: 6px;
        font-size: 12px;
    }

    .dropdown-list__item:hover {
        background-color: rgba(0, 0, 0, 0.2);
    }


    .switch-wrap{
        position: absolute;
        right: 0;
        bottom: 25px;
        position: fixed;

    }
    .switch {
        
        position: relative;
        display: inline-block;
        width: 80px;
        height: 34px;
        vertical-align:middle;
    }

    
    .switch input {display:none;}

    
    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        -webkit-transition: .4s;
        transition: .4s;
    }

    .slider:before {
        position: absolute;
        content: "";
        height: 26px;
        width: 26px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        -webkit-transition: .4s;
        transition: .4s;
    }

    input:checked + .slider {
        background-color: #d32323;
    }

    input:focus + .slider {
        box-shadow: 0 0 1px #d32323;
    }

    input:checked + .slider:before {
        -webkit-transform: translateX(50px);
        -ms-transform: translateX(50px);
        transform: translateX(50px);
    }

    
    .slider.round {
        border-radius: 34px;
    }

    .slider.round:before {
        border-radius: 50%;
    }

    p {
        margin:0px;
        display:inline-block;
        font-size:15px;
        font-weight:bold;
    }

    .btn_content{
        position: fixed;
        right: 10px;
        bottom: 23px;
        display: inline-block;
        width: 120px;
        height: 45px;
        background-position: -270px -55px;
        background-repeat: no-repeat;
        vertical-align: top;
        cursor: pointer;
        z-index: 600;
        background-color: rgb(180, 173, 173);
        color: white;
        font-weight: 700;
        border-radius: 25px;
        outline: none;
    }
    
    .btn_content:hover{
    	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
    }

</style>
</head>
<body>
<!-- <h1>핫딜</h1> -->

<!-- <div class="topnav">
		<form action = "/dealight/hotdeal/register">
			<input type="number" min = "0" name = "storeId" placeholder="매장번호를 선택해주세요">
			<button type="submit" data-oper = 'register'>핫딜 등록</button>		
		</form>
		
		<button type="submit" data-oper = 'activate'>핫딜 진행중</button>
		<button type="submit" data-oper = 'pending'>핫딜 예정</button>
	</div> -->
	
	<div class="main-container">
		<div class="switch-wrap">
        <!-- <label class="switch">
            <input type="checkbox">
            <span class="slider round">핫딜중</span>
          </label>
          <p>OFF</p><p style="display:none;">ON</p> -->

          <button type="button" id="hotdeal_btn" data-oper="pending" class="btn_content">
			핫딜 예정 보기
          </button>
          </div>
		<div class="search-container">
            <div class="search-wrap">
                <div class="search-form">
                    <div class="region-box js-search0" id="region">
                            <div class="css-region">
                                <label class="css-regionLabel css-label js-label">
                                    <div class="label-region">지역</div>

                                    <div class="dropdown-select">
                                        <input type="text" id="region_input" required placeholder="지역을 선택해주세요">
                                    </div>

                                <div class="dropdown-list"></div>
                                </label>
                            </div>
                    </div>
                    <div class="divider"></div>
                    <div class="startTime-box js-search1" id="startTime">
                        
                        <div class="css-startTime">
                            <label class="css-startTimeLabel css-label js-label">
                                
                                
                                <div class="label-region">시작시간</div>
                                <div class="dropdown-select">
                                    <input type="text" id="startTime_input" required placeholder="시간">
                                </div>
                                <div class="dropdown-list"></div>
                            </label>
                        </div>
                    </div>

                <div class="divider"></div>

                <div class="region-box js-search2" id="endTime">
                         
                    <div class="css-endTime">
                        <label class="css-endTimeLabel css-label js-label">
                            <div class="label-region">종료시간</div>

                            <div class="dropdown-select">
                            <input type="text" id="endTime_input" required placeholder="시간">
                            </div>

                            <div class="dropdown-list">
                            </div>
                        </label>
                
                </div>
            </div>


                <button id="searchBtn" data-oper="search" class="search-btn flex" style="flex-basis: 50px;">
                    <img src="/resources/img/search.svg" alt="" style="width: 24px;">
                    <!-- <i class="fas fa-search" style="color: white;"></i> -->
                </button>
                    
                
                </div>


            </div>
            <!--search-form end-->
       </div> 
        <!-- search-container-->
        
        <div class="hotdeal-container">
          <%--   <div class="card js-htdl<c:out value="${status.index}"/>">
                <div class="card-lmtpnum">
                    <div class="card-elaptime">
                        00:52:42
                    </div>
                    
                    <h4>선착순 <c:out value="${htdl.lmtPnum}" />명</h4>
                    
                </div>

                <div class="card-img">

                    <img class="card-img-top" src="/resources/img/img1.jpg" alt="" style="width: 100%; height: 320px;">
                    <div class="card-dc">
                        <span>15%</span>
                    </div>

                    <div class="card-price card-afterPrice">
                        <span>₩18500</span>
                    </div>

                    <div class="card-price card-beforePrice">
                        <span>₩20000</span>
                    </div>

                </div>
                <div class="card-body">

                    <div class="card-rate">

                        <div class="card-rating" data-rate-value=2></div>

                        <div class="card-curpnum">
                            <span>🔥</span>
                            <p class="arrow-box">마감까지<br> 20명<br> 남았습니다!</p>
                        </div>

                    </div>


                    <div class="card-title">
                        <h3>[종로] 브런치가 맛있는 집</h3>
                    </div>

                    <div class="card-menu">
                        메뉴:&nbsp;<span>디저트 콤보 1인 세트</span>
                    </div>

                    <div class="card-intro">
                        소개:&nbsp;<span>청계천 바로 앞! 쫄깃한 도우가 매력적인 뉴욕식 피자 전문점</span>
                    </div>

                </div>

                <div class="card-footer">
                    
                </div>

            </div> --%>
            
            
            </div>
            <!-- hotdeal-container end -->
            
             	<div class="panel-footer1">
            
            	</div>
           
      </div>

<!-- 	<div class="hotdeal-search">
		<span class="icon"></span>
		<button class="hotdeal_locationFilterBtn">
		<span class="hotdeal_locationFilterLabel">지역</span>
		</button>
		<input type="text" style="width:60px;height:20px;">
		
	</div> -->

	<!-- <div class="hotdeal"> -->
	<%-- <c:forEach items="${lists}" var="htdl" varStatus="status">
		<div class="css-hotdeal js-htdl<c:out value="${status.index}"/>">
			=========================================<br> 핫딜 번호:
			<c:out value="${htdl.htdlId}" />
			<br> 핫딜 이름:
			<c:out value="${htdl.name}" />
			<br> 핫딜 할인율:
			<fmt:parseNumber integerOnly="true" value="${htdl.dcRate * 100}" />
			%<br> 핫딜 시작 시간:
			<c:out value="${htdl.startTm}"></c:out>
			<br> 핫딜 종료 시간:
			<c:out value="${htdl.endTm}" />
			<br> 메뉴:
			<c:forEach items="${htdl.dtlsList}" var="detail" varStatus="status">
				<c:out value="${detail.menuName}" />,
			</c:forEach>
			<br>
			<c:if test="${htdl.intro ne null}">
			핫딜 소개: <c:out value="${htdl.intro}" />
				<br>
			</c:if>
			핫딜마감인원:
			<c:out value="${htdl.lmtPnum}" />
			<br> 매장 평점:
			<c:out value="${htdl.storeEval.avgRating}" />
			<br> 리뷰 수:
			<c:out value="${htdl.storeEval.revwTotNum} " />
			<br> =========================================<br>
		</div>
	</c:forEach> --%>
	<!-- </div> -->
	
	
		<!-- The Modal -->
<!-- 		<div id="myModal" class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"> -->
		
		  <!-- Modal content -->
<!-- 		  <div class="modal-content">
		  <span class="close">&times;</span>
		    <div class="modal-header">
		    	선착순: <h4 class="modal-lmtPnum" id="lmtPnum"></h4><label>명</label><br>
		    	<h4 class="modal-name" id="htdlName"></h4><br> -->
		    	<!-- <input type="hidden" id="mhtdlId" name = "htdlId"> -->
<!-- 		    </div>
	
		    <div class="modal-body">
		    <div class="modal-htdlImg">
		    </div>
		    	<span class= 'modal-startTm' id="startTm"></span> &nbsp; - &nbsp; <span class= 'modal-endTm' id="endTm"></span><br>
		    	<span class= 'css-elapTime modal-elapTime' id="elapTime"></span><br>
		    	<h4 class="modal-dcRate" id="dcRate"></h4><br>
		    	<span class="modal-befPrice" id="befPrice" style="text-decoration:line-through; color:#999999;">
		    	</span>
		    	<br>
		    	<h4 class="modal-afterPrice" id="afterPrice"></h4><br>
		    	<h4 class="modal-avgRating" id="avgRating"></h4><br>
		    	<h4 class="modal-revwTotNum" id="revwTotNum"></h4><br>
		    	<h4 class="modal-menuName" id="menuName"></h4><br>
		    	<h4 class="modal-intro" id="intro"></h4><br>
		    </div>
		    
		    <div class="modal-footer">
		    	<h3 style="color: red; font-weight: bold;">※ 유의 사항</h3>
		    	<ul>
		    		<li>1인 1매만 구매 가능합니다.</li>
		    		<li>구매 전 전용 지점을 확인해주세요.</li>
		    		<li>시간을 준수해 주시기 바랍니다.</li>
		    		<li>양도 및 재판매 불가합니다.</li>
		    	</ul>
		    	<h3 style="color: red; font-weight: bold;">※ 환불 규정</h3>
		    	<ul>
		    		<li>사용 기간 내 환불 요청에 한해 구매 금액 전액 환불, 상품 사용 기간 이후 환불 요청 건은 수수료 10%를 제외한 금액 환불을 원칙으로 합니다.</li>
		    		<li>환불 기간 연장은 불가합니다.</li>
		    		<li>구매 후 1시간 이내 환불 요청: 100% 환불</li>
		    		<li>구매 후 1시간 이후 환불 요청: 90% 환불</li>
		    	</ul>
		    	
		   		<br>
			    <div class="text-center">	
		        		<button type="submit" class="css-btn js-dealBtn">딜 하기</button>	    		
		      	</div>
		    </div>
		  </div>
		</div> -->

	<script>
	let htdlUL = $(".hotdeal-container"); //핫딜
	let size = '<c:out value="${fn:length(lists)}"/>'; //진행중인 핫딜 갯수

	let showListId = null; //setInterval id
	let showElapTimeId = null; // elapTime id
	let pageNum = 1;
	let htdlPageFooter = $(".panel-footer1"); //핫딜 페이지
	
	//모달
	let modal = $(".modal"),
		/* htdlId = $("#mhtdlId"), */
		htdlImg = $(".modal-htdlImg"),
		lmtPnum = $("#lmtPnum"), //제한 인원
		htdlName = $("#htdlName"), //핫딜 이름
		startTm = $("#startTm"), //시작 시간
		endTm = $("#endTm"), //종료 시간
		mElapTime = $("#elapTime"), //경과 시간
		dcRate = $("#dcRate"), //할인율
		befPrice = $("#befPrice"), //할인 전 가격
		afterPrice = $("#afterPrice"), //할인 후 가격
		avgRating = $("#avgRating"), //평점
		revwTotNum = $("#revwTotNum"), //리뷰수
		menuName = $("#menuName"), //메뉴이름
		intro = $("#intro"); //핫딜 소개
	
	let storeId = 0; //매장번호
	let paramStusCd = "A"; //핫딜 상태코드
	let htdlId = 0; //핫딜번호
	const userId= "<c:out value="${userId}"/>" || null;
	let ishtdlPayHistory = false;
	
	let elapTimeArr = []; //경과시간 배열
	
	$(document).ready(function() {
		
		console.log("==="+size);
		showList(paramStusCd);
		showElapTimeStart();
		//showListStart(paramStusCd, pageNum); //1초마다 핫딜 리스트를 그린다
		
		/* for(var i=0; i< size; i++){
			$(".js-htdl"+i).on('click', function(){
				console.log("aaaa"+i);
			});
		} */
		
		/* $(".js-htdl0").on('click',function(){
			console.log("aaaa");
		}); */
		
		let check = $("input[type='checkbox']");
        check.click(function(){
            $("p").toggle();
        });

        //[사용자에게 보여질값, 실제 값]
	    let item1 = ["내 위치", "a"];
	    let item2 = ["종로구", "b"];
	    let item3 = ["평양","c"];
        let item4 = ["화성","d"];
        
        let startTimeArr = ["09:00","09:30","10:00","10:30",
        "11:00","11:30","12:00","12:30","13:00","13:30",
        "14:00","14:30","15:00","15:30","16:00","16:30","17:00",
        "17:30","18:00","18:30","19:00","19:30"];

        let endTimeArr = ["09:00","09:30","10:00","10:30",
        "11:00","11:30","12:00","12:30","13:00","13:30",
        "14:00","14:30","15:00","15:30","16:00","16:30","17:00",
        "17:30","18:00","18:30","19:00","19:30"];
        
	    //셀렉박스에 넣어줄 요소들
	    let values = [item1, item2, item3, item4];
	    //아이디값을 넣어줄 inpu태그의 name으로 지정할것
    	const region = $("#region");
	    const startTime = $("#startTime");
	    const endTime = $("#endTime");
    	const form = $("#searchForm");
    	//(클릭이벤트를 걸어줄 요소, 셀렉박스 요소값, 선택값을 추가할 form)
    	
    	
    	// selectEvent(region ,values, form);
    	
        selectEvent(startTime ,startTimeArr, form);
        selectEvent(endTime ,endTimeArr, form);
        /* Rater.js 로직*/
        $(".card-rating").rate({
                        max_value: 5,
                        step_size: 0.5,
                        initial_value: 0,
                        selected_symbol_type: 'utf8_star', // Must be a key from symbols
                        cursor: 'default',
                        readonly: true,
                    });

        
        
        for(let i=0; i<3; i++){

            $(".js-search"+i).on("click", "label input", function(){

                console.log("====");
                // let regionState =  $(".css-regionLabel").hasClass("css-regionLabel");
                
                let selectLabel = $(this).find("js-label");

                console.log(selectLabel);
                console.log(i);
                //selectLabel.attr('class', "select-label");
                switch(i){
                    case 0:                        
                        $(".css-regionLabel").attr('class', "select-regionLabel");
                        console.log(".....click");
                        break;
                        
                    case 1:
                        $(".css-startTimeLabel").attr('class', "select-startTimeLabel");
                        
                        break;
                        
                    case 2:
                        
                        $(".css-endTimeLabel").attr('class', "select-endTimeLabel");
                        
                        break;
                        
                }
                
                // if(selectLabel.hasClass("css-regionLabel")){
                //     selectLabel.attr('class', "select-label");
                    
                // }else if(selectLabel.hasClass("css-startTimeLabel")){
                //     selectLabel.attr('class', "select-label");
                    
                // }else if(selectLabel.hasClass("css-endTimeLabel")){
                //     selectLabel.attr('class', "select-label");
                    
                // }

                // if(beforeState){
                //     $(".css-regionLabel").attr('class', "select-label");
                //     return;
                // }
            });

        }

        $(".js-search0").on("focusout", function(){
            $(".select-regionLabel").attr('class', "css-regionLabel");
            $(".css-regionLabel").addClass("css-label");
            $(".css-regionLabel").addClass("js-label");
            console.log("...");
        });

        $(".js-search1").on("focusout", function(){
            $(".select-startTimeLabel").attr('class', "css-startTimeLabel");
            $(".css-startTimeLabel").addClass("css-label");
            $(".css-startTimeLabel").addClass("js-label");
            console.log("...startTime label");
        });

        $(".js-search2").on("focusout", function(){
            $(".select-endTimeLabel").attr('class', "css-endTimeLabel");
            $(".css-endTimeLabel").addClass("css-label");
            $(".css-endTimeLabel").addClass("js-label");
            // console.log("...");
        });
       
		$("button").on("click", function(e){
			e.preventDefault();
			
			let operation = $(this).data("oper");
			console.log(operation);
			
			//핫딜 검색
			if(operation === 'search'){
				/* let regionVal = $("#region_input").val();
				let startTmVal = $("#startTime_input").val();
				let endTmVal = $("#endTime_input").val(); */
				/* let region = encodeURIComponent(regionVal);
				let startTm = encodeURIComponent(startTmVal);
				let endTm = encodeURIComponent(endTmVal); */
				/* stusCd: paramStusCd,
				page: pageNum, */
				let regionVal = "종로";
				let startTmVal = "13:00";
				let endTmVal = "14:00";
				let region = encodeURIComponent(regionVal);
				let startTm = encodeURIComponent(startTmVal);
				let endTm = encodeURIComponent(endTmVal);
				let data = {
						region: region,
						startTm: startTm,
						endTm: endTm
						}
				
				console.log(JSON.stringify(data));
				$.ajax({
					type:'get',
					url:"/dealight/get/search/I/1",
					dataType: 'json',
					contentType:'application/json; charset=utf-8',
					data: JSON.stringify(data),
					success: function(data){
						console.log(data);
					}
					
				});
				
				/* getSearchHtdlList(obj, function(result){
					console.log("===========result=======");
					console.log(result);
				}) */
			}
			
			//핫딜 예정
			if(operation === 'pending'){
				 /* getList({stusCd: "P"}, function(list){
					for(var i=0, len = list.length || 0; i<len; i++){
						console.log(list[i]);
						console.log(list[i].dtlsList);	
					}	
				}); */ 
				/* stop(showListId); */
				stop(showElapTimeId);
				htdlUL.empty();
				paramStusCd = "P";
				showList(paramStusCd, pageNum);
				$(this).data("oper", "activate");
				$(this).css("background", "red");
				$(this).css("color", "white");
				$(this).text("핫딜중 보기");
				console.log("oper change : " + $(this).data("oper"));
				//showListStart("P",pageNum);
			}else if(operation === 'activate'){
				//핫딜 진행중
					/* getList({stusCd: "A"}, function(list){
					for(var i=0, len = list.length || 0; i<len; i++){
						console.log(list[i]);
					}
					
				});  */
				
				/* stop(showListId); */
				htdlUL.empty();
				paramStusCd = "A";
				showList(paramStusCd);
				showElapTimeStart();
				$(this).data("oper", "pending");
				$(this).css("background", "rgb(180, 173, 173)");
				$(this).css("color", "white");
				$(this).text("핫딜예정 보기");
				console.log("oper change : " + $(this).data("oper"));
				/* showListStart(paramStusCd, pageNum); */
				//showList("A");
			}
			/* else if(operation === 'register'){
				$("form").submit();
			} */
		});
		
		//모달 닫기
	/* 	$(".close").on("click", function(){
			clearInterval(showElapTimeId);
			mElapTime.html("");
			modal.hide();
		});
		 */
		//딜 하기 클릭 시 매장 상세로 이동한다
/* 		$(".js-dealBtn").on("click", function(e){
			e.preventDefault();
			let body = $("body");
			
			console.log("================htdlId: " + htdlId);
			//해당 핫딜번호,메뉴,가격 
			/* let htdlId = $("#mhtdlId").val(); */
			/* let htdlMenu = $("#menuName").text();
			let afterPrice = $("#afterPrice").text().substr(1); */
			
			//폼 만들기
			/* let form = $("<form></form>");
			form.attr("action", "/dealight/store");
			form.attr("method", "get"); */
			//요청 폼 입력
			/* let storeIdInput = $("<input type='hidden' value='"+ storeId +"' name='storeId'>");
			let htdlIdInput = $("<input type='hidden' value='"+ htdlId +"' name='htdlId'>");
			let clsCdInput = $("<input type='hidden' value='B' name='clsCd'>");
		    form.append(storeIdInput);
		    form.append(htdlIdInput);
		    form.append(clsCdInput);
		    form.appendTo(body); */
		    //전송
		    //form.submit();
		    
		//});
		
		//페이지 번호 클릭 시
		htdlPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			
			console.log("page click");
			
			//클릭한 페이지 번호
			let targetPageNum = $(this).attr("href");
			
			pageNum = targetPageNum;
			//setInterval 중지
			stop(showListId);
			console.log("====="+paramStusCd);
			//핫딜 리스트 그리기
			showListStart(paramStusCd, pageNum);
			window.scrollTo(0,0);
		});
				
	});

	//타이머 중지
	function stop(id){
		clearInterval(id);
	}
	
	//타이머 설정
	function showListStart(stusCd, pageNum){
		//showList(stusCd, pageNum);
		showListId = setInterval(showList, 1000, stusCd, pageNum);
	}
	
	/* //경과시간 카운트다운
	function showElapTimeStart(elapTime){
		showElapTimeId = setInterval(getModalElapTime, 1000, elapTime);
	}
	
	//모달 경과시간
	function getModalElapTime(endTime, startTime){
		
		let elapTime = getElapTime(endTime, startTime);
		mElapTime.html(elapTime);
	} */
	

	
	//핫딜 경과시간
	function showHtdlElapTime(endTime, startTime){
		
		let elapTime = getElapTime(endTime, startTime);
		/* $(".js-elapTime1").html(elapTime); */
		return elapTime;
	}
	
	function getElapTime(endTime, startTime){
		console.log("--------end-----"+ endTime);
		
		//종료 시간 변환
		let fmtTime = new Date(endTime);
		console.log("fmtTime: " + fmtTime);
		let date = null;
		
		if(startTime != null)
			date = new Date(startTime);
		else 
			date =new Date();
		
	    		
		//var endTime = endTimes[i].innerHTML;
		//console.log("endTime: " + endTime);
		
		console.log("==================시간계산 startTime: " + startTime);
			
		if(fmtTime.getTime() - date.getTime()<=0){
			return "00:00:00";
		}
		//경과 시간
		let elapsedTime = (fmtTime.getTime() - date.getTime()) / 1000;
		
		console.log("=========="+elapsedTime);

		//경과 시간 시분초 구한다
		let elapsedSec = Math.floor((elapsedTime % 3600 % 60));
		let elapsedMin = Math.floor((elapsedTime % 3600 / 60));
		let elapsedHour = Math.floor((elapsedTime / 3600));
		
		console.log("hour: " +elapsedHour);
		console.log("m: " +elapsedMin);
		console.log("s: " +elapsedSec);
		
		//시분초 문자열 00:00:00
		let elapTime = [ (elapsedHour > 9 ? '' : '0')+ elapsedHour, ':',
						(elapsedMin > 9  ? '' : '0')+ elapsedMin, ':',
						(elapsedSec > 9  ? '' : '0')+ elapsedSec].join('');
								
		console.log("elapTime========"+elapTime);
		return elapTime;
	}
	
	//핫딜 경과시간 카운트 다운
	function showElapTimeStart(){
		showElapTimeId = setInterval(countElapTime, 1000);
	}
	
	function countElapTime(){
		for(let i=0, len=elapTimeArr.length; i<len; i++){
			//1초씩 카운트 다운
			let countElapTime = getElapTime(elapTimeArr[i], null);
			//card-elaptime 출력
			$(".card-elaptime").text(countElapTime);
			if(countElapTime === "00:00:00"){
				//css 변경
			}
		}
	}
	
	//검색된 핫딜 리스트 가져오기
	function getSearchHtdlList(param, callback, error){
		
		let stusCd = param.stusCd;
		let page = param.page || 1;
		let region = param.region;
		let startTm = param.startTm;
		let endTm = param.endTm;
		//let regionStr = encodeURIComponent(region);
		
	/* 	let data = {
				region:region,
				startTm:startTm,
				endTm:endTm
		} */
		
		let searchUrl = "/dealight/get/search/I/"+page+"?region="+regionStr+"&startTm="+startTm+"&endTm="+endTm;
		
	
		
		/* $.getJSON("/dealight/get/search/I/"+page+"?region="+regionStr+"&startTm="+startTm+"&endTm="+endTm
				, function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status, err){
			if(error){
				error();
			}
		}); */
		
	}
	
	//핫딜 리스트 보여주기
	function showList(param, page){
		
		getList({stusCd: param, page: page || 1},
			function(data){
			//console.log("list: " + JSON.stringify(data.lists));
			//console.log("data: " + JSON.stringify(data));
			//console.log("listDtls: " + JSON.stringify(data.lists[0].htdlDtls));
	
			//ajax 요청 list가 널이거나 0이면 ""
			if(data.lists == null || data.lists.length == 0){
				htdlUL.html("");
				return;
			}
			
			//페이지가 -1이면 첫페이지
			if(page == -1){
				pageNum = 1;
				showListStart(param, pageNum);
				return;
			}
			console.log(data.lists.length);
			
			//핫딜 동적생성
			let str = htdlHtml(data.lists);
			htdlUL.html(str);
			//핫딜 페이지
			showHtdlPage(data.total);
			eventHtdlListener(data.lists.length);
			
		});
	
	}
	
	//핫딜 페이지 그리기
	function showHtdlPage(listCnt){
		let endNum = Math.ceil(pageNum / 10.0) * 10;
		let startNum = endNum - 9;
		
		let prev = startNum != 1;
		let next =false;
		
		//끝번호 * 9 이 리스트갯수보다 더 많을 때
		if(endNum * 9 >= listCnt){
			endNum = Math.ceil(listCnt/9.0);
		}
		//끝번호 * 10보다 많을 때
		if(endNum * 10 < listCnt){
			next = true;
		}
		
		let pageStr = "<div class='panel-footer1'><ul class='pagination'>";
		if(prev){
			pageStr+="<li><a href='"+(startNum - 1)+"'>Previous</a></li>";
		}
		
		for(let i = startNum; i<=endNum; i++){
			
			let active = pageNum == i ? "active":"";
			pageStr += "<li "+active+" '><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(next){
			pageStr += "<li><a href='"+(endNum+1)+"'>Next</a></li>";
		}
		
		pageStr+="</ul></div>";
		//console.log(pageStr);
		htdlPageFooter.html(pageStr);
	}
	
	//핫딜 그리기
	function htdlHtml(list){
		let str = "";
		str +="<div class='hotdealState-wrap'></div>";
		//list에 따른 핫딜 동적 생성
		for(let i =0, len = list.length || 0; i<len; i++){
			/* let elapTime = getElapTime(list[i].endTm); */
			let elapTime = "";
			if(list[i].stusCd === 'A'){
				elapTime = showHtdlElapTime(list[i].endTm, null);
				elapTimeArr.push(list[i].endTm);
			}
			else{				
				elapTime = showHtdlElapTime(list[i].endTm, list[i].startTm);
			}
			
			let fileCallPath = null;
			let srcObj = null;
			//console.log("hotdeal : " + JSON.stringify(list[i]));
			//console.log("hotdeal image: " + list[i].htdlImg);
			if(list[i].htdlImg != null){
				let htdlPhotoSrc = list[i].htdlImg;
				srcObj = subSrc(htdlPhotoSrc);
				fileCallPath = encodeURIComponent("/"+ srcObj["uploadPath"]+"/"+ srcObj["fileName"]); //원본
				
				//console.log("================핫딜 이미지: " + htdlPhotoSrc);
			}
			
			/* str += "<div class='css-hotdeal js-htdl"+i+"'>"; */
			///* str += "<div class='css-hotdeal js-htdl'>"; */ //
			/* str += "=========================================<br>" */
			
			/* if(fileCallPath != null && srcObj != null){				
				str += "<div class='uploadResult'>";
				str += "<ul>";
				str += "<li data-path='"+ srcObj["uploadPath"] +"'";
				str += " data-filename=\'"+ srcObj["fileName"] +"\'><div>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str += "</li>";
				str += "</ul></div>";
			} */
			
			/* if(fileCallPath != null && srcObj != null){				
				str += "<div class='uploadResult'>";
				str += "<ul>";
				str += "<li data-path='"+ srcObj["uploadPath"] +"'";
				str += " data-filename=\'"+ srcObj["fileName"] +"\'><div>";
				str += "<img src='/display?fileName=" + fileCallPath + "'>";
				str += "</div>";
				str += "</li>";
				str += "</ul></div>";
			} */
			
			str += "<div class='card js-htdl"+i+"'>";
			str += "<input type='hidden' class='js-htdlId' value='"+list[i].htdlId+"'>";
			str += "<div class='card-lmtpnum'>";
			str += "<div class='card-elaptime'>"+elapTime+"</div>";
			str += "<h4>선착순 "+list[i].lmtPnum+"명</h4></div>";
			str += "<div class='card-img'>";
			
							
			str += "<img class='card-img-top' src='/display?fileName=" + fileCallPath + "' style='width:100%; height: 320px;'>";
			
			/* str += "<img class='card-img-top' src='/resources/img/img1.jpg' style='width:100%; height: 320px;'>"; */
			str += "<div class='card-dc'>";
			str += "<span>"+(list[i].dcRate * 100)+"%</span></div>";
			str += "<div class='card-price card-afterPrice'>";
			str += "<span>₩"+(list[i].befPrice - list[i].ddct)+"</span></div>";
			str += "<div class='card-price card-beforePrice'>";
			str += "<span>₩"+list[i].befPrice+"</span></div></div>";
			
			str += "<div class='card-body'>";
			
			str += "<div class='card-rate'>";
			str += "<div class='card-rating data-rate-value="+Math.round(list[i].storeEval.avgRating)+"'></div>";
			str += "<div class='card-curpnum'>";
			str += "<span>🔥</span>";
			str += "<p class='arrow-box'>마감까지<br>"+(list[i].lmtPnum - list[i].curPnum) +"명<br> 남았습니다!</p></div></div>";
			
			str += "<div class='card-title'>";
			str += "<h3>["+list[i].brch+"]&nbsp;"+ list[i].name+"</h3></div>";
			
			str += "<div class='card-menu'>";
			str += "<span>";
			let menuArr = []
			//핫딜 메뉴 리스트 생성
			for(let j=0, dtlsLen = list[i].htdlDtls.length || 0; j<dtlsLen; j++){
				menuArr.push(list[i].htdlDtls[j].menuName);
				/* str += list[i].menuName+" "; */
				//console.log(list[i].htdlDtls[j].menuName);
			}
			if(menuArr.length > 1)
				str += list[i].setName+"</span></div>";
			else
				str+= menuArr[0] +"</span></div>";
			
			
			str += "<div class='card-intro'>";
			str += "<span>"+list[i].intro+"</span></div></div></div>";

			/* 
			str += "남은 시간: <span class='js-elapTime css-elapTime'>"+elapTime+"</span><br>"
			str += "핫딜 번호: <span class='js-htdlId'>"+ list[i].htdlId+"</span><br>"
			str += "핫딜 이름: "+ list[i].name+"<br>" */
			/* str += "<img src='<spring:url value='/resources/img/testimg.png'/>' width='300px' height='250px'>" */
			/* str += "핫딜 할인율: "+ list[i].dcRate * 100+"%"+"<br>"
			str += "핫딜 시작 시간: "+ "<span class= 'js-start'>"+list[i].startTm+"</span>"+"<br>"
			str += "핫딜 종료 시간: "+ "<span class= 'js-end'>"+list[i].endTm+"</span>"+"<br>"
			
			str += "메뉴: "; */
			//console.log("======="+ list[i].htdlDtls);
			//console.log(list[i].htdlDtls);
		
	/* 	//핫딜 메뉴 리스트 생성
		for(let j=0, dtlsLen = list[i].htdlDtls.length || 0; j<dtlsLen; j++){
			str += list[i].htdlDtls[j].menuName+" ";
			//console.log(list[i].htdlDtls[j].menuName);
		} */
			/* str +="<br>"; */
			//console.log("========="+list[i].befPrice);
			//console.log("========="+list[i].ddct);
			
			/* str += "핫딜 할인 전 가격: <span style='text-decoration:line-through; color:#999999;'>"+ list[i].befPrice+"</span><br>";
			str += "핫딜 할인 후 가격: "+ (list[i].befPrice - list[i].ddct)+"<br>";
			str += "핫딜 소개: "+ list[i].intro+"<br>";
			str += "핫딜 마감 인원: "+ list[i].lmtPnum+"<br>";
			str += "매장 평점 "+ list[i].storeEval.avgRating+"<br>";
			str += "리뷰 수 "+ list[i].storeEval.revwTotNum+"<br>";
			str += "=========================================";
			str +="</div>" */
		}
		
		/* showElapTimeStart(); */
		return str;
	}
	
	//이미지 url 파일경로 나누기
	function subSrc(PhotoSrc){
		let srcObj = {};
	
		let index = PhotoSrc.lastIndexOf("/");
		//console.log("photo index ============" + index);			
		
		srcObj["uploadPath"] = PhotoSrc.substring(0,index);
		console.log("photoSrc: " + PhotoSrc.substring(0,index));
		srcObj["fileName"] = PhotoSrc.substring(index + 1);
		
		return srcObj;
	}
	
	//해당 핫딜을 ajax 요청을 통해 불러온다
	function getHtdl(param, callback, error){
		let htdlId = param.htdlId;
		
		//console.log("htdlId: "+ htdlId);
		
		$.get("/dealight/hotdeal/get/"+htdlId+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status, err){
			if(error){
				error();
			}
		});  
	}
	
	
	//모달 띄우기
	 function showModal(htdl, ishtdlPayHistory){
		 let size = htdl.htdlDtls.length;		
		 let str = [];
		 
		 //비로그인 상태 
		 if(userId == null)
			ishtdlPayHistory = true;

		 if(htdl.stusCd === 'A'){
			showElapTimeStart(htdl.endTm);			 
		 }
		 else{
			 clearInterval(showElapTimeId);
			 getModalElapTime(htdl.endTm, htdl.startTm);
		 }
		
		 //핫딜 이미지(uuid+fileName)
		 let filePath = htdl.htdlImg;
		 //console.log(filePath+"modal filePath==============")
		 
		 //원본 이미지 파일 경로
		 let fileCallPath = encodeURIComponent("/"+ filePath);
		 //console.log("========fileCallPath1: " + fileCallPath);
		 //섬네일 파일 경로
		 /* let srcObj = subSrc(filePath);
		 let thumnailfileCallPath = encodeURIComponent("/"+ srcObj["uploadPath"] +"/s_"+ srcObj["fileName"]);
		 console.log("=========fileCallPath: " + fileCallPath); */
		 
		 /* let fileCallPath = path.replace(new RegExp(/\\/g), "/"); */

		//핫딜 번호
		let htdlNum = htdl.htdlId;
		htdlId = htdlNum;
		//console.log("========htdlNUm : " + htdlNum);
		htdlImg.html("<img src='/display?fileName="+ fileCallPath+ "'>");
		storeId = htdl.storeId;
		console.log("============storeId: "+storeId);
		console.log("=========htdlNum: "+htdlNum);
		console.log("===============showModal" + htdl.lmtPnum+"," + size);
		//제한 인원, 핫딜 이름, 시작시간, 마감시간
		lmtPnum.text(htdl.lmtPnum);
		htdlName.text(htdl.name);
		startTm.text(htdl.startTm);
		endTm.text(htdl.endTm);
		
		//경과시간,할인율,할인전후가격,평균평점,리뷰수
		let elapTime = getElapTime(htdl.endTm);
		
		console.log(elapTime+"===============elapTime");
		/* htdlId.val(htdlNum); */
		$("#mhtdlId").val(htdlNum);
		
		dcRate.text(htdl.dcRate*100+"%");
		befPrice.text("₩"+htdl.befPrice);
		afterPrice.text("₩"+(htdl.befPrice - htdl.ddct));
		avgRating.text(htdl.storeEval.avgRating);
		revwTotNum.text(htdl.storeEval.revwTotNum);
		
		for(let i=0; i<size; i++){
			str.push(htdl.htdlDtls[i].menuName);
		}
		menuName.text(str.join(","));		
		
		intro.text(htdl.intro); 
		const dealBtn = $(".js-dealBtn");
		
		if(!ishtdlPayHistory){
			dealBtn.text("🔥이미 구매하신 상품입니다.");
			dealBtn.css("background", "black");
			dealBtn.prop("disabled", true);
		}else if(htdl.stusCd !== 'A'){
			dealBtn.text("🔥오픈 예정입니다.");
			dealBtn.css("background", "orange");
			dealBtn.prop("disabled", true);
		}else{
			dealBtn.text("🔥딜 하기");
			dealBtn.css("background", "red");
			dealBtn.prop("disabled", false);
		}
		
		
		
		modal.show();
	}
	
	
	//핫딜 구매이력 체크
	 function isHtdlPayExistChecked(param, callback, error){
			let userId = param.userId;
			let htdlId = param.htdlId;
			console.log("======userId : " + userId);
			console.log("======htdlId : " + htdlId);
			
			$.getJSON("/dealight/reservation/htdlcheck/"+userId+"/"+htdlId+".json",
					function(data){
				if(callback){
					callback(data);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	 //핫딜 클릭(상세) 이벤트 등록
	function eventHtdlListener(size){
		
		//생성된 핫딜에 클릭시 이벤트 생성
		for(let i = 0; i< size; i++){
		 $(".js-htdl"+i).on("click",function(){
			 console.log(this);
			 
			 //핫딜번호를 가져온다
			 let param = $(this).find(".js-htdlId").val();
			 console.log($(this).find(".js-htdlId").val());
			 
			 location.href="/dealight/hotdeal/get/"+param;

			/*  if(userId != null){				 
				 isHtdlPayExistChecked({htdlId: param, userId: userId}, function(result){
					 console.log("===========hotdeal pay check: "+ result);
					 ishtdlPayHistory = result;
				 });
			 } */

			 /* getHtdl({htdlId: param}, function(result){
				 
				 console.log("핫딜 get.."+ JSON.stringify(result));
				 //모달에 값 전달하기
				 showModal(result, ishtdlPayHistory);
			 });  */
			 
		 });
		}
	}

	//핫딜 ajax 요청
	function getList(param, callback, error){
		let stusCd = param.stusCd;
		let page = param.page || 1;
		console.log(stusCd);
		console.log("======page: "+ page);
		
		$.getJSON("/dealight/hotdeal/main/"+stusCd+"/"+page+".json",
			function(data){
			if(callback){
				callback(data);
			}
			
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	function selectEvent(dropdown, values, searchForm){
	    const list = dropdown.find(".dropdown-list");
	    const selectValue =dropdown.find(".dropdown-select");
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
        // $(document).click(function(){
        //     list.css("visibility", "") 
        //     console.log("......외부 클릭");
        // });

        dropdown.on("focusout",function(){
            list.css("visibility", "") 
            console.log("......외부 클릭");
        });

      	//select 아이템 추가
        let str = addItem(values);
        list.append(str);

        //셀렉박스 요소 선택 이벤트
        dropdown.find(".dropdown-list__item").on("click", function(e){
            //클릭시 셀렉박스에 내용 반영
            
            selectValue.find("input").val($(this).html());
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

    };

    //select 아이템 추가 함수
    function addItem(values){
        let str ="";
        for(let index in values){   
            
            str += "<div class='dropdown-list__item' data-value='"+(values[index])+"'>"+(values[index])+"</div>";
            
        }
        return str;
    }
    
	
	$(".card-rating").rate({
        max_value: 5,
        step_size: 0.5,
        initial_value: 0,
        selected_symbol_type: 'utf8_star', // Must be a key from symbols
        cursor: 'default',
        readonly: true,
    });
	
</script>
</body>
</html>

