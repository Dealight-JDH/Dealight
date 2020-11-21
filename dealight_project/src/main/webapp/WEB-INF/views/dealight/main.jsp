<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 수빈 ! -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            border: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        .main {
            height: 2400px;
            width: 100%;
            /* display: flex; */
        }

        .topDiv {
            border: 1px solid black;
            width: 100%;
            height: 2%;
            display: flex;
            /* ììì ìí¥ ì£¼ê¸° ìí ì¤ì  */
            /* ììì¸ inline-blockë¤ì ê°ì´ë°ì ë ¬
            justify-content: center; */
        }

        .top {
            border: 1px solid black;
            overflow: hidden;
            flex: 1;
            /* ë¹ì¨ì 1:1:1ë¡ ì£¼ê¸° */
            height: 100%;
            display: inline-block;
        }

        .dropbtn {
            margin-top: 1.5%;
            margin-left: 1.5%;
            border: none;
            outline: none;
            background-color: white;
            font-size: 30px;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            margin-left: 0;
            z-index: 1;
            background-color: #f1f1f1;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        }

        .dropdown-content a {
            display: block;
            padding: 10px 12px;
            color: black;
            text-decoration: none;
        }

        .dropdown-content a:hover {
            background-color: crimson;
            color: white;
        }

        .dropdown-menu {
            font-size: 20px;
        }

        .logo {
            margin-left: 21%;
            padding: 3px 8px;
            display: inline-block;
            height: 100%;
            font-size: 30px;
        }

        .logo-content {
            float: left;
            margin-right: 10px;
        }

        .logo-pic {
            display: inline-block;
            margin: 0;
        }

        .logo-title {
            font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
            color: crimson;
        }

        .rightIcon {
            float: right;
            padding: 3px 8px;
            font-size: 28px;
        }

        .middleDiv {
            border: 1px solid black;
            width: 100%;
            height: 600px;
            position: relative;
        }

        .imgContainer {
            width: 100%;
            height: 100%;
            position: absolute;
        }

        .imgContainer img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .searchBarDiv {
            border: 1px solid black;
            margin: 0 auto;
            margin-top: 100px;
            width: 40%;
            height: 100px;
            position: relative;
        }

        .topRow {
            border: 1px solid black;
            display: inline-block;
            width: 100%;
            height: 50%;
            background-color: white;
        }

        .topRowBar {
            border: 1px solid black;
            float: left;
            width: 33.33%;
            height: 100%;
        }

        .bottomRow {
            border: 1px solid black;
            display: block;
            position: absolute;
            top: 50%;
            width: 100%;
            height: 50%;
            background-color: white;
        }

        .bottomRowBar {
            border: 1px solid black;
            float: left;
            width: 80%;
            height: 100%;
        }

        .searchbtn {
            background-color: crimson;
            color: white;
            width: 20%;
            height: 100%;
            border: none;
        }

        .dealTitleDiv {
            border: 1px solid rgb(151, 151, 151);
            width: 80%;
            height: 50px;
            margin: 30px auto 0 auto;
        }

        .dealTitle {
            border: 1px solid black;
            width: 150px;
            height: 100%;
            display: inline-block;
        }

        .dealDiv {
            border: 1px solid black;
            width: 80%;
            height: 1200px;
            margin: auto;
            overflow: hidden;
        }

        .dealContainer {
            border: 1px solid black;
            display: inline-block;
            margin: 23px 30px;
            width: 28%;
            height: 350px;
        }

        .dealImg {
            border: 1px solid black;
            display: block;
            width: 100%;
            height: 70%;
        }

        .dealText {
            border: 1px solid black;
            display: block;
            width: 100%;
            height: 30%;
        }

        .footer {
            border: 1px solid black;
            width: 100%;
            height: 180px;
        }
    </style>
</head>

<body>

    <div class="dropdown-content">
        <a href="#" class="dropdown-menu">í«ë ì°¾ê¸°</a>
        <a href="#" class="dropdown-menu">ë§¤ì¥ ì°¾ê¸°</a>
    </div>

    <div class="main">
        <div class="topDiv" id="topDiv">
            <div class="top">
                <button class="dropbtn"><i class="fas fa-bars" color="black"></i></button>
            </div>

            <div class="top">
                <div class="logo">
                    <div class="logo-content">
                        <a href="#" style="text-decoration: none">
                            <div class="logo-pic"><i class="fas fa-circle" color="red" style="font-size: 20px"></i></div>
                            <div class="logo-pic"><i class="fas fa-circle" color="yellow" style="font-size: 20px"></i></div>
                            <div class="logo-pic"><i class="fas fa-circle" color="green" style="font-size: 20px"></i></div>
                        </a>
                    </div>
                    <div class="logo-content">
                        <a href="#" class="logo-title" color="black" style="text-decoration: none">Dealight</a>
                    </div>
                </div>
            </div>

            <div class="top">
                <div class="rightIcon"><a href="#"><i class="fas fa-question-circle" color="black"></i></a></div>
                <div class="rightIcon"><a href="#"><i class="fas fa-bell" color="black"></i></a></div>
                <div class="rightIcon"><a href="#"><i class="fas fa-user" color="black"></i></a>
                </div>
            </div>
        </div>

        <div class="middleDiv">
            <div class="imgContainer">
                <img src="../img/main.jpg">

                <form action="/search/" class="searchBarDiv" method="get">
                    <div class="topRow">
                        <input type="text" class="topRowBar" name="pNum" placeholder="인원">
                        <input type="text" class="topRowBar" name="region" placeholder="지역">
                        <input type="text" class="topRowBar" name="time" placeholder="시간">
                    </div>
                    <div class="bottomRow">
                        <input type="text" class="bottomRowBar" placeholder="가게명 검색, 해시태그를 입력하세요">
                        <button class="searchbtn">매장보기</button>
                    </div>
                </form>
                <!-- imgContainer -->
            </div>
            <!-- middleDiv -->
        </div>

        <div class="dealTitleDiv">
            <div class="dealTitle">6</div>
        </div>

        <div class="dealDiv">
            <div class="dealContainer">
                <div class="dealImg">
                </div>
                <div class="dealText">
                </div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
            <div class="dealContainer">
                <div class="dealImg"></div>
                <div class="dealText"></div>
            </div>
        </div>

        <div class="footer"></div>
    </div>

    <script>

    </script>
</body>

</html>