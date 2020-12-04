	// 모달 선택
	const modal = $("#myModal"),
		close = $(".close"),
		modalContent = $(".modal-content");

	close.on("click", (e) => {
		modal.css("display","none");
		modal.find("ul").html("");
		modal.find("#map").html("");
		modal.find("#map").css("display", "none");
	});
	
	modal.find("#map").css("display", "none");
	
	/*
	 모달이 아닌 화면을 클릭하면 모달이 종료가 되어야 하는데 그렇지 않음.
	*/
	window.onclick = function(event) {
		  if (event.target == modal) {
			  modal.css("display","none");
			  modal.find("ul").html("");
		  }
	};
