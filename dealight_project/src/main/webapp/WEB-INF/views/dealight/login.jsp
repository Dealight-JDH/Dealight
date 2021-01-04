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
<title>딜라이트</title>
<style>
 	* { /* CSS초기화. 이거 없으면 div태그 사이에 공백 생김*/

    margin  : 0;   /* 값이 0일 때는 단위 안씀. */
    border  : 0;
    padding : 0;
    /* font-family: 'Nanum Gothic', sans-serif; */
    }
    /* div{
        border: 2px solid red;
    } */
    /* .nav-bar{
        display: flex;
        height: 60px;
        justify-content: center;
        border: 2px solid red;
        align-items: center;
        background-color: #d32323;
        
    } */
    
    .main_nav{
    	background-color: #d32323;
    }
    .main-container-wrap{
        min-width: 1050px;
    }
    .main-container{
        display: flex;
        min-height: 720px;
        width: 960px;
        margin: 0 auto;
        padding: 0 15px;
        
        padding-bottom: 36px;
    }
    .login-container{
        display: inline-flex;
        flex-direction: column;
        margin: 30px;
        margin-top: 5px;
        margin-right: 15px;
        width: 400px;
        height: 720px;
        padding: 0px 15px;
    }
    .login-form{
        display: flex;
        margin-top: 130px;
        flex-direction: column;
        justify-content: center;
    }


    .img-container{
        display: inline-flex;
        margin: 30px;
        margin-top: 130px;
        width: 460px;
        height: 360px;
        padding: 0px 15px;
    }

    .img-picture{
        display: flex;
        margin-top: 50px;
        margin-left: 40px;
    }

    ul{
        list-style: none;
        margin: 0px;
        padding: 0px;
        max-width: 100%;
        width: 100%;
    }
    .sub-heading{
        font-weight: bold;
        font-size: 16px;
    }

    .login-container h2{
        font-size: 22px;
    }

    h2{
        color: #D32323;
    }
    .header{
        margin-bottom: 15px;
    }
    .header h2{
        display: flex;
        justify-content: center;
        margin-bottom: 5px;
        font-size: 30px;
        font-weight: bold;
    }
    .header p{
        display: flex;
        justify-content: center;
    }

    #id, #password{
        display: flex;
        width: 100%;        
        padding: 12px 20px;
        margin: 8px 0;
        border: 1px solid rgb(139, 139, 139);
        border-radius: 4px;
        box-sizing: border-box;
    }

    .btn-primary{
        width: 100%;
        padding: 10px 13px;
        background-color:  #d32323;
        opacity: 0.9;
        border-radius: 4px;
        outline: none;
        cursor: pointer;
    }


    .social-login{
        display: flex;
        flex-direction: column;
        margin-top: 15px;
        justify-content: center;
    }
    

    .kakao-btn{
        width: 100%;
        padding: 10px 13px;
        margin-bottom: 15px;
        background-color: #F29F05;
        border-radius: 4px;
        outline: none;
        cursor: pointer;
    }

    .naver-btn{
        width: 100%;
        padding: 10px 13px;
        background-color: rgb(10, 177, 33);
        border-radius: 4px;
        outline: none;
        cursor: pointer;
    }
    
    span{
        font-size: 15px;
        font-weight: bold;
        color: white;
    }
    
    .remember{
        display: flex;
        margin: 8px 0px;
        justify-content: space-between;
    }
    
    .login-separator{
        display: flex;
        flex-direction: row;
        justify-content: center;
        margin: 8px 0px 0px;
        padding: 8px 0px;
    }
    .line{
        margin-top: 8px;
        width: 100%;
        height: 0px;
        border: 1px solid silver;

    }
    .hr-line1{
        width: 50%;
        /* border: 1px solid gray; */
        display: flex;
        padding-right: 15px;
        justify-content: flex-start;
    }
    .hr-line2{
        width: 50%;
        /* border: 1px solid gray; */
        display: flex;
        padding-left: 15px;
        justify-content: flex-end;
    }
    
    p>a{
    	color: rgb(238, 76, 76);
    	text-decoration: underline;
    }
    
    .nav_reg_brno>a{
    	color:white;
    }
    #remember-me{
        margin-right: 2px;
    }
    .find{
        cursor: pointer;
    }

    .css-password{
        margin: 0  0 12px;
    }
</style>

</head>
<body>
<h2><c:out value="${error }"/></h2>



    <div class="main-container-wrap">
        <div class="main-container">

        <div class="login-container">
            
            <div class="login-form">

                <div class="header">
                    <h2>로그인</h2>
                    <p class="sub-heading">
                        딜라이트가 처음이신가요? &nbsp;
                        <a href="/dealight/register">회원가입</a>
                    </p>
                </div>
                <!-- header end-->
            <form action="/login" method="post">
                <div>
                    <input id="id" type="text" name="username" placeholder="아이디">
                </div>

                <div>
                    <input id="password" type="password" name="password" placeholder="비밀번호">
                </div>
                
                <div class="remember">
                    <label for="remember-me"><input type="checkbox" name="remember-me" id="remember-me">자동 로그인</label>
                    <label for="findIdPwd" class="find">아이디/비밀번호 찾기</label>
                </div>

                <div>
                    <button type="submit" class="btn btn-primary">
                        <span>로그인</span>
                    </button>
                </div>

                <input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }"/>
            </form>
            
            </div>
            <!-- loginfForm end-->

            <div class="login-separator">
                <div class="hr-line1"><div class="line"></div></div>
                <div class="hr-or">OR</div>
                <div class="hr-line2"><div class="line"></div></div>
            </div>
            <!--login-separator end-->

            <div class="social-login">
                <ul>
                    <li>
                        <div id="kakao_id_login">
                            <button class="kakao-btn" onclick="moveKakao();">
                                <span>카카오 로그인</span>
                            </button>
                        </div>
                    </li>
                    <li>
                        <div id="naver_id_login">
                            <button class="naver-btn" onclick="moveNaver();">
                                <span>네이버 로그인</span>
                            </button>
                        </div>
                    </li>

                </ul>

            </div>

        </div>
        <!--login-container-->

        <div class="img-container">
            <div class="img-picture">
                <img src="/resources/img/signup_illustration.png" alt="">
            </div>
        </div>

        </div>
</div>


<script type="text/javascript">

	function moveKakao(){
		
		location.href="${kakao_url }";
		
	}
	
	function moveNaver(){
		location.href="${naver_url }";
	}
</script>	
</body>
</html>