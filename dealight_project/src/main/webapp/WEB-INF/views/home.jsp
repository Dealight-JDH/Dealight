<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
    /*
    Kakao.init('9a6bde461f2e377ce232962931b7d1ce');
    console.log(Kakao.isInitialized());
    Kakao.API.request({
    	  url: '/v1/api/talk/profile'
    });
    */
/*
    Kakao.API.request({
    	  url: '/v1/api/talk/profile',
    	  success: function(response) {
    	    console.log(response);
    	  },
    	  fail: function(error) {
    	    console.log(error);
    	  }
    	});
    	*/
    /*
    Kakao.API.request({
    	  url: '/v2/api/talk/memo/default/send',
    	  data: {
    	    template_object: {
    	      object_type: 'feed',
    	      content: {
    	        title: '카카오톡 링크 4.0',
    	        description: '디폴트 템플릿 FEED',
    	        image_url:
    	          'http://mud-kage.kakao.co.kr/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png',
    	        link: {
    	          web_url: 'https://developers.kakao.com',
    	          mobile_web_url: 'https://developers.kakao.com',
    	        },
    	      },
    	      social: {
    	        like_count: 100,
    	        comment_count: 200,
    	      },
    	      button_title: '바로 확인',
    	    },
    	  },
    	  success: function(response) {
    	    console.log(response);
    	  },
    	  fail: function(error) {
    	    console.log(error);
    	  },
    	});
    */
    /*
    Kakao.Auth.login({

        success : function (authObj) {
            Kakao.API.request({
                url: '/v1/api/talk/profile',
                success: function(response) {
                    console.log(response);
                },
                fail: function(error) {
                    console.log(error);
                }
            });
            console.log("um.....");
        }
    });
    */
        // access 토큰 8fq_59EjZv-KPI5RUJsHEGV69bEyirSCuH1jnEuvuDFUsnf3FhjGRbpimRhI-xHqQPWKVAopcBMAAAF1zHMKvQ
        /*
        msg();
        
        function msg(msg,callback,error){
	        $.ajax({
	            type : 'get',
	            url : 'https://kapi.kakao.com/v1/api/talk/profile',
	            contentType : "application/json; charset=utf-8",
	            headers : {Authorization : "Bearer " + "FnH7fN2Z0rWkRdt7urmzeQdx8RCqH65BrJouSQo9dRoAAAF1zodBIA"},
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
        */
    </script>
</body>
</html>
