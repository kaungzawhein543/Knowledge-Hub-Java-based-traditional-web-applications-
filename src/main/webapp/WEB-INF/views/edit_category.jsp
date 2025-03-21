<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Category</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<style>
		 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');
	
	        .navbar {
            list-style-type: none;
            position: fixed;
            top:0;
            width: 100%;
            background-color: white;
            box-shadow: 0px 0.3px 40px rgba(0, 0, 0, 0.2);
            z-index: 99;
        }

        .container-fluid {
            max-width: 1900px;
            padding: 3px;
        }

        .navbar-nav li a {
            display: inline-block;
            text-decoration: none;
            color: black;
            padding: 5px 40px;
            border: 1px solid transparent;
            transition: 0.5 ease;
            text-align: center;
        }
		.navbar-nav li:not(#navbtn) a:hover {
		    background-color: gainsboro;
		    color: #111;
		}
		.navbar #navbtn:hover a{
			color:white !important;
		}
		 #nitem {
		    text-decoration: none;
		    color: black;
		    display: block;
		    margin:0;
		    width: 100%;
		    transition: 0.5 ease;
		    text-align: center;
		    border-radius: 50px;
		}	

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #fff;
            min-width: 100%;
        }

        .dropdown-content a {
            display: block;
            padding: 20px !important;
            width: 100%;
            color: #333;
            text-decoration: none;
        }
		body{
			margin: 0;
			padding: 0;
			background-color: aliceblue;
		}

	

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
		
        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f4f4f4;
        }   

        .navbar-brand {
            font-size: 28px;
            font-family: "Ubuntu", sans-serif;
            font-weight: 500;
            font-style: normal;
            margin-left: 10px;
        }
		h3{
            text-align: center;
            margin-top: 20px;
        }
        .editForm {
            height: auto;
            display: flex;
            flex-direction: column;
            margin: 10px auto;
            width: 40%;
            padding: 20px;
            padding-right: 3%;
            gap: 15px;
            min-width: 350px;
            border-bottom: none;
            color: black;
        }
        
        
        .text{
            background-color: rgb(249, 247, 247);
            position: absolute;
            top: -11%;
            left: 49%;
        }
        
        input{
			margin-top: 10px;
            margin-bottom: 10px;
        }
        label{
			margin-bottom: 10px;
		}
		 .wrapper{
            width: 600px;
            padding: 15px;
            margin: 150px auto;
            background-color: #fff;
            border-radius: 30px;
            
            box-shadow: 0 10px 30px rgba(5, 5, 5, 0.1);
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
	
</style>
<body>
<c:if test="${message ne null }">
	<div id="message" class="auto-disappear text-white bg-dark">${message}</div>
</c:if>
<nav class="navbar navbar-expand-lg navbar-light">
		        <div class="container-fluid">
		            <a class="navbar-brand" href="/knowledge_hub">Knowledge Hub</a>
		            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
		                aria-controls="navbarNav" aria-label="Toggle navigation">
		                <span class="navbar-toggler-icon"></span>
		            </button>
		            <div class="collapse navbar-collapse" id="navbarNav">
		                <ul class="navbar-nav ms-auto">
		                 	<c:choose>
		                 		<c:when test="${userStatus eq 'approve'}">
				                    <li id="navbtn" class="btn btn-outline-primary"><i class="fa-solid fa-plus"></i><a href="../add_blog">Create Blog</a></li>
			                 	</c:when>
			                 	<c:when test="${userStatus eq 'requested'}">	                 			
				                    <li id="navbtn" class="btn btn-info disabled"><i class="spinner-border spinner-border-sm text-light"></i><a  href="">Please Wait Response</a></li>
			                 	</c:when>
			                 	<c:otherwise>	                 		
				                    <li id="navbtn" class="btn btn-dark"><a href="bloggerRequest" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
			                 	</c:otherwise>
		                 	</c:choose>
							<c:if test="${sessionScope.isSuper_Admin || sessionScope.isAdmin}">
			                     <li id="navbtn" class="btn btn-primary ms-3"><i class="fa-solid fa-arrow-up-right-from-square"></i><a class="text-white" href="../admin_dashboard">Admin Dashboard</a></li>
							</c:if>
		                    <li class="nav-item">
		                        <div class="dropdown m-2">
		                        <a href="blogs" id="nitem"><i class="fa-brands fa-font-awesome"></i> New Feed</a>
		                            <div class="dropdown-content">
		                            <a href="/knowledge_hub/#home"><i class="fas fa-home"></i> Home</a>
		                                <a href="/knowledge_hub/#about"><i class="fas fa-circle-info"></i> About us</a>
		                                <a href="/knowledge_hub/#feedback"><i class="fas fa-message"></i> Feedbacks</a> 
		                            </div>
		                        </div>
		                    </li>
		                    <li class="nav-item">
		                        <a href="../user_detail/${sessionScope.userId}" id="nitem" class="m-2"><i class="fas fa-user-circle"></i> Profile</a>
		                    </li>
		                </ul>
		            </div>
		        </div>
		    </nav>
	 <div class="wrapper">
    <form:form action="../editCategory?categoryid=${categoryid}" class="editForm" modelAttribute="category" method="POST">
        <h3>Edit Category</h3>
        
        <div class="form-floating">
            <form:input path="name" type="text" placeholder="Enter Category Name" name="name2" id="name2" class="form-control border-secondary" required="true" autocomplete="off"/>
            <form:label path="name" for="name2">Name</form:label>
            <form:errors path="name" cssClass="error"></form:errors>
        </div>
    
        
        <button type="submit" class="btn btn-primary mb-3">Update Category</button>

    </form:form>
    </div>
    <script type="text/javascript">
    const messageElement = document.getElementById('message');

	document.addEventListener('DOMContentLoaded', function() {
	    const messageElement = document.getElementById('message');
	    if (message !== null && message !== "") {
	      setTimeout(function() {
	        messageElement.classList.add('hidden');
	      }, 3000); 
	    }
	  });
    </script>
</body>
</html>