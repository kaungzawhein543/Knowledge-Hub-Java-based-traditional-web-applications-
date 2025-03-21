<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blogs</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<script type="text/javascript" src=<c:url value="/resources/js/blogs.js"/>></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
	 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');

        * {
            padding: 0;
            box-sizing: border-box;
        }

        body {
            overflow: hidden;
        }

        .navbar {
            list-style-type: none;
            position: fixed;
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

        .allmain {
            height: 100vh;
        }

        .main3 {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
        }

        .left {
            overflow-y: scroll !important;
            max-width: 300px;
        }

        .menu {
            width: 100%;
        }

        .menu a {
            display: block;
            width: 100%;
            display: inline-block;
            text-decoration: none;
            color: black;
            padding: 10px 15px;
            transition: 0.5 ease;
            text-align: center;
        }

        .menu a:hover {
            background-color: #a3a3a3;
        }

        #mySearch {
            width: 100%;
            font-size: 18px;
            padding: 11px;
            border: 1px solid #ddd;
        }

        #myMenu {
            list-style-type: none;
            padding: 0;
            margin: 0;
            width: 100%;
            transition: transform 0.5s ease;
            /* Add smooth transition */
        }

        .aside1 {
            width: 100%;
            height: calc(100vh - 150px);
            scroll-behavior: smooth;
            overflow-y: auto;
        }

        .aside1 h3 {
            font-family: Verdana, Geneva, Tahoma, sans-serif;
            padding: 10px;
            color: #000;
            width: auto;
            min-width: 100px;
        }

        .left,
        .main,
        .right {
            margin-top: 70px !important;
            flex: 1;
            flex-wrap: nowrap;
            overflow-y: scroll;
            background-color: aliceblue;
        }

        .main {
            min-width: 200px;
            flex: 2;
            width: 80%;
            padding: 20px 50px 50px 50px;
        }

        .wrapper {
            margin: 30px 50px !important;
            padding: 15px;
            width: auto;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 10px 40px rgba(5, 5, 5, 0.1);
        }

        .bloggers {
            list-style-type: none;
            background-color: aliceblue;
            padding: 0;
        }
        .bloggers li{
            width: 100%;
            padding: 15px;
        }
        .bloggers li:hover{
            background-color: rgb(208, 208, 208);
        }
        .blog-post h5 a {
            text-decoration: none;
            color: black;
            font-weight: 600;
        }

        .blog-post h5 a:hover ,#date:hover ,.showcategory:hover{
            text-decoration: underline;
        }

        .carousel-item {
            height: 250px;
        }

        .carousel-item img {
            width: 100%;
            height: 250px !important;
            border-radius: 5px;
        }
        .carousel-caption {
            color: black;
            background-color: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(5px);
        }
        .aside{
            height: calc(100vh - 100px); /* Adjust the height as needed */
            overflow-y: auto; /* Enable vertical scrolling */
            padding-right: 10px;
        }
        .newfed{
            transition: all 0.3s;
            font-size: 20px;
        }
        .newfed:hover{
            background-color: rgb(44, 34, 183) !important;
        }

        .bloggers li img {
            width: 35px;
            height: 35px;
            border-radius: 50%;
        }
        .bloggers li a{
            text-decoration: none;
            padding-left: 10px;
            color: #000;
        }
	.image-container {
		 max-width: auto;
		 height: auto;
	 }
	 .image-container img {
	     width: 100%; /* You can adjust this value to resize the image */
	     height: auto;
	 }
	 .blogcontent{
	 	white-space: nowrap; /* Prevent text from wrapping */
	    overflow: hidden; /* Hide overflow text */
	    text-overflow: ellipsis; /* Display ellipsis (...) when text overflows */
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
	 	#navbtn{
	 		min-width:30px !important;
	 	}
	 	.profile{
	 		width:40px;
	 		height:40px;
	 		border-radius: 50%;
	 		object-fit: cover;
	 	}
	    .mostviewtext{
	    	font-family: "Ubuntu", sans-serif;
	    }
	    #seeMoreLink:hover{
	    	color:blue !important;
	    }
</style>
</head>
<body>
	<c:if test="${message ne null}">
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
		                    <li id="navbtn" class="btn btn-outline-primary" onclick="redirectToCreateBlog('${sessionScope.userId}')"><i class="fa-solid fa-plus"></i><a href="add_blog">Create Blog</a></li>
	                 	</c:when>
	                 	<c:when test="${userStatus eq 'requested'}">	                 			
		                    <li id="navbtn" class="btn btn-info disabled"><i class="spinner-border spinner-border-sm text-light"></i><a  href="">Please Wait Response</a></li>
	                 	</c:when>
	                 	<c:otherwise>	                 		
		                    <li id="navbtn" class="btn btn-dark"><a href="./uploadform" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
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
    <div class="main3">

        <!--left side-->


        <div class="left d-none d-md-block allmain text-light" style="background-color: aliceblue;">
	    <div class="menu d-none d-md-block col-md-4 col-lg-3">
	        <div class="aside1 list-group" id="menuContainer">
	            <h3 class="" style="font-weight: 600;">Categories</h3>
	            <input type="text" id="mySearch" onkeyup="myFunction()" placeholder="Search.." title="Type in a category">
	            <ul id="myMenu">
	                <c:forEach var="category" items="${categories}">                    
	                    <li><a href="categories/${category.id}" class="list-group-item list-group-item-action">${category.name}</a></li>
	                </c:forEach> 
	            </ul>
	        </div>
	    </div>
	</div>


        <!--Main middle side-->


        <div class="main allmain">
        <c:forEach var="blog" items="${randomBlogs}">
            <div class="wrapper">
                <div class="blog-post mb-2">
               		 <div class="d-flex">
				        <c:choose>
				        	<c:when test="${blog.encodeProfile eq null}">
					        	<img src="<c:url value="/resources/photos/nonprofile.png"/>" alt="blogphoto" class="profile">
				        	</c:when>
				        	<c:otherwise>
					        	<img src="data:image/jpeg;base64,${blog.encodeProfile}" alt="blogphoto" class="profile" >
				        	</c:otherwise>
				        </c:choose>
				             <div style="display: flex;flex-direction: column;">
				             	<h5 class="ms-3"><a href="user_detail/${blog.users_id}">${blog.username}</a></h5>
		                     	<p class="blog-post-meta ms-3" id="date"><a class="text-dark text-decoration-none" href="detail?blogid=${blog.id}&userId=${sessionScope.userId}"> ${blog.createdAt}</a></p>
				             </div>
				             <div class="ms-auto" style="font-family: sans-serif;font-size: 5px !important;">
		                     		<h5 style="font-family: sans-serif;font-size: 17px !important;">Category: <a class="text-dark text-decoration-none" href="categories/${blog.categories_id}"><span class="showcategory">${blog.categories_name}</span></a> </h5>
		                     </div>
				        </div>
			       
                   	<div id="initialContent" style="word-break: break-all;">
			            <h3 class="blog-post-title" style="font-weight: 600;">${blog.title}</h3>
				    </div>
                    <div id="content">
                        <div id="initialContent">
                            <p class="blogcontent">${blog.content}</p>
                        </div>
                        <a class="text-dark" href="detail?blogid=${blog.id}&userId=${sessionScope.userId}" id="seeMoreLink">See More</a>
                    </div>
                </div>
                <c:if test="${blog.encodedPhoto ne null}">
	                <div class="image-container">
				           <img src="data:image/jpeg;base64,${blog.encodedPhoto}" alt="blogphoto" style="min-height: 300px; margin-top: 0;border-radius: 10px;">
			        </div>
                </c:if>
				<div class="p-2">
            		<i class="far fa-eye"></i><span style="font-family: sans-serif;font-size: 17px !important;">Views: ${blog.views}</span>			
				</div>               
            </div>
        </c:forEach>
       </div>
            
        <!--Right Side-->
        <div class="right d-none d-lg-block">
            <div class="aside">
                <div id="carouselId" class="carousel slide" data-bs-ride="carousel">
                    <ol class="carousel-indicators list-unstyled">
                        <li data-bs-target="#carouselId" data-bs-slide-to="0" class="active" aria-current="true"
                            aria-label="First slide"></li>
                        <li data-bs-target="#carouselId" data-bs-slide-to="1" aria-label="Second slide"></li>
                        <li data-bs-target="#carouselId" data-bs-slide-to="2" aria-label="Third slide"></li>
                    </ol>
                    <h5 class="p-4 mostviewtext mostviewtext text-muted">Most View Blogs</h5>
                    <div class="carousel-inner" role="listbox">
                    <c:forEach var="viewblog" items="${mostViewedBlogs}"  varStatus="status">
                        <div class="carousel-item  <c:if test='${status.first}'>active</c:if>" style="cursor: pointer">
                            <c:if test="${viewblog.encodedPhoto ne null}">
				                <div class="image-container"   onclick="redirectToBlogDetail('${viewblog.id}', '${sessionScope.userId}')">
						           <img src="data:image/jpeg;base64,${viewblog.encodedPhoto}" alt="blogphoto" class="d-block" style="object-fit:cover;">
						        </div>
			                </c:if>
			                <c:if test="${viewblog.encodedPhoto eq null}">
				                <div class="image-container"  onclick="redirectToBlogDetail('${viewblog.id}', '${sessionScope.userId}')">
	   					        	<img src="<c:url value="/resources/photos/blogdefaultphoto.jpg"/>" alt="blogphoto" class="d-block">			             
						        </div>
			                </c:if>
                            <div class="carousel-caption d-none d-md-block">
                                <h3>${viewblog.title}</h3>
                            </div>
                        </div>
                    </c:forEach>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselId"
                        data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselId"
                        data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                    
                </div>

                <h5 class="p-2 ms-1 mostviewtext mostviewtext text-muted">Trend Bloggers</h5>
                <ul class="bloggers">
				    <c:forEach var="blogger" items="${trendBloggers}">
				        <li class="rounded" onclick="redirectToUserDetail('${blogger.user_id}')" style="cursor:pointer;">
				        <c:choose>
				        	<c:when test="${blogger.encodedProfile eq null}">
					        	<img src="<c:url value="/resources/photos/nonprofile.png"/>" alt="blogphoto">
				        	</c:when>
				        	<c:otherwise>
					        	<img src="data:image/jpeg;base64,${blogger.encodedProfile}" alt="blogphoto" >
				        	</c:otherwise>
				        </c:choose>
				            <a href="user_detail/${blogger.user_id}">${blogger.name}</a>
				        </li>
				    </c:forEach>
				</ul>
            </div>
        </div>
    </div>
</body>
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

function scrollToTop() {
	const mainElement = document.querySelector('.main');
	const rightElement = document.querySelector('.aside');
	const leftElement = document.querySelector('.left');
    if (mainElement) {
        mainElement.scrollTop = 0;
    }
    if(rightElement){
    	rightElement.scrollTop = 0;
    }
    if(leftElement){
    	leftElement.scrollTop = 0;
    }
   
}
window.addEventListener('load', scrollToTop);
function redirectToUserDetail(userId) {
    window.location.href = 'user_detail/' + userId;
}
function redirectToBlogDetail(blogid, userid) {
    window.location.href = 'detail?' + 'blogid=' + blogid + '&userId=' + userid;
}
function redirectToCreateBlog(userId) {
    window.location.href = 'add_blog/'+ userId;
}
function redirectAdminDashboard() {
    window.location.href = 'admin_dashboard';
}
</script>
</html>