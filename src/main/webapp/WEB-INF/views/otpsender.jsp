<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Form</title>
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
     <style> 
     	 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');
     
        body{
            height: 100vh;
            width: 100%;
        }
        .btn{
            width: 100px !important;
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
    </style>
</head>
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
	<div class="container d-flex flex-column w-100  h-100 justify-content-center align-content-center">
        <h4 class="mx-auto" style="font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;">Reset Your password</h4>
        <form action="sendEmail" method="post" class="form-control mx-auto" style="width: 30%;">
            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter Your Email Address">
                <label for="email">Enter Your Email address</label>
              </div>
            <p style="color:red">${message}</p>
              
            <div class="d-flex justify-content-end m-2 flex-lg-row flex-column">
               <a href="../knowledge_hub/login" class="btn btn-secondary float-end me-3">Cancel</a>
               <input type="submit" class="float-end btn btn-primary" value="Send Otp">
           </div>
        </form>
    </div>

</body>
</html>
