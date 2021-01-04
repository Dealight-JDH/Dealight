<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>딜라이트</title>

<!-- <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<style type="text/css">
	*{
            padding: 0;
            margin: 0;
            border:0;
            font-family: 'Nanum Gothic', sans-serif;
        }

        /* div{
            border: 1px solid red;
        }  */

        .nav-bar{
        display: flex;
        
        height: 60px;
        justify-content: center;
        border: 1px solid red;
        align-items: center;
        background-color: #d32323;
        color: white;
        }

        .main-container{
            display: flex;
            min-width: 1050px;
            height: 600px;
            flex-direction: row;
            justify-content: center;
            
            margin:60px;
        }

        .pay-container{
            display: flex;
            width: 40%;
            height: 83%;
            flex-direction: column;
            align-content: center;
            margin: 0 32px;
            padding: 8px;
            border: 1px solid rgb(139, 139, 139, 0.3);
            /* box-shadow: 3px 3px 4px  rgb(139, 139, 139); */
            box-shadow: 0px 16px 32px rgba(0, 0, 0, 0.1), 0px 3px 8px
		rgba(0, 0, 0, 0.1);
        } 

        .success_title{
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 10px 36px 0;
            height: 40px;

        }

        .success-img{
            display: flex;
            justify-content: center;
            align-items: center;
            
            height: 150px;
            margin: 10px 36px 0;
        }

        .success_img{
            width: 100px;
            height: 100px;
            background-color: white;
        }
        p{
            font-size: 18px;
        }

        .css-font{
            font-size: 14px;
        }
        
        .success_title>span{
            font-size: 25px;
            font-weight: bold;
            margin-left: 32px;
        }

        /* .content-wrap{
            display: flex;
            flex-direction: column;
            
        } */

        .success_email{
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 20px 36px 0 85px;
            height: 40px;
        }

        .success_email>span{
            font-size: 16px;
            font-weight: bold;
            margin-left: 32px;
        }

        .success_sub{
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 4px 36px;
            height: 40px;
        }

        .success_name{

            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 5px 36px 0 85px;
            height: 40px;

        }

        .success_name>span{
            font-size: 16px;
            font-weight: bold;
            margin-left: 32px;
        }


        .btn-wrap{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 15px 36px 10px;
            padding-bottom: 8px;
            /* align-items: center; */
        }

        .btn_home{
            display: flex;
            /* justify-content: center;
            align-items: center; */
            width: 70%;
            margin-top: 12px;
            height: 50px;
            
        }


        .btn{
            width: 100%;
            height: 100%;
            font-size: 16px;
            background-color: red;
            color: white;
            cursor: pointer;
            border-radius: 3px;
            outline: none;
        }
</style>
</head>
<body>

    <div class="main-container">

        <div class="pay-container">

            <div class="success-img">
                <img class="success_img" src="/resources/img/check_circle_big.png" alt="">
            </div>
            <div class="success_title">
                <!-- <span>홍길동</span><p>님의 예약이 완료되었습니다.</p> -->
                <h2>소셜 로그인에 성공하였습니다.</h2>
            </div>

            <div class="success_sub">
                    <h3>즐거운 시간 되세요!</h3>
            </div>

    
                <div class="success_email">
                    <span>이메일:</span>&nbsp;<p class="css-font">${user.userId}</p>
                </div>
    
                <div class="success_name">
                    <span>이름:</span>&nbsp;<p class="css-font">${user.name }</p>
                </div>


            <div class="btn-wrap">
                <div class="btn_home">
                    <button class="btn" data-oper="home"><span>홈으로 이동</span></button>
                </div>
            </div>

        </div>
    </div>


<%-- <div style="text-align: center">
	${user.userId }
	${user.id }
	${user.name } <!-- 네이버일때 -->
	<c:if test="${user.nickName != null}">
		${user.nickName }
	</c:if>
</div> --%>


<form action ="/login" method = "post">
	<input type="hidden" name="username" value="${user.userId }">
	
	
</form>

<script type="text/javascript">

	
	//let hash = CryptoJS.MD5(pwd);
    //let key = CryptoJS.enc.Utf8.parse(hash);               // hex로 변환
    //let base64 = CryptoJS.enc.Base64.stringify(key);  // hex를 원래 포멧으로 변환
	
	$(document).ready(function(){
		//$("input[name='password']").val(base64);
		
		$("button").on("click", function(e){
			e.preventDefault();
			let pwd = "<c:out value='${pwd}'/>";		
			let operation = $(this).data("oper");
			if(operation === 'home'){
				
				/* let decrypt = CryptoJS.enc.Base64.parse(base64);
			    let hashData = decrypt.toString(CryptoJS.enc.Utf8);
			    console.log("decrypt hash:", hashData); */
			   	let pwdInput = "<input type='hidden' name='password' value='"+pwd+"'>";
			   	$("form").append(pwdInput);
				$("form").submit();
			}
			
		});
	});
	
</script>
</body>
</html>