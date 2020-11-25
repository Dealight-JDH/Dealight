/**
 * 
 */
        const arr = [1,2,3,4,5,6,7,8,9,10];

        let cnt = 0;

        console.log(arr.length);

      

            
            document.getElementById("scroll-content").addEventListener("scroll", function(event) {
                if(cnt >= arr.length)
                    return;

                var newDiv = document.createElement("div");
                newDiv.innerHTML = arr[cnt++];
                newDiv.className = "good"
                document.getElementById("scroll-content").appendChild(newDiv);
            });



        var checkForNewDiv = function() {
            var lastDiv = document.querySelector("#scroll-content > div:last-child");
            var maindiv = document.querySelector("#scroll-content");
            var lastDivOffset = lastDiv.offsetTop + lastDiv.clientHeight;
            var pageOffset = maindiv.offsetTop + maindiv.clientHeight;            
            
            if (pageOffset > lastDivOffset - 10) {
                var newDiv = document.createElement("div");
                newDiv.innerHTML = arr[cnt++];
                newDiv.className = "good"
                document.getElementById("scroll-content").appendChild(newDiv);
                checkForNewDiv();
            }

        };

        checkForNewDiv();