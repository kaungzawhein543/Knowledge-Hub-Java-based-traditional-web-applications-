<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blogs</title>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/blogs.css"/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style type="text/css">
	@import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');

	.image-container {
	 max-width: 100%;
	 height: auto;
 }
 .image-container img {
     width: 100%; /* You can adjust this value to resize the image */
     height: auto;
 }
 .blog-post h5 a {
     text-decoration: none;
     color: black;
     font-weight: 600;
}

 .blog-post h5 a:hover {
     text-decoration: underline;
}

 .wrapper {
            margin: 30px auto !important;
            padding: 15px;
            width: 50%;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 10px 40px rgba(5, 5, 5, 0.1);
        }

        #see-more {
            color: blue;
            cursor: pointer;
        }
        .blogcontent{
		 	white-space: nowrap; /* Prevent text from wrapping */
		    overflow: hidden; /* Hide overflow text */
		    text-overflow: ellipsis; /* Display ellipsis (...) when text overflows */
		}
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
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .dropdown-content a {
            display: block;
            padding: 20px !important;
            width: 100%;
            color: #333;
            text-decoration: none;
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
        .back {
		    color: black;
		    transition: all .2s;
		    width: 50px;
		    height: 50px;
		    border-radius: 50%;
		    text-align: center; 
		    line-height: 50px !important; 
		    position:abosolute;
		    top:300px;
		}
		
		.back:hover {
		    color: #11122e;
		    background-color: #d7d9d7;    
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
</head>
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
		                    <li id="navbtn" class="btn btn-outline-primary" onclick="redirectToCreateBlog('${sessionScope.userId}')"><i class="fa-solid fa-plus"></i><a href="../add_blog">Create Blog</a></li>
	                 	</c:when>
	                 	<c:when test="${userStatus eq 'requested'}">	                 			
		                    <li id="navbtn" class="btn btn-info disabled"><i class="spinner-border spinner-border-sm text-light"></i><a  href="">Please Wait Response</a></li>
	                 	</c:when>
	                 	<c:otherwise>	                 		
		                    <li id="navbtn" class="btn btn-dark"><a href="../uploadform" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
	                 	</c:otherwise>
                 	</c:choose>
					<c:if test="${sessionScope.isSuper_Admin || sessionScope.isAdmin}">
	                     <li id="navbtn" class="btn btn-primary ms-3"  onclick="redirectAdminDashboard()"><i class="fa-solid fa-arrow-up-right-from-square"></i><a class="text-white" href="../admin_dashboard">Admin Dashboard</a></li>
					</c:if>
                    <li class="nav-item">
                        <div class="dropdown m-2">
                        <a href="../blogs" id="nitem"><i class="fa-brands fa-font-awesome"></i> New Feed</a>
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
    <div>
    <a href="../blogs"><i class="back fas fa-arrow-left me-3 ms-3" style="margin-top:100px;font-size:30px;"></i></a>
    <h1 style="display:inline-block;">#${categoryname}</h1><br>
		<c:if test="${empty blogs}">
    		<h1 class="text-center mt-5 text-muted">There is no blogs in this category</h1>
              	<div class="text-center"  style="margin-bottom: 200px;">
		            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
	            </div>
    	</c:if>
    	<c:forEach var="blog" items="${blogs}">
            <div class="wrapper">
                <div class="blog-post mb-2">
                    <h5><a href="#">${blog.username}</a></h5>
                    <p class="blog-post-meta">${blog.createdAt}</p>
                    <h2 class="blog-post-title">${blog.title}</h2>
                    <div id="content">
                        <div id="initialContent">
                            <p class="blogcontent">${blog.content}</p>
                        </div>
                        <a href="../detail?blogid=${blog.id}&userId=${sessionScope.userId}" id="seeMoreLink">See More</a>
                    </div>
                </div>
                <c:if test="${blog.encodedPhoto ne null}">
	                <div class="image-container">
				           <img src="data:image/jpeg;base64,${blog.encodedPhoto}" alt="blogphoto" style="min-height: 300px;width:100% !important; margin-top: 0;">
			        </div>
                </c:if>
            </div>
    	</c:forEach>
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