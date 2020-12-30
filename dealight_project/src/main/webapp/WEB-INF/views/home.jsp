<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Place Autocomplete</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBGR7CBhUjuiLLWGac5u4u_5yN7n6CWO8w&libraries=places&callback=initAutocomplete" async defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style type="text/css">
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }

      /* Optional: Makes the sample page fill the window. */
      html,
      body {
        height: 100%;
        margin: 0;
        padding: 0;
      }

      #description {
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
      }

      #infowindow-content .title {
        font-weight: bold;
      }

      #infowindow-content {
        display: none;
      }

      #map #infowindow-content {
        display: inline;
      }

      .pac-card {
        margin: 10px 10px 0 0;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        background-color: #fff;
        font-family: Roboto;
      }

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
        font-size: 13px;
        font-weight: 300;
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 400px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      #title {
        color: #fff;
        background-color: #4d90fe;
        font-size: 25px;
        font-weight: 500;
        padding: 6px 12px;
      }
    </style>
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
 	       
 	      let container = document.getElementById('map');
 		   	container.style.display = 'block';
 		   	container.style.width = '500px';
 		   	container.style.height = '500px';
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
 	})
  	}
    </script>
  </head>
  <body>
    <div id="pac-container">
		<span>Location</span> <input class="form-control2"
			id="pac-input" type="text" name="keyword"
			
			placeholder="Enter a location">
			
			<div id="map"></div>
	</div>
  </body>
</html>