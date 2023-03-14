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
    public void init() throws ServletException {
        courseController = new CourseController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("courses/addCourse.jsp");
                dispatcher.forward(request, response);
            } else if (action.equals("edit")) {
                CourseModel courseModel = courseController.getCourseById(Integer.parseInt(id));
                request.setAttribute("course", courseModel);
                RequestDispatcher dispatcher = request.getRequestDispatcher("courses/editCourse.jsp");
                dispatcher.forward(request, response);
            } else if (action.equals("signIn")) {
                HttpSession session = request.getSession();
                int userId = (int) session.getAttribute("userId");
                courseController.createUserCourse(userId, Integer.parseInt(id));
                response.sendRedirect("CourseServlet");
            } else {
                courseController.delete(Integer.parseInt(id));
                response.sendRedirect("CourseServlet");
            }
        } else {
            List<CourseModel> courses = courseController.getAll();
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
        }
        response.sendRedirect("CourseServlet");
    }
}
