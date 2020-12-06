<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../includes/mainMenu.jsp" %>
   <%--  <%
           Cookie[] cookies = request.getCookies(); 
           String cookieVal ="";
            
            if(cookies !=null){
            	for(Cookie i : cookies){
                    if(i.getName().equals("id")){
                        cookieVal=i.getValue();
                    }
                }
            }
            %> --%>
            
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
        .css-loginForm{
            border: 1px solid;
            margin-top: 150px;
            position: fixed;
            left: 35%;
            padding: 40px;
            height: 400px;
            width: 380px;
            z-index: 1;
            background-color: white;
        }

        .form-group{
            padding: 5px;
            margin:auto; 

        }

       .find, .login-footer{
            text-align: center;
        }
        
        /* .black-bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 100%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    } */

    .saveId{
    	text-align: left;
    	margin: 0;
    	mar
    }
</style>
<!-- <style>
	
	/* * { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/
        
            margin  : 0;   /* 값이 0일 때는 단위 안씀. */
            border  : 0;
            padding : 0;
     } */
     
	/* .main-wrraper{
		width:1050px;
		height: 700px;
		margin: auto;
		border: solid 2px;
	} */
	.css-loginForm{
		width:1050px;
		height: 700px;
		margin: 100px;
		border: solid 2px;
	} 
</style> -->
</head>
<body>
<h2><c:out value="${error }"/></h2>



<div class="css-loginForm">
<form action="/login" method="post"> 
    
    <div>
		아이디: <input type="text" name="username">
	</div><br>
	
	<div>
		비밀번호: <input type="password" name="password">
	</div>
	
	<div>
		<input type='checkbox' name='remember-me'> Remember me
	</div>
	
	<div>
		<input type="submit">
	</div>
	

<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }"/>
 </form>
 
 
    <div id="naver_id_login" style="text-align:center margin-top: 6px;">
		<a href="${naver_url}">
			<img width="250" src="/resources/img/naver_Bn_Green.PNG"/>
		</a><br>
 		<a href="${kakao_url }">
     		<img width="250" src="/resources/img/kakao_login_medium_narrow.png">
 		</a>
	</div>
</div>	
</body>
</html>