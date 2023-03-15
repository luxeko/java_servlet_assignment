<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Edit user</title>
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
<div class="container py-5">
    <h3><a href="UserServlet" class="text-decoration-none text-success">Users</a> <i class="bi bi-arrow-right"></i> Edit
        user</h3>
    <form action="UserServlet?id=${user.id}" method="POST" id="createUser">
        <div class="mb-3" id="input_name">
            <label for="name" class="form-label"><span class="text-danger">*</span>Username</label>
            <input type="text" class="form-control" name="name" id="name" value="${user.name}">
        </div>
        <div class=" mb-3">
            <label for="country" class="form-label">Country</label>
            <input type="text" class="form-control" name="country" id="country" value="${user.country}">
        </div>
        <div class=" mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-select" name="role" id="role">
                <c:choose>
                    <c:when test="${user.role != null && user.role == 'admin'}">
                        <option value="student">Student</option>
                        <option value="admin" selected>Admin</option>
                    </c:when>
                    <c:otherwise>
                        <option value="student" selected>Student</option>
                        <option value="admin">Admin</option>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>
        <div class="mt-4 d-flex justify-content-start">
            <button type="reset" class="btn btn-light  me-3"><i class="bi bi-arrow-clockwise"></i> Reset</button>
            <button type="submit" class="btn btn-success"><i class="bi bi-plus-lg"></i>
                Update
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

        $('#name').on('input', function () {
            name = $(this).val();
        })
        $('#createUser').on('submit', function (e) {
            e.preventDefault();
            $('.error_name').remove();
            if (handleCheckValid(name)) {
                this.submit();
            }
        })
        const handleCheckValid = (name) => {
            if (!name || name.trim() === "") {
                $('#input_name').append('<span style="font-size: 13px" class="text-danger error_name">*Please enter your name</span>')
                return false;
            }
            return true;
        }
    });
</script>
</body>
</html>
