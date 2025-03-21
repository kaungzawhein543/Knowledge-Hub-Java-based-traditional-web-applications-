<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Knowledge Hub</title>

<link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
<link href="<c:url value="/resources/css/admindashboard.css"/>" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<script type="text/javascript" src="https://cdn.datatables.net/2.0.7/js/dataTables.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/3.0.2/js/dataTables.buttons.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.dataTables.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/3.0.2/js/buttons.print.min.js"></script>

<link href="https://cdn.datatables.net/2.0.7/css/dataTables.dataTables.css" rel="stylesheet">
<link href="https://cdn.datatables.net/buttons/3.0.2/css/buttons.dataTables.css" rel="stylesheet">

<script type="text/javascript" src="<c:url value="/resources/js/admindashboard.js"/>"></script>
<style type="text/css">
	table.dataTable {
    width: 100% !important; /* Set table width to 100% */
    margin: 0 !important; /* Remove any margins */
}

/* Optional: If you want to remove padding from the table */
table.dataTable {
    padding: 0 !important;
}

/* Optional: If you want to make the table header cells center-aligned */
table.dataTable thead th {
    text-align: center;
}
.tab-content {
    height: 100vh;
    margin-top:30px;
    margin-bottom:50px;
}
.bta{
	width:130px;
}
.codeToBlog{
	color:black;
	text-decoration: none;
}
.codeToBlog:hover{
	text-decoration: underline;
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
				                    <li id="navbtn" class="btn btn-outline-primary"><i class="fa-solid fa-plus"></i><a href="add_blog">Create Blog</a></li>
			                 	</c:when>
			                 	<c:when test="${userStatus eq 'requested'}">	                 			
				                    <li id="navbtn" class="btn btn-info disabled"><i class="spinner-border spinner-border-sm text-light"></i><a  href="">Please Wait Response</a></li>
			                 	</c:when>
			                 	<c:otherwise>	                 		
				                    <li id="navbtn" class="btn btn-dark"><a href="uploadform" class="text-light"><i class="fa-solid fa-file-circle-plus"></i> Request post access</a></li>
			                 	</c:otherwise>
		                 	</c:choose>

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
	 <header>
	 		<!-- Navbar -->
			<!-- Navbar End -->
        <div>
        <!--Row Start  -->
            <div class="row">
            	<!-- First Column Start -->
                <div class="col-2 col-lg-2 p-0 list-group" style="padding:0 0 0 10px !important;background-color:aliceblue;z-index: 2; position: absoulute; height: 100vh;margin-bottom:100px;">
                    <div class="nav flex-column  text-lg-start" style="width: 100%" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <span><a href="#" class="d-none d-lg-block list-group-item disabled" style="font-size: 20px;">Controls</a></span>
                        <a class="nav-link p-3 list-group-item list-group-item-action active" id="v-pills-user-tab" data-toggle="pill" href="#user" role="tab" aria-controls="v-pills-user" aria-selected="false"><i class="fas fa-users"></i><span class="d-none d-lg-inline"> User List</span></a>
                        <c:if test="${sessionScope.isSuper_Admin}">
	                        <a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-admin-tab" data-toggle="pill" href="#admin" role="tab" aria-controls="v-pills-admin" aria-selected="false"><i class="fas fa-user-tie"></i> <span class="d-none d-lg-inline">Admin List</span></a>
                        </c:if>
                        <a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-category-tab" data-toggle="pill" href="#category" role="tab" aria-controls="v-pills-category" aria-selected="false"><i class="fas fa-list"></i> <span class="d-none d-lg-inline">Categories</span></a>
                        <a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-bloggerinfo-tab" data-toggle="pill" href="#userbloggerinfo" role="tab" aria-controls="v-pills-bloggerinfo" aria-selected="false"><i class="fas fa-info-circle"></i> <span class="d-none d-lg-inline">User Bloggers Info</span></a>
                       <c:if test="${sessionScope.isSuper_Admin}">
	                        <a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-bloggerinfo-tab" data-toggle="pill" href="#adminbloggerinfo" role="tab" aria-controls="v-pills-bloggerinfo" aria-selected="false"><i class="fas fa-info-circle"></i> <span class="d-none d-lg-inline">Admin Bloggers Info</span></a>
                       </c:if>
                        <a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-report-tab" data-toggle="pill" href="#report" role="tab" aria-controls="v-pills-report" aria-selected="false"><i class="fas fa-flag"></i> <span class="d-none d-lg-inline">Reports</span></a>
                        <a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-feedback-tab" data-toggle="pill" href="#feedback" role="tab" aria-controls="v-pills-feedback" aria-selected="false"><i class="fas fa-comment"></i> <span class="d-none d-lg-inline">Feedbacks</span></a>

                        <span><a href="#" class="d-none d-lg-block secControl list-group-item disabled mt-1" style="font-size: 20px;">Controls</a></span>    
                       <a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-addcategory-tab" data-toggle="pill" href="#addcategory" role="tab" aria-controls="v-pills-addcategory" aria-selected="false">
						    <i class="fas fa-edit"></i><span  class="d-none d-lg-inline"> Add Category</span>
						</a>
						<c:if test="${sessionScope.isSuper_Admin}">
							<a class="nav-link p-3 list-group-item list-group-item-action" id="v-pills-addadmin-tab" data-toggle="pill" href="#addadmin" role="tab" aria-controls="v-pills-addadmin" aria-selected="false">
							    <i class="fas fa-edit"></i><span  class="d-none d-lg-inline">Add Admin</span>
							</a>
						</c:if>

   
                    </div>
                </div>
                <!-- First Column End -->
                
               <!-- Second Column Start -->
              <div class="col-10 col-lg-10" style="padding-bottom:100px;margin-top: 20px !important;height:100vh !important;overflow-y:auto; !important">
              	<!-- Tab Content Start -->
                <div class="tab-content" id="v-pills-tabContent" style="border: 100px;">
                <!-- First tab start -->
                  <div class="tab-pane fade show active" id="user"  role="tabpanel" aria-labelledby="v-pills-user-tab">
                        <h3 style="font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-align: center;">Users List</h3>
                                <table class="table table-responsive" id="userListTable" >
                                    <thead>
                                        <tr class="text-center">
                                            <th>Id</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Dob</th>
                                            <th>Gender</th>
                                            <th>Role_name</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${users}" varStatus="loop">
                                            <tr class="text-center">
                                                <td>${loop.index+1}</td>
                                                <td>${user.name}</td>
                                                <td>${user.email}</td>
                                                <td>${user.dob}</td>
                                                <td>${user.gender}</td>
                                                <td>${user.role_name}</td>
                                                <c:choose>
                                                	<c:when test="${user.status == 0}">
		                                                <td>
		                                                    <a href="changestatus?id=${user.id}&status=${user.status}" class="btn bta btn-danger"><i class="fas fa-ban"></i> Ban</a>
		                                                </td>                                                	
	                                                </c:when>
	                                                <c:otherwise>
		                                                <td>
		                                                    <a href="changestatus?id=${user.id}&status=${user.status}" class="btn bta btn-success"><i class="fa-solid fa-user-check"></i> Active</a>
		                                                </td>                                                	
	                                                </c:otherwise>
                                                </c:choose>
                            
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                  </div>
                  <!-- First tab End -->
	
				<!-- Second tab start -->
                  <div class="tab-pane fade" id="admin" role="tabpanel" aria-labelledby="v-pills-admin-tab"> 
                        <h3 style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-align: center;">Admins List</h3>
                                <table class="table" id="adminListTable">
                                    <thead>
                                        <tr class="text-center">
                                        	<th>Id</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Dob</th>
                                            <th>Gender</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="admin" items="${admins}" varStatus="loop">
                                            <tr class="text-center">
                                            	<td>${loop.index+1}</td>
                                                <td>${admin.name}</td>
                                                <td>${admin.email}</td>
                                                <td>${admin.dob}</td>
                                                <td>${admin.gender}</td>
                                               <c:choose>
                                                	<c:when test="${admin.status == 0}">
		                                                <td>
		                                                    <a href="changestatus?id=${admin.id}&status=${admin.status}" class="btn bta btn-danger"><i class="fas fa-ban"></i> Ban</a>
		                                                </td>                                                	
	                                                </c:when>
	                                                <c:otherwise>
		                                                <td>
		                                                    <a href="changestatus?id=${admin.id}&status=${admin.status}" class="btn bta btn-success"><i class="fa-solid fa-user-check"></i> Active</a>
		                                                </td>                                                	
	                                                </c:otherwise>
                                                </c:choose>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                  </div>
                  <!-- Second tab End -->
                  
                  <!--Third Tab Start -->
                  <div class="tab-pane fade" id="category" role="tabpanel" aria-labelledby="v-pills-category-tab">
	                        <h3 style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-align: center;">Categories</h3>
	                                <table class="table" id="categoryListTable" >
	                                    <thead>
	                                        <tr class="info text-center">
	                                            <th>Id</th>
	                                            <th>Name</th>
	                                            <th>Action</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                        <c:forEach var="category" items="${categories}">
	                                            <tr class="text-center">
	                                                <td>${category.id}</td>
	                                                <td>${category.name}</td>
	                                                 <td>
	                                                     <a href="editCategory/${category.id}" class="btn bta btn-success p-2"><i class="fas fa-edit"></i> Edit</a>
	                                                 </td>
	                            
	                                            </tr>
	                                        </c:forEach>
	                                    </tbody>
	                                </table>
                  </div>
                  <!-- Third Tab End -->
                  
                  <!-- Fourth Tab Start -->
                  <div class="tab-pane fade" id="userbloggerinfo" role="tabpanel" aria-labelledby="v-pills-bloggerinfo-tab">
                        <h3 style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-align: center;">User Bloggers Information</h3>
                                <table class="table" id="userbloggerListTable" >
                                    <thead>
                                        <tr class="text-center">
                                            <th>Id</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Permissions</th>
                                            <th>More Info</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:set var="displayIndex" value="0"/>
                                        <c:forEach var="blogger" items="${bloggers}" varStatus="loop">
                                        	<c:if test="${blogger.user_role eq 3}">
		                                            <tr class="text-center">
		                                                <td>${displayIndex + 1}</td>
		                                                <td>${blogger.name}</td>
		                                                <td>${blogger.email}</td>
		                                                <td>
		                                                <c:choose>
		                                                	<c:when test="${blogger.status eq 'approve'}">
		                                                		Approved
		                                                	</c:when>
		                                                	<c:otherwise>
		                                                		Not defined
		                                                	</c:otherwise>
		                                                </c:choose>
		                                                </td>
		                                                <td><a href="detail_blogger?bloggerid=${blogger.id}&bloggerRole=${blogger.user_role}" class="btn bta btn-primary">Detail</a>
		                                            <c:set var="displayIndex" value="${displayIndex + 1}" />                                     	
                                        	</c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                  </div>
                  <div class="tab-pane fade" id="adminbloggerinfo" role="tabpanel" aria-labelledby="v-pills-bloggerinfo-tab">
                        <h3 style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-align: center;">Admins Bloggers Information</h3>
                                <table class="table" id="adminbloggerListTable" >
                                    <thead>
                                        <tr class="text-center">
                                            <th>Id</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Permissions</th>
                                            <th>More Info</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:set var="displayIndex" value="0"/>
                                        <c:forEach var="blogger" items="${bloggers}" varStatus="loop">
                                        	<c:if test="${blogger.user_role eq 2}">
                                            <tr class="text-center">
                                                <td>${displayIndex + 1}</td>
                                                <td>${blogger.name}</td>
                                                <td>${blogger.email}</td>
                                                <td>
		                                                <c:choose>
		                                                	<c:when test="${blogger.status eq 'approve'}">
		                                                		Approved
		                                                	</c:when>
		                                                	<c:otherwise>
		                                                		Not defined
		                                                	</c:otherwise>
		                                                </c:choose>
		                                                </td>
                                                <td><a href="detail_blogger?bloggerid=${blogger.id}&bloggerRole=${blogger.user_role}" class="btn bta btn-primary">Detail</a></td>                       
                                            </tr>
                                            <c:set var="displayIndex" value="${displayIndex + 1}" />                                 	
                                        	</c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                  </div>
                  <!-- Fourth Tab End -->
                  
                  
                  <!-- Fifth Tab Start -->
                  <div class="tab-pane fade" id="report" role="tabpanel" aria-labelledby="v-pills-report-tab">
	                        <h3 style="font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-align: center;">Reports</h3>
	                        <c:if test="${empty reports}">
	                        	<h1 class="text-center mt-5 text-muted">There is no Reports in current time</h1>
			               		<div class="text-center"  style="margin-bottom: 200px;">
						            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
					            </div>
	                        </c:if>
	                        <c:forEach var="report" items="${reports}">
								<div class="card w-100 ms-auto my-5">
		                            <div class="card-header">
		                                <h4 class="card-title">Blog Code : <a class="codeToBlog" href="detail?blogid=${report.blog_id}&userId=${sessionScope.userId}">${report.blog_code}</a></h4>
		                            </div>
		                            <div class="card-body">
		                                <p class="card-text">Blogger Name: ${report.blogger_name}</p>
		                                <p class="card-text">Content: ${report.content}</p>
		                            </div>
		                            <div class="card-footer">
		                            	<a href="detail?blogid=${report.blog_id}&userId=${sessionScope.userId}" class="btn bta btn-success">Check Blog</a>
										<button onclick="approveReport(${report.blog_id}, ${report.id})" class="btn  btn-primary">Approve Report</button>
										<a href="rejectReport?reportid=${report.id}" class="btn btn-danger">Reject report</a>
		                            </div>
	                        	</div>
	                                            
	                        </c:forEach>
	                        
                  </div>
				<!-- Fifth Tab End -->
				
				<!-- Sixth tab start -->
                  <div class="tab-pane fade" id="feedback" role="tabpanel" aria-labelledby="v-pills-feedback-tab">
                        <h3 style="font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;text-align: center;">Feedbacks</h3>
                         <c:if test="${empty feedbacks}">
	                        	<h1 class="text-center mt-5 text-muted">There is no Feedbacks in current time</h1>
			               		<div class="text-center"  style="margin-bottom: 200px;">
						            <i class="text-muted fas fa-robot" style="font-size:50px;"></i>
					            </div>
	                        </c:if>
                        <c:forEach var="feedback" items="${feedbacks}">
						    <div class="card w-100 mb-3 ms-auto">
							    <div class="card-body">
								    <table class="table text-left" id="userListTable" >
								        <tbody>
								            <tr>
								                <th style="width: 10%">Feedback:</th>
								                <td style="width: 90%">${feedback.content}</td>
								            </tr>
								        </tbody>
								    </table>
								</div>
							</div>
						</c:forEach>

                    </div>
                        <div class="tab-pane fade" id="addcategory" role="tabpanel" aria-labelledby="v-pills-addcategory-tab">
                            <div  id="addCategoryForm" class="wrapper">
                                <form:form modelAttribute="category" action="addcategory" class="categoryForm">
                                    <h2>New Category</h2>
                        
                                    <div class="form-floating" >
                                        <form:input path="name" type="text" name="name" id="title" class="form-control border-secondary" placeholder="Enter Category Name" required="true" autocomplete="off"/>
                                        <form:label path="name" for="name">Category Name</form:label>
                                    </div>
                                    <br>
                                        <button type="submit" class="btn btn-primary mt-3" >Add Category</button>
                                </form:form>
                            </div>
                        </div>
                        <c:if test="${sessionScope.isSuper_Admin}">
                        	<div class="tab-pane fade" id="addadmin" role="tabpanel" aria-labelledby="v-pills-addadmin-tab">
	                            <div class="wrapper" >
	                                <form:form action="add_Admin" class="adminForm form-control" style="border:none !important;" method="post" modelAttribute="admin" onsubmit="return validateAge()">
	                        
	                                        <h2 class="text-center">Add Admin</h2>
	                                
	                                            <div class="form-floating">
	                                                <form:input path="name"  class="form-control border-secondary" placeholder="Enter Admin Name" required="true" autocomplete="off"/>
	                                                <form:label path="name">Enter Admin name</form:label><br>
	                                            </div>
	                                
	                                            <div class="form-floating">
	                                                <form:input path="email" type="email"  class="form-control border-secondary" placeholder="Enter Admin email" required="true" autocomplete="off"/>
	                                                <form:label path="email">Enter your email</form:label><br>
	                                            </div>
	                                
	                                            <div class="form-floating">
	                                                <form:input path="password" type="password" value="${password}" class="form-control border-secondary" placeholder="Enter Admin password" required="true" autocomplete="off"/>
	                                                <form:label path="password">Enter your password</form:label><br>
	                                            </div>
	                                
	                                            <div class="form-group">
	                                                <form:label path="dob">Date of Birth</form:label><br>
	                                                <form:input path="dob" type="date" id="birthday" name="birthday" class="form-control border-secondary" required="true" autocomplete="off"/>
	                                            </div>
	                                
	                                            <label class="my-3">Gender</label>
	                                            <div class="form-check">
										              <form:label path="gender" for="male">Male</form:label>
										              <form:radiobutton path="gender" id="male" value="male" required="true"/>
										                  
										              <form:label path="gender" for="female">Female</form:label>
										              <form:radiobutton path="gender"  id="female" name="role" value="female" required="true"/>
										          </div>
										                                
	                                            <form:input type="hidden" path="status" value="2"/>
	                                            <button type="submit" class="btn btn-primary mt-3">Add Admin</button>
	                                </form:form>
	                                </div>
	                          </div>
                        </c:if>
                </div>
                </div>
              </div>
            </div>

    </header>
	 
	 
	<script type="text/javascript">
	 $(document).ready( function () {
	        $('#userListTable').DataTable({
	        	layout: {
	                topStart: {
	                    buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
	                }
	            }
	        });
	    });
	 
	 $(document).ready( function(){
		 $('#adminListTable').DataTable({
	        	layout: {
	                topStart: {
	                    buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
	                }
	            }
	        });
	 })
	 $(document).ready( function(){
		 $('#userbloggerListTable').DataTable({
	        	layout: {
	                topStart: {
	                    buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
	                }
	            }
	        });
	 })
	 $(document).ready( function(){
		 $('#adminbloggerListTable').DataTable({
	        	layout: {
	                topStart: {
	                    buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
	                }
	            }
	        });
	 })
	 $(document).ready( function(){
		 $('#categoryListTable').DataTable({
	        	layout: {
	                topStart: {
	                    buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
	                }
	            }
	        });
	 })
	
	const messageElement = document.getElementById('message');

	document.addEventListener('DOMContentLoaded', function() {
	    const messageElement = document.getElementById('message');
	    if (message !== null && message !== "") {
	      setTimeout(function() {
	        messageElement.classList.add('hidden');
	      }, 3000); 
	    }
	  });
	
    function setMaxDate() {
        var today = new Date();
        var maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
        var maxDateString = maxDate.toISOString().split('T')[0]; // Convert date to YYYY-MM-DD format
        document.getElementById('birthday').setAttribute('max', maxDateString);
    }

    window.onload = setMaxDate;
    
    function validateAge() {
        var birthday = document.getElementById('birthday').value;
        var today = new Date();
        var inputDate = new Date(birthday);
        var age = today.getFullYear() - inputDate.getFullYear();
        var m = today.getMonth() - inputDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < inputDate.getDate())) {
            age--;
        }
        if (age < 18) {
            alert('Admin must be at least 18 years old.');
            return false;
        }
        return true;
    }
    function approveReport(blogId, reportId) {
        if (confirmcheck()) {
            window.location.href = "approveReport?blogId=" + blogId + "&reportId=" + reportId;
        }
    }

    function confirmcheck() {
        if(confirm("Do You want to approve this report")) {
            return true;
        } else {
            return false;
        }
    }

	</script>
</body>
</html>