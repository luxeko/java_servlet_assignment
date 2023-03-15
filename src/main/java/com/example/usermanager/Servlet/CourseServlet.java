package com.example.usermanager.Servlet;

import com.example.usermanager.Controllers.CourseController;
import com.example.usermanager.Models.CourseModel;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "CourseServlet", value = "/CourseServlet")
public class CourseServlet extends HttpServlet {
    CourseController courseController;

    @Override
    public void init(){
        courseController = new CourseController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        if (action != null) {
            switch (action) {
                case "add": {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("courses/addCourse.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
                case "edit": {
                    CourseModel courseModel = courseController.getCourseById(Integer.parseInt(id));
                    request.setAttribute("course", courseModel);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("courses/editCourse.jsp");
                    dispatcher.forward(request, response);
                    break;
                }
                case "signUp":
                    int userId = (int) session.getAttribute("userId");
                    courseController.createUserCourse(userId, Integer.parseInt(id));
                    session.setAttribute("success", "Sign up success");
                    response.sendRedirect("CourseServlet");
                    break;
                default:
                    courseController.delete(Integer.parseInt(id));
                    session.setAttribute("success", "Delete success");
                    response.sendRedirect("CourseServlet");
                    break;
            }
        } else {
            int userId = (int) session.getAttribute("userId");
            List<CourseModel> courses = courseController.getAll(userId);
            request.setAttribute("courses", courses);
            RequestDispatcher dispatcher = request.getRequestDispatcher("courses/listCourse.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String start_time = request.getParameter("start_time");
        String end_time = request.getParameter("end_time");
        String id = request.getParameter("id");
        HttpSession session = request.getSession();
        if (id != null && !id.equals("")) {
            // update
            CourseModel courseModel = courseController.getCourseById(Integer.parseInt(id));
            courseModel.setName(name);
            courseModel.setCode(code);
            try {
                courseModel.setStart_time(new SimpleDateFormat("yyyy-MM-dd").parse(start_time));
                courseModel.setEnd_time(new SimpleDateFormat("yyyy-MM-dd").parse(end_time));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            courseController.update(courseModel);
            session.setAttribute("success", "Update success");
        } else {
            CourseModel courseModel = new CourseModel();
            courseModel.setCode(code);
            courseModel.setName(name);
            try {
                courseModel.setStart_time(new SimpleDateFormat("yyyy-MM-dd").parse(start_time));
                courseModel.setEnd_time(new SimpleDateFormat("yyyy-MM-dd").parse(end_time));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
            courseController.create(courseModel);
            session.setAttribute("success", "Create success");
        }
        response.sendRedirect("CourseServlet");
    }
}
