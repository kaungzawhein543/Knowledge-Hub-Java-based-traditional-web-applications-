<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="viewport" content="width=device-width, initial-scale=1.0">
<title>Knowledge hub</title>
    <!-- Bootstrap CSS -->
<link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/header.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>
	<c:if test="${message ne null}">
		<div id="message" class="auto-disappear text-white bg-dark">${message}</div>
	</c:if>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light position-fixed">
            <div class="container-fluid">
                <a class="navbar-brand" href="/knowledge_hub">Knowledge Hub</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="#home"><i class="fas fa-home"></i> Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about"><i class="fas fa-info-circle"></i> About</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#myteam"><i class="fa-solid fa-people-group"></i> My Team</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#feedback"><i class="fas fa-comment"></i> Feedback</a>
                        </li>
                        <li class="nav-item">
                        <c:choose>
                            <c:when test="${sessionScope.login}">
                            	<li class="nav-item">
                            		<a class="nav-link" href="user_detail/${sessionScope.userId}">Profile</a>
                            	</li>
                            </c:when>
                            <c:otherwise>
								<div class="dropdown">
									<a class="dropdown-toggle nav-link" href="register">Sign up</a>
									<div class="dropdown-content">
										<a href="login" class="login">Login</a>
									</div>
								</div>
							</c:otherwise>
                        </c:choose>
                            
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="jumbotron" id="home">
        <div class="centered-content">
            <h4 class="title"><b>Unlock Your Learning Journey at Knowledge Hub!</b></h4>
            <p>Hi Guys, I would like to introduce you to a website that will provide you with such knowledges.<br>
                If you want to gain knowledges or share knowledge, don't hesitate to enter this website. <br>
                I believe that when you go into it, you will get and share all kinds of knowledges.</p>

            <p>So, Let's enter this website</p>
            <a href="blogs" class="viewknowledge" role="button">View Knowledges</a>
        </div>
        <img src="<c:url value="/resources/photos/herosection.svg"/>" alt="" width="600px">
    </div>

    <section>
        <div class="container">
            <div class="row" id="about">
                <div class="col-lg-8 mx-auto mt-5">
                    <div class="about-section">
                        <h2>About Us</h2>
                        <p>Welcome to Knowledge Hub, your go-to destination for all things knowledge-related! We are
                            passionate about empowering individuals and organizations to learn, grow, and succeed in
                            their endeavors.</p>
                        <h2>Our Mission</h2>
                        <p>Our mission is to democratize knowledge and make it accessible to everyone, regardless of
                            their background or location. We believe that knowledge has the power to transform lives and
                            shape a better future for all.</p>
                        <h2>What We Offer</h2>
                        <p>At Knowledge Hub, we provide a diverse range of resources, including articles, tutorials,
                            courses, and interactive tools, covering a wide array of topics such as technology, science,
                            business, arts, and more. Whether you're a student, professional, or lifelong learner,
                            you'll find something valuable here to enrich your mind and broaden your horizons.</p>
                    </div>
                </div>
            </div>

        </div>
        <div class="row" id="myteam">
            <div class="col-lg-12">
                <div class="team-section">
                    <h2 class="text-center mb-4">Our Team</h2>
                    <div class="row d-flex justify-content-center">
                        <div class="col-lg-2">
                            <div class="team-member">
                                <img src="<c:url value="/resources/photos/coffee.jpg"/>" alt="Team Member 1">
                                <h3>Kaung Zaw Hein</h3>
                                <p>Project Leader</p>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="team-member">
                                <img src="<c:url value="/resources/photos/coffee.jpg"/>" alt=" Team Member 2">
                                <h3>Wah Wah Shwe Sin Htike</h3>
                                <p>Frondend Developer</p>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="team-member">
                                <img src="<c:url value="/resources/photos/coffee.jpg"/>" alt=" Team Member 3">
                                <h3>Chaw Ei Ei Htwe</h3>
                                <p>Frondend Developer</p>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="team-member">
                                <img src="<c:url value="/resources/photos/coffee.jpg"/>" alt=" Team Member 4">
                                <h3>Kaung Myat Linn</h3>
                                <p>Backend Developer</p>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <div class="team-member">
                                <img src="<c:url value="/resources/photos/coffee.jpg"/>" alt=" Team Member 5">
                                <h3>Aung Khant</h3>
                                <p>Backend Developer</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="contact-section">
                    <h2>Get in Touch</h2>
                    <p>We're always eager to hear from our users! If you have any questions, feedback, or suggestions,
                        please don't hesitate to contact us. You can reach out to us via email at <a
                            href="mailto:kzheindev789@gmail.com">kzheindev789@gmail.com</a> or connect with us on social
                        media.</p>
                </div>
            </div>
        </div>
    </section>
    <section class="feedback my-5" id="feedback" style="padding-top: 100px;">

        <!-- Modal Body -->
        <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
        <div class="modal fade" id="modalId" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"
            role="dialog" aria-labelledby="modalTitleId" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitleId">
                            Send Feedback
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form:form action="addfeedback" method="post" modelAttribute="feedback">
                            <form:textarea path="content" name="" rows="5" cols="20" class="form-control" required="true" autocomplete="off"></form:textarea>
                            <div class="mt-3 text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                    Close
                                </button>
                                <button type="submit" class="btn btn-primary ">Send Feedback</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>

        <div class="feedback-text">
            <h3>WE WANT YOUR FEEDBACK</h3>
            <p>Your feedback is invaluable to us! We're constantly striving to improve our services, and your input
                helps us understand what we're doing well and where we can make enhancements. Please take a moment to
                share your thoughts with us. Whether it's a suggestion, a compliment, or an area you think we can
                improve, we're eager to hear from you. Thank you for helping us serve you better!</p>
            <button class="btn btn-success"  data-bs-toggle="modal" data-bs-target="#modalId">Send Feedback</button>
        </div>
        <img src="<c:url value="/resources/photos/feedback.svg"/>" alt="feedback" class="d-none d-md-none d-lg-inline-block">
    </section>
    <section id="footer">
        <div class="firstfooter ">
            <div>
                <i class="fas fa-location-arrow  bg-light p-2 rounded-5"></i>
                <a href="https://maps.app.goo.gl/86PmLhDFqG9SrixF8" class="location">No. 169, MTP Condo, 2 Floor (AB),
                    Insein Road</a>
            </div>
            <div>
                <i class="fas fa-phone bg-light p-2 rounded-5"></i>
                <a href="tel:+95 9770554551" class="location">+95 9770554551</a>
            </div>
            <div>
                <i class="fas fa-envelope bg-light p-2 rounded-5"></i>
                <a href="mailto:kzheindev789@example.com" class="location">kzheindev789@example.com</a>
            </div>
        </div>
        <div class="secondfotter">
            <h5>Thanks For visiting our website</h5>
            <p>This website is making for JWD Project.We know we can't do the perfect website but we tried our
                best.Please forgive some weakness and mistakes from our website.Thanks you</p>
        </div>
        <p class=" text-center">&copy;Copyright 2024 Knowledge-Hub</p>
    </section>
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
	sessionStorage.removeItem("expirationTime");
	</script>
</body>
</html>