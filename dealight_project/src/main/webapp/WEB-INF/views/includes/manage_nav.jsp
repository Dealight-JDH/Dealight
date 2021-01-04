<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<main class="store_board" id="store_board_main">
<div class="main_box"><!-- main box -->
            <div class="board"> <!-- board -->
                <div class="board_left_wrapper">
                    <div class="board_left_top">
                        <div class="nav_date js-clock">
                        	<span class="date">2020-12-18</span><span style="color:white;">_</span><span class="time">00:00</span>
                        </div>
                    </div>
                    <div class="board_left_bot">
                        <div id="btn_wait_register_id" class="btn_wait_register manage_side_menu_box"><a href="/dealight/business/manage/?storeId=${storeId}">관리 화면</a></div>
                        <div class='manage_side_menu_box'><a href="/dealight/business/manage/modify?storeId=${storeId}">정보 수정</a></div>
                        <div class='manage_side_menu_box'><a href="/dealight/business/manage/menu?storeId=${storeId}">메뉴 수정</a></div>
                        <div class='manage_side_menu_box'><a href="/dealight/business/manage/dealhistory?storeId=${storeId}">핫딜 이력</a></div>
                        <div class='manage_side_menu_box'><a href="/dealight/business/">매장 리스트</a></div>
                        <div id="store_info_box">
                            <div class="store_info_tit">매장 이름</div>
                            <div class="store_info_val">${store.storeNm}</div>
                            <div class="store_info_tit">매장 수용 인원</div>
                            <div class="store_info_val">${store.bstore.acmPnum}명</div>
                            <div class="store_info_tit">매장 평균 식사 시간</div>
                            <div class="store_info_val">${store.bstore.avgMealTm}분</div>	
                        </div>
                    </div>
                </div>
				<div class="board_right_wrapper">
                    <div class="board_wrapper"> <!-- board wrapper -->
                        <div class="board_top_box"> <!-- top box -->
                            <div class="top_box_items light"> 
                                <span>영업 상태</span>
                                <form id="seatStusForm" action="/dealight/business/manage/board/seat"
                                        method="put">
                                        <input name="seatStusColor" id="color_value" value="" hidden>
                                        <input name="storeId" value="${storeId}" hidden>
                                        <button class="btn_seat_stus green" data-color="Green"><i class="fas fa-circle"></i></button>
                                        <button class="btn_seat_stus yellow" data-color="Yellow"><i class="fas fa-circle"></i></button>
                                        <button class="btn_seat_stus red" data-color="Red"><i class="fas fa-circle"></i></button>
                                </form>
                            </div> 
                       </div>
