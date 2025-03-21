<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blog's Detail</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
            min-width:500px !important;
            margin: 100px auto;
            padding: 15px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 10px 20px rgba(5, 5, 5, 0.3);
            
        }
        label{
			margin: 10px 0;
		}

        select{
            margin-bottom: 20px;
        }

        label .categories_name{
            margin-top:20px ;
        }
        #see-more {
        color: blue;
        cursor: pointer;
    }

    .blog-post h5 a{
        text-decoration: none;
        color: black;
        font-weight: 600;
    }
    .blog-post h5 a:hover{
        text-decoration: underline;
    }
    .cmticon{
    	padding:10px;
    	width: 100px !important;
	    height: 100px !important;
	    border-radius: 50%;
	    text-align: center; 
	    line-height: 50px !important;
    }
    .reacticon{
    	width: 30px !important;
	    height: 30px !important;
	    border-radius: 50%;
	    text-align: center !important; 
	    line-height: 30px !important;
    }
    .reacticon:hover{
    	background-color: #d7d9d7;
    }
    .cmticon:hover{
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
		  	.profile{
	 		width:40px;
	 		height:40px;
	 		border-radius: 50%;
	 		object-fit: cover;
	 	}
	 	  .back {
		    color: black;
		    transition: all .2s;
		    width: 50px;
		    position:absolute;
		    top:15%;
		    left:8%;
		    height: 50px;
		    border-radius: 50%;
		    text-align: center; /* Center the content horizontally */
		    line-height: 50px; /* Center the content vertically */
		}
		
		.back:hover {
		    color: #11122e;
		    background-color: #d7d9d7;    
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
				                    <li id="navbtn" class="btn btn-outline-primary"><i class="fa-solid fa-plus"></i><a href="add_blog">Create Blog</a></li>
			                 	</c:when>
			                 	<c:when test="${userStatus eq 'requested'}">	                 			
				                    <li id="navbtn" class="btn btn-info disabled"><i class="spinner-border spinner-border-sm text-light"></i><a  href="">Please Wait Response</a></li>
			                 	</c:when>
			                 	<c:otherwise>	                 		
				                    <li id="navbtn" class="btn btn-dark"><a href="uploadform" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
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
	<a href="blogs" id="backkey"><i class="back fas fa-arrow-left" style="font-size:30px;"></i></a>
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
		                   <div class="d-flex justify-content-end">
		                   		<c:if test="${sessionScope.userId == blog.users_id}">
					             	<a href="edit_blog/${blog.id}" class="btn btn-success ms-auto"><i class="fas fa-edit"></i> Edit</a>		             	
					             	<a href="delete_blog?blogid=${blog.id}&blogcode=${blog.code}" class="btn btn-danger ms-2"><i class="fas fa-trash"></i> Delete</a>
					             </c:if>
		                   </div>
             
             <div id="initialContent" style="word-break: break-all;">
	            <h2 class="blog-post-title"><b>${blog.title}</b></h2>
		    </div>
            
<div id="content">
    <div id="initialContent" style="word-break: break-all;">
        <p>${blog.content}</p>
    </div>
</div>

        </div>
      	<c:choose>
      		<c:when test="${blog.encodedPhoto ne null}">
       			<img src="data:image/jpeg;base64,${blog.encodedPhoto}"width="100%" style="min-height: 300px; margin-top: 0;">
      		</c:when>
      	</c:choose>
           
        <div class="d-flex flex-row p-2">
            <div class="like-section pe-3">
            	<c:choose>
				    <c:when test="${react eq 'Liked'}">
				        <a href="" onclick="likeBlog(event, 'http://localhost:8080/knowledge_hub/like-blog', ${sessionScope.userId}, ${blogid})" id="like"><i class="fas fa-heart text-danger reacticon" id="likeicon"></i></a>
				        <span id="likeCount" class="like-count">${blog.likes_counts}</span>
				    </c:when>
				    <c:otherwise>            		
				        <a href="" onclick="likeBlog(event, 'http://localhost:8080/knowledge_hub/like-blog', ${sessionScope.userId}, ${blogid})" id="like"><i class="far fa-heart text-danger reacticon" id="likeicon"></i></a>
				        <span id="likeCount" class="like-count">${blog.likes_counts}</span>
				    </c:otherwise>
				</c:choose>
            </div>
            <div class="comment-section">
                <i class="fa-solid fa-comment reacticon"></i>
                <span id="commentCount" class="comment-count">${blog.comments_counts}</span>
            </div>
            <div class="like-section pe-3 ms-auto">
            	<c:choose>
            		<c:when test="${save eq 'Saved'}">
	               		 <a href="" onclick="likeBlog(event, 'http://localhost:8080/knowledge_hub/save-blog', ${sessionScope.userId}, ${blogid})" class="btn btn-primary" id="save"><i class="fas fa-bookmark" id="saveicon"></i> <span id="savetext">Unsave</span></a>
            		</c:when>
            		<c:otherwise>            		
	               		 <a href="" onclick="likeBlog(event, 'http://localhost:8080/knowledge_hub/save-blog', ${sessionScope.userId}, ${blogid})" class="btn btn-outline-primary" id="save"><i class="far fa-bookmark" id="saveicon"></i> <span id="savetext">Save</span></a>
            		</c:otherwise>
            	</c:choose>
            </div>
            <div class="report-section">
            	<button data-bs-toggle="modal" data-bs-target="#report" class="btn btn-outline-warning"><i class="fas fa-warning"></i> Report</button>
            </div>
        </div>
    <div class="modal fade" id="report" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog"
        aria-labelledby="modalTitleId" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitleId">
                        Send Report To This Blog
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
					<form:form action="addreport?blogid=${blog.id}" method="post" modelAttribute="report">
							<form:input type="hidden" path="blog_code" value="${blog.code}"/>
							<form:input type="hidden" path="blogger_name" value="${blog.username}"/>
                            <form:textarea path="content" name="" rows="5" cols="20" class="form-control" autocomplete="off" required="true"></form:textarea>
                            <div class="mt-3 text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary ">Send Report</button>
                            </div>
                     </form:form>
				</div>
            </div>
        </div>
    </div>
        <div class="card-footer">
            <form:form action="post_comments" method="POST" modelAttribute="comment">
                <form:label path="content" for="comment">Comment:</form:label>
                <form:hidden path="comment_user_id" value="${sessionScope.userId}"/>
                <form:hidden path="blogs_id" value="${blogid}"/>
                <form:textarea  path="content"  class="form-control" rows="3" id="comment" name="comment" placeholder="Write your Comment" required="true"></form:textarea>
                <button type="submit" class="btn btn-primary mt-2">Add Comment</button>
            </form:form>
        </div>
            <c:forEach items="${blog.comments}" var="comment">
			        <div class="card m-3">
						    <div class="card-body">
				                <div class="d-flex align-items-center justify-content-between">
				                    <div>
				                        <h6><a href="user_detail/${comment.comment_user_id}" style="text-decoration:none; color:black; font-weight: 600;">${comment.comment_user_name}</a></h6>
				                        <span style="display: inline-block;">${comment.content}</span>
				                    </div>
				                    <div class="ms-auto">
				                        <c:if test="${comment.comment_user_id eq sessionScope.userId}">
				                            <a class="cmticon" href="edit_comment?commentid=${comment.id}&userid=${sessionScope.userId}&blogid=${blogid}"><i class="text-dark fas fa-pencil"></i></a>
				                            <a class="cmticon" href="delete_comment?commentid=${comment.id}&userid=${sessionScope.userId}&blogid=${blogid}"><i class="text-danger fas fa-trash"></i></a>
				                        </c:if>
				                    </div>
				                </div>
							 </div>
					</div>
            </c:forEach>
    </div>
    <div class="modal dark-modal fade" id="confirm" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog  modal-dialog-centered">
		    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="exampleModalLabel"><i class="fas fa-warning"></i> Warning</h1>
						<button type="button" class="btn-close" style="color:white !important;" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        Do you really want to Delete your blog?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <a href="delete_blog?blogid=${blog.id}&blogcode=${blog.code}" type="button" class="btn btn-primary">Delete</a>
				      </div>
		    </div>
	  </div>
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
	function likeBlog(event, url, userId, blogId) {
	    event.preventDefault(); // Prevent the default link behavior
	
	    const fullUrl = new URL(url);
	    fullUrl.searchParams.append("userid", userId);
	    fullUrl.searchParams.append("blogid", blogId);
	
	    fetch(fullUrl)
	    .then(response => {
	        if (!response.ok) {
	            throw new Error('Network response was not ok');
	        }
	        return response.json(); // Parse the JSON response
	    })
	    .then(data => {
	    	console.log(data)
	        if (data) {
	            document.querySelector("#likeCount").innerHTML = data['likes_counts'];
	        } else {
	            console.error('Likes count not found in the response');
	        }
	    	if(data['check_like'] === 'Liked'){
	            document.querySelector("#likeicon").classList.remove('far','fa-heart');
	            document.querySelector("#likeicon").classList.add('fas','fa-heart');
	    	}else{
	            document.querySelector("#likeicon").classList.remove('fas','fa-heart');
	            document.querySelector("#likeicon").classList.add('far','fa-heart');
	    	}
	
	    	if(data['check_save'] === 'Saved'){
	            document.querySelector("#saveicon").classList.remove('far','fa-bookmark');
	            document.querySelector("#saveicon").classList.add('fas','fa-bookmark');
	            document.querySelector("#save").classList.remove('btn','btn-outline-primary');
	            document.querySelector("#save").classList.add('btn','btn-primary');
	            document.querySelector("#savetext").innerHTML = "Unsave";
	    	}else{
	            document.querySelector("#saveicon").classList.remove('fas','fa-bookmark');
	            document.querySelector("#saveicon").classList.add('far','fa-bookmark');
	            document.querySelector("#save").classList.remove('btn','btn-primary');
	            document.querySelector("#save").classList.add('btn','btn-outline-primary');
	            document.querySelector("#savetext").innerHTML = "Save";
	    	}
	    })
	    .catch(error => {
	        // Handle errors
	        console.error('There was a problem with the fetch operation:', error);
	    });
	}




	</script>
</body>
</html>