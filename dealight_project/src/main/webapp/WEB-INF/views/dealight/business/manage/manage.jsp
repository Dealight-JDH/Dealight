<!-- 동인 추가 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../../../includes/mainMenu.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 관리</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/0f892675ba.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="/resources/js/Chart.js"></script>
    <style>
        *{
            font-family: 'Nanum Gothic', sans-serif;
        }
        .store_board{
            width: 95%;
            height: auto;
            /*border: 1px solid black;*/
            /*margin: 50px 30px;*/
            margin-top: 20px;
            border-radius: 20px;
            padding: 5px 15px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
        }
        .main_box{
            margin: 20px;
            /*border: 1px black solid;*/
            
        }
        .board{
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            /*border: 1px black solid;*/
        }
        .board_wrapper{
            display: flex;
            flex-wrap:nowrap;
            width: 80%;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            /*border: 1px black solid;*/
        }
        .tab_nav{
            display: flex;
            flex-direction: row;
            justify-content: flex-end;
            align-items: flex-end;
            /*border: 1px solid black;*/
            padding: 5px 0;
            height: 30px;
            width: 90%;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
            margin-bottom: 20px;
        }
        .tab_items{
            /*border: 1px solid black;*/
            padding: auto auto;
            margin: auto 15px 0 15px;
            cursor: pointer;
        }
        .tab_items:hover{
            opacity: 0.7;
            box-shadow: 2px 2px 7px rgba(0, 0, 0, 0.274);
        }
        .tab_items a{
            padding: 5px 5px;
            font-size: 24px;
            font-weight: bold;
        }
        .curTab{
            color: white;
            background-color:  #d32323;
            padding: 0px 8px;
            border-radius: 20px;
        }


        .board_top_box{
            display: flex;
            flex-direction: row;
            justify-content: center;
            /*border: 1px black solid;*/
            width: 90%;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
            margin-bottom: 20px;
        }
        .top_box_items{
            width: 50%;
            /*border: 1px solid black;*/
        }
        .clock{
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: row;
            justify-content: center;
            font-family: 'Montserrat', sans-serif;
        }
        .cur_date{
            font-size: 24px;
            font-weight: bold;
            width: 50%;
            height: 100%;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            /*border: 1px solid black;*/
        }
        .cur_date > span {
            padding-right: 10px;
        }
        .cur_time{
            font-size: 24px;
            font-weight: bold;
            width: 50%;
            height: 100%;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            /*border: 1px solid black;*/
        }
        .cur_time > span{
            padding-right: 10px;
        }
        .time{
            color: rgba(0, 0, 0, 0.794);
        }
        .btn_seat_stus{
            cursor: pointer;
            outline: none;
            border: 0; 
            padding: 0; 
            background-color: transparent !important; 
            font-size: 32px;
            padding: 0 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.274);
            opacity: 0.5;
        }
        .btn_seat_stus:hover{
            opacity: 1.0;
        }
        .btn_seat_stus.green{color: green;}
        .btn_seat_stus.yellow{color: yellow;}
        .btn_seat_stus.red{color: red;}
        .top_box_items{
            padding: 10px;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
        }
        .top_box_items.light{
        	justify-content: flex-end;
        	
            /*border: 1px solid black;*/
        }
        .top_box_items.light > *{
            /*border: 1px black solid;*/

        }
        .top_box_items.light > span{
            font-weight: bold;
            font-size: 24px;
            padding-right: 10px;
        }
        .curStus {
            opacity: 1.0;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
        }

        /* board */
        #board{
            /*border: 1px black solid;*/
            width: 90%;
            height: 600px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
        }
        .board_left_box{
            width: 40%;
            height:90%;
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            justify-content: space-around;
        }
        .board_right_box{
            width: 55%;
            height: 90%;
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .next_wrapper{
            /*border: 1px solid black;*/
            padding-right: 0px;
            width: 70%;
            height: 80%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-around;
            
        }
        .next_wait{
            position: relative;
            /*border: 1px solid black;*/
            height: 40%;
            width: 100%;
            border-radius: 20px;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
        }
        .btn_enter_wait{
	        position: absolute;
	            left: 100%;
	            top: 10%;
	            width: 60px;
	            text-align: center;
	            border-radius: 0 10px 10px 0;
	            background-color: gray;
	            color: white;
	            font-size: 18px;
	            font-weight: bold;
	            padding: 4px 7px;
	            cursor: pointer;
	            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
	            outline:none;
            	border:0px;
          }
        .btn_enter_wait:hover{
            opacity: 0.7;
        	}
        .btn_noshow_wait{
        	position: absolute;
            left: 100%;
            top: 40%;
            width: 60px;
            text-align: center;
            border-radius: 0 10px 10px 0;
            background-color: gray;
            color: white;
            font-size: 18px;
            font-weight: bold;
            padding: 4px 7px;
            cursor: pointer;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            outline:none;
            border:0px;
        }
        .btn_noshow_wait:hover{
            opacity: 0.7;
        }
        .next_rsvd{
            position: relative;
            /*border: 1px solid black;*/
            height: 40%;
            width: 100%;
            border-radius: 20px;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
        }
        .next_tit{
            position: absolute;
            border-radius: 10px;
            left: 20px;
            top: 10px;
            padding: 5px 10px;
            background-color: #d32323;
            color: white;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            font-weight: bold;
            letter-spacing: 2px;
        }
        .next_info{
            margin-top: 20px;
            margin-left: 20px;
            /*border: 1px black solid;*/
            width: 90%;
            height: 70%;
            padding: 5px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .next_info_top{
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: flex-end;
            /*border: 1px solid black;*/
            width: 100%;
            height: 30%;
        }
        .next_info_top > span{
            
            padding-bottom: 3px;
        }
        .next_info_bot{
            /*border: 1px solid black;*/
            width: 100%;
            height: 70%;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            align-items: center;
        }
        .wait_name{
            letter-spacing: 2px;
            font-weight: bold;
            font-size: 14px;
            border-radius: 20px;
            color: white;
            padding: 4px 7px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            background-color: rgba(106, 153, 255, 0.87);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
        }
        .wait_telno{
            align-self: flex-end;
            letter-spacing: 2px;
            font-weight: bold;
            font-size: 9px;
            border-radius: 20px;
            color: white;
            padding: 4px 7px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            background-color: rgba(106, 153, 255, 0.87);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
        }
        .next_wait_pnum{
            font-weight: bold;
            font-size: 42px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .next_wait_regtm{
            font-weight: bold;
            font-size: 42px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .next_rsvd_name{
            letter-spacing: 2px;
            font-weight: bold;
            font-size: 14px;
            border-radius: 20px;
            color: white;
            padding: 4px 7px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            background-color: rgba(106, 153, 255, 0.87);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
        }
        .next_rsvd_telno{
            align-self: flex-end;
            letter-spacing: 2px;
            font-weight: bold;
            font-size: 9px;
            border-radius: 20px;
            color: white;
            padding: 4px 7px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            background-color: rgba(106, 153, 255, 0.87);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
        }
        .next_rsvd_pnum{
            font-weight: bold;
            font-size: 42px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .next_rsvd_tm{
            font-weight: bold;
            font-size: 42px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .list_wrapper{
            /*border: 1px black solid;*/
            width: 100%;
            height: 80%;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            align-items: flex-start;
        }
        
        .wait_list_wrapper{
            /*border: 1px black solid;*/
            width: 40%;
            height: 100%;
            
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            overflow:scroll;
            box-shadow: 2px 2px 7px rgba(0, 0, 0, 0.274);
        }
        .wait_list_wrapper::-webkit-scrollbar{
            display: none;
        }
        .rsvd_list_wrapper{
            /*border: 1px black solid;*/
            width: 40%;
            height: 100%;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            overflow:scroll;
            box-shadow: 2px 2px 7px rgba(0, 0, 0, 0.274);
        }
        .rsvd_list_wrapper::-webkit-scrollbar{
            display: none;
        }
        .wait_list_tit{
            position: absolute;
            border-radius: 10px;
            left: 20px;
            top: 10px;
            padding: 5px 10px;
            background-color: #d32323;
            color: white;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            font-weight: bold;
            letter-spacing: 2px;
        }
        .rsvd_list_tit{
            position: absolute;
            border-radius: 10px;
            left: 20px;
            top: 10px;
            padding: 5px 10px;
            background-color: #d32323;
            color: white;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            font-weight: bold;
            letter-spacing: 2px;
        }
        .wait{
            /*border: 1px solid black;*/
            height: 25%;
            min-height: 20%;
            width: 90%;
            margin: 5px;
            border-radius: 10px;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.404);
        }
        .wait > button{
            position: absolute;
            right: 15px;
            bottom: 10px;
        }
        .list_blank{
            /*border: 1px solid black;*/
            min-height: 15%;
            height: 15%;
            width: 90%;
        }
        .list_info_top{
            /*border: 1px black solid;*/
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            align-items: center;
        }
        .list_info_bot{
            /*border: 1px black solid;*/
            width: 100%;
            height: 50%;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
        }
        .wait{
        	cursor:pointer;
        }
        .wait_name.wait_list{
            align-items: center;
        }
        .wait_telno.wait_list{
            align-self: center;
        }
        .list_wait_pnum{
            /*border: 1px black solid;*/
            font-weight: bold;
            font-size: 24px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .list_wait_regtm{
            /*border: 1px black solid;*/
            font-weight: bold;
            font-size: 24px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .list_info_bot >span{
            margin-left: 20px;
            margin-right: 10px;
        }
        .list_info_bot.rsvd_list{
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }
        .rsvd{
            /*border: 1px solid black;*/
            height: 25%;
            min-height: 20%;
            width: 90%;
            margin: 5px;
            border-radius: 10px;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.404);
        }
        .rsvd_name.rsvd_list{
            align-items: center;
        }
        .rsvd_telno.rsvd_list{
            align-self: center;
        }
        .list_rsvd_pnum{
            /*border: 1px black solid;*/
            font-weight: bold;
            font-size: 24px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .list_rsvd_regtm{
            /*border: 1px black solid;*/
            font-weight: bold;
            font-size: 24px;
            color:rgba(0, 0, 0, 0.548);
            text-shadow: 3px 3px 4px rgba(0, 0, 0, 0.13);
        }
        .rsvd_name{
            letter-spacing: 2px;
            font-weight: bold;
            font-size: 14px;
            border-radius: 20px;
            color: white;
            padding: 4px 7px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            background-color: rgba(106, 153, 255, 0.87);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
        }
        .rsvd_telno{
            align-self: flex-end;
            letter-spacing: 2px;
            font-weight: bold;
            font-size: 9px;
            border-radius: 20px;
            color: white;
            padding: 4px 7px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            background-color: rgba(106, 153, 255, 0.87);
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
        }
        
        /* 타임 바*/
        .rsvd_time_bar{
            /*border: solid 1px black;*/
            position: relative;
            margin : 0 auto;
            margin-top : 50px;
            margin-bottom: 50px;
            border-radius: 10px;
            width: 80%;
            height: 100px;
            display: flex;
            flex-direction: row;
            overflow-x: auto;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            font-family: 'Montserrat', sans-serif;
        }
        .rsvd_time {
            width: 150px;
    		flex-shrink: 0;
    		height: 100%;
        }
        .time_table{
            border :rgba(255, 255, 255, 0.575) solid 1px;
            border-radius: 5px;
       		width: 150px;
        	height: 50px;
            /* green 예약 없을 때 */
            background-color: rgba(125, 255, 164, 0.698);
            /* green 예약 있을 때*/
            /*background-color: rgba(37, 201, 89, 0.911);*/
            /* yellow */
            /*background-color: rgba(248, 236, 73, 0.781);*/
            /* red */
            /*background-color: #d32323;*/
            /* gray*/
            /*background-color: #29242460;*/
        }
        .time_text_box{
            display: flex;
            justify-content: center;
            flex-direction: row;
            align-items: center;
        }
        .time_text{
            text-align: center;
            font-weight: bolder;
            font-size: 16px;
            padding: 3px;
            margin: 3px;
        }
        .cur_time_mark{
            display: inline;
            position: absolute;
            top: 12px;
            left: 180px;
            border: 8px solid;
            border-color: #d32323 transparent transparent transparent;
            pointer-events: none;
        }
        /* manage side menu*/
        .manage_side_menu{
            width: 20%;
            height: 748px;
            /*border: 1px black solid;*/
            display: flex;
            justify-content: flex-start;
            align-items: center;
            flex-direction: column;
            box-shadow: 2px 2px 7px rgba(0, 0, 0, 0.274);
        }
        .manage_side_menu a{text-decoration: none; color: white;}
        .manage_side_menu a:visited { text-decoration: none; color: white;} 
        .manage_side_menu a:hover { text-decoration: none; color: white;} 
        .manage_side_menu a:active { text-decoration: none; color: white;}
        .manage_side_menu > div{
            cursor: pointer;
            width: 70%;
            height: 10%;
            margin: 50px 0 0 0;
            padding: 20px;
            /*border: 1px solid black;*/
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            background-color: #d32323;
            color: white;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            box-shadow: 3px 3px 8px rgba(0, 0, 0, 0.527);
        }
        
        .btn_wait_register{
            text-align: center;
            line-height: 40px;
        }
        #side_menu_tit{
            cursor: unset;
            width: 100%;
            padding: 0;
            border-radius: 0;
            align-self: start;
            margin-top: 0;
            margin-bottom: 50px;
        }
        .info_box{
            width: 95%;
            height: auto;
            /*border: 1px solid black;*/
            margin: 50px 30px;
            border-radius: 20px;
            
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
        }
        #store_board_main{
        	width:95%;
        	max-width:95%;
        }
        #switch_manage{
        	color:white;
        }
        /* The Modal (background) */
        .modal {
	        display: none; /* Hidden by default */
	        position: fixed; /* Stay in place */
	        z-index: 1; /* Sit on top */
	        left: 0;
	        top: 0;
	        width: 100%; /* Full width */
	        height: 100%; /* Full height */
	        overflow: auto; /* Enable scroll if needed */
	        background-color: rgb(0,0,0); /* Fallback color */
	        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	        animation: fadeEffect 0.3s;
        }

                /* The Modal (background) */
        .modal {
	        display: none; /* Hidden by default */
	        position: fixed; /* Stay in place */
	        z-index: 1; /* Sit on top */
	        left: 0;
	        top: 0;
	        width: 100%; /* Full width */
	        height: 100%; /* Full height */
	        overflow: auto; /* Enable scroll if needed */
	        background-color: rgb(0,0,0); /* Fallback color */
	        background-color: rgba(0, 0, 0, 0.219); /* Black w/ opacity */
	        animation: fadeEffect 0.8s;
        }

        /* Modal Content/Box */
        .modal-content {
            position: relative;
	        background-color: #fefefe;
	        margin: 10% auto; /* 15% from the top and centered */
	        
	        display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-self: start;
            border-radius: 15px;
            box-shadow: 3px 3px 7px rgba(44, 36, 36, 0.342);
	        width: 40%; /* Could be more or less, depending on screen size */
            height: 60%;
	        animation: fadeEffect 0.3s;
            overflow: scroll;
        }
        .modal_header{
            padding: 0 0;
            width: 100%;
            padding: 20px;
            padding-bottom: 25px;
            /*border: 1px black solid;*/
            background-color: #d32323;
            border-radius: 15px 15px 0 0;
        }
        .modal_wrapper_regwait{
            margin: 10px;
            padding: 0 25px 50px 25px;
            /*display: flex;*/
            flex-direction: column;
            justify-content: center;
            align-items: center;
            display:none;
        }
        .modal_tit{
            /*border: 1px black solid;*/
            
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            width: 100%;
            height: 50px;
            color: #d32323;
            text-shadow: 1px 1px 6px rgba(44, 36, 36, 0.171);
        }
        .modal_top{
            width: 100%;
            height: 250px;
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }
        .modal_bot{
            width: 100%;
            height: 100px;
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .modal_bot > div{
            font-weight: bold;
            font-size: 18px;
            margin: 5px 0;
        }
         .modal-content ul{
         	margin : 0 0;
         	display : inline-block;
        }

        /* The Close Button */
        .close_modal {
            position : absolute;
            right : 20px;
            top : 10px;
            display : inline-block;
            margin : 0 0;
            color: white;
            font-size: 24px;
        
        }

        .close_modal:hover,
        .close_modal:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .form_left_wrapper{
            width: 50%;
            height: 80%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            border-right: 2px rgba(71, 71, 71, 0.26) solid;
        }
        .form_right_wrapper{
            width: 50%;
            height: 80%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            /*border: 1px black solid;*/
        }
        #submit_waitRegForm{
            padding: 30px;
            background-color:#d32323;
            color: white;
            font-size: 32px;
            font-weight: bold;
            border: 0;
            border-radius: 30px;
            text-shadow: 1px 1px 6px rgba(44, 36, 36, 0.171);
            box-shadow: 1px 1px 6px rgba(44, 36, 36, 0.171);
            outline: none;
            cursor: pointer;
        }
        #submit_waitRegForm:hover{
            opacity: 0.7;
        }
        #waitRegForm{
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            flex-direction: column;
            align-items: center;
        }
        #waitRegForm > div{
            width: 80%;
            margin-top: 10px 0 10px 0;
        }
        #waitRegForm input {
            width: 100%;
            height: 30px;
            border: 1px rgb(122, 122, 122) solid;
            margin: 10px 0 10px 0;
            border-radius: 5px;
            padding-left: 10px;
        }
        #waitRegForm input:focus{
            border:1px black solid;
        }
        #name_msg,#phoneNum_msg,#pnum_msg{
        	width:100%;
        	height:10px;
        	font-size:6px;
        	color:green;
        	padding-left : 10px;
        }
        
        
        /* hover */
        
        .dealight_tooltip {
        position: relative;
        display: inline-block;
        border-bottom: 1px dotted black;
        }

        .dealight_tooltip .dealight_tooltiptext {
        visibility: hidden;
        width: 300px;
        background-color: white;
        color: black;
        text-align: center;
        font-weight : bold;
        border-radius: 6px;
        padding: 5px 0;
		box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
        /* Position the dealight_tooltip */
        position: absolute;
        top : 0px;
        z-index: 1;
        }

        .dealight_tooltip:hover .dealight_tooltiptext {
        visibility: visible;
        }
        .time_table_rsvd_dtls{
        	cursor:pointer;
        }
        .time_table_rsvd_dtls:hover{
        	opacity:0.7;
        }
        .btnRsvd{
        	cursor:pointer;
        }
        
        /* 예약 상세 모달 추가 */
        .modal_wrapper_rsvdDtls{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .modal_top.rsvdDtls{
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: flex-start;
            height: 250px;
            /*border: 1px black solid;*/
            margin-bottom: 20px;
            
        }
        .htdl_stus{
            position: absolute;
            top: 55px;
            right: 30px;
            font-size: 36px;
            color: #d32323;
        }
        .modal_rsvd_info{
            
            padding-left: 20px;
            line-height: 25px;
        }
        .rsvd_left_wrapper{
            width: 50%;
            height: 80%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            padding-top: 5px;
            margin-top:15px;
            border-right: 2px rgba(71, 71, 71, 0.26) solid;
        }
        .rsvd_right_wrapper{
            width: 50%;
            height: 80%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            padding-top: 5px;
            margin-top:15px;
            overflow:scroll;
        }
        .modal_bot_rsvd{
            width: 95%;
            height: 170px;
            /*border: 1px black solid;*/
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            overflow: scroll;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.219);
            border-radius: 10px;
        }
        .rsvd_history{
            margin-top: 5px;
            position: relative;
            width: 80%;
            height: 130px;
            /*border: 1px solid black;*/
            border: 1px solid rgba(92, 92, 92, 0.205);
            border-radius: 10px;
            margin-bottom: 10px;
            box-shadow: 2px 2px 8px rgba(44, 36, 36, 0.171);
            overflow: scroll;
            min-height: 100px;
            padding:8px;
        }
        .rsvd_history .htdl_stus{
            top: 10px;
            right: 20px;
            font-size: 18px;
        }
        
        /* info box */
        .info_box{
            width: 95%;
            height: auto;
            /*border: 1px solid black;*/
            margin: 50px 30px;
            border-radius: 20px;
            
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.274);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            overflow: hidden;
        }
        .store_info_tit{
            width: 100%;
            align-self: start;
            border-radius: 20px 20px 0 0;
            padding: 20px 20px 20px 30px;
            font-size: 24px;
            font-weight: bold;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            margin-top: 0;
            color: white;
            letter-spacing: 4px;
            background-color: #d32323;
            height: 40px;
        }
        .store_info_cnts{
            padding: 30px;
            line-height: 30px;
            font-size: 18px;
            font-weight: bold;
        }
        .uploadResult{
            width: 100%;
            /*border: 1px black solid;*/
            padding: 0 10px 0 0;
        }
        .uploadResult > ul {
            
            width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
            background-color: white;
            /*border: 1px black solid;*/
            overflow: scroll;
            list-style-type:none;
        }

        .uploadResult > ul img {
            margin: 20px 60px;
            min-width: 150px;
            max-height: 100%;

        }


        .store_img_tit{
            padding: 30px;
            line-height: 30px;
            font-size: 18px;
            font-weight: bold;
        }
        .dealight_tooltip_user {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: flex-start;
            margin: 40px;
            width: 200px;
            height: 100px;
            padding: 10px 15px;
            
            border: 1px rgba(82, 82, 82, 0.185) solid;
            background-color: #d32323;
            color: white;
            font-weight: bold;
            font-size: 24px;
            border-radius: 20px;
            position: relative;
            display: inline-block;
            cursor: pointer;
            box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.274);
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.246);
            border-right: 32px rgba(0, 0, 0, 0.493) solid ;
        }
        .dealight_tooltip_user .dealight_tooltiptext_user {
            visibility: hidden;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-start;
            width: 180px;
            height: 150px;
            background-color:  rgb(128, 128, 128);
            color: white;
            text-align: center;
            font-size: 18px;
            font-weight : bold;
            border-radius: 6px;
            padding: 20px 20px;
            box-shadow: 2px 2px 12px rgba(0, 0, 0, 0.700);
            /* Position the dealight_tooltip */
            position: absolute;
            top : -200px;
            right: 5px;
            z-index: 1;
        }
        .dealight_tooltip_user:hover{
        	opacity:0.7;
        }

        .dealight_tooltip_user:hover .dealight_tooltiptext_user {
             visibility: visible;
             opacity: 1; 
        }
        
        #rsvd_rslt_baord{
        	width:90%;
        	height:600px;
        	flex-direction: column;
        	justify-content: flex-start;
        	align-items: center;
        	box-shadow: 2px 2px 12px rgba(0,0,0,0.274);
        }
        .chart_wrapper{
        	width:auto;
        	height:60%;
        }
        .last_week_trend{
        	padding:15px 30px;
        	color : white;
        	background-color : #d32323;
        	display:flex;
        	flex-direction: row;
        	justify-content: flex-start;
        	align-items: center;
        	font-weight: bold;
        	font-size:36px;
        	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.274);
        	margin-bottom: 15px;
        	
        }
        .today_rsvd_rslt_tit{
        	display:block;
        	border-radius:20px;
        	
        	margin-left:20px;
        	padding: 10px 20px;
        	background-color: black;
        	color:white;
        	font-size: 18px;
        	font-weight: bold;
        	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.274);
        }
        .rsvdRslt{
        	margin-top:30px;
        	margin-left:20px;
        	display:flex;
        	flex-direction: column;
        	justify-content: flex-start;
        	align-items: flex-start;
        }
        .rsvd_rslt_wrapper{
        	font-size : 18px;
        	font-weight:bold;
        	margin-top:15px;
        	margin-left:20px;
        	display: flex;
        	flex-direction: row;
        	justify-content: flex-start;
        	align-items: center;
        }
        .rsvd_rslt_wrapper > div {
        	margin-right: 15px;
        }
        #seatStusForm{
        	margin-bottom: 0;
        	margin-right:50px;
        }
        /* 핫딜 제안 등록 폼*/
                .modal_wrapper_htdl_regform{
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
        }
        .modal_top.htld_reg{
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
        }
        .regHtdlForm{
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
        }
        .htdl_reg_form_wrapper{
            width:  70%;
        }
        .htdl_menu{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            font-size: 12px;
        }
        .htdl_menu_itmes{
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
            width: 80%;
        }
        .htdl_label_input {
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-content: center;
            width: 80%;
        }
        .htdl_label_input > span{
            margin: 5px 0;
            width: 30%;
            font-size: 12px;
            margin-right: 30px;
            font-weight: bold;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
        }
        .htdl_label_input > input,textarea,select{
            margin: 5px 0;
            width: 80%;
            border-radius: 3px;
            border: 1px black solid;
            resize: none;
            padding: 5px;
        }
        .htdl_reg_btn_box{
        	margin-top : 20px;
            width: 80%;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: flex-start;
        }
        .htdl_reg_btn_box button{
            outline: none;
            background-color:#d32323b6;
            color:white;
            font-size: 18px;
            border-radius: 10px;
            padding: 3px 12px;
            border: 0;
            cursor: pointer;
            margin-right: 20px;
            font-weight: bold;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.219);
        }
        .htdl_reg_btn_box button:hover{
            opacity: 0.7;
        }
        .uploadDiv.htdl{
            width: 80%;
        }
        
    </style>
</head>
<body>
    <main class="store_board" id="store_board_main">
        <div class="main_box"><!-- main box -->
            <div class="board"> <!-- board -->
                <div class="manage_side_menu">
                    <div id="side_menu_tit">
                        매장 관리 화면
                    </div>
                    <div class="btn_wait_register">
                        오프라인 웨이팅<br>
                        등록
                    </div>
                    <div>
                        <a href="/dealight/business/manage/dealhistory?storeId=${storeId}">핫딜 히스토리</a>
                    </div>
                    <div>
                        <a href="/dealight/business/manage/modify?storeId=${storeId}">매장 정보 수정</a>
                    </div>
                </div>
                <div class="board_wrapper"> <!-- board wrapper -->
                    <nav class="tab_nav">
                            <div class="tab_items curTab"><a class="switch switch_board" id="switch_manage">매장관리</a></div>
                            <div class="tab_items"><a class="switch switch_rsvd_rslt">현황판</a></div>
                    </nav>
                    <div class="board_top_box"> <!-- top box -->
                        <div class="top_box_items date_box"> <!-- cur time -->
                            <div class="js-clock clock">
                                    <div class="cur_date">
                                        <span><i class="far fa-calendar-alt"></i></span>
                                        <span class="date">2020-12-18</span>
                                    </div>
                                    <div class="cur_time">
                                        <span><i class="far fa-clock"></i></span>
                                        <span class="time">00:00</span>
                                    </div>
                            </div>
                        </div> <!-- end time -->
                        <div class="top_box_items light"> <!-- light -->
                            <span>현재 착석 상태</span>
                            <form id="seatStusForm" action="/dealight/business/manage/board/seat"
                                    method="put">
                                    <input name="seatStusColor" id="color_value" value="" hidden>
                                    <input name="storeId" value="${storeId}" hidden>
                                    <button class="btn_seat_stus green" data-color="Green"><i class="fas fa-circle"></i></button>
                                    <button class="btn_seat_stus yellow" data-color="Yellow"><i class="fas fa-circle"></i></button>
                                    <button class="btn_seat_stus red" data-color="Red"><i class="fas fa-circle"></i></button>
                            </form>
                        </div> <!-- end light -->
                </div> <!-- end top box -->
        
                <div id="rsvd_rslt_baord" style="display : none">
                    <div class="last_week_trend">최근 7일 Trend</div>
                    <div class="chart_wrapper"><canvas id="rsvd_chart" style="height:30vh; width:50vw"></canvas></div>
                    <div class="rsvdRslt">
	                                        
                    </div>
                    <!-- 
                    <h1>최근 7일 예약 현황</h1>            
                    <div class="last_week_rsvd"></div>
                     -->
                </div>
        
                <div id="board">
                    <div class="board_left_box">
                        <div class="next_wrapper">
                            <div class="next_wait">
                                <span class="next_tit">NEXT 웨이팅</span>
                                <div class="next_info nextWait">

                                </div>
                            </div>
                            <div class="next_rsvd">
                                <span class="next_tit">NEXT 예약</span>
                                <div class="next_info nextRsvd">
                                    
                                </div>
                            </div>
                        </div>
                    </div> <!-- end left box -->
                    <div class="board_right_box">
                        <div class="list_wrapper">
                            <div class="wait_list_wrapper waitList">
                            </div>
                            <div class="rsvd_list_wrapper rsvdList">
                            </div>
                        </div>
                    </div> <!-- end right box -->
                </div> <!-- end board wrapper -->
            </div> <!-- end board -->
            </div>
                <div class="rsvd_time_bar"><!-- rsvd time bar -->
                    
                </div> <!-- end rsvd time bar -->
            </div> <!-- end main box -->
        </main>


        <div class="info_box"> <!--  info box -->
	        <div class="store_info_tit">
	            <span>매장 정보</span>
	           </div>
            <div class="store_info_cnts">
			
			</div>
            <div class="store_img_tit">
            	<span>매장 사진</span>
        	</div>
            <div class='uploadResult'>
                <ul>
                </ul>
            </div> <!-- uploadResult -->
            
            <div class='bigPictureWrapper'>
                <div class='bigPicture'>
                </div>
            </div>
            
    <div>
		<c:if test="${empty todayRsvdUserList}">
			<h2>오늘 예약하신 손님이 없습니다.🤣</h2>
		</c:if>
		
		<c:if test="${not empty todayRsvdUserList}">
			<c:forEach items="${todayRsvdUserList}" var="user">
			<div class="dealight_tooltip_user">
	            <div class="rsvd_user_name">${user.name}</div>
	            <div class="rsvd_user_id">${user.userId}</div>
	            <div class="rsvd_user_telno">${user.telno}</div>
	            <div class="dealight_tooltiptext_user">
	                <span>예약 번호 : ${user.rsvdId}</span>
	                <span>핫딜 번호 : 124</span>
	                <span>예약 인원 : ${user.pnum}</span>
	                <span>등록 날짜 : ${user.inDate }</span>
	                <span>총 가격 : ${user.totAmt }</span>
	                <span>총 주문 수량 : ${user.totQty }</span>
	            </div>
	        </div>
			</c:forEach>
		</c:if>
	</div>
        </div> <!-- end info box -->
        	<!-- The Modal -->
	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close_modal"><i class="fas fa-times"></i></span>
	        <div class="modal_header"></div>
			<ul class="rsvdDtls"></ul>
			<ul class="userRsvdList"></ul>
			<ul class="waiting_registerForm"></ul>
			<div class="modal_wrapper_regwait content_div"></div>
			<div class="modal_wrapper_rsvdDtls content_div"></div>
			<div class='modal_wrapper_htdl_regform content_div'></div>
		</div>
	</div>
<script>

const storeId = ${storeId};

/*시간바 만들기*/
/*현재시간으로 스크롤 고정*/
let writeTimeBar = function (curTime) {
        timeArr = ['','09:00','09:30','10:00','10:30','11:00','11:30','12:00'
            ,'12:30','13:00','13:30','14:00','14:30','15:00','15:30','16:00',
            '16:30','17:00','17:30','18:00','18:30','19:00','19:30','20:00','20:30','21:00','21:30','22:00'];
        let strTime = "";
        let curPos = 0; 
        strTime += "<div class='cur_time_mark'></div>";
        for(let i = 1; i <= 27; i++){
            if(curTime === timeArr[i])
                curPos = i - 1;
            strTime += "<div class='rsvd_time dealight_tooltip' id='slide-"+i+"'><div class='time_text_box'><span class='time_text'>"+timeArr[i]+"</span></div><div class='time_table'></div></div>";
        }
        document.querySelector(".rsvd_time_bar").innerHTML = strTime;
        // 예약 상태바 초기 스크롤 고정
        document.querySelector(".rsvd_time_bar").scrollLeft = ((parseInt(curPos)*150) - 150);
        document.getElementsByClassName("cur_time_mark")[0].style.left= ((parseInt(curPos)*150) + 30).toString() +'px';
        }

    let curToday = new Date();
    let curHour = curToday.getHours(),
        curMinutes = curToday.getMinutes();
        
        if(curMinutes >= 30)
            curMinutes = '30';
        else
            curMinutes = '00';
        
        let curTime = curHour + ":" + curMinutes;

        // TimeBar 작성
        writeTimeBar(curTime);
	
	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close_modal"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
		modal.find(".content_div").html("");
		modal.find(".content_div").css("display","none");
	});
	
	window.onclick = function(e) {
		
		  if (e.target === document.getElementById('myModal')) {
			  modal.css("display","none");
			  modal.find("ul").html("");
			  modal.find(".content_div").html("");
			  modal.find(".content_div").css("display","none");
		  }
	}
	
    // esc 눌러서 모달 escape
    $(document).keyup(function(e) {
    	if(e.key === "Escape"){
    		modal.css("display","none");
    		modal.find("ul").html("");
    		modal.find(".content_div").html("");
    		modal.find(".content_div").css("display","none");
    	}
    });
    
    	$(".alert_closebtn").on("click", e => {
    		$(e.target).parent().addClass("hide");
    		$(e.target).parent().removeClass("show");
    		//setTimeout($(e.target).parent().removeClass("showAlert"),5000); 	
    	});
    	
        
    	

</script>
<script>

    /*
    REST 방식으로 서버와 통신
    	비동기로 board를 바꿔주는 서비스
    */
    let boardService = (() => {
      
    	
        /*put 함수*/
        // 매장의 착석 상태 코드를 변경한다.
        function putChangeStatusCd(params,callback,error) {
        	
        	let storeId = params.storeId,
        		seatStusCd = params.seatStusCd;
        	
            $.ajax({
                type:'put',
                url:'/dealight/business/manage/board/seat/'+storeId+'/'+seatStusCd,
                data : {},
                contentType : "application/json",
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
    	 // 매장의 웨이팅 상태를 '노쇼'로 변경한다.
        function putNoshowWaiting(waitId,callback,error) {
            $.ajax({
                type:'put',
                url:'/dealight/business/manage/board/waiting/noshow/' + waitId,
                data : {waitId:waitId},
                contentType : "application/json",
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
    
     	// 매장의 웨이팅 상태를 '입장'으로 변경한다.
        function putEnterWaiting(waitId,callback,error) {
    
            $.ajax({
                type:'put',
                url:'/dealight/business/manage/board/waiting/enter/' + waitId,
                data : {waitId:waitId},
                contentType : "application/json",
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
    	
     	// 매장의 웨이팅 상태를 '취소'로 변경한다.
        function putCancelWaiting(waitId,callback,error) {
    
            $.ajax({
                type:'put',
                url:'/dealight/business/manage/board/waiting/cancel/' + waitId,
                data : {waitId:waitId},
                contentType : "application/json",
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
    
        /*get 함수*/
        // 예약의 '예약상세'를 가져온다.
        function getRsvdDtls(param,callback,error) {
        	
        	let rsvdId = param.rsvdId;
        	
        	$.getJSON("/dealight/business/manage/board/reservation/dtls/" + rsvdId + ".json",
        		function(data) {
        			if(callback) {
        				callback(data);
        			}
        	}).fail(function(xhr,status,err){
        		if(error) {
        			error();
        		}
        	});
        	
        }
        
     	// 사용자의 '해당 매장'의 '예약 리스트'를 가져온다.
		function getUserRsvdList(param,callback,error) {
        	
        	let storeId = param.storeId,
        		userId = param.userId;
        	
        	//console.log(storeId);
        	//console.log(userId);
        	
        	$.getJSON("/dealight/business/manage/board/reservation/list/" + storeId +"/" + userId + ".json",
        		function(data) {
        			if(callback) {
        				callback(data);
        			}
        	}).fail(function(xhr,status,err){
        		if(error) {
        			error();
        		}
        	});
        	
        }
        
        // 매장의 '예약 현황판' 내용을 가져온다.
		function getRsvdRslt(param,callback,error) {
            
            let storeId = param.storeId;
            
            $.getJSON("/dealight/business/manage/board/reservation/rslt/"+storeId+".json",
                function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
        }
        
        // '해당 매장'의 '예약 리스트'를 가져온다.
        function getRsvdList(param,callback,error) {
            
            let storeId = param.storeId;
            
            let rsvdList = $.getJSON("/dealight/business/manage/board/reservation/"+storeId+".json",
                function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
    	
            
            return rsvdList;
        }
    
        // '해당 매장'의 '웨이팅 리스트'를 가져온다.
        function getWaitList(param,callback,error) {
            
            let storeId = param.storeId;
            
            let waitList = $.getJSON("/dealight/business/manage/board/waiting/"+storeId+".json",
                function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
            
            return waitList;
        }
    
        // '매장'의 정보를 가져온다.
        function getStore(param,callback,error) {
            
            let storeId = param.storeId;
    
            $.getJSON("/dealight/business/manage/board/store/"+storeId+".json",
                    function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
        }
        
        // '웨이팅 리스트'에서 '다음 웨이팅'을 가져온다.
        function getNextWait(waitList){
            if(!waitList){
                return;
            }
                       
            return waitList.filter(wait =>  wait.waitStusCd === 'W')
                    .sort((w1,w2) =>  w1.waitId - w2.waitId)[0];
        };
        
        // 오늘의 예약을 '시간대 별'로 가져온다.
        function getTodayRsvdMap(param,callback,error){
      
        	let storeId = param.storeId;
        	
        	$.getJSON("/dealight/business/manage/board/reservation/map/"+ storeId +".json",
                    function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });

        };
        
        // 오늘의 시간대 별 예약 상태를 가져온다.
        function getTodayRsvdStusMap(param,callback,error){
      
        	let storeId = param.storeId;
        	
        	$.getJSON("/dealight/business/manage/board/reservation/stusmap/"+ storeId +".json",
                    function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });

        };
        
        // 해당 매장의 다음 웨이팅을 가져온다.
        function getNextRsvd(param,callback,error){
        	
        	
        	let storeId = param.storeId;
        	
        	
        	$.getJSON("/dealight/business/manage/board/reservation/next/"+ storeId +".json",
                    function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
        };
        
        // 매장의 '지난 7일 웨이팅 현황' 내용을 가져온다.
		function getLastWeekWait(param,callback,error) {
            
            let storeId = param.storeId;
            
            $.getJSON("/dealight/business/manage/board/waiting/rslt/"+storeId+"/list.json",
                function(data){
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
        };
    
        // 웨이팅 정보를 등록한다.
        function regWait(wait, callback,error) {
    
            $.ajax({
                type : 'post',
                url : '/dealight/business/manage/board/waiting/new',
                data : JSON.stringify(wait),
                contentType : "application/json; charset=utf-8",
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
            })
        }
        
        // 핫딜 정보를 등록한다.
        function regHtdl(wait, callback,error) {
    
            $.ajax({
                type : 'post',
                url : '/dealight/business/manage/board/htdl/new',
                data : JSON.stringify(wait),
                contentType : "application/json; charset=utf-8",
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
            })
        }
        
        // '해당 매장'의 지난주 예약 정보를 가져온다.
        function getLastWeekRsvd(param, callback,error) {
        	
			let storeId = param.storeId;
        	
        	$.getJSON("/dealight/business/manage/board/reservation/rslt/"+ storeId +"/list.json",
                    function(data){
        					console.log(data);
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
        };
        
        function getMenuList(param,callback,error) {
        	
        	let storeId = param.storeId;
        	
        	$.getJSON("/dealight/business/manage/board/menus/"+ storeId +".json",
                    function(data){
        					console.log(data);
                        if(callback){
                            callback(data);
                        }
                    }).fail(function(xhr,status,err){
                        if(error){
                            error();
                        }
            });
        	
        }
        
    
        return {
            regWait:regWait,
            regHtdl:regHtdl,
            getStore : getStore,
            getWaitList : getWaitList,
            getRsvdList : getRsvdList,
            putCancelWaiting : putCancelWaiting,
            putNoshowWaiting : putNoshowWaiting,
            putEnterWaiting : putEnterWaiting,
            putChangeStatusCd : putChangeStatusCd,
            getNextWait : getNextWait,
            getNextRsvd : getNextRsvd,
            getTodayRsvdMap : getTodayRsvdMap,
            getTodayRsvdStusMap : getTodayRsvdStusMap,
            getRsvdRslt : getRsvdRslt,
            getLastWeekWait : getLastWeekWait,
            getUserRsvdList : getUserRsvdList,
            getRsvdDtls : getRsvdDtls,
            getLastWeekRsvd : getLastWeekRsvd,
            getMenuList : getMenuList
        };
    })();
    
    
    /*
    	서버가 시작 되면 동작하는 코드
    */
    $(document).ready(() => {
    	/* 변수 설정*/
        
        /* HTML 태그 변수 설정*/
        const seatStusForm = $("#seatStusForm"),
	        colorVal = $("#color_value"),
	        storeInfoDiv = $(".store_info_cnts"),
	        rsvdListDiv = $(".rsvdList"),
	        waitListDiv = $(".waitList"),
	        nextWaitDiv = $(".nextWait"),
	        nextRsvdDiv = $(".nextRsvd"),
	        rsvdMapUL = $(".rsvdMap"),
	        storeSeatUL = $(".storeSeatStus"),
	        rsvdRsltDiv = $(".rsvdRslt"),
	        userRsvdListUL = $(".userRsvdList"),
	        rsvdDtlsDiv = $(".modal_wrapper_rsvdDtls"),
	        rsvdDtlsInfoDiv = $("#modal_rsvd_dtls"),
	        userRsvdListDiv = $(".modal_bot_rsvd"),
	        waitRegFormDiv = $(".modal_wrapper_regwait"),
	        lastWeekRsvdUL = $(".last_week_rsvd"),
	        regHtdlFormDiv = $(".modal_wrapper_htdl_regform"),
	        btnAcceptHtdl = $(".btnAcceptHtdl")
	        
        ;
        
        function init(storeId){
            showBoard(storeId); // 현재 '매장'의 'board'를 보여주는 코드
            showTime(); // 현재 시간을 보여주는 코드
            setInterval(showTime, 1000); // 매초 update
            console.log("get rsvd list...............");
        }
            
        init(storeId);
        
        /*
        	매장의
        	board를 보여준다.
        	매장 정보
        	웨이팅 리스트
        	예약 리스트
        	시간대별 예약 리스트
        	다음 예약, 다음 웨이팅
        */
        
        function showStoreInfo (storeId){
        	
        	boardService.getStore({storeId : storeId}, function (store) {
                let strStoreInfo = "";
                if(store == null){
                	storeInfoDiv.html("");
                    return;
                }
                
                strStoreInfo += "<div class='store_info_items'>매장 이름 : " + store.storeNm + "</div>";
                strStoreInfo += "<div class='store_info_items'>매장 연락처 : " + store.telno + "</div>";
                strStoreInfo += "<div class='store_info_items'>매장 수용 인원 : " + store.bstore.acmPnum + "</div>";
                strStoreInfo += "<div class='store_info_items'>매장 소개 : " + store.bstore.storeIntro + "</div>";
                strStoreInfo += "<div class='store_info_items'>매장 평균식사시간 : " + store.bstore.acmPnum + "분</div>";
                strStoreInfo += "<div class='store_info_items'>매장 라스트오더시간 : " + store.bstore.lastOrdTm + "</div>";
                
                storeInfoDiv.html(strStoreInfo);
                
                /*착석 상태*/
                let colors = document.getElementsByClassName("btn_seat_stus");
                for(let i = 0; i < colors.length; i++){
                	if(colors[i].dataset.color[0] === store.bstore.seatStusCd)
                		colors[i].className += " curStus";
                }
        	})
        };
        
        function showWaitList(storeId){
        	
        	console.log("show wait list.........." + storeId);
        	
        	boardService.getWaitList({storeId:storeId}, function (waitList) {
                let strWaitList = "";
                if(waitList == null){
                    waitList.html("");
                    return;
                }
                strWaitList += "<span class='wait_list_tit'>웨이팅 리스트</span>";
                strWaitList += "<div class='list_blank'></div>";
                waitList.forEach(wait => {
                	strWaitList += "<div class='wait' data-waitId='"+wait.waitId+"'>";
                        strWaitList += "<div class='list_info_top'>";
                        strWaitList += "<span class='wait_name wait_list'>"+wait.custNm+"</span>";
                        strWaitList += "<span class='wait_telno wait_list'>"+wait.custTelno+"</span>";
                        strWaitList += "</div>";
                        strWaitList += "<div class='list_info_bot'>";
                        strWaitList += "<span class='list_wait_pnum'>"+wait.waitPnum+"명</span>";
                        let parStr = wait.waitRegTm.split(" ")[1].split(":");
      	              	let time = parStr[0] + ":" + parStr[1];
                        strWaitList += "<span class='list_wait_regtm'>"+time+"</span>";
                        strWaitList += "</div>";
                    	strWaitList += "<button class='btn_wait_call'><a href='/oauth?storeId="+wait.storeId+"&waitId="+wait.waitId+"'>호출</a></button>";
                    	strWaitList += "</div>";
                });
    
              waitListDiv.html(strWaitList);   
             
              $(".wait").on("click",(e)=>{
            	  
            	  console.log(e.target);
            	  
            	  let waitId = e.target.dataset.waitid
            	  
            	  if(e.target.className === "btn_wait_call" || e.target.parentNode.className === "btn_wait_call")
            		  return;
            	  
            	  console.log("wait1 : "+waitId);
            	  
            	  if(e.target.dataset.waitId) waitId = e.target.dataset.waitid;
            	  
            	  console.log("wait2 : "+waitId);
            	  
                  if(e.target.parentNode.dataset.waitid) waitId = e.target.parentNode.dataset.waitid;
                  
                  console.log("wait3 : "+waitId);
                  
                  if(e.target.parentNode.parentNode.dataset.waitid) waitId = e.target.parentNode.parentNode.dataset.waitid;
                  
                  console.log("wait4 : "+waitId);
            	  
                  window.open("/dealight/business/waiting/"+waitId);
            	  
              });
              
              
              let nextWait = boardService.getNextWait(waitList);
              
              let strNextWait = "";
              
              if(nextWait){
	              strNextWait += "<div class='next_info_top'>";
	              strNextWait += "<span class='wait_name' data-id='"+nextWait.waitId+"'>"+nextWait.custNm+"</span>"
	              strNextWait += "<span class='wait_telno'>"+nextWait.custTelno+"</span>";
	              strNextWait += "</div>";
	              strNextWait += "<div class='next_info_bot'>";
	              strNextWait += "<span class='next_wait_pnum'>"+nextWait.waitPnum+"명</span>";
	              let parStr = nextWait.waitRegTm.split(" ")[1].split(":");
	              let time = parStr[0] + ":" + parStr[1];
	              strNextWait += "<span class='next_wait_regtm'>"+time+"</span>";
	              strNextWait += "<button class='btn_enter_wait'>입장</button>";
	              strNextWait += "<button class='btn_noshow_wait'>노쇼</button>";
	              strNextWait += "</div>";
              }
              nextWaitDiv.html(strNextWait);
              
              $(".btn_enter_wait").on("click", waitEnterHandler);
              $(".btn_noshow_wait").on("click", waitNoshowHandler);
    
            }); 
        }
        
        function showRsvdList(storeId){
        	
        	console.log("show rsvd list..........." + storeId);
        	
        	boardService.getRsvdList({storeId:storeId}, function (rsvdList) {
                let strRsvdList = "";
                if(rsvdList == null){
                    rsvdList.html("");
                    return;
                }
                console.log("===============================");
                strRsvdList += "<span class='rsvd_list_tit'>예약 리스트</span>";
                strRsvdList += "<div class='list_blank'></div>";
                
                rsvdList.forEach(rsvd => {
                	if(rsvd.htdlId == null) strRsvdList += "<div class='rsvd rsvd_i btnRsvd'>" ;
                	else strRsvdList += "<div class='rsvd rsvd_i cur_htdl btnRsvd'>" ;
                		strRsvdList += "<li hidden class='btnStoreId'>"+rsvd.storeId+"</li>";
                		strRsvdList += "<li hidden class='btnUserId'>"+rsvd.userId+"</li>";
                		strRsvdList += "<div class='list_info_top'>";
                		strRsvdList += "<span class='rsvd_name rsvd_list'>"+rsvd.userId+"</span>";
                		strRsvdList += "<span class='rsvd_telno rsvd_list'>"+rsvd.totQty+"</span>";
                		strRsvdList += "</div>";
                		strRsvdList += "<div class='list_info_bot rsvd_list'>";
                		strRsvdList += "<span class='list_rsvd_pnum'>"+rsvd.pnum+"명</span>";
                		let parStr = rsvd.time.split(" ")[1].split(":");
      	              	let time = parStr[0] + ":" + parStr[1];
                		strRsvdList += "<span class='list_rsvd_regtm'>"+time+"</span>";
                		strRsvdList += "</div></div>";
                });
    
              rsvdListDiv.html(strRsvdList);
              $(".btnRsvd").on("click", showUserRsvdListHandler);
              
            }); 
        }
        
        function showRsvdMap(storeId){
        	
			strRsvdMap = "";
            
            boardService.getTodayRsvdMap({storeId:storeId}, function(map){
            	let strRsvdMap = "";
            	
            	console.log("map.............................."+map);
            	
            	if(!map)
            		return;
            	Object.entries(map).forEach(([key,value]) => {
            		console.log("key : "+key+", value : " + value);
            		strRsvdMap += "<li class='dealight_tooltip'>"+key + " : 예약번호[" + value+"] <span class='dealight_tooltiptext'>"+value+"번호 상세보기</span></li></br>";
            		for(let i = 1; i < 28; i ++){
            			// debug
            			console.log(key+' : '+i+ ' : '+document.querySelector("#slide-"+i).textContent);
            			console.log(key === document.querySelector("#slide-"+i).textContent);
            			if(key === document.querySelector("#slide-"+i).textContent){
            				let strHtml = "";
            				let strVal = value.toString();
            				
            				console.log("strVal : " + strVal);
            				let parVal = strVal.split(",");
            				let ppVal = parVal[parVal.length - 1].split(" ");
            				parVal[parVal.length-1] = ppVal[0];
            				
            				strHtml += "<span class='dealight_tooltiptext'>";
            				for(let i = 0; i < parVal.length; i++){
            					if(i !== parVal.length -1) strHtml += "<span class='time_table_rsvd_dtls'>"+parVal[i]+'</span>,';
            					if(i === parVal.length -1) strHtml += "<span class='time_table_rsvd_dtls'>"+parVal[i]+'</span>';
            				}
            				strHtml += " 번호 예약</span>";
            				document.querySelector('#slide-'+i+' .time_table').innerHTML = strHtml;
            				document.querySelector('#slide-'+i+' .time_table').style.backgroundColor = 'rgba(37, 201, 89, 0.911)';
            			}
            		}
            	})
            	
            	boardService.getTodayRsvdStusMap({storeId:storeId},function(map){
            		Object.entries(map).forEach(([key,value]) => {
                		console.log("key : "+key+", value : " + value);
                		for(let i = 1; i < 28; i ++){
                			if(key === document.querySelector("#slide-"+i).textContent){
                				if(value === 'R')
                					document.querySelector('#slide-'+i+' .time_table').style.backgroundColor = '#d32323';
                				else if(value === 'Y')
                					document.querySelector('#slide-'+i+' .time_table').style.backgroundColor = 'rgba(248, 236, 73, 0.781)';
                				else if(value === 'G')
                					document.querySelector('#slide-'+i+' .time_table').style.backgroundColor = 'rgba(125, 255, 164, 0.698)';
                				else if(value === 'B')
                					document.querySelector('#slide-'+i+' .time_table').style.backgroundColor = '#29242460';
                				else
                					document.querySelector('#slide-'+i+' .time_table').style.backgroundColor = 'rgba(37, 201, 89, 0.911)';
                			}
                		}
                	});
            	})
            	
            	rsvdMapUL.html(strRsvdMap);
                
                
                $(".time_table_rsvd_dtls").on("click", function(e) {
                	let rsvdId = $(e.target).text();
                	
                	console.log("rsvd id : " + rsvdId);
                	
                	boardService.getRsvdDtls({rsvdId:rsvdId}, rsvd=>{
                		console.log("rsvd id : " + rsvd.rsvdId);
                		let userId = rsvd.userId;
                		console.log("user id : " + userId);
                		let storeId = rsvd.storeId;
                		console.log("store id : " + storeId);
                		showUserRsvdList(storeId,userId);
	            		
	            		modal.css("display","block");
                	})
            	
            	});
            	
            });
            
            boardService.getNextRsvd({storeId:storeId},function(rsvd){
            	
            	console.log("get next rsvd .......................");
            	
        		let strNextRsvd = "";
        		if(!rsvd)
        			return;
        		strNextRsvd += "<div class='next_info_top'>";
        		strNextRsvd += "<span class='next_rsvd_name'>"+rsvd.userId+"</span>";
        		strNextRsvd += "<span class='next_rsvd_telno'>"+rsvd.totQty+"</span>";
        		strNextRsvd += "<span class='store_htdl' style='display:none;'>"+rsvd.htdlId+"</span>";
        		strNextRsvd += "</div>";
        		strNextRsvd += "<div class='next_info_bot'>";
        		strNextRsvd += "<span class='next_rsvd_pnum'>"+rsvd.pnum+"명</span>";
        		let parStr = rsvd.time.split(" ")[1].split(":");
	            let time = parStr[0] + ":" + parStr[1];
        		strNextRsvd += "<span class='next_rsvd_tm'>"+time+"</span>";
        		strNextRsvd += "</div>";
                
                nextRsvdDiv.html(strNextRsvd);
        	});
        	
        }
        
        function showBoard(storeId) {

        	showStoreInfo(storeId);
            
        	showWaitList(storeId);
    
        	showRsvdList(storeId);
            
            showRsvdMap(storeId);
  
        };
        
        // 예약 현황판을 보여준다.
        function showRsvdBoard(storeId) {
        	
        	let dateArr = new Array();
        	
        	let today = new Date();
        	let year, month, date;
        	
        	for(let i = 0; i < 7; i++) {
        		year =  today.getFullYear();
        		month = (today.getMonth() + 1);
        		date = today.getDate();
        		if(date < 10) date = "0" + date.toString();
        		dateArr[i] =    year + '/' + month + '/' + date;
        		today.setDate(today.getDate() - 1);
        	}
        	
    		let pnumArr = [0,0,0,0,0,0,0];
    		let amountArr = [0,0,0,0,0,0,0];
    		let waitPnumArr = [0,0,0,0,0,0,0];
        	
            // 매장의 '예약 현황판' 내용을 가져온다.
    		let getRsvdRsltPr = function (param) {
                
                let storeId = param.storeId;

                return new Promise(function(resolve,reject){
                    $.getJSON("/dealight/business/manage/board/reservation/rslt/"+storeId+".json",
                        function (data) {
                                if(data){
                                    resolve(data);
                                }
                                reject(new Error("Request is Failed"));
                        });
                });
                
            };

            // 매장의 '지난 7일 웨이팅 현황' 내용을 가져온다.
    		let getLastWeekWaitPr = function(param) {
                
                let storeId = param.storeId;
                
                return new Promise(function(resolve,reject){
                    $.getJSON("/dealight/business/manage/board/waiting/rslt/"+storeId+"/list.json",
                        function (data) {
                                    if(data){
                                        resolve(data);
                                    }
                                    reject(new Error("Request is Failed"));
                                }
                            );
                    });
            };

            // '해당 매장'의 지난주 예약 정보를 가져온다.
            let getLastWeekRsvdPr = function (param) {
            	
    			let storeId = param.storeId;
                
                return new Promise(function(resolve,reject){
                    $.getJSON("/dealight/business/manage/board/reservation/rslt/"+ storeId +"/list.json",
                        function (data) {
                                if(data){
                                    resolve(data);
                                }
                                reject(new Error("Request is Failed"));
                            }
                        );
                    });
            };

            let createChartPr = function(){
            	
            	console.log("promise 4th.....................................");
                        
                console.log('dateArr : '+dateArr);
    		    console.log('pnumArr : '+pnumArr);
    		    console.log('amountArr : '+amountArr);
    		    console.log('waitPnumArr : '+waitPnumArr);
    		    let chart = document.getElementById('rsvd_chart');
    		    let context = chart.getContext('2d'),
    		    rsvdChart = new Chart(context, {
    		         	type : 'line',
    		          	data : {
    		          		labels : [dateArr[6], dateArr[5], dateArr[4], dateArr[3], dateArr[2], dateArr[1], dateArr[0]],
    		          		datasets : [{
    		           			label : '예약 인원',
    		           			lineTension : 0,
    		           			data : [pnumArr[6], pnumArr[5], pnumArr[4], pnumArr[3], pnumArr[2], pnumArr[1], pnumArr[0]],
    		           			backgroundColor : "rgba(153,255,51,0.4)"
    		           		},  {
    		           			label : "웨이팅 인원",
    		           			data : [waitPnumArr[6],waitPnumArr[5],waitPnumArr[4],waitPnumArr[3],waitPnumArr[2],waitPnumArr[1],waitPnumArr[0]],
    		          			backgroundColor: "rgba(238, 48, 105, 0.835)"
    		           		}
    		           		/*,{
    		           			label : "예약 금액",
    		          			data : [amountArr[6],amountArr[5],amountArr[4],amountArr[3],amountArr[2],amountArr[1],amountArr[0]],
    		          			backgroundColor: "rgba(255,153,0,0.4)"
    		           		}*/]
    		           	}
    		       	}); // end chart js
            }

            let p1 = getRsvdRsltPr;
            let p2 = getLastWeekWaitPr;
            let p3 = getLastWeekRsvdPr;
            let p4 = createChartPr;

            let p5 = Promise.all([p1,p2,p3,p4]);

            p5.then(function (value) {
            	
            	console.log("promise start.....................................");
            	console.log("p5 : " + p5);


                value[0]({storeId:storeId}).then(dto => {
                	
                	console.log("promise 1st.....................................");
                	console.log('dto : '+dto);

                    let strRsvdRslt = "";
            		if(!dto)
            			return;
            		strRsvdRslt += "<div class='today_rsvd_rslt_tit'>당일 예약 결과</div>";
            		strRsvdRslt += "<div class='rsvd_rslt_wrapper'>";
            		strRsvdRslt += "<div>오늘 총 예약 수 : " + dto.totalTodayRsvd  +"</div>";
            		strRsvdRslt += "<div>오늘 총 예약 인원 : " + dto.totalTodayRsvdPnum  +"</div>";
            		strRsvdRslt += "<div>[오늘의 인기 메뉴]</div>";
            		Object.entries(dto.todayFavMenuMap).forEach(([key,value]) => {
    	        		strRsvdRslt += "<div>" + key +' : '+ value  +"</div>";
                    })
                    strRsvdRslt += "</div>";

                    console.log('strRsvdRslt : '+strRsvdRslt);
                    rsvdRsltDiv.html(strRsvdRslt);
                        
                    return value[1]({storeId:storeId});
                }).then(waitList => {
                	console.log("promise 2nd.....................................");
                	console.log("wait list : "+waitList);
    	        		
    	        		waitList.forEach( wait => {
    	        			console.log('wait reg tm : '+wait.strWaitRegTm);
    	        			console.log('wait pnum : '+wait.waitPnum);
    	        			waitPnumArr[dateArr.indexOf(wait.strWaitRegTm)] += wait.waitPnum;
    	        			
                        });
                    
                    return value[2]({storeId:storeId});
                    
                }).then(rsvdList => {
                	
                	console.log("promise 3rd.....................................");
                	
                    let strLastWeekRsvd = "";
            		if(!rsvdList)
            			return;
            		
            		console.log(rsvdList[0].pnum);
            		console.log('wait id : '+rsvdList[0].waitId);
            		console.dir(rsvdList[0]);
    				
            		rsvdList.forEach(rsvd => {
            			console.log('rsvd str reg date : ' + rsvd.strRegDate);
            			pnumArr[dateArr.indexOf(rsvd.strRegDate)] += rsvd.pnum;
            			amountArr[dateArr.indexOf(rsvd.strRegDate)] += rsvd.totAmt;
            			
            			//pnumArr[dateArr.indexOf(rsvd.strInDate)].push(rsvd)
            			
            			strLastWeekRsvd += "<li hidden class='btnStoreId'>"+rsvd.storeId+"</li>";
            			strLastWeekRsvd += "<li hidden class='btnUserId'>"+rsvd.userId+"</li>";
            			strLastWeekRsvd += "<li>매장번호 : "+ rsvd.storeId + "</li>";
            			strLastWeekRsvd += "<li>회원 아이디 : "+ rsvd.userId + "</li>";
            			strLastWeekRsvd += "<li>핫딜 번호 :"+ rsvd.htdlId + "</li>";
            			strLastWeekRsvd += "<li>승인 번호 : "+ rsvd.aprvNo + "</li>";
            			strLastWeekRsvd += "<li>예약 인원 : "+ rsvd.pnum + "</li>";
            			strLastWeekRsvd += "<li>예약 시간 : "+ rsvd.time + "</li>";
            			strLastWeekRsvd += "<li>예약 상태 : "+ rsvd.stusCd + "</li>";
            			strLastWeekRsvd += "<li>예약 총 금액 : "+ rsvd.totAmt + "</li>";
            			strLastWeekRsvd += "<li>예약 총 수량 : "+ rsvd.totQty + "</li>";
            			strLastWeekRsvd += "<li>예약 등록 날짜 : "+ rsvd.strRegDate + "</li>";
            			strLastWeekRsvd += "===========================================";
                    });
            		
            		console.log('str Last Week Rsvd : ' + rsvdList);
                    
    	        	lastWeekRsvdUL.html(strLastWeekRsvd);

                    return value[3]();
                }).then();
               
            });
        };
        
        /*
        	유저의 예약 히스토리를 보여준다.
        
        */
        function showUserRsvdList(storeId,userId,callback){
        	
        	boardService.getUserRsvdList({storeId:storeId,userId:userId}, function(userRsvdList){
        		
        		let strUserRsvdList = "";
        		if(!userRsvdList)
        			return;
        		
        		strUserRsvdList += "<div class='modal_tit'>";
        		strUserRsvdList += "<span>kjuioq님의 예약 상세</span>";
        		strUserRsvdList += "</div>";
        		strUserRsvdList += "<div class='modal_top rsvdDtls' id='modal_rsvd_dtls'>";
        		strUserRsvdList += "</div>";
        		strUserRsvdList += "<div class='modal_bot_rsvd'>";
        		userRsvdList.forEach(rsvd => {
        			strUserRsvdList += "<div class='rsvd_history'>";
        			if(rsvd.htdlId != null) strUserRsvdList += "<span class='htdl_stus'><i class='fas fa-fire'></i></i></span>";
            		strUserRsvdList += "<span>예약 번호 : "+rsvd.rsvdId+"</span><br>";
            		strUserRsvdList += "<span>회원 아이디 : "+ rsvd.userId + "</span><br>";
            		strUserRsvdList += "<span>예약 인원 : "+ rsvd.pnum + "</span><br>";
            		strUserRsvdList += "<span>예약 시간 : "+ rsvd.time + "</span><br>";
            		strUserRsvdList += "<span>예약 상태 : "+ rsvd.stusCd + "</span><br>";
            		strUserRsvdList += "<span>예약 총 금액 : "+ rsvd.totAmt + "</span><br>";
            		strUserRsvdList += "<span>예약 총 수량 : "+ rsvd.totQty + "</span><br>";
            		strUserRsvdList += "<span>예약 등록 날짜 : "+ rsvd.regdate + "</span>";
            		strUserRsvdList += "</div>";
        		});
        		strUserRsvdList += "</div>";

        		rsvdDtlsDiv.css("display","flex")
        		rsvdDtlsDiv.html(strUserRsvdList);
        		console.log("=======================")
        		console.log("user history complete")
        		showRsvdDtls(userRsvdList[0].rsvdId);
        		
        	})
        };
        
        /*
        	예약 상세를 보여준다.
        
        */
        function showRsvdDtls(rsvdId){
        	
        	boardService.getRsvdDtls({rsvdId:rsvdId}, function(rsvd){
        		
				let strRsvdDtls = "";
				if(!rsvd)
					return;
				
				strRsvdDtls += "<div class='rsvd_left_wrapper'>";
				if(rsvd.htdlId != null) strRsvdDtls += "<span class='htdl_stus'><i class='fas fa-fire'></i></span>";
				strRsvdDtls += "<div class='modal_rsvd_info'>예약 번호 : " + rsvd.rsvdId +"</div>";
				strRsvdDtls += "<div class='modal_rsvd_info'>예약 시간 : " + rsvd.time +"</div>";
				strRsvdDtls += "<div class='modal_rsvd_info'>예약 총 가격 : " + rsvd.totQty +"원</div>";
				strRsvdDtls += "<div class='modal_rsvd_info'>예약 총 수량 : " + rsvd.totQty +"개</div>";
				strRsvdDtls += "<div class='modal_rsvd_info'>예약 시간 : " + rsvd.regdate +"</div>";
				strRsvdDtls += "</div>";
				strRsvdDtls += "<div class='rsvd_right_wrapper'>";
				rsvd.rsvdDtlsList.forEach(dtls => {
					strRsvdDtls += "<div class='modal_rsvd_info'>";
					strRsvdDtls += "<span>메뉴 이름 : " + dtls.menuNm +"</span><br>";
					strRsvdDtls += "<span>메뉴 가격 : " + dtls.menuPrc +"원</span><br>";
					strRsvdDtls += "<span>메뉴 수량 : " + dtls.menuTotQty +"</span>";
					strRsvdDtls += "</div>";
				});
				strRsvdDtls += "</div>";
        		
				$("#modal_rsvd_dtls").html(strRsvdDtls);
        		console.log("=======================")
        		console.log(strRsvdDtls);
        		console.log("rsvd dtls complete")
        		
        	})
        };
        /*
        
        	오프라인 웨이팅 등록 폼을 보여준다.
        
        */
        
        function showWaitRegisterForm(storeId){
        	
        	let date = new Date();
        	let strWaitRegForm = "";
        	
        	parDate = date.toLocaleDateString().split(".");
        	let regTime = parDate[0] + "/" + parDate[1].trim() + "/" + parDate[2].trim() +" "+
        	date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        	
        	strWaitRegForm += "<div class='modal_tit'>";
        	strWaitRegForm += "<span>웨이팅 현장 등록</span>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "<div class='modal_top'>";
        	strWaitRegForm += "<div class='form_left_wrapper'>";
        	strWaitRegForm += "<form action='/dealight/business/manage/waiting/register' id='waitRegForm' method='post'>";
        	strWaitRegForm += "<div>";
        	strWaitRegForm += "<input type='text' class='' id='js_wait_custNm' name='custNm' placeholder='고객 이름'>";
        	strWaitRegForm += "<span id='name_msg'></span>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "<div>";
        	strWaitRegForm += "<input type='text' class='' id='js_wait_custTelno' placeholder='고객 전화번호' name='custTelno' id='js_wait_custTelno'>";
        	strWaitRegForm += "<span id='phoneNum_msg'></span>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "<div>";
        	strWaitRegForm += "<input type='text' class=''id='js_wait_pnum' placeholder='웨이팅 인원' name='waitPnum' id='js_wait_pnum'>";
        	strWaitRegForm += "<span id='pnum_msg'></span>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "<input type='text' name='waitRegTm' value='"+regTime+"' hidden>";
        	strWaitRegForm += "<input type='text' name='storeId' value='"+storeId+"' hidden>";
        	strWaitRegForm += "</form>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "<div class='form_right_wrapper'>";
        	strWaitRegForm += "<button id='submit_waitRegForm' type='submit'>현장 등록</button>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "<div class='modal_bot'>";
        	strWaitRegForm += "<div>등록 시간</div>";
        	strWaitRegForm += "<div>"+regTime+"</div>";
        	strWaitRegForm += "</div>";
        	strWaitRegForm += "";
        	
        	waitRegFormDiv.css("display","flex")
        	waitRegFormDiv.html(strWaitRegForm);
        	
        	/* wait register valid check*/
        	const wait_custNm = document.querySelector("#js_wait_custNm"),
	        	wait_phoneNum = document.querySelector("#js_wait_custTelno"),
	        	wait_pnum = document.querySelector("#js_wait_pnum"),
	        	btn_submit = document.querySelector("#submit_waitRegForm"),
	        	name_msg = document.querySelector("#name_msg"),
	        	phoneNum_msg = document.querySelector("#phoneNum_msg"),
	        	pnum_msg = document.querySelector("#pnum_msg"),
	        	waitRegForm = document.querySelector('#waitRegForm');
        	
        	const inputList = [wait_custNm,wait_phoneNum,wait_pnum];

        	// 웨이팅 등록의 valid check를 진행한다.
        	nameLenCheck = function () {
        		if(1 <= wait_custNm.value.length && wait_custNm.value.length <= 5)
        			return true;
        		return false;
        	}

        	phoneNumLenCheck = function () {
        		if(1 <= wait_phoneNum.value.length && wait_phoneNum.value.length <= 13)
        			return true;
        		return false;
        	}

        	pnumSizeCheck = function () {
        		if(isNaN(wait_pnum.value))
        			return false;
        		if(1 <= parseInt(wait_pnum.value) && parseInt(wait_pnum.value) <= 10)
        			return true;
        		return false;
        	}

        	wait_custNm.addEventListener("focusout", () => {
        		if(1 <= wait_custNm.value.length){
        		    if(nameLenCheck()){
        		        name_msg.innerText = "이름 형식이 적당하네요.";
        		    }
        		    else {
        		    	name_msg.innerText = "이름 길이를 다시 확인해 주세요. (5자 이내)";
        		    	name_msg.style.color = "red";
        		    }
        		}
        	})

        	wait_phoneNum.addEventListener("focusout", () => {
        		if(1 <= wait_phoneNum.value.length){
        		    if(phoneNumLenCheck()){
        		        phoneNum_msg.innerText = "전화번호 형식이 적당하네요!";
        		    }
        		    else {
        		    	phoneNum_msg.innerText = " 전화번호 길이를 다시 확인해 주세요. (13자 이내)";
        		    	phoneNum_msg.style.color = "red";
        		    }
        		}
        	})

        	wait_pnum.addEventListener("focusout", () => {
        		if(1 <= wait_pnum.value.length){
        		    if(pnumSizeCheck()){
        		        pnum_msg.innerText = "인원이 적당합니다.";
        		    }
        		    else {
        		    	pnum_msg.innerText = "인원이 너무 많거나 형식이 적당하지 않아요! (10명 이내)";
        		    	pnum_msg.style.color = "red";
        		    }
        		}
        	})

        	// null이면  true
        	nullCheck = function(inputList) {
        	    for(let i = 0; i < inputList.length; i++)
        	        if(inputList[i].value == "")
        	            return true;
        	    
        	    return false;
        	}
        	
        	let modalInputCustNm = modal.find("input[name='custNm']"),
				modalInputCutsTelNo = modal.find("input[name='custTelno']"),
				modalInputWaitPnum = modal.find("input[name='waitPnum']"),
				modalInputWaitRegTm = modal.find("input[name='waitRegTm']"),
				modalInputStoreId = modal.find("input[name='storeId']");
    	
        	btn_submit.addEventListener("click", (e) => {
    		
	    		e.preventDefault();
	    		
	    		let wait = {
	    				custNm : modalInputCustNm.val(),
	    				custTelno : modalInputCutsTelNo.val(),
	    				waitRegTm : modalInputWaitRegTm.val(),
	    				waitPnum : modalInputWaitPnum.val(),
	    				storeId : modalInputStoreId.val()
	    		};
	    		
	    		
	    	    if(nullCheck(inputList)){
	    	        alert("필드가 비었어요")
	    	        return;
	    	    }
	    	    
	    	    if(!nameLenCheck()){
	    	    	alert("🙅이름을 형식에 맞게 입력해주세요");
	    	        return;
	    	    }
	    	    
	    	    if(!phoneNumLenCheck()){
	    	        alert("🙅전화번호를 형식에 맞게 입력해주세요");
	    	        return;
	    	    }
	    	    
	    	    if(!pnumSizeCheck()){
	    	        alert("🙅예약인원을 형식에 맞게 입력해주세요");
	    	        return;
	    	    }
	    	    
	
	    		boardService.regWait(wait, result => {
	    			
	    			//alert(result);
	        		showWaitList(storeId);
	        		modal.find("ul").html("");
	    			modal.find("input").val("");
	    			modal.css("display","none");
	    			
	    		});
    		
    		});
        };
        
        // 메뉴리스트
        
        let showRegHtdl = function(storeId){
        	
        	let strHtdl = "";
        	
        	console.log('show reg htdl store id : '+storeId);
        	
        	boardService.getMenuList({storeId:storeId}, function(menuList){
        	
        		console.log('show reg htdl store id : '+storeId);
        		
	        	strHtdl += "<div class='modal_tit'>";
	        	strHtdl += "<span>핫딜 등록하기</span>";
	        	strHtdl += "</div>";
	        	strHtdl += "<div class='modal_top htld_reg'>";
	        	strHtdl += "<div class='htdl_reg_form_wrapper'>";
	        	strHtdl += "<form class='regHtdlForm' action='/dealight/business/manage/board/htdl/new' method='post'>";
	        	strHtdl += "<div class='htdl_label_input htdl_name'>";
	        	strHtdl += "<span>핫딜 제목</span>";
	        	strHtdl += "<input class='form-control' name='name' placeholder='핫딜 제목'>";
	        	strHtdl += "</div>";
	        	strHtdl += "<div class='htdl_label_input htdl_menu'>";
	        	strHtdl += "<span>핫딜 메뉴</span>";
	        	strHtdl += "<div class='htdl_menu_itmes'>";
	        	if(menuList)
	        	menuList.forEach((menu,i) => {
		        	strHtdl += "<input type='checkbox' id='menu"+i+"' class='js-menu' value='"+menu.price+"'>";
		        	strHtdl += "<label for='menu"+i+"'>" +menu.name+"</label>";
	        	});
	        	strHtdl += "</div>";
	        	strHtdl += "</div>";
	        	strHtdl += "<div class='htdl_label_input htdl_dc'>";
	        	strHtdl += "<span>할인율</span>";
	        	strHtdl += "<select id='dcRate' name='dcRate'>";
	        	strHtdl += "<option value=''>--</option>";
	        	strHtdl += "<option value='10'>10%</option>";
	        	strHtdl += "<option value='20'>20%</option>";
	        	strHtdl += "<option value='30'>30%</option>";
	        	strHtdl += "<option value='40'>40%</option>";
	        	strHtdl += "<option value='50'>50%</option>";
	        	strHtdl += "</select>";
	        	strHtdl += "</div>";
	        	strHtdl += "<div class='htdl_label_input htdl_bef_price'>";
	        	strHtdl += "<span>할인 적용전 가격</span>";
	        	strHtdl += "<input class='js-befPrice' value='0' name='befPrice' readonly='readonly'>";
	        	strHtdl += "</div>";
	        	
	        	strHtdl  += "<div class='htdl_label_input htdl_aft_price'>";
	        	strHtdl  += "<span>할인 적용후 가격</span>";
	        	strHtdl  += "<input class='js-aftPrice' readonly='readonly'>";
	        	strHtdl  += "</div>";
	        	strHtdl  += "<div class='htdl_label_input htdl_start_tm'>";
	        	strHtdl  += "<span>핫딜 시작 시간</span>";
	        	strHtdl  += "<input type='time' name='startTm' readonly>";
	        	strHtdl  += "</div>";
	        	strHtdl  += "<div class='htdl_label_input htld_end_tm'>";
	        	strHtdl  += "<span>핫딜 마감 시간</span>";
	        	strHtdl  += "<input type='time' name='endTm' readonly>";
	        	strHtdl  += "</div>";
	        	strHtdl  += "<div class='htdl_label_input htdl_lmt_pnum'>";
	        	strHtdl  += "<span>핫딜 제한 인원:</span>";
	        	strHtdl  += "<input class='form-control' type='number' min='0' max='50' name='lmtPnum' readonly='readonly'>";
	        	strHtdl  += "</div>";
	        	strHtdl  += "<div class='htdl_label_input htdl_intro'>";
	        	strHtdl  += "<span>핫딜 소개</span>";
	        	strHtdl  += "<textarea rows='2' cols='22' name='intro'></textarea>";
	        	strHtdl  += "</div>";
	        	
	        	strHtdl += "<div class='uploadDiv htdl'><input type='file' name='uploadFile'></div>";
                strHtdl += "<div class='uploadResult'><ul></ul></div>";
                strHtdl += "<input type='hidden' id='storeId' name='storeId' value='"+storeId+"'>";
                strHtdl += "<div class='htdl_reg_btn_box'>";
                strHtdl += "<button class='regHtdlBtn' type='submit' data-oper='register'>승낙</button>";
                strHtdl += "<button class='regHtdlBtn' type='submit' data-oper='refuse'>거절</button>";
                strHtdl += "</div>";
	        	
        		console.log("before strHtdl : "+ strHtdl);
        		regHtdlFormDiv.css("display","flex")
	        	regHtdlFormDiv.html(strHtdl);
	        	
	        	// 핫딜 제안 등록폼에 데이터를 넣어준다.
	        	$(".regHtdlForm input[name=name]").val($(".manage_htdl_dto").data().name);
        		$(".regHtdlForm input[name=lmtPnum]").val($(".manage_htdl_dto").data().lmtpnum);
        		$(".regHtdlForm input[name=startTm]").val($(".manage_htdl_dto").data().starttm);
        		$(".regHtdlForm input[name=endTm]").val($(".manage_htdl_dto").data().endtm);
        		
	        	/* jong woo js*/
	        	//메뉴 리스트, 할인율, 메뉴 체크박스
	        	let menus = document.querySelectorAll(".js-menu"),
		        	dcRate = document.querySelector("#dcRate"),
		        	menuBox = document.querySelectorAll(".js-menu");
	        	
	        	//할인 적용 전/후 가격
	        	let befPrice = document.querySelector(".js-befPrice"),
	        		afterPrice = document.querySelector(".js-aftPrice"),
	        		total = 0,
	        		rate = 0;
	        	
	            // 핫딜 등록폼 
	    		//할인 적용한 가격 계산
	    		let getAfterPrice = function (total, rate) {
	    			let price = total - (total * rate);
	    			console.log(price);
	    			afterPrice.value = price;
	    		}

	    		//메뉴 체크
	    		let menuCheck = function (price, idx) {

	    			if (menus[idx].checked)
	    				total += Number(price);
	    			else
	    				total -= Number(price);
	    			befPrice.value = total;

	    			getAfterPrice(total, rate);
	    		};
	        	
	        	//메뉴에 따른 가격 선택
	    		for (let i = 0; i < menus.length; i++) {
	    			$(".js-menu").eq(i).click(function() {
	    				console.log($(this).val());
	    				menuCheck($(this).val(), i);
	    			});
	    		};
	    		
	    		//할인율 변화
	    		$("#dcRate").change(function(){
	    			rate = $(this).val()/100;
	    			console.log("change: " + rate);
	
	    			getAfterPrice(total, rate);
	    		});
	    		
	    		
	    		let regHtdlFormObj = $(".regHtdlForm");
	    		
	    		$(".regHtdlBtn").on("click", function(e){
	    			
	    			e.preventDefault();
	    			
	    			let operation = $(this).data("oper");
	    			console.log(operation);
	    			let path = $(".uploadResult ul li").data("path");
	    			let fileName = $(".uploadResult ul li").data("filename");
	    			
	    			if(operation === 'register'){
	    				
	    				for(let i =0; i< menuBox.length; i++){
	    					//체크된 라벨 input 추가
	    					if(menuBox[i].checked){		
	    						console.log(i+"================");
	    						regHtdlFormObj.append("<input type='hidden' name='menu["+i+"].name' value='"+ $("label[for='menu"+(i+1)+"']").text()+"'>");
	    						regHtdlFormObj.append("<input type='hidden' name='menu["+i+"].price' value='"+ $("#menu"+(i+1)).val()+"'>");
	    							
	    					}
	    				}
	    				regHtdlFormObj.append("<input type='hidden' name='htdlPhotoSrc' value='"+ path + "/" + fileName + "'>");
	    				
	    				let formData = new FormData();
	    				
	    				let inputData = $(".regHtdlForm input");
	    				
	    				for(let i = 0; i < inputData.length; i++){
	    					formData.append($(".regHtdlForm input")[i].name, $(".regHtdlForm input")[i].value)
	    				}
	    				
	    				$.ajax({
	    		            url : '/dealight/business/manage/board/htdl/new',
	    		            processData : false,
	    		            contentType : false, data:
	    		                formData, type: 'POST',
	    		                dataType : 'json',
	    		                success : function(result) {
	    		                	alert(result);
	    		                	console.log(result);
	    			        		modal.find("ul").html("");
	    			    			modal.find("input").val("");
	    			    			modal.css("display","none");
	    		                }
	    		        })
	    		        alert("핫딜을 등록하셨습니다.");
	    				setTimeout(()=>{
	    					modal.find("ul").html("");
		    				modal.find("input").val("");
		    				modal.css("display","none");
		    				$(".alert.manage_htdl").addClass("hide");
		    	    		$(".alert.manage_htdl").removeClass("show");
	    				},1000)
	    				//regHtdlFormObj.submit();
	    				
	    			}else if(operation === 'refuse'){
	    				alert("핫딜이 거절 되었습니다.");
	    				modal.find("ul").html("");
		    			modal.find("input").val("");
		    			modal.css("display","none");
	    			}
	    			
	    		}); // reg btn click
        	});// end get menuList
        	
        	
        }; // end show  reg htdl
        
        let showRegHtdlHandler = function(e) {
        	
        	if(confirm("핫딜을 등록하시겠습니까?")){
        		showRegHtdl(storeId);
        		modal.css("display","block");        		
        	}
        }
        btnAcceptHtdl.on("click",showRegHtdlHandler);
        
        /* 이벤트 처리*/
        
        /*현황판 토글*/

		let switchBoard = $(".switch_board");
		let switchRsvdRslt = $(".switch_rsvd_rslt");
        
        let switchBoardHandler = function(e){
			
        	let storeId = ${storeId};
			
			e.preventDefault();
			
			if($("#board").css("display") === 'none'){
				// debug
				//console.log("board none => block");
				//$(".switch").text('매장관리');
				showBoard(storeId);
				$("#rsvd_rslt_baord").css("display", "none");
				$("#board").css("display", "flex");
				$(document.getElementsByClassName("tab_items")).removeClass("curTab");
				$(".switch_rsvd_rslt").css("color", "black")
				$(e.target.parentNode).addClass("curTab");
				$(".switch_board").css("color","white");
				//$(".switch_board").css("color", "#fff").css("background","#343436");
				//$(".switch_rsvd_rslt").css("color", "#000").css("background","#fff");
			}
        }
		
        let switchRsvdRsltHandler = function(e){
			
        	let storeId = ${storeId};
			
			e.preventDefault();
			
			if($("#rsvd_rslt_baord").css("display") === 'none'){
				// debug
				//console.log("rsvd rslt board none => block");
				//$(".switch").text('현황판');
				showRsvdBoard(storeId);
				$("#board").css("display", "none");
				$("#rsvd_rslt_baord").css("display", "block");
				$(document.getElementsByClassName("tab_items")).removeClass("curTab");
				$(".switch_board").css("color", "black")
				$(e.target.parentNode).addClass("curTab");
				$(".switch_rsvd_rslt").css("color","white");
				//$(".switch_rsvd_rslt").css("color", "#fff").css("background","#343436");
				//$(".switch_board").css("color", "#000").css("background","#fff");
			}
			
        }
        

        switchBoard.on("click", switchBoardHandler);
        switchRsvdRslt.on("click", switchRsvdRsltHandler);
		
        /*당일 예약 결과 가져오기*/
        $("#btn_rsvd_rslt").on("click",switchRsvdRsltHandler);

        /*새로고침*/
        $("#refresh").on("click", e => {
        	// debug
        	//console.log("show board...")
        	showBoard(storeId);
        });

        
        let showUserRsvdListHandler = function(e) {
        	
        	let rstoreId = $(e.target).parent().find(".btnStoreId").text(),
    		ruserId = $(e.target).parent().find(".btnUserId").text();
        	console.log("======================");
        	console.log(rstoreId);
        	console.log(ruserId);
        	
    		if(!rstoreId){
    			rstoreId = $(e.target).parent().parent().find(".btnStoreId").text();
        		ruserId = $(e.target).parent().parent().find(".btnUserId").text();
    		}
        	
    		modal.css("display","block");

    		showUserRsvdList(rstoreId, ruserId);
        }
        /*예약리스트에 있는 내용 중, 예약 상세 보여주기*/
        /*회원의 예약 리스트 보여주기*/
        $(".btnRsvd").on("click", showUserRsvdListHandler);
        	
        /* 웨이팅 등록 */
        $(".btn_wait_register").on("click", e => {
        	
        	modal.css("display","block");
        	showWaitRegisterForm(storeId);
        	
        });

        let changeSeatStusHandler = function(e) {
        	
            e.preventDefault();
            
            let color = "";

            let param = {};
            param.storeId = storeId;
            
            if(e.target.dataset.color) param.seatStusCd = e.target.dataset.color[0];
            if(e.target.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.dataset.color[0];
            if(e.target.parentNode.parentNode.dataset.color) param.seatStusCd = e.target.parentNode.parentNode.dataset.color[0];
            
            //param.seatStusCd = e.target.dataset.color[0];
            $(".btn_seat_stus").removeClass("curStus");
            e.target.className += " curStus";
            
        	boardService.putChangeStatusCd(param, function(result){
            	showStoreInfo(param.storeId);
        	});
        }
        /* 매장 착석 상태 처리*/
        $(".btn_seat_stus").on("click",changeSeatStusHandler);
        
        let waitEnterHandler = function(e) {
        	
        	/*dom 코드는 변경될 가능성 있음*/
        	let waitId = parseInt(document.querySelector(".nextWait .wait_name").dataset.id);

        	boardService.putEnterWaiting(waitId, function(result){
        		//alert(result);
        		showWaitList(storeId);
        	});
        }

        /*웨이팅 입장 처리*/
        $(".btn_enter_wait").on("click", waitEnterHandler);
        let waitNoshowHandler = function(e){
        	
        	/*dom 코드는 변경될 가능성 있음*/
        	let waitId = parseInt(document.querySelector(".nextWait .wait_name").dataset.id);

        	boardService.putNoshowWaiting(waitId, function(result){
        		//alert(result);
	        	showWaitList(storeId);
        	});
        }

        /*웨이팅 노쇼 처리*/
        $(".btn_noshow_wait").on("click", waitNoshowHandler);
        
        
        /* web socket!!!!!!!!!!!!!!!!!!!!*/
        /* 	<div id="socketAlert" class="alert alert-success" role="alert"">알림!!!</div> */
        let socket = null;
   	 
	   	function connectWS() {
	   		// 전역변수 socket을 선언한다.
	   		// 다른 페이지 어디서든 소켓을 불러올 수 있어야 하기 때문이다.
	   		
	   	 	// 소켓을 ws로 연다.
	   	 	var ws = new WebSocket("ws://localhost:8181/manageSocket");
	   	 	socket = ws;
	
	   	 	// 커넥션이 연결되었는지 확인한다.
	   	 	ws.onopen = function () {
	   	 	    console.log('Info: connection opened.');
	   	 	};
	
	   	 	
	   	 	// 받은 메시지를 출력한다.
	   	 	// 메시지를 수신한 이벤트 핸들러와 같다.
	   	 	ws.onmessage = function (event) {
	   	 	    console.log("ReceiveMessage : ", event.data+'\n');
	   	 	    
	   	 	    // 추후에 message 형식을 JSON으로 변환해서 message type을 지정해줘야 한다.
	   	 	    //if()
	   	 	    	
	   	 	   	//alert(event.data);
	   	 	    console.log(typeof event.data);
	   	 	    
	   	 	    let data = JSON.parse(event.data);
	   	 	    
	   	 	    console.log(typeof data);
	   	 	    console.log("cmd : "+data.cmd);
	   	 		console.log("sendUser : "+data.sendUser);
	   	 	    console.log("storeId : "+data.storeId);
	   	 	    console.log("dto : " + data.htdlDto);
	   	 	    
				let curNotiCnt = $(".show").length;
	 	    
	 	    	console.log("curNotiCnt : "+curNotiCnt);
	 	    	
	 	    	let dtoSpan ="";
	 	    	//let dtoSpan = "<span class='manage_htdl_dto' data-name='"+dto.name+"' data-startNm='"+dto.startNm+"' data-endTm='"+dto.endTm+"' data-lmtPnum='"+dto.lmtPnum+"' ></span>"
	 	    	if(data.htdlDto) dtoSpan = "<span class='manage_htdl_dto' data-name='"+data.htdlDto.name+"' data-startTm='"+data.htdlDto.startTm+"' data-endTm='"+data.htdlDto.endTm+"' data-lmtPnum='"+data.htdlDto.lmtPnum+"' ></span>"
	   	 	    
				if(data.cmd === 'rsvd'){
		   	 		showRsvdList(storeId);
		   	 		showRsvdMap(storeId);
		   	 		$('.alert.manage_rsvd .alert_tit').html('예약 알림');
		   	 		$('.alert.manage_rsvd .alert_senduser').html(data.sendUser);
		   	 		$('.alert.manage_rsvd .alert_msg').html(data.msg);
		   	 		document.getElementsByClassName("manage_rsvd")[0].style.bottom = 15 + curNotiCnt*75;
		   	 		$('.alert.manage_rsvd').removeClass("hide");
		   	 		$('.alert.manage_rsvd').addClass("show");
		   	 		$('.alert.manage_rsvd').addClass("showAlert");
		   	 		console.log(data.msg);
				} else if (data.cmd === 'wait'){
		   	 		showWaitList(storeId);
		   	 		$('.alert.manage_wait .alert_tit').html('웨이팅 알림');
		   	 		$('.alert.manage_wait .alert_senduser').html(data.sendUser);
		   			$('.alert.manage_wait .alert_msg').html(data.msg);
		   			document.getElementsByClassName("manage_wait")[0].style.bottom = 15 + curNotiCnt*75;
		   			$('.alert.manage_wait').removeClass("hide");
		   	 		$('.alert.manage_wait').addClass("show");
		   	 		$('.alert.manage_wait').addClass("showAlert");
				} else if (data.cmd === 'htdl') {
		   	 		$('.alert.manage_htdl .alert_tit').html('핫딜 알림');
		   	 		//$('.alert.manage_htdl .alert_senduser').html(data.sendUser);
		   			$('.alert.manage_htdl .alert_msg').html(data.msg);
		   			$('.alert_dto').html(dtoSpan);
		   			$('.alert.manage_htdl').removeClass("hide");
		   	 		$('.alert.manage_htdl').addClass("show");
		   	 		$('.alert.manage_htdl').addClass("showAlert");
		   	 		
		   	 		// 핫딜 넘어오는 데이터 storeid, start tm, end tm, htdl name, 
		   	 		// 
				}
	   	 	    
	   	 	    //let socketAlert = $('#socektAlert');
	   	 		//socketAlert.html(event.data);
	   	 	    //socketAlert.css('display','block');
			    
			    // 메시지가 3초 있다가 자동으로 사라지게
			    /*	
			    setTimeout( function(){
			    	
			    	$socketAlert.css('display','none');
			    },3000);
	   	 	    */
			    
			    /*
	   	 	    let socketAlert = $('#socektAlert');
	   	 		socketAlert.innerHTML = event.data;
	   	 	    socketAlert.style.display = "block";
	   	 	   	showWaitList(storeId);
	   	 	    */
	   	 	   	
	   	 	    // 메시지가 3초 있다가 자동으로 사라지게
	   	 	    /*
	   	 	    setTimeout( function(){
	   	 	    	
	   	 	    	$socketAlert.css('display','none');
	   	 	    },3000);
	   	 	    */
	   	 	};
	
	
	   	 	// connection을 닫는다.
	   	 	ws.onclose = function (event) {
	   	 		console.log('Info: connection closed.');
	   	 		//setTimeout( function(){ connect(); }, 1000); // retry connection!!
	   	 	};
	   	 	ws.onerror = function (event) { console.log('Error'); };
	   	 	
	   	 }
	   		
	   		// input 내용을 socket에 send
	   		$('#btnSend').on('click', function(evt) {
	   			  evt.preventDefault();
	   			if (socket.readyState !== 1) return;
	   				  let msg = $('input#msg').val();
	   				  socket.send(msg);
	   			});
	   		
	   		connectWS();
   });
	
    /* get store img (즉시실행함수)*/
    $(document).ready(function() {
    	

        (function(){
            
        	let storeId = ${storeId};
            
            $.getJSON("/dealight/business/manage/getStoreImgs", {storeId:storeId}, function(imgs){
                
            	// debug
                //console.log("즉시 함수..");
                //console.log(imgs);
                
                let str = "";
                
                $(imgs).each(function(i, img){
                	
                	// debug
                	//console.log(img);
                    
                    // image type
                    if(img.image) {
                        
                        let fileCallPath = encodeURIComponent(img.uploadPath+"/s_" +img.uuid + "_" +img.fileName);
                        
                        str += "<li data-path='" + img.uploadPath + "'data-uuid='" + img.uuid + "'data-filename='"
                            + img.fileName +"'data-type='" + img.image+"'><div>";
                        str += "<img src='/display?fileName=" + fileCallPath+"'>";
                        str += "</li>";
                        
                    } else {
                        
                        str += "<li data-path='" + img.uploadPath +"' data-uuid='" + img.uuid 
                                +"' data-filename='" + img.fileName +"' data-type='" + img.image+"'><div>";
                        str += "<span>" + img.fileName+"</span><br/>";
                        str += "<img src='/resources/img/attach.png'>";
                        str += "</div>";
                        str += "</li>";
                    }
                });
                
                $(".uploadResult ul").html(str);
                
            }); // end getjson
            
        })(); // end function

        
        $(".uploadResult").on("click", "li", function(e){
            
        	// debug
            // console.log("view image");
            
            let liObj = $(this);
            
            let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
            
            if(liObj.data("type")){
                
                showImage(path.replace(new RegExp(/\\/g), "/"));
            } else {
                //download
                self.location = "/download?fileName=" + path
            }
        });
        
        function showImage(fileCallPath) {
            
            alert(fileCallPath);
            
            $(".bigPictureWrapper").css("display", "flex").show();
            
            $(".bigPicture")
            .html("<img src='/display?fileName=" + fileCallPath +"'>")
            .animate({width:'100%',height:'100%'},1000);
            
        }
        
        $(".bigPictureWrapper").on("click",function(e){
            $(".bigPicture").animate({width : '0%', height : '0%'}, 1000);
            setTimeout(function(){
                $('.bigPictureWrapper').hide();
            },1000);
        })


        var operForm = $("#operForm");
        
        $("button[data-oper='modify']").on("click", function(e){
            
            operForm.attr("action", "/board/modify").submit();
            
        });
        
        $("button[data-oper='list']").on("click",function(e){
            
            operForm.find("#bno").remove();
            operForm.attr("action","/board/list");
            operForm.submit();
            
        });
        
    });

    </script>
 <%@include file="../../../includes/mainFooter.jsp" %>
 <script src="/resources/js/clock.js"></script>
</body>
</html>