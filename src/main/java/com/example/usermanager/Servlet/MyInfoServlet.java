package com.example.usermanager.Servlet;

import com.example.usermanager.Controllers.CourseController;
import com.example.usermanager.Controllers.UserController;
import com.example.usermanager.Models.CourseModel;
import com.example.usermanager.Models.UserModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyInfoServlet", value = "/MyInfoServlet")
public class MyInfoServlet extends HttpServlet {
    UserController userController;
    CourseController courseController;

    @Override
    public void init() throws ServletException {
        userController = new UserController();
        courseController = new CourseController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId;
        String action = request.getParameter("action");
        if (action != null && action.equals("preview")) {
            userId = Integer.parseInt(request.getParameter("id"));
        } else {
            userId = (int) session.getAttribute("userId");
        }
        UserModel userModel = userController.getUserById(userId);
        List<CourseModel> courses = courseController.getCourseByUserId(userId);
        request.setAttribute("user", userModel);
        request.setAttribute("courses", courses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("myInfo.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
    }
}
