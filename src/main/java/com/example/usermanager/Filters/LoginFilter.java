package com.example.usermanager.Filters;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "LoginFilter", urlPatterns = "/*")
public class LoginFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        String contextPath = request.getServletContext().getContextPath();

        HttpServletResponse resp = (HttpServletResponse) response;
        HttpServletRequest req = (HttpServletRequest) request;
        String path = req.getServletPath();
        HttpSession session = req.getSession();

        System.out.println("Start filter " + contextPath + " - " + path);
        System.out.println("End filter");
        if (path.endsWith("css") || path.endsWith("js") || path.contains("LoginServlet") || path.contains("LogoutServlet")) {
            // ko lam gi
            chain.doFilter(request, response);
        } else {
            String currentUser = (String) session.getAttribute("current_user");
            String role = (String) session.getAttribute("role");
            if (currentUser == null || currentUser.equals("")) {
                // chua login
                if (path.contains("index.jsp")) {
                    chain.doFilter(request, response);
                } else {
                    resp.sendRedirect("index.jsp");
                }
            } else if (path.contains("index.jsp")) {
                if (role.equals("admin")) {
                    resp.sendRedirect("UserServlet");
                } else {
                    resp.sendRedirect("CourseServlet");
                }
            } else if (path.contains("UserServlet")) {
                if (role.equals("admin")) {
                    chain.doFilter(request, response);
                } else {
                    resp.sendRedirect("CourseServlet");
                }
            } else {
                chain.doFilter(request, response);
            }
        }

    }
}
