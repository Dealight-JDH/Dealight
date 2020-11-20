/* 동인  */

window.onload = function () {
wait_custNm = document.querySelector("#js_wait_custNm"),
wait_phoneNum = document.querySelector("#js_wait_custTelno"),
wait_pnum = document.querySelector("#js_wait_pnum"),
btn_submit = document.querySelector("#submit_waitRegForm"),
name_msg = document.querySelector("#name_msg"),
phoneNum_msg = document.querySelector("#phoneNum_msg"),
pnum_msg = document.querySelector("#pnum_msg"),
inputList = document.querySelectorAll("input");


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
	if(1 <= wait_phoneNum.value <= 10)
		return true;
	return false;
}

wait_custNm.addEventListener("focusout", () => {
	if(1 <= wait_custNm.value.length){
	    if(nameLenCheck()){
	        name_msg.innerText = "🙆‍♂️ 이름 형식이 적당하네요.";
	    }
	    else {
	    	name_msg.innerText = "🙅‍♂️ 이름 길이를 다시 확인해 주세요. (5자 이내)";
	    }
	}
})

wait_phoneNum.addEventListener("focusout", () => {
	if(1 <= wait_phoneNum.value.length){
	    if(phoneNumLenCheck()){
	        name_msg.innerText = "🙆‍♂️ 전화번호 형식이 적당하네요!";
	    }
	    else {
	    	name_msg.innerText = "🙅‍♂️ 전화번호 길이를 다시 확인해 주세요. (13자 이내)";
	    }
	}
})

wait_pnum.addEventListener("focusout", () => {
	if(1 <= wait_pnum.value.length){
	    if(pnumSizeCheck()){
	        name_msg.innerText = "🙆‍♂️ 인원이 적당합니다.";
	    }
	    else {
	    	name_msg.innerText = "🙅‍♂️ 인원이 너무 많아요! (10명 이내)";
	    }
	}
})

nullCheck = function(inputList) {
    for(let i = 0; i < inputList.length; i++)
        if(inputList[i].value == "")
            return false;
    
    return true;
}
        
btn_submit.addEventListener("click", (e) => {

    e.preventDefault();

    if(!nullCheck(inputList)){
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
    
    
    
    
    console.log("submit 성공");
    form.submit();
});
}