<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
<link href="resources/css/register.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
</head>
<style>
	 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');

	*{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        

        .wrapper{
            width: 70%;
            padding: 15px;
			margin: 100px auto;
            background-color: #fff;
            border-radius: 30px;
            box-shadow: 0 10px 30px rgba(5, 5, 5, 0.1);
            display: flex;
            flex-direction: row;
        }

        body{
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: aliceblue;
        }
        h3{
            text-align: center;
            margin-top: 20px;
            font-size: 40px;
        }
        .registerForm {
            height: auto;
            display: flex;
            flex-direction: column;
            margin: 10px auto;
            width: 70%;
            padding: 20px;
            padding-right: 0;
            gap: 6px;
            border-bottom: none;
            color: black;
        }
        .line{
            border-bottom: 1px solid black;
        }
        .box{
            position: relative;
            padding: 11px;
        }
        .text{
            background-color: white;
            position: absolute;
            top: -11%;
            left: 49%;
        }
        .pwnotsame{
            font-size: 14px;
            margin: 0;
            color: red;
        }
        input{
            margin-bottom: 10px;
        }
        label{
			margin-bottom: 10px;
            font-size: 90%;
		}
        @media (max-width:1088px) {
            label{
                font-size: 80%;
            }
        }
		.error{
			color:red;
		}
		.auto-disappear {
		    opacity: 1;
		    transition: opacity 1s ease-in-out;
		    position: fixed;
		    bottom: 20%;
		    display: block;
		    width: auto;
		    right: 45%;
		    z-index:999;
		    padding:10px;
		    border-radius: 10px;
		  }
		
		  #message.hidden {
		    opacity: 0;
		    transition: opacity 1s ease-in-out;
		  }
		       .navbar-brand {
            padding-left: 20px;
            font-size: 27px !important;
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }

		.nav-link{
        	padding:20px !important;
        	border-radius: 10px;
        }
        .login{        
        	padding:20px !important;
        }
		nav{
			padding: 0 !important;
		}
		.container-fluid{
			padding: 0 !important;
		}
        .title {
            font-size: 31px;
        }
		
        .navbar {
            list-style-type: none;
            position: fixed;
            top:0;
            width: 100%;
            background-color: white;
            box-shadow: 0px 0.3px 40px rgba(0, 0, 0, 0.2);
        }

        .container-fluid {
            max-width: 1900px;
            padding: 3px;
        }

         .navbar-nav li a {
            display: inline-block;
            text-decoration: none;
            color: black;
            padding: 5px 15px;
            border: 1px solid transparent;
            transition: 0.5 ease;
            text-align: center;
        }

        .navbar-nav li a:hover {
            background-color: gainsboro;
            color: #111;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #fff;
            min-width: 100%;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .dropdown-content a {
            display: block;
			width:100%;
            color: white;
            text-decoration: none;
        }

        .dropdown:hover .dropdown-content {
            display: block;
            width:100%;
        }

        .dropdown-content a:hover {
            background-color: #f4f4f4;
        }
        body {
            background-color: #f8f9fa;
            overflow-y:hidden;
        }
        label{
        	margin-left:10px;
        }
</style>
<body>
<nav class="navbar navbar-expand-lg navbar-light position-fixed">
            <div class="container-fluid">
                <a class="navbar-brand" href="/knowledge_hub">Knowledge Hub</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="/knowledge_hub/#home"><i class="fas fa-home"></i> Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/knowledge_hub/#about"><i class="fas fa-info-circle"></i> About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/knowledge_hub/#myteam"><i class="fa-solid fa-people-group"></i> My Team</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/knowledge_hub/#feedback"><i class="fas fa-comment"></i> Feedback</a>
                        </li>
                        <li class="nav-item">
                        <c:choose>
                            <c:when test="${sessionScope.login}">
                            	<li class="nav-item">
                            		<a href="user_detail/${sessionScope.userId}">Profile</a>
                            	</li>
                            </c:when>
                            <c:otherwise>
								<div class="dropdown">
									<a class="dropdown-toggle nav-link" href="register">Sign up</a>
									<div class="dropdown-content">
										<a href="login" class="login">Login</a>
									</div>
								</div>
							</c:otherwise>
                        </c:choose>
                            
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
<div class="wrapper">
    <img src="resources/photos/register.svg" alt="register photo" width="500px" class="d-none d-lg-block" style="min-width: 300px;">
    <form:form action="register" class="registerForm" method="post" modelAttribute="user">
        <h3 style="font-size:40px;">Sign Up</h3>
			<c:if test="${message ne null}">
				<div id="message" class="auto-disappear text-white bg-dark">${message}</div>
			</c:if>
			<div class="row">
                <div class="form-floating col-sm-12 col-lg-6">
                    <form:input path="name" type="text" name="name" id="name" class="form-control border-secondary" placeholder="Enter your name" required="true" autocomplete="off"/>
                    <form:label path="name" for="name">Enter your name</form:label>
                    <form:errors path="name" cssClass="error"></form:errors>
                </div>
            
                <div class="form-floating col-sm-12 col-lg-6">
                    <form:input path="email"  type="email" name="email2" id="email2" class="form-control border-secondary" placeholder="Enter your email address" required="true" autocomplete="off"/>
                    <form:label path="email" for="email2">Enter your email address</form:label>
                    <form:errors path="email" cssClass="error"></form:errors>
                </div>
           </div>
           <div class="row">
                <div class="form-floating col-sm-12 col-lg-6">
                    <form:input path="password" type="password" name="password2" id="password2" class="form-control border-secondary" placeholder="Enter your password" required="true" autocomplete="off"/>
                    <form:label path="password" for="password2">Enter your password</form:label>
                    <form:errors path="password" cssClass="error"></form:errors>
                    <span class="pwmaxchar error"></span>
                </div>
                <div class="form-floating col-sm-12 col-lg-6">
                    <input type="password" name="cfmpassword2" id="cfmpassword2" placeholder="Enter your confirm password" class="form-control border-secondary" required autocomplete="off">
                    <label for="cfmpassword2">Comfirm your password</label>
                    <span class="pwnotsame error"></span>
                </div>
                <div>
                    <input type="checkbox" name="showpw" id="showpw">
                    <label for="showpw">Show password</label>
                </div>
           </div>

      <div class="row">
          <div class="form-check col-lg-6">
  
              <form:label path="gender" for="male">Male</form:label>
              <form:radiobutton path="gender" id="male" value="male" required="true"/>
                  
              <form:label path="gender" for="female">Female</form:label>
              <form:radiobutton path="gender"  id="female" name="role" value="female" required="true"/>
          </div>
        <div class="form-group  col-lg-6">
            <form:label path="dob">Date of Birth</form:label>
            <form:input path="dob" type="date" class="form-control border-secondary" autocomplete="off" required="true"/>
            <form:errors path="dob" cssClass="error"/>
        </div>

      </div>
    
        <div class="form-group">
            <input type="checkbox" id="terms" required/>
            <label for="terms" style="user-select: none;">I agree to the <a href="terms"> terms and conditions</a></label>
        </div>
    
        <button type="submit" class="btn btn-primary mb-3">Sign up</button>

        <p>Already have account? <a href="login" class="Register">Login</a></p>
    </form:form>

    </div>
    <script>
        document.querySelector(".registerForm").addEventListener('submit', function (event) {
            var pw = document.querySelector("#password2");
            var cfmpw = document.querySelector("#cfmpassword2");
			var pwmaxchar = document.querySelector(".pwmaxchar");
			var pwNotSameError = document.querySelector(".pwnotsame");

            var pwvalue = pw.value;
            var cfmpwvalue = cfmpw.value;
            
            
            if(pwvalue === null){
            	return false;
            }else if(pwvalue.length < 8){
            	pwmaxchar.innerHTML = "*Password must atleast 8 charactors.";
            	event.preventDefault();
            	return false;
            }
            if (pwvalue !== cfmpwvalue) {
                pwNotSameError.innerHTML = "*Password must be the same";
                event.preventDefault();
                return false;
            }
            return true;
        });
        document.querySelector("#showpw").addEventListener('click',function(){
            var pw = document.querySelector("#password2");
            var cfmpw = document.querySelector("#cfmpassword2");
        
            if(this.checked){
                pw.type="text";
                cfmpw.type="text";
            }else{
                pw.type="password"
                cfmpw.type="password"
            }
        })
        
        const messageElement = document.getElementById('message');

		document.addEventListener('DOMContentLoaded', function() {
		    const messageElement = document.getElementById('message');
		    if (message !== null && message !== "") {
		      setTimeout(function() {
		        messageElement.classList.add('hidden');
		      }, 1000); 
		    }
		  });
		sessionStorage.removeItem("expirationTime");
    </script>
	
</body>
</html>