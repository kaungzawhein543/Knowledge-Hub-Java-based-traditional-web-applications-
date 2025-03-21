<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Comment</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style type="text/css">
	@import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');

        * {
            padding: 0;
            box-sizing: border-box;
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
		
        .wrapper {
            width: 50%;
            margin: 100px auto;
            padding: 15px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 10px 20px rgba(5, 5, 5, 0.3);
        }


    .blog-post h5 a{
        text-decoration: none;
        color: black;
        font-weight: 600;
    }
    .blog-post h5 a:hover{
        text-decoration: underline;
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
		                    <li id="navbtn" class="btn btn-outline-primary"><i class="fa-solid fa-plus"></i><a href="add_blog/${sessionScope.userId}">Create Blog</a></li>
	                 	</c:when>
	                 	<c:when test="${userStatus eq 'requested'}">	                 			
		                    <li id="navbtn" class="btn btn-info disabled"><i class="spinner-border spinner-border-sm text-light"></i><a  href="">Please Wait Response</a></li>
	                 	</c:when>
	                 	<c:otherwise>	                 		
		                    <li id="navbtn" class="btn btn-dark"><a href="bloggerRequest" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
	                 	</c:otherwise>
                 	</c:choose>
					<c:if test="${sessionScope.isSuper_Admin || sessionScope.isAdmin}">
	                     <li id="navbtn" class="btn btn-primary ms-3"  onclick="redirectAdminDashboard()"><i class="fa-solid fa-arrow-up-right-from-square"></i><a class="text-white" href="admin_dashboard">Admin Dashboard</a></li>
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
                        <a href="user_detail/${sessionScope.userId}" id="nitem" class="m-2"><i class="fas fa-user-circle"></i> Profile</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
	<div class="wrapper">
        <!-- Example blog post -->
        <div class="blog-post mb-2">
            <h5><a href="#">${blog.username}</a></h5>
            <p class="blog-post-meta">${blog.createdAt}
                
            <h2 class="blog-post-title">${blog.title}</h2>
            
            <!-- Blog post content -->
            <div id="content">
                <div id="initialContent">
                    <!-- Display initial 1000 words here -->
                    <p>${blog.content}</p>
                </div>
            </div>  
        </div>
        <!-- Blog post image -->
        <img src="data:image/jpeg;base64,${blog.encodedPhoto}" alt="Blog Post Image" width="100%" style="min-height: 300px; margin-top: 0;">

           
        <div class="d-flex flex-row p-2">
              <!-- Like icon with Count -->
            <div class="like-section pe-3">
                <i class="far fa-heart"></i>
                <span id="likeCount" class="like-count">${blog.likes_counts}</span>
            </div>

            <!-- Comment icon with Count -->
            <div class="comment-section">
                <i class="fa-solid fa-comment"></i>
                <span id="commentCount" class="comment-count">${blog.comments_counts}</span>
            </div>
        </div>

        <div class="card-footer">
            <form:form action="edit_comment?commentid=${commentid}" method="POST" modelAttribute="editcomment" style="z-index:101;" id="form">
                <form:label path="content" for="comment">Comment:</form:label>
                <form:hidden path="comment_user_id" value="${sessionScope.userId}"/>
                <form:hidden path="blogs_id" value="${blogid}"/>
                <form:textarea  path="content"  class="form-control" rows="3" id="comment" name="comment" placeholder="Write your Comment" autofocus="true"></form:textarea>
                <button type="submit" class="btn btn-primary">Edit Comment</button>
                <a href="/knowledge_hub/detail?blogid=${blogid}&userId=${sessionScope.userId}"><i class="btn btn-secondary">Cancel</i></a>
            </form:form>
        </div>
        <div class="card m-3">
	        <div class="card-body">
	            <ul class="list-group">
	                <c:forEach items="${blog.comments}" var="comment">
	                	<h6><a href="user_detail/${comment.comment_user_id}" style="text-decoration:none; color:black; font-weight: 600;">${comment.comment_user_name}</a></h6>
	                    <li style="list-style-type:none; display:inline !important;">${comment.content}</li>
	                    <c:if test="${comment.comment_user_id eq sessionScope.userId}">
	                    	<a class="ms-auto" href="edit_comment?commentid=${comment.id}&userid=${sessionScope.userId}&blogid=${blogid}"><i class="text-dark fas fa-pencil"></i></a>
	                    </c:if>
	                </c:forEach>
	            </ul>
	        </div>
        </div>
    </div>
    <script type="text/javascript">
    function scrollToForm() {
        const formElement = document.querySelector('#form');
        
        if (formElement) {
            formElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }

    window.addEventListener('load', scrollToForm);
	
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