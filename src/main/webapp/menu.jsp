<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<nav class="navbar navbar-expand-lg bg-success bg-gradient">
    <div class="container-fluid">
        <c:choose>
            <c:when test="${sessionScope.role != null && sessionScope.role == 'admin'}">
                <a class="navbar-brand text-white" href="#">Admin</a>
            </c:when>
            <c:otherwise>
                <a class="navbar-brand text-white" href="#">Customer</a>
            </c:otherwise>
        </c:choose>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <c:choose>
                        <c:when test="${sessionScope.role != null && sessionScope.role == 'admin'}">
                            <a class="nav-link text-white" href="UserServlet">Users</a>
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="CourseServlet">Courses</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <c:out value="${sessionScope.current_user}"/>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="MyInfoServlet">My info</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
