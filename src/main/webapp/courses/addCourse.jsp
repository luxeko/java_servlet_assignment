<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Add course</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet" type="text/css"/>
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
        Add
        course</h3>
    <form action="CourseServlet" method="POST" id="createCourse">
        <div class="mb-3" id="input_name">
            <label for="name" class="form-label"><span class="text-danger">*</span>Name</label>
            <input type="text" class="form-control" name="name" id="name">
        </div>
        <div class="mb-3" id="input_code">
            <label for="code" class="form-label"><span class="text-danger">*</span>Code</label>
            <input type="text" class="form-control" name="code" id="code">
        </div>
        <div class="row mb-3">
            <div class="col-3" id="input_start-time">
                <label for="start_time" class="form-label"><span class="text-danger">*</span>Start time</label>
                <input type="date" class="form-control" name="start_time" id="start_time">
            </div>
            <div class="col-3" id="input_end-time">
                <label for="end_time" class="form-label"><span class="text-danger">*</span>End time</label>
                <input type="date" class="form-control" name="end_time" id="end_time">
            </div>
        </div>
        <div class="mt-4 d-flex justify-content-start">
            <button type="reset" class="btn btn-light me-3"><i class="bi bi-arrow-clockwise"></i> Reset</button>
            <button type="submit" class="btn btn-success"><i class="bi bi-plus-lg"></i>
                Create
            </button>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        let name = ''
        let code = ''
        let start_time = ''
        let end_time = ''
        $('#name').on('input', function () {
            name = $(this).val();
            console.log(name)
        })
        $('#code').on('input', function () {
            code = $(this).val();
            console.log(code)
        })
        $('#start_time').on('input', function () {
            start_time = $(this).val();
            console.log(start_time)
        })
        $('#end_time').on('input', function () {
            end_time = $(this).val();
            console.log(end_time)
        })
        $('#createCourse').on('submit', function (e) {
            e.preventDefault();
            $('.error_name').remove();
            $('.error_code').remove();
            $('.error_start-time').remove();
            $('.error_end-time').remove();

            if (handleCheckValid(name, code, start_time, end_time)) {
                this.submit();
            }
        })
        const handleCheckValid = (name, code, start_time, end_time) => {
            if (!name || name.trim() === "") {
                $('#input_name').append('<span style="font-size: 13px" class="text-danger error_name">*Please enter name of course</span>')
                return false;
            } else if (!code || code.trim() === "") {
                $('#input_code').append('<span style="font-size: 13px" class="text-danger error_name">*Please enter code of course</span>')
                return false;
            } else if (!start_time || start_time.trim() === "") {
                $('#input_start-time').append('<span style="font-size: 13px" class="text-danger error_start-time">*Please enter start time</span>')
                return false;
            } else if (!end_time || end_time.trim() === "") {
                $('#input_end-time').append('<span style="font-size: 13px" class="text-danger error_end-time">*Please enter end time</span>')
                return false;
            }
            return true;
        }
    })
</script>
</body>
</html>
