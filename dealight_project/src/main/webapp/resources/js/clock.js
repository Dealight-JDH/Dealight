const clockContainer = document.querySelector(".js-clock"),
      clockTime = clockContainer.querySelector(".time"),
      clockDate = clockContainer.querySelector(".date");

function getTime(hour, second){
    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth();
    const day = date.getDate();
    const minutes = date.getMinutes();
    const hours = date.getHours();
    const seconds = date.getSeconds();

    clockDate.innerText = year + '년' + (month+1) + '월' + day + '일';

    clockTime.innerText = `${hours < 10 ? `0${
        hours}` : hours}:${minutes < 10 ? `0${
        minutes}` : minutes}:${seconds < 10 ? `0${
        seconds}` : seconds}`;
}


function init() {
    getTime();
    setInterval(getTime, 1000);
    
}

init();
