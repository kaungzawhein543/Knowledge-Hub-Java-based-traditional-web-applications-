<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Blogger Register</title>
</head>
<style>
    	 @import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');

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
        	#navbtn{
	 		min-width:30px !important;
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
		    padding:10px;
		    height: 50px;
		    border-radius: 50%;
		    text-align: center; /* Center the content horizontally */
		    line-height: 50px; /* Center the content vertically */
		}
		
		.back:hover {
		    color: #11122e;
		    background-color: #d7d9d7;    
		}
		#otherEducation{
			display: none;
		}
</style>
<link rel="stylesheet" href="<c:url value='resources/css/bloggerregister.css'/>">
<link rel="stylesheet" href="<c:url value='resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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
 <div class="wrapper">
 	   	<a href="./blogs" id="backkey"><i class="back fas fa-arrow-left" style="font-size:30px;"></i></a>
 
        <img src="<c:url value='resources/photos/blogger.svg'/>" alt="" width="400px" style="margin-left: 50px;" class="d-none d-lg-block">
        <form:form action="add_blogger" class="registerForm" modelAttribute="blogger" method="post">
            <h3>Register For Blog</h3>
            
        
           <div class="row text-center">
                <div class="form-floating col-lg-6">
                    <form:input path="name" type="text" name="name" value="${blogger.name}" placeholder="Enter your name" id="name" class="form-control border-secondary " required="true" autocomplete="off"/>
                    <form:label path="name" for="name" style="margin-left:10px;">Enter your name</form:label>
                    <form:errors path="name" cssClass="error"></form:errors>
                </div>
            

                <div class="form-floating col-lg-6">
                    <form:input path="email" type="email" name="email2" value="${blogger.email}" placeholder="Enter your email" id="email2" class="form-control border-secondary" required="true" autocomplete="off"/>
                    <form:label path="email" for="email2" style="margin-left:10px;">Enter your email</form:label>
                    <form:errors path="email" cssClass="error"></form:errors>
                    <p class="text-danger text-left">${error}</p>
                </div>
           </div>
        
            <div class="form-floating">
                <form:input path="address" type="text" name="address" value="${blogger.address}" placeholder="Enter your Address" id="address" class="form-control border-secondary" required="true" autocomplete="off"/>
                <form:label path="address" for="address">Enter your addresss</form:label>
                <form:errors path="address" cssClass="error"></form:errors>
            </div>
        
            <div class="form-group">
                <form:label path="education" for="education">Education</form:label>
                <form:select path="education" name="education" id="othereducation" class="form-select border-secondary">
                    <option value="" disabled selected="selected">Select Education</option>
                    <option value="High School Diploma/GED">High School Diploma/GED</option>
                    <option value="Associate's Degree">Associate's Degree</option>
                    <option value="Bachelor's Degree">Bachelor's Degree</option>
                    <option value="Master's Degree">Master's Degree</option>
                    <option value="Doctorate/Ph.D.">Doctorate/Ph.D.</option>
                    <option value="Professional Degree">Professional Degree (e.g., MD, JD)</option>
                    <option value="Technical/Vocational Certificate">Technical/Vocational Certificate</option>
                    <option value="Other">Other</option>
                </form:select>
            </div>
        	<div id="otherEducation" class="form-floating" style="display: none;">
        		<form:textarea path="education" class="form-control border-secondary" placeholder="Other Education: "/>
        		<form:label path="education">Other Education</form:label>
        	</div>
            <div class="form-floating">
                <form:input path="ph_contact" type="text" value="${blogger.ph_contact}" name="ph" placeholder="Enter your phone" id="ph" class="form-control border-secondary" required="true" autocomplete="off"/>
                <form:label path="ph_contact" for="ph">Phone</form:label>
                <form:errors path="ph_contact" cssClass="error"></form:errors>
            </div>

            <div class="form-floating">
                <form:textarea path="personality" name="content" value="${blogger.personality}" placeholder="Enter your personality" id="myTextBox" class="form-control border-secondary"></form:textarea>
                <div id="charCount">0 / 300</div>
                <form:label path="personality" for="content">Personality:</form:label><br>
                <form:errors path="personality" cssClass="error"></form:errors>
            </div>

            <button type="submit" class="btn btn-primary mb-3">Register</button>
		</form:form>
            <script>
               var textBox=document.getElementById("myTextBox");
                  var maxLength=300;
                  var charCount=document.getElementById("charCount");

                  textBox.addEventListener("input",function(){
                        var currentLength=textBox.value.length;
                        charCount.textContent=Math.min(currentLength, maxLength)+"/"+maxLength;

                        if(currentLength>maxLength){
                            textBox.value=textBox.value.slice(0,maxLength);
                        }
                  });
                  
                  const messageElement = document.getElementById('message');

              	document.addEventListener('DOMContentLoaded', function() {
              	    const messageElement = document.getElementById('message');
              	    if (message !== null && message !== "") {
              	      setTimeout(function() {
              	        messageElement.classList.add('hidden');
              	      }, 3000); 
              	    }
              	  });
              	document.addEventListener('DOMContentLoaded', function() {
              	    const selectElement = document.querySelector('#othereducation');
              	    const otherEducationDiv = document.getElementById('otherEducation');

              	    function checkOtherEducation() {
              	        if (selectElement.value === 'Other') {
              	        	selectElement.value = "";
              	            otherEducationDiv.style.display = 'block';
              	        } else {
              	            otherEducationDiv.style.display = 'none';
              	        }
              	    }

              	    // Run the check when the page loads
              	    checkOtherEducation();

              	    // Add event listener for changes
              	    selectElement.addEventListener('change', checkOtherEducation);
              	});





                  </script>
        </div>
</body>
</html>