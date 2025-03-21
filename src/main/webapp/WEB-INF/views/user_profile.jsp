<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style type="text/css">
    	 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');
    	* {
            padding: 0;
		    margin: 0;
		    box-sizing: border-box;
        }

        .navbar {
            list-style-type: none;
            position: fixed !important;
            top:0;
            width: 100%;
            background-color: white;
            box-shadow: 0px 0.3px 40px rgba(0, 0, 0, 0.2);
            z-index: 99;
        }

        .container-fluid {
            max-width: 1900px;
            padding: 3px !important;
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

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f4f4f4;
        }   

        .navbar-brand {
            font-size: 28px !important;
            font-family: "Ubuntu", sans-serif;
            font-weight: 500;
            font-style: normal;
            margin-left: 10px;
        }
    	.blogs{
	        display: flex;
	        flex-direction: row;
	        justify-content: space-between;
	        flex-basis: 3;
	        flex-wrap: wrap;
	        gap: 50px;
	        padding: 50px;
	        justify-content: center;
	      }
	      .blogs .card-body {
		      height: 200px; /* Set a fixed height for the card bodies */
		      overflow: hidden; /* Hide any content that overflows the fixed height */
		    }

	    .blogs .card-img-top {
	      height: 150px; /* Set a fixed height for the card images */
	      object-fit: cover; /* Make sure the images cover the entire area */
	    }

	    .blogs .card-text {
	      overflow: hidden;
	      text-overflow: ellipsis; /* Add ellipsis for text overflow */
	      white-space: nowrap; /* Prevent text wrapping */
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
		.image-container {
	        max-width: 100%;
	        height: auto;
        }
        .image-container img {
            width: 100%; /* You can adjust this value to resize the image */
            height: auto;
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
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script type="text/javascript" src="<c:url value="/resources/js/bootstrap.bundle.min.js" />"></script>    
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
</head>
<body>
	<c:if test="${message ne null}">
		<div id="message" class="auto-disappear text-white bg-dark">${message}</div>
	</c:if>
	<nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="../">Knowledge Hub</a>
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
		                    <li id="navbtn" class="btn btn-dark"><a href="../uploadform" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
	                 	</c:otherwise>
                 	</c:choose>
					<c:if test="${sessionScope.isSuper_Admin || sessionScope.isAdmin}">
	                     <li id="navbtn" class="btn btn-primary ms-3"><i class="fa-solid fa-arrow-up-right-from-square"></i><a class="text-white" href="../admin_dashboard">Admin Dashboard</a></li>
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
	<section> 
        <div class="container mt-5 py-5" >
           <a href="../blogs" id="backkey"><i class="back fas fa-arrow-left" style="margin-top:15px;font-size:30px;margin-bottom:20px;"></i></a>
          <div class="row">
            <div class="col-lg-4 mx-auto">
              <div class="card mb-4">
                <div class="card-body text-center">
                    <c:choose>
					    <c:when test="${user.encodedProfile ne null}">
					        <img src="data:image/jpeg;base64,${user.encodedProfile}" alt="avatar" class="img-fluid " style="width: 100px;height: 100px;border-radius: 20px; padding:10px;object-fit:fit;">				
					    </c:when>
					    <c:otherwise>
					        <img alt="profile" src="<c:url value="/resources/photos/nonprofile.png" />" style="width: 100px;">
					    </c:otherwise>
					</c:choose>
                  <h5 class="my-3">${user.name}</h5>
                  <div class="d-flex justify-content-center mb-2 flex-column align-content-center">

				                    
				  <c:if test="${user.id == sessionScope.userId}">
				  		<label for="file_input" class="btn btn-outline-primary m-auto">Edit Photo</label>
						<a href="../logout" class="btn btn-outline-secondary m-auto">Logout</a>
					  <div class="modal fade" id="editPhotoModal" tabindex="-1"
					      aria-labelledby="editPhotoModalLabel" aria-hidden="true">
						      <div class="modal-dialog">
							          <div class="modal-content">
								              <div class="modal-header">
								                  <h5 class="modal-title" id="editPhotoModalLabel">Do you want to upload this photo?</h5>
								                  <button type="button" class="btn-close"
								                      data-bs-dismiss="modal" aria-label="Close"></button>
								              </div>
								              
								              <div class="modal-body">
									              <form action="${sessionScope.userId}" method="post" enctype="multipart/form-data">
									                      <div class="image-container">
									                          <img id="preview" src="#" alt="Preview" style="display:none;">
									                      </div>
									                      <input type="file" id="file_input" name="file" accept=".jpg. .png, .jpeg" class="fileinput d-none">
									                      <div class="mt-3" style="display:flex;justify-content:flex-end;">
									                          <input type="submit" id="uploadBtn" class="btn btn-primary me-2" value="submit">
									                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
									                      </div>
									               </form>
								              </div>
							          </div>
						      </div>
					  </div>
				  </c:if>
					
				</div>
                </div>
            </div>
            </div>
            
           <c:if test="${user.id == sessionScope.userId}">
           		 <div class="col-lg-8">
              <div class="card mb-4">
                <div class="card-body">

                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Name</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0">${user.name}</p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Email</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0">${user.email}</p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">DOB</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0">${user.dob}</p>
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <p class="mb-0">Gender</p>
                    </div>
                    <div class="col-sm-9">
                      <p class="text-muted mb-0">${user.gender}</p>
                    </div>
                  </div>
                </div>    
              </div>
            </div>
           </c:if>
          </div>
        </div>

        <div class="container mt-0">
            <div id="v-pills-tab" role="tablist" aria-orientation="vertical">
            <ul class="nav nav-tabs row">
              <c:if test="${user.id != sessionScope.userId}">
              	  <h5 class="text-center h3">Blogs</h5>
              </c:if>
              <c:if test="${user.id == sessionScope.userId}">
	              <li class="nav-item col-sm-4">
	                <a class="nav-link active" data-toggle="tab" href="#tab1">Blog Post</a>
	              </li>
	              <li class="nav-item col-sm-4">
	                <a class="nav-link" data-toggle="tab" href="#tab2">Saved Post</a>
	              </li>
	              <li class="nav-item col-sm-4">
	                <a class="nav-link" data-toggle="tab" href="#tab3">Liked Post</a>
	              </li>
              </c:if>
	            </ul>
          </div>
          
            <div class="tab-content mt-0">
              <div class="tab-pane fade show active" id="tab1">
              <c:choose>              		
	               <c:when test="${not empty postblogs}">
	               		<div class="blogs">
			                <c:forEach var="blog" items="${postblogs}">                
			                  <div class="card" style="width: 18rem;">
			                    <img src="data:image/jpeg;base64,${blog.encodedPhoto}" class="card-img-top" alt="..."  style="height:150px;object-fit:cover;">
			                    <div class="card-body">
			                      <h5 class="card-title">${blog.title}</h5>
			                      <p class="card-text">${blog.content}</p>
			                      <a href="../detail?blogid=${blog.id}&userId=${sessionScope.userId}" class="btn btn-primary">View Details</a>
			                    </div>
			                  </div>
			                </c:forEach>
				     </div>
	               </c:when>
	               <c:otherwise>
	               		<c:choose>
		               		<c:when test="${sessionScope.userId eq user.id}">
			               		<h1 class="text-center mt-5 text-muted">There is no blogs you posted</h1>
			               		<div class="text-center" style="margin-bottom: 200px;">
						            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
					            </div>
		               		</c:when>
							<c:otherwise>							
			               		<div>
			               			<h1 class="text-center mt-5 text-muted" >There is no blogs this user posted</h1>
				               		<div class="text-center" style="margin-bottom: 200px;">
							            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
						            </div>
			               		</div>
							</c:otherwise>
	               		</c:choose>
	               </c:otherwise>
              </c:choose>
               </div>
            <c:if test="${user.id == sessionScope.userId}">
           <div class="tab-pane fade" id="tab2">
              <c:choose>              		
	               <c:when test="${not empty savedblogs}">
	               		<div class="blogs">
			                <c:forEach var="blog" items="${savedblogs}">                
			                  <div class="card" style="width: 18rem;">
			                    <c:if test="${blog.encodedPhoto ne null}">
					                <div class="image-container">
							           <img src="data:image/jpeg;base64,${blog.encodedPhoto}" alt="blogphoto" class="d-block"  style="height:150px;object-fit:cover;">
							        </div>
				                </c:if>
				                <c:if test="${blog.encodedPhoto eq null}">
					                <div class="image-container">
		   					        	<img src="<c:url value="/resources/photos/blogdefaultphoto.jpg"/>" alt="blogphoto" class="d-block"  style="height:150px;object-fit:cover;">			             
							        </div>
				                </c:if>
			                    <div class="card-body">
			                      <h5 class="card-title">${blog.title}</h5>
			                      <p class="card-text">${blog.content}</p>
			                      <a href="../detail?blogid=${blog.id}&userId=${sessionScope.userId}" class="btn btn-primary">View Details</a>
			                    </div>
			                  </div>
			                </c:forEach>
				     </div>
	               </c:when>
	               <c:otherwise>
	               		<c:choose>
		               		<c:when test="${sessionScope.userId eq user.id}">
			               		<h1 class="text-center mt-5 text-muted" >There is no blogs you saved</h1>
			               		<div class="text-center" style="margin-bottom: 200px;">
						            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
					            </div>
		               		</c:when>
							<c:otherwise>							
			               		<div>
			               			<h1 class="text-center mt-5 text-muted" >There is no blogs this user saved</h1>
				               		<div class="text-center" style="margin-bottom: 200px;">
							            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
						            </div>
			               		</div>
							</c:otherwise>
	               		</c:choose>
	               </c:otherwise>
              </c:choose>
               </div>
             
           </c:if>
           
           <c:if test="${user.id == sessionScope.userId}">
              <div class="tab-pane fade" id="tab3">
              <c:choose>              		
	               <c:when test="${not empty likedblogs}">
	               		<div class="blogs">
			                <c:forEach var="blog" items="${likedblogs}">                
			                  <div class="card" style="width: 18rem;">
			                    <c:if test="${blog.encodedPhoto ne null}">
					                <div class="image-container">
							           <img src="data:image/jpeg;base64,${blog.encodedPhoto}" alt="blogphoto" class="d-block" style="height:150px;object-fit:cover;">
							        </div>
				                </c:if>
				                <c:if test="${blog.encodedPhoto eq null}">
					                <div class="image-container">
		   					        	<img src="<c:url value="/resources/photos/blogdefaultphoto.jpg"/>" alt="blogphoto" class="d-block"  style="height:150px;object-fit:cover;">			             
							        </div>
				                </c:if>
			                    <div class="card-body">
			                      <h5 class="card-title">${blog.title}</h5>
			                      <p class="card-text">${blog.content}</p>
			                      <a href="../detail?blogid=${blog.id}&userId=${sessionScope.userId}" class="btn btn-primary">View Details</a>
			                    </div>
			                  </div>
			                </c:forEach>
				     </div>
	               </c:when>
	               <c:otherwise>
	               		<c:choose>
		               		<c:when test="${sessionScope.userId eq user.id}">
			               		<h1 class="text-center mt-5 text-muted">There is no blogs you liked</h1>
			               		<div class="text-center" style="margin-bottom: 200px;">
						            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
					            </div>
		               		</c:when>
							<c:otherwise>							
			               		<h1 class="text-center mt-5 text-muted">There is no blogs this user liked</h1>
			               		<div class="text-center"  style="margin-bottom: 200px;">
						            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
					            </div>
							</c:otherwise>
	               		</c:choose>
	               </c:otherwise>
              </c:choose>
               </div>
               </c:if>
            </div>
		</div>
      </section>
</div>
<script type="text/javascript">
document.getElementById('file_input').addEventListener('change', function() {
	  // Show the modal when a file is selected
	  $('#editPhotoModal').modal('show');
	});
	
document.getElementById("file_input").addEventListener("change", function() {
  var fileInput = this.files[0];
  
  var reader = new FileReader();

  reader.onload = function(e) {
    document.getElementById("preview").src = e.target.result;
    document.getElementById("preview").style.display = "inline-block";
  }

  reader.readAsDataURL(fileInput);
});

const messageElement = document.getElementById('message');

document.addEventListener('DOMContentLoaded', function() {
  const messageElement = document.getElementById('message');
  if (messageElement !== null && messageElement !== "") {
    setTimeout(function() {
      messageElement.classList.add('hidden');
    }, 3000); 
  }
});


</script>
</body>
</html>
