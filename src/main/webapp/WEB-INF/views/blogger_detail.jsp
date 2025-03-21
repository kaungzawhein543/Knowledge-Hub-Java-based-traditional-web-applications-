<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blogger Details</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">

<style type="text/css">
	@import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');

	td {
		padding: 20px !important;
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
            <a class="navbar-brand" href="/knowledge_hub/">Knowledge Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                 	<c:choose>
                 		<c:when test="${userStatus eq 'approve'}">
		                    <li id="navbtn" class="btn btn-outline-primary"><i class="fa-solid fa-plus"></i><a href="./add_blog">Create Blog</a></li>
	                 	</c:when>
	                 	<c:when test="${userStatus eq 'requested'}">	                 			
		                    <li id="navbtn" class="btn btn-info disabled"><i class="spinner-border spinner-border-sm text-light"></i><a  href="">Please Wait Response</a></li>
	                 	</c:when>
	                 	<c:otherwise>	                 		
		                    <li id="navbtn" class="btn btn-dark"><a href="./uploadform" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
	                 	</c:otherwise>
                 	</c:choose>
					<c:if test="${sessionScope.isSuper_Admin || sessionScope.isAdmin}">
	                     <li id="navbtn" class="btn btn-primary ms-3"><i class="fa-solid fa-arrow-up-right-from-square"></i><a class="text-white" href="./admin_dashboard">Admin Dashboard</a></li>
					</c:if>
                    <li class="nav-item">
                        <div class="dropdown m-2">
                        <a href="./blogs" id="nitem"><i class="fa-brands fa-font-awesome"></i> New Feed</a>
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
	<div class="container" style="margin-top:100px;height: auto;">
            <h2 class="text-center">Blogger Information</h2>
            <div style="display: flex;gap:30px;">
            	<a href="admin_dashboard" id="backkey"><i class="back fas fa-arrow-left" style="margin-top:15px;font-size:30px;margin-bottom:20px;"></i></a>
            
            <table class="table  table-bordered mt-3 " style="width: 100%;height: 80%;vertical-align: middle;">
               
                    <tr>
                        <th class="text-align">Name</th>
                        <td>${blogger.name}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${blogger.email}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${blogger.address}</td>
                    </tr>
                    <tr>
                        <th>Education</th>
                        <td>${blogger.education}</td>
                    </tr>
                    <tr>
                        <th>Ph_contact</th>
                        <td>${blogger.ph_contact}</td>
                    </tr>
                    <tr>
                        <th>Personality</th>
                        <td>${blogger.personality}</td>
                    </tr>
                    <tr>
                        <th>Action</th>
                        	<td>
                        <c:choose>
	                        	<c:when test="${blogger.status eq 'approve'}">
	                        		<a href="delete_blogger/${blogger.id}" class="btn btn-danger"> Remove Permission</a>
	                        	</c:when>
	                           	<c:otherwise>
	                           		 <a href="approve_blogger?user_id=${blogger.id}" class="btn btn-success "><i class="fas fa-edit"></i> Approve</a>
	                            	<button  class="btn btn-danger " data-bs-toggle="modal" data-bs-target="#warning"><i class="fas fa-edit"></i> Reject</button>
	                           	</c:otherwise>
                        </c:choose>
	                        </td>
                    </tr>
                </tbody>
            </table>
            </div>
            <div class="modal dark-modal fade" id="warning" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog  modal-dialog-centered">
				    <div class="modal-content">
						      <div class="modal-header">
						        <h1 class="modal-title fs-5" id="exampleModalLabel"><i class="fas fa-warning"></i> Warning</h1>
								<button type="button" class="btn-close" style="color:white !important;" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">
						        Do you really want to reject this user?
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
						        <a href="decline_blogger?bloggerid=${blogger.id}" type="button" class="btn btn-primary">Reject</a>
						      </div>
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
        </script>
</body>
</html>