document.addEventListener("DOMContentLoaded", function() {
    document.querySelector("input[type='submit']").addEventListener("click", function(event) {
        var pw = document.querySelector("#pw");
        var cfmpw = document.querySelector("#cfpw");
        var pwmaxchar = document.querySelector(".pwmaxchar");
        var pwNotSameError = document.querySelector(".pwnotsame");

        var pwvalue = pw.value;
        var cfmpwvalue = cfmpw.value;

        if (pwvalue === null) {
            return false;
        } else if (pwvalue.length < 8) {
            pwmaxchar.innerHTML = "*Password must be at least 8 characters.";
            event.preventDefault();
            return false;
        }

        if (pwvalue !== cfmpwvalue) {
            pwNotSameError.innerHTML = "*Passwords must match.";
            event.preventDefault();
            return false;
        }

        return true;
    });
});

function checkPasswordLength() {
    var pw = document.querySelector("#pw");
    var pwmaxchar = document.querySelector(".pwmaxchar");

    var pwLength = pw.value.length;
    if (pwLength >= 8) {
        pwmaxchar.style.display = "none";
    } else {
        pwmaxchar.style.display = "block"; 
    }
}
function checkPwSameOrNot(){
	var pw = document.querySelector("#pw");
	var cfpw = document.querySelector("#cfpw");
	
	var pwNotSameError = document.querySelector(".pwnotsame");
	if(pw.value !== cfpw.value){
		pwNotSameError.style.display = "block";
	}else{
		pwNotSameError.style.display = "none";
	}
}
setInterval(checkPasswordLength, 1000);
setInterval(checkPwSameOrNot, 1000);

document.addEventListener("DOMContentLoaded", function() {
	session.removeItem("expirationTime");
    console.log("Document is ready!");
});
