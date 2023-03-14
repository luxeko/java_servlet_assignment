<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Edit course</title>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"
            integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="../menu.jsp" %>
<div class="container mt-4">
    <h3><a href="CourseServlet" class="text-decoration-none text-success">Courses</a> <i class="bi bi-arrow-right"></i>
        Edit
        course</h3>
    <form action="CourseServlet?id=<c:out value="${course.id}"></c:out>" method="POST" id="updateCourse">
        <div class="mb-3" id="input_name">
            <label for="name" class="form-label"><span class="text-danger">*</span>Name</label>
            <input type="text" class="form-control" name="name" id="name" value="<c:out value="${course.name}"></c:out>">
        </div>
        <div class="mb-3" id="input_code">
            <label for="code" class="form-label"><span class="text-danger">*</span>Code</label>
            <input type="text" class="form-control" name="code" id="code" value="<c:out value="${course.code}"></c:out>">
        </div>
        <div class="row mb-3">
            <div class="col-3" id="input_start-time">
                <label for="start_time" class="form-label"><span class="text-danger">*</span>Start time</label>
                <input type="date" class="form-control" name="start_time" id="start_time" value="<c:out
                value="${course.start_time}"></c:out>">
            </div>
            <div class="col-3" id="input_end-time">
                <label for="end_time" class="form-label"><span class="text-danger">*</span>End time</label>
                <input type="date" class="form-control" name="end_time" id="end_time" value="<c:out
                value="${course.end_time}"></c:out>">
            </div>
        </div>
        <div class="mt-4 d-flex justify-content-start">
            <button type="reset" class="btn btn-light me-3"><i class="bi bi-arrow-clockwise"></i> Reset</button>
            <button type="submit" class="btn btn-success"><i class="bi bi-plus-lg"></i>
                Update
            </button>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
</body>
</html>
