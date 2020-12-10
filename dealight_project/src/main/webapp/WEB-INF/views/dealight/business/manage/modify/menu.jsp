<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	.select_img img{
		margin : 20px 0;
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
        }

        /* Modal Content/Box */
        .modal-content {
        background-color: #fefefe;
        margin: 10% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 60%; /* Could be more or less, depending on screen size */
        }

        /* The Close Button */
        .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .close:hover,
        .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
        
        /* The Delete Button*/
        .btn_delete {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        }

        .btn_delete:hover,
        .btn_delete:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
        }
	
</style>
<style>
	img {
	
	width : 100px;
	height : 100px;
	
	}
	main{
		margin : 30px auto;
		width:1050px;
	}
</style>
</head>
<body>
<%@include file="../../../../includes/mainMenu.jsp" %>
<main>
	<h1>Business Menu Page</h1>
	
	<h2>메뉴 등록</h2> 
	<form action="/dealight/business/manage/menu/register" method="post" id="regForm">
		============================================================</br>
		<input name="storeId" value="${storeId}" hidden>
		
		<label for="name">메뉴 이름 : </label>
		<input name="name" required> </br>
		
		<label for="price">메뉴 가격 : </label>
		<input name="price" required> </br>
		
		<label for="recoMenu">메뉴 추천 여부 : </label>
		<input name="recoMenu" type="checkbox"></br>
		
		<div class=""><h2>사진 첨부하기(1개만 가능)</h2></div>
			<div class="file_body">
			<div class="form_img">
				<input type="file" name='uploadFile'>
			</div> 
			<div class='uploadResult'>
				<ul>
				</ul>
			</div> <!-- uploadResult -->
		</div> 
		<div class='bigPictureWrapper'>
			<div class='bigPicture'>
			</div>
		</div>
		<button id="submit_menuRegForm" type="submit">제출하기</button></br>
		============================================================
	</form>
	
	<h2>메뉴 리스트</h2>
	<c:if test="${empty menus }">
	<h2>현재 등록하신 메뉴가 없습니다!🤣</h2>
	</c:if>
	<c:if test="${not empty menus }">
		<c:forEach items="${menus }" var="menu">
			<div class="menu">
				=========================================
				<span hidden class='menuSeq'>${menu.menuSeq }</span>
				<span hidden class='storeId'>${menu.storeId }</span>
				<span hidden class='name'>${menu.name }</span>
				<span hidden class='price'>${menu.price }</span>
				<span hidden class='thumImgUrl'>${menu.thumImgUrl }</span>
				<span hidden class='recoMenu'>${menu.recoMenu }</span>
				<span hidden class='imgUrl'>${menu.imgUrl }</span>
				<h4>매장 번호 : ${menu.storeId }</h4>
				<h4>메뉴 번호 : ${menu.menuSeq }</h4>
				<h4>메뉴 이름 : ${menu.name }</h4>
				<h4>메뉴 가격 : ${menu.price }</h4>
				<h4>메뉴 사진 : ${menu.thumImgUrl }</h4>
				<h4>메뉴 추천 여부 : ${menu.recoMenu }</h4>
				<c:if test="${not empty menu.imgUrl}"><h4>메뉴 사진 : </h4><img src="/display?fileName=${menu.encThumImgUrl }"></c:if>
			</div>
		</c:forEach>
	</c:if>
</main>

	<div id="myModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<div class="menu_content"></div>
		</div>
	</div>

<script>
	/* 정규식으로 파일 형식을 제한한다. */
	const regex = new RegExp("(.*>)\.(exe|sh|zip|alz)$");
	/*최대 파일 크기를 제어한다  */
	const maxSize = 5242880; /* 5MB */
	// add category ***페이지마다 변경 필요
	const category = 'menuImgs';
	// page type
	const pageType = "register";
	// storeId
	const storeId = null;
	// isModal
	const isModal = false;
	// btn id
	let btnSubmit = "#submit_menuRegForm";
	/* form 역할을 하는 엘리먼트를 선택한다. */
	let formObj = $("#regForm");
</script>
<script type="text/javascript" src="/resources/js/singleFileUpload.js?ver=1"></script>
<script>
/* 동인  */

	const menuUl = $(".menu_content");

	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
	});
	
	window.onclick = function(e) {
		
		  if (e.target === document.getElementById('myModal')) {
			  modal.css("display","none");
			  modal.find("ul").html("");
		  }
	};
	
    // esc 눌러서 모달 escape
    $(document).keyup(function(e) {
    	if(e.key === "Escape"){
    		modal.css("display","none");
    		modal.find("ul").html("");
    	}
    });
	
	/** REST FUL 대기 **/
	let menuService = (() => {
		
		/* 매장 내용 변경 put */
		function putModifyMenu(params, callback,error ){
			
			$.ajax({
				
				type : 'put',
				url : '/dealight/business/manage/menu/modify',
				data : {
					'storeId' : params.storeId,
					'menuSeq' : params.menuSeq,
					'name' : params.name,
					'price' : params.price,
					'recoMenu' : params.recoMenu,
					'imgUrl' : params.imgUrl,
					'thumImgUrl' : params.thumImgUrl
						},
			contentType : 'application/json',
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
		
	});

	

/* 페이지가 로드 되면 실행된다. */
$(document).ready(function(e){
    
	let showMenuModalHandler = function(e) {
			let menuSeq = $(e.target).parent().find(".menuSeq").text(),
			storeId = $(e.target).parent().find(".storeId").text(),
			name = $(e.target).parent().find(".name").text(),
			price = $(e.target).parent().find(".price").text(),
			recoMenu = $(e.target).parent().find(".recoMenu").text(),
			imgUrl = $(e.target).parent().find(".imgUrl").text(),
			thumImgUrl = $(e.target).parent().find(".thumImgUrl").text().trim();
		
		console.log(menuSeq);
		
		recoCheck = '';
		
		if(recoMenu === 'Y')
			recoCheck = 'checked';
		
		let strMenu = "";
		strMenu += "<h2>메뉴 수정</h2>"
		strMenu += "<form id='menuForm_modify' action='' method='post'>";
		strMenu += "매장 번호 : <input type='text' name='storeId' value='"+storeId+"' readonly></br>";
		strMenu += "메뉴 일련 번호 : <input type='text' name='menuSeq' value='"+menuSeq+"' readonly></br>";
		strMenu += "메뉴 이름 : <input type='text' name='name' value='"+name+"'></br>";
		strMenu += "메뉴 가격 : <input type='number' name='price' value='"+price+"'></br>";
		strMenu += "추천 여부 : <input type='checkbox' name='recoMenu' "+recoCheck+"></br>";
		if(imgUrl) strMenu += "메뉴 사진 : <img src='/display?fileName="+encodeURI(thumImgUrl)+"'>";
		strMenu += "<div><h2>사진 첨부하기(1개만 가능)</h2></div>";
		strMenu += "<div class='file_body_modify'>";
		strMenu += "<div class='form_img_modify'>";
		strMenu += "<input type='file' id='js_upload' name='uploadFile'>";
		strMenu += "</div> ";
		strMenu += "<div class='uploadResult_modify'>";
		strMenu += "<ul></ul></div></div> ";
		strMenu += "<div class='bigPictureWrapper_modify'><div class='bigPicture_modify'></div></div>";
		strMenu += "</form>";
		strMenu += "<button data-oper='modify' class='btn_modify'>수정</button>";
		strMenu += "<button data-oper='remove' class='btn_remove'>제거</button>";
		$(".menu_content").html(strMenu);
		modal.css("display", "block");
		
		var btnSubmit_modify = ".btn_modify";
		var formObj_modify =  $("#menuForm_modify");
		
		let showUploadResult_modify = function (uploadResultArr) {
	        
	        /**업로드 된게 없으면 그대로 반환 */
			if(!uploadResultArr || uploadResultArr.length == 0){return; }
	        
	        /*업로드 결과를 보여줄 ul를 선택 */
			let uploadUL_modify = $(".uploadResult_modify ul");
			
			let str = "";
	        
	        /*업로드 결과를 보여준다. */
			$(uploadResultArr).each(function(i,obj){
				
	            /* 만일 파일이 이미지 형식이면 */
	            /* data에 path,uuid,filename,type을 각각 저장한다. */
				
				if(i === 0) // 파일 1개만 올릴 수 있게
				if(obj.image) {
					let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					
					// 
					let originPath = obj.uploadPath + "\\" + obj.uuid +"_" + obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li data-path='" + obj.uploadPath +"'";
					str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
					str += "><div>";
					str += "<span>" + obj.fileName +"</span>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str += "<button type ='button' data-file=\'"+fileCallPath+"\' data-type='image'"
								+" class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "</li>";
	                /* 만일 파일이 이미지 형식이 아니면 */
	                /* default img를 보여준다. */
				} else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");

					str += "<li "
					str += "data-path='" + obj.uploadPath + "'data-uuid='" + obj.uuid + "'data-filename='" + obj.fileName + "' data-type='" +obj.image+"'>" + "<div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>삭제</button><br>";
					str += "</li>";
				}
			});
	        
			uploadUL_modify.html(str);
		}
	    
		var inputHandler_modify = function(e){
		        
		        /* 기존 기능은 제한한다.*/
				e.preventDefault();
				
				let str = "";
		        
		        /* 업로드 결과 화면에 업로드 결과를 작성해준다.*/
		        /* jquery의 foreach문 */
				$(".uploadResult_modify ul li").each(function(i, obj) {
					
					let jobj = $(obj);
					
					str += "<input type='hidden' name='imgUrl' value='" + jobj.data("path").replace(new RegExp(/\\/g),"/")+"/"+jobj.data("uuid")+"_"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='thumImgUrl' value='" + jobj.data("path").replace(new RegExp(/\\/g),"/")+"/"+"s_"+jobj.data("uuid")+"_"+jobj.data("filename")+"'>";
					
				});
		        	
		        /*위에서 작성한 글을 form에 추가하고 제출한다. */
		        formObj_modify.attr("action","/dealight/business/manage/menu/modify");
		        formObj_modify.attr("method", "post");
		        formObj_modify.append(str).submit();
			
		};
		
	    
	    /* change() 해당하는 요소의 value에 변화가 생길 경우 이를 감지하여 등록된 콜백함수를 동작시킨다.  */
		var uploadHandler_modify = function(e){
			
	    	console.log("change event");
	    	
	    	let cloneObj = $(".form_img_modify").clone();
	        
	        let formData = new FormData();
	        
	        let inputFile = $("#js_upload");
	        
	        let files = inputFile[0].files;
	        
			formData.append("category", category);
			
	            if(!checkExtension(files[0].name, files[0].size)) {
	                return false;
	            }
	            formData.append("uploadFile", files[0]);
	        
	        $.ajax({
	            url : '/uploadAjaxAction',
	            processData : false,
	            contentType : false, data:
	                formData, type: 'POST',
	                dataType : 'json',
	                success : function(result) {
	                	showUploadResult_modify(result); // 업로드 결과 처리 함수
	               	 	$(".form_img_modify").html(cloneObj.html()); // 첨부파일 개수 초기화
	               	 	$("#js_upload").change(uploadHandler_modify); // 이벤트 등록 (재귀)
	                }
	        })
	    };
	
	    /* 업로드 결과를 누르면 해당 파일을 제거한다.  */
		var deleteHandler_modify = function(e){
			
			console.log("delete file");
			
			if(!confirm("Remove this file?"))
							return;
			
			  		let targetFile = $(this).data("file");
					console.log(targetFile);
			
					let type = $(this).data("type");
					console.log(type);
			
					let targetLi = $(this).closest("li");
					console.log(targetLi);
			
			$.ajax({
					url : '/deleteFile',
					data : {fileName : targetFile, type:type},
					dataType : 'text',
					type : 'POST',
					success : function(result) {
						alert(result);
						targetLi.remove();
					}
					}); // $.ajax
			};
	
		var showImage_modify = function (fileCallPath) {
			
			alert(fileCallPath);
			
			$(".bigPictureWrapper_modify").css("display","flex").show();
			
			$(".bigPicture_modify")
			.html("<img src='/display?fileName=" + fileCallPath + "'>")
			.animate({width:'100%',height:'100%'},1000);
			
			
		}// end show image
		
		var showImageHandler_modify = function(e) {
	    	
			if(e.target.type === "button")
	    		return;
	    	
	        let liObj = $(this);
	        
	        let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") +"_" +liObj.data("filename"));
	        
	        if(liObj.data("type")){
	            
	            showImage_modify(path.replace(new RegExp(/\\/g), "/"));
	        } else {
	            //download
	            self.location = "/download?fileName=" + path
	        }
		};
		
		var bigImgAniHandler_modify = function (e) {
			$(".bigPicture_modify").animate({width:'0%',height:'0%'},1000);
			setTimeout(()=>{
				$(this).hide();
			}, 1000);
		}
		
		/* submit 타입의 버튼을 제어한다.*/
		$("#js_upload").change(uploadHandler_modify); 
		$(".uploadResult_modify").on("click", "button", deleteHandler_modify);
	    $(".uploadResult_modify").on("click", "li", showImageHandler_modify);
		$(".bigPictureWrapper_modify").on("click",bigImgAniHandler_modify);
		$(".btn_modify").on("click", inputHandler_modify);
		$(".btn_remove").on("click", function(e){
			if(comfirm("정말로 삭제하시겠습니까?")){
				formObj_modify.attr("method", "post");
				formObj_modify.attr("action", "/dealight/business/manage/menu/delete").submit();
			}
		});
		
	} // show menu
	
	$(".menu > *").on("click", showMenuModalHandler);
	
}); // ready end
</script>
</body>
</html>