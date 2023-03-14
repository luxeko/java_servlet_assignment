<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Add user</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <link href="${pageContext.request.contextPath}/css/select.css" rel="stylesheet" type="text/css">
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
    <h3><a href="UserServlet" class="text-decoration-none text-success">Users</a> <i class="bi bi-arrow-right"></i> Add
        user</h3>
    <form action="UserServlet" method="POST" id="createUser" enctype="application/x-www-form-urlencoded">
        <div class="mb-3" id="input_email">
            <label for="email" class="form-label"><span class="text-danger">*</span>Email</label>
            <input type="email" class="form-control" name="email" id="email">
        </div>
        <div class="mb-3" id="input_name">
            <label for="name" class="form-label"><span class="text-danger">*</span>Username</label>
            <input type="text" class="form-control" name="name" id="name">
        </div>
        <div class="mb-3">
            <label for="country" class="form-label">Country</label>
            <input type="text" class="form-control" name="country" id="country">
        </div>
        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" name="role" id="role">
                <option value="" selected>Choose</option>
                <option value="student">Student</option>
                <option value="admin">Admin</option>
            </select>
        </div>
        <div class="mb-3" id="input-password">
            <label for="password" class="form-label"><span class="text-danger">*</span>Password</label>
            <input type="password" class="form-control" name="password" id="password">
        </div>
        <div class="mb-3" id="input_re-password">
            <label for="re-password" class="form-label"><span class="text-danger">*</span>Re-Password</label>
            <input type="password" class="form-control" id="re-password">
        </div>
        <div class="mt-4 d-flex justify-content-start">
            <button type="reset" class="btn btn-light  me-3"><i class="bi bi-arrow-clockwise"></i> Reset</button>
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
        let email = ''
        let name = ''
        let password = ''
        let rePassword = ''
        $('#email').on('input', function () {
            email = $(this).val();
        })
        $('#name').on('input', function () {
            name = $(this).val();
        })
        $('#password').on('input', function () {
            password = $(this).val();
        })
        $('#re-password').on('input', function () {
            rePassword = $(this).val();
        })
        $('#createUser').on('submit', function (e) {
            e.preventDefault();
            $('.error_email').remove();
            $('.error_password').remove();
            $('.error_name').remove();
            if (handleCheckValid(email, name, password, rePassword)) {
                this.submit();
            }
        })
        const handleCheckValid = (email, name, password, rePassword) => {
            if (!email || email.trim() === "" || !validateEmail(email)) {
                console.log(validateEmail(email));
                $('#input_email').append('<span style="font-size: 13px" class="text-danger error_email">*Invalid email</span>')
                return false;
            } else if (!name || name.trim() === "") {
                $('#input_name').append('<span style="font-size: 13px" class="text-danger error_name">*Please enter your name</span>')
                return false;
            } else if (!password || password.trim() === "") {
                $('#input-password').append('<span style="font-size: 13px" class="text-danger error_password">*Please enter your password</span>')
                return false;
            } else if (rePassword.trim() !== password.trim()) {
                $('#input_re-password').append('<span style="font-size: 13px" class="text-danger error_password">*Re-entered password is incorrect</span>')
                return false;
            }
            return true;
        }
        const validateEmail = (email) => {
            return email.toLowerCase().match(
                /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            );
        };
    });
</script>
</body>
</html>
