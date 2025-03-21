<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Blog</title>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
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
		body{
	            margin: 0;
	            padding: 0;
	            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	        }
        .registerForm {
            height: 100vh;
            display: flex;
            flex-direction: column;
            margin: auto;
            width: 40%;
            padding: 100px 20px;
            gap: 15px;
            min-width: 350px;
            border-bottom: none;
            color: black;
        }
        .fileinput{
            display: none;
        }
        .image-container {
        max-width: 100%;
        height: auto;
        }
        .image-container img {
            width: 100%; /* You can adjust this value to resize the image */
            height: auto;
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
            <a class="navbar-brand" href="./">Knowledge Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
					<c:if test="${sessionScope.isSuper_Admin || sessionScope.isAdmin}">
	                     <li id="navbtn" class="btn btn-primary ms-3"><i class="fa-solid fa-arrow-up-right-from-square"></i><a class="text-white" href="./admin_dashboard">Admin Dashboard</a></li>
					</c:if>
                    <li class="nav-item">
                        <div class="dropdown m-2">
                        <a href="./blogs" id="nitem"><i class="fa-brands fa-font-awesome"></i> New Feed</a>
                            <div class="dropdown-content">
                            <a href="/knowledge_hub/#home"><i class="fas fa-home"></i> Home</a>
                                <a href="/knowledge_hub/#About us"><i class="fas fa-circle-info"></i> About us</a>
                                <a href="/knowledge_hub/#Feedbacks"><i class="fas fa-message"></i> Feedbacks</a> 
                            </div>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="./user_detail/${sessionScope.userId}" id="nitem" class="m-2"><i class="fas fa-user-circle"></i> Profile</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
	   	<a href="./blogs" id="backkey"><i class="back fas fa-arrow-left" style="font-size:30px;"></i></a>
		<form:form action="/knowledge_hub/add_blog/${sessionScope.userId}" method="post"  modelAttribute="blog" enctype="multipart/form-data" class="registerForm">
	        <h3>Create Blog</h3>
	        <form:hidden path="code" value="${blogCode}"/>
			 <h4>${blogCode}</h4>
	        <br>
	    	<div class="form-floating mb-3">
	            <form:input path="title" type="text" name="title" id="title" placeholder="Enter Title" class="form-control border-secondary" required="true" autocomplete="off"/>
	            <form:label path="title" for="title" >Title</form:label> 
	            <div id="charCount1">0 / 40</div>
            </div>
	    
	        <div class="form-floating">
	            <form:textarea path="content" name="content" id="myTextBox" class="form-control border-secondary" placeholder="Content" required="true" autocomplete="off"></form:textarea>
	            <form:label path="content" for="myTextBox">Content</form:label>
	            <div id="charCount2">0 / 3000</div>
	        </div>
	        <div class="form-group">
	            <form:select class="form-select  border-secondary" path="categories_id">
	                <form:option value="0" disabled="true">CATEGORIES</form:option>
			    	<form:options items="${categories}" itemValue="id" itemLabel="name" />
	            </form:select>
	        </div>
	        
	        <label for="file-upload" class="custom-file-input btn btn-success">Choose photo</label>
	        <input type="file" id="file-upload" name="file" accept=".jpg, .png, .jpeg" class="fileinput">
	        <div class="image-container">
	            <img id="preview" src="#" alt="Preview" style="display:none;">
	        </div>
	
	        <button type="submit" class="btn btn-primary" style="width:30%;">Create Blog</button>

    </form:form>
	<script>
	const messageElement = document.getElementById('message');

	document.addEventListener('DOMContentLoaded', function() {
	    const messageElement = document.getElementById('message');
	    if (message !== null && message !== "") {
	      setTimeout(function() {
	        messageElement.classList.add('hidden');
	      }, 3000); 
	    }
	  });
	document.addEventListener("DOMContentLoaded", function(){
	    var textBox = document.getElementById("myTextBox");
	    var maxLength = 3000;
	    var charCount = document.getElementById("charCount2");

	    function updateCharCount() {
	        var currentLength = textBox.value.length;
	        charCount.textContent = Math.min(currentLength, maxLength) + " / " + maxLength;
	    }

	    updateCharCount();

	    textBox.addEventListener("input", function() {
	        updateCharCount();

	        if (textBox.value.length > maxLength) {
	            textBox.value = textBox.value.slice(0, maxLength);
	            updateCharCount();
	        }
	    });
	});
        document.getElementById("file-upload").addEventListener("change", function() {
            var fileInput = this.files[0];
            
            var reader = new FileReader();
          
            reader.onload = function(e) {
	            var maxSizeInBytes = 5 * 1024 * 1024;
	            if (fileInput.size > maxSizeInBytes) {
	                alert("Please upload a photo smaller than 16MB.");
	                document.getElementById("preview").style.display = "none";
	                document.getElementById("file-upload").value = ''; // Clear the file input
	                console.log('No')
	            } else {
	                document.getElementById("preview").src = e.target.result;
	                document.getElementById("preview").style.display = "inline-block";
	                console.log('Yes')
	            }             
            }
          
            reader.readAsDataURL(fileInput);
            
          });
          document.addEventListener("DOMContentLoaded", function(){
      	    var textBox = document.getElementById("title");
      	    var maxLength =40;
      	    var charCount = document.getElementById("charCount1");

      	    function updateCharCount() {
      	        var currentLength = textBox.value.length;
      	        charCount.textContent = Math.min(currentLength, maxLength) + " / " + maxLength;
      	    }

      	    updateCharCount();

      	    textBox.addEventListener("input", function() {
      	        updateCharCount();

      	        if (textBox.value.length > maxLength) {
      	            textBox.value = textBox.value.slice(0, maxLength);
      	            updateCharCount();
      	        }
      	    });
      	});
    </script>
</body>
</html>