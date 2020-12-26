// 모달 선택
	const modal = $("#myModal"),
		close = $(".close_modal"),
		modalContent = $(".modal-content"),
		btn_show_board = $("#btn_show_board");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
		modal.find(".content_div").html("");
		modal.find("#map").css("display","none");
		modal.find(".content_div").css("display","none");
	});
	
	window.onclick = function(e) {
		
		  if (e.target === document.getElementById('myModal')) {
			  modal.css("display","none");
			  modal.find("ul").html("");
			  modal.find(".content_div").html("");
			  modal.find("#map").css("display","none");
			  modal.find(".content_div").css("display","none");
		  }
	}
	
    // esc 눌러서 모달 escape
    $(document).keyup(function(e) {
    	if(e.key === "Escape"){
    		modal.css("display","none");
    		modal.find("ul").html("");
    		modal.find(".content_div").html("");
    		modal.find("#map").css("display","none");
    		modal.find(".content_div").css("display","none");
    	}
    });
    
    	$(".alert_closebtn").on("click", e => {
    		$(e.target).parent().addClass("hide");
    		$(e.target).parent().removeClass("show");
    		//setTimeout($(e.target).parent().removeClass("showAlert"),5000); 	
    	});