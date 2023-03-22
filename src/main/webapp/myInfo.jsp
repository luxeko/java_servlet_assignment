<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>User info</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet"
          type="text/css"/>
    <link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/newToast.css" rel="stylesheet" type="text/css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"
            integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="menu.jsp" %>
<c:if test="${sessionScope.success != null }">
    <div id="toast" data-value="${sessionScope.success}"></div>
</c:if>
<%
    session.removeAttribute("success");
%>
<section>
    <div class="container my-5">
        <div class="row" style="height: max-content;">
            <div class="col-lg-4" style="position: sticky; top: 10px; height: 500px">
                <div class="card mb-4" style="box-shadow: -7px 7px 0 #198754;">
                    <div class="card-body text-center">
                        <img src="${pageContext.request.contextPath}/assets/avatar.jpg"
                             alt="avatar"
                             class="rounded-circle img-fluid" style="width: 150px; aspect-ratio: 12/11">
                        <h5 class="my-3"><c:out value="${user.name}"></c:out></h5>
                        <p class="text-muted mb-1"><c:out value="${user.role}"></c:out></p>
                        <p class="text-muted mb-4"><c:out value="${user.country}"></c:out></p>
                    </div>
                </div>
                <div class="card mb-4 mb-lg-0" style="box-shadow: -7px 7px 0 #198754;">
                    <div class="card-body p-0">
                        <ul class="list-group list-group-flush rounded-3">
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="bi bi-paypal text-primary"></i>
                                <a style="cursor: pointer"
                                   class="mb-0 text-decoration-none text-primary">https://paypal.me/luxeko1999</a>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fab fa-github fa-lg" style="color: #333333;"></i>
                                <a style="cursor: pointer"
                                   class="mb-0 text-decoration-none text-primary">https://github.com/luxeko</a>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fab fa-instagram fa-lg" style="color: #ac2bac;"></i>
                                <a style="cursor: pointer"
                                   class="mb-0 text-decoration-none text-primary">https://www.facebook
                                    .com/caubelamli2/</a>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                <i class="fab fa-facebook-f fa-lg" style="color: #3b5998;"></i>
                                <a style="cursor: pointer"
                                   class="mb-0 text-decoration-none text-primary ">https://www.instagram.com/_xeko_1
                                    .9/</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="card mb-4" style="box-shadow: -7px 7px 0 #198754;">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0" style="font-weight: 500">Name</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><c:out value="${user.name}"></c:out></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0" style="font-weight: 500">Email</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><c:out value="${user.email}"></c:out></p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0" style="font-weight: 500">Phone</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">(097) 123-4567</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0" style="font-weight: 500">Mobile</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0">(097) 123-4567</p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-sm-3">
                                <p class="mb-0" style="font-weight: 500">Address</p>
                            </div>
                            <div class="col-sm-9">
                                <p class="text-muted mb-0"><c:out value="${user.country}"></c:out></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card mb-4 mb-md-0" style="box-shadow: -7px 7px 0 #198754;">
                            <div class="card-body">
                                <h4 class="mb-4"><span class="text-success font-italic me-1">
                                    Course</span>List
                                </h4>
                                <c:forEach items="${courses}" var="course" varStatus="loop">
                                    <div class="mb-4 course">
                                        <p class="mb-1 course-name" style="font-weight: 500; font-size:
                                        1.2rem">${course.name}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div style="font-size: 0.88rem">
                                                <i class="bi bi-qr-code"></i><i class="ms-1">${course.code}</i>
                                            </div>
                                            <div class="flex-shrink-0">
                                            <span class="time" style="font-weight: 500">
                                                <i class="bi bi-calendar2-week"></i>
                                                <i class="start-time"><fmt:formatDate pattern="dd/MM/yyyy"
                                                                                      value="${course.start_time}"/></i> -
                                                <i class="end-time"><fmt:formatDate pattern="dd/MM/yyyy"
                                                                                   value="${course.end_time}"/></i>
                                            </span>
                                            </div>
                                        </div>
                                        <div class="progress rounded mt-2" style="height: 7px;">
                                            <div class="progress-bar" role="progressbar"
                                                 aria-valuenow=""
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/progress.js"></script>
</body>
</html>
