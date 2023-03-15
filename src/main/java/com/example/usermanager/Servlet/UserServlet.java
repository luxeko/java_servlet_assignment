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
        HttpSession session = request.getSession();
        if (action != null) {
            if (action.equals("add")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("users/addUser.jsp");
                dispatcher.forward(request, response);
            } else if (action.equals("edit")) {
                UserModel userModel = userController.getUserById(Integer.parseInt(id));
                request.setAttribute("user", userModel);
                RequestDispatcher dispatcher = request.getRequestDispatcher("users/editUser.jsp");
                dispatcher.forward(request, response);
            } else {
                userController.delete(Integer.parseInt(id));
                session.setAttribute("success", "Delete success");
                response.sendRedirect("UserServlet");
            }
        } else {
            String search = request.getParameter("search");
            if (search != null && !search.equals("")) {
                List<UserModel> users = userController.getUserByRequest(search);
                for (UserModel user: users) {
                    List<String> array = courseController.getCourseNameByUserId(user.getId());
                    user.setCourseName(array);
                }
                request.setAttribute("users", users);
                RequestDispatcher dispatcher = request.getRequestDispatcher("users/listUser.jsp");
                dispatcher.forward(request, response);
            } else {
                List<UserModel> users = userController.getAll();
                for (UserModel user: users) {
                    List<String> array = courseController.getCourseNameByUserId(user.getId());
                    user.setCourseName(array);
                }
                request.setAttribute("users", users);
                RequestDispatcher dispatcher = request.getRequestDispatcher("users/listUser.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String country = request.getParameter("country");
        String role = request.getParameter("role");
        String id = request.getParameter("id");
        HttpSession session = request.getSession();
        if (id != null && !id.equals("")) {
            // update
            UserModel userModel = userController.getUserById(Integer.parseInt(id));
            userModel.setName(name);
            userModel.setCountry(country);
            userModel.setRole(role);
            userController.update(userModel);
            session.setAttribute("success", "Update success");
        } else {
            UserModel userModel = new UserModel();
            userModel.setEmail(email);
            userModel.setName(name);
            userModel.setCountry(country);
            userModel.setPassword(password);
            userModel.setRole(role);
            userController.create(userModel);
            session.setAttribute("success", "Create success");
        }
        response.sendRedirect("UserServlet");
    }
}
