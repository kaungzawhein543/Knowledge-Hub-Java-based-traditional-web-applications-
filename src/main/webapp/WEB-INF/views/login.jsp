<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link href="<c:url value="resources/css/bootstrap.min.css"/>" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.bundle.min.js"/>"></script>
</head>
<style>
		 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');
	
        body{
        	height:100vh;
        	overflow-y:hidden;
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
            justify-content: center;
        }

        body{
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: aliceblue;
        }
        h3{
            text-align: left;
            font-size: 40px;
            margin-top: 30px;
        }
        .loginForm {
            height: auto;
            padding: 20px;
            padding-right: 3%;
            gap: 15px;
            width: 70%;
            display: flex;
            flex-direction: column;
            min-width: 300px;
            border-bottom: none;
            color: black;
            max-width: 400px;
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
            margin-bottom:20px;
        }
		label{
			margin-bottom: 10px;
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
			
		.error{
			color:red;
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
            
        }
        
        
		
</style>	
<body>
    <c:if test="${message ne null}">
		<div id="message" class="auto-disappear text-white bg-dark">${message}</div>
	</c:if>
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
        <form:form action="login" class="loginForm" modelAttribute="user" method="post">
            <h3>Login</h3>
            
            <div class="form-floating">
                <form:input path="email"  type="email" class="form-control border-secondary" placeholder="Enter your email address" id="email" required="true" autocomplete="off"/>
               	<form:label path="email" for="email">Enter your email address</form:label>	
                <form:errors path="email" cssClass="error"/>
            </div>
        
            <div class="form-floating">
                <form:input path="password" type="password" id="password" class="form-control border-secondary" placeholder="Enter your password" required="true" autocomplete="off"/>
                <form:label path="password" for="password">Enter your  password</form:label>
                <form:errors path="password" cssClass="error"/>   
            </div>

            <div>
                <input type="checkbox" name="showpw" id="showpw">
                <label for="showpw">Show password</label>
            </div>
        
            <button type="submit" class="btn btn-primary mb-3" >Login</button>
			<a href="forgetpassword">forget password?</a>
            <p>Create new account? <a href="register" class="Register">Sign up</a></p>
        </form:form>
        <img src="resources/photos/signin2.svg" alt="" width="500px" class="d-none d-lg-block"  style="min-width: 300px;">
    </div>
    
    <script>

        document.querySelector("#showpw").addEventListener('click',function(){
            var pw = document.querySelector("#password");
        
            if(this.checked){
                pw.type="text";
            }else{
                pw.type="password"
            }
        })

		const messageElement = document.getElementById('message');

	document.addEventListener('DOMContentLoaded', function() {
	    const messageElement = document.getElementById('message');
	    if (message !== null && message !== "") {
	      setTimeout(function() {
	        messageElement.classList.add('hidden');
	      }, 3000); 
	    }
	  });
      		sessionStorage.removeItem("expirationTime");
    </script>
</body>
</html>