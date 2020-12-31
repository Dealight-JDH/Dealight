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
<%@include file="includes/mainMenu.jsp" %> 
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/main.css" type ="text/css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="/resources/js/Rater.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBGR7CBhUjuiLLWGac5u4u_5yN7n6CWO8w&libraries=places&callback=initAutocomplete" async defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style type="text/css">
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */

      #pac-container {
        padding-bottom: 12px;
        margin-right: 12px;
      }

      .pac-controls {
        display: inline-block;
        padding: 5px 11px;
      }

      .pac-controls label {
        font-family: Roboto;
        font-size: 20px;
        font-weight: 300;
      }

      #pac-input {
      width: 100%;
	position: relative;
        font-size: 18px;
        font-weight: 300;
        margin-left: 12px;
        text-overflow: ellipsis;
        
      }

	
      input{
      	border:none;
      	background-color: transparent;
      }
      input:focus{
      	border:none;
      	outline:none;
      }
    </style>
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
	                            <div id="timebox" class="search-item" style="min-width: 200px; ">
	                                <div class="ws-block" id="time">
	                                    시간
	                                    <div class="dropdown">
	                                        <div class="dropdown-select">
	                                            <span class="select">13:30</span>
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
    </div>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBGR7CBhUjuiLLWGac5u4u_5yN7n6CWO8w&libraries=places&callback=initAutocomplete" async defer></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a6bde461f2e377ce232962931b7d1ce"></script>
    <script>
    window.onload = function(){
    	initAutocomplete
    }
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
  		
  		$.ajax({
            url:'https://dapi.kakao.com/v2/local/search/address.json?query='+encodeURIComponent(place.formatted_address),
            type:'GET',
            headers: {'Authorization' : 'KakaoAK e511e2ddb9ebfda043b94618389a614c'},
 	  	   success:function(data){
 	       console.log(data.documents[0].x);
 	       console.log(data.documents[0].y);
 	     
 	       
 	   },
 	   error : function(e){
 	       console.log(e);
 	   }
 	})
  	}
    </script>
  </body>
</html>