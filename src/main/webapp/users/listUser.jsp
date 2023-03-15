<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>List User</title>
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
<%@include file="../menu.jsp" %>
<c:if test="${sessionScope.success != null }">
    <div id="toast" data-value="${sessionScope.success}"></div>
</c:if>
<%
    session.removeAttribute("success");
%>
<div class="container py-5">
    <div class="mb-3 d-flex justify-content-between align-items-start">
        <div>
            <a href="UserServlet?action=add" class="btn btn-success"><i class="bi
		bi-plus-lg"></i> Add user</a>
        </div>
        <div>
            <form action="UserServlet" method="GET" class="d-flex" role="search">
                <input class="form-control me-2" name="search" type="search" placeholder="Search..."
                       aria-label="Search">
                <button class="btn btn-outline-success me-2" type="submit">Search</button>
                <a href="UserServlet" class="btn btn-outline-danger" type="submit">Reset</a>
            </form>
        </div>
    </div>
    <table class="table table-bordered">
        <thead class="table-secondary">
        <tr>
            <th scope="col">#</th>
            <th scope="col">Name</th>
            <th scope="col">Email</th>
            <th scope="col">Role</th>
            <th scope="col">Country</th>
            <th scope="col">Courses</th>
            <th class="text-center" scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user" varStatus="loop">
            <tr>
                <th scope="row" class="align-middle"><c:out value="${loop.index + 1}"/></th>
                <td class="align-middle"><c:out value="${user.name}"/></td>
                <td class="align-middle"><c:out value="${user.email}"/></td>
                <td class="align-middle"><c:out value="${user.role}"/></td>
                <td class="align-middle"><c:out value="${user.country}"/></td>
                <td class="align-middle" style="width: 400px">
                    <c:forEach items="${user.courseName}" var="course">
                        <span class="badge text-bg-success p-2 mb-1">${course}</span>
                    </c:forEach>
                </td>
                <td class="align-middle">
                    <div class="d-flex justify-content-center align-items-center">
                        <a href="MyInfoServlet?action=preview&id=${user.id}"
                           class="btn btn-primary text-white me-2"><i class="bi bi-eye"></i></a>
                        <a href="UserServlet?action=edit&id=${user.id}"
                           class="btn btn-warning text-white me-2"><i class="bi bi-pencil"></i></a>
                        <a onclick="return confirm('Are you sure you want to delete ${user.name}?')"
                           href="UserServlet?action=delete&id=${user.id}"
                           class="btn btn-danger"><i class="bi bi-trash"></i></a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/newToast.js"></script>
<script>
    const el = document.getElementById('toast')
    if (el !== null) {
        toast({
            title: 'Success',
            message: el.dataset.value,
            type: 'success',
            duration: 5000
        });
    }
</script>
</body>
</html>
