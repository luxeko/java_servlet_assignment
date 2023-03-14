package com.example.usermanager.Servlet;

import com.example.usermanager.Controllers.UserController;
import com.example.usermanager.Models.UserModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/UserServlet")
public class UserServlet extends HttpServlet {
    UserController userController;

    @Override
    public void init() throws ServletException {
        userController = new UserController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String action = request.getParameter("action");
        System.out.println(action);
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
                response.sendRedirect("UserServlet");
            }
        } else {
            List<UserModel> users = userController.getAll();
            request.setAttribute("users", users);
            RequestDispatcher dispatcher = request.getRequestDispatcher("users/listUser.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
