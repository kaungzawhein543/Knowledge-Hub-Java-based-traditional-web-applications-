<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Terms</title>
<link href="<c:url value="resources/css/bootstrap.min.css"/>" rel="stylesheet"></link>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.bundle.min.js"/>"></script>
</head>
<style>
    		 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');
    
	    body{
	        padding: 0;
	        margin: 0;
	    }

        * {
            box-sizing: border-box;
            margin: 0;
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
         .auto-disappear {
		    opacity: 1;
		    transition: opacity 1s ease-in-out;
		    position: fixed;
		    bottom: 20%;
		    display: block;
		    width: auto;
		    right: 45%;
		    padding:10px;
		    border-radius: 10px;
		  }
		
		  /* More specific selector for animation */
		  #message.hidden {
		    opacity: 0;
		    transition: opacity 1s ease-in-out;
		  }
  


         .container-fluid{
             max-width: 2000px;
             margin:0;
             background-color:white;
         }

        

         .row{
            margin-top: 80px;
           height: auto;
            width: 100%;
         }
         *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

        .wrapper{
            width: 600px;
            padding: 15px;
            margin: auto;
            background-color: #fff;
            border-radius: 30px;
            box-shadow: 0 10px 30px rgba(5, 5, 5, 0.1);
        }

        body{
            margin: 0;
            padding: 0;
            background-color: aliceblue;
        }

        .categoryForm {
            height: 85%;
            display: flex;
            flex-direction: column;
            margin:auto;
            width: 40%;
            padding: 20px;
            padding-right: 3%;
            gap: 15px;
            min-width: 350px;
            border-bottom: none;
            color: black;
        }

        .text{
            background-color: white;
            position: absolute;
            top: -11%;
            left: 49%;
        }

        label{
            margin-bottom: 10px;
        }

        .container{
            margin-top: 10%;
        }
    
    </style>
<body>
	  
  <header>
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
                            <a class="nav-link" href="./#home"><i class="fas fa-home"></i> Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./#about"><i class="fas fa-info-circle"></i> About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./#myteam"><i class="fa-solid fa-people-group"></i> My Team</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./#feedback"><i class="fas fa-comment"></i> Feedback</a>
                        </li>
                        <li class="nav-item">
                        <c:choose>
                            <c:when test="${sessionScope.login}">
                            	<li class="nav-item">
                            		<a class="nav-link" href="user_detail/${sessionScope.userId}">Profile</a>
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
</header>
   
    <div class="container">
        <h1>Terms and Conditions</h1>
        <p>Last updated: April 7, 2024</p>
        <h3>Welcome to Knowledge Hub!</h3>
        <p>These terms and conditions outline the rules and regulations for the use of Knowledge Hub's website, located at [Website URL].</p>
        <p>By accessing this website, you agree to comply with and be bound by the following terms and conditions. If you do not agree with any part of these terms and conditions, you must not use our website.</p>
       
        
        <h3>1. Introduction</h3>
        <p>1.1 These terms and conditions govern your use of Knowledge Hub.</p>
        <p>1.2 By using Knowledge Hub, you accept these terms and conditions in full. If you disagree with any part of these terms and conditions, do not use our website.</p>

        <h3>2. Intellectual Property Rights</h3>
        <p>2.1 Unless otherwise stated, Knowledge Hub and/or its licensors own the intellectual property rights for all material on Knowledge Hub. All intellectual property rights are reserved.</p>
        <p>2.2 You may access this material for your personal use, subject to restrictions set in these terms and conditions.</p>
        <p>2.3 You must not:

            Republish material from Knowledge Hub
            Sell, rent, or sub-license material from Knowledge Hub
            Reproduce, duplicate, or copy material from Knowledge Hub
            Redistribute content from Knowledge Hub
        </p>

        <h3>3. User Content</h3>
        <p>3.1 "Your user content" means any material (text, images, etc.) that you submit to Knowledge Hub for any purpose.</p>
        <p>3.2 You grant Knowledge Hub a worldwide, irrevocable, non-exclusive, royalty-free license to use, reproduce, adapt, publish, translate, and distribute your user content in any existing or future media. You also grant Knowledge Hub the right to sub-license these rights and the right to bring an action for infringement</p>

    </div>
</body>
</html>