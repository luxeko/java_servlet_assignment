package com.example.usermanager.Servlet;

import com.example.usermanager.Controllers.UserController;
import com.example.usermanager.Models.UserModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    UserController userController;

    @Override
    public void init() throws ServletException {
        userController = new UserController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("UserServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean checkLogin = userController.login(email, password);
        if (checkLogin) {
            UserModel userModel = userController.getRoleByEmail(email);
            HttpSession session = request.getSession();
            session.setAttribute("current_user", email);
            session.setAttribute("role", userModel.getRole());
            session.setAttribute("userId", userModel.getId());
            doGet(request, response);
        } else {
            request.setAttribute("error_login", "Login fail");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }

    }
}
