package com.example.usermanager.Servlet;

import com.example.usermanager.Controllers.CourseController;
import com.example.usermanager.Controllers.UserController;
import com.example.usermanager.Models.CourseModel;
import com.example.usermanager.Models.UserModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/UserServlet")
public class UserServlet extends HttpServlet {
    UserController userController;
    CourseController courseController;

    @Override
    public void init() throws ServletException {
        userController = new UserController();
        courseController = new CourseController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String action = request.getParameter("action");
        System.out.println(action);
        if (action != null) {
            if (action.equals("add")) {
                List<CourseModel> listCourse = courseController.getAll();
                request.setAttribute("listCourse", listCourse);
                RequestDispatcher dispatcher = request.getRequestDispatcher("users/addUser.jsp");
                dispatcher.forward(request, response);
            } else if (action.equals("edit")) {
                UserModel userModel = userController.getUserById(Integer.parseInt(id));
                request.setAttribute("user", userModel);
                RequestDispatcher dispatcher = request.getRequestDispatcher("users/editUser.jsp");
                dispatcher.forward(request, response);
            } else {
                userController.delete(Integer.parseInt(id));
                response.sendRedirect("UserServlet");
            }
        } else {
            List<UserModel> users = userController.getAll();
            for (UserModel user: users) {
                List<String> array = courseController.getUserCourseByUserId(user.getId());
                user.setCourseName(array);
            }
            request.setAttribute("users", users);
            RequestDispatcher dispatcher = request.getRequestDispatcher("users/listUser.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String country = request.getParameter("country");
        String id = request.getParameter("id");
        String[] courses = request.getParameterValues("listCourse");

        if (id != null && !id.equals("")) {
            // update
            UserModel userModel = userController.getUserById(Integer.parseInt(id));
        } else {
            UserModel userModel = new UserModel();
            userModel.setEmail(email);
            userModel.setName(name);
            userModel.setCountry(country);
            userModel.setPassword(password);
            userController.create(userModel);
            int userId = userModel.getId();
            for (String course : courses) {
                courseController.createUserCourse(userId, Integer.parseInt(course));
            }
        }
        response.sendRedirect("UserServlet");
    }
}
