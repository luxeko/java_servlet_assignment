package com.example.usermanager.Controllers;

import com.example.usermanager.Models.CourseModel;
import com.example.usermanager.Models.UserModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseController {
    String url = "jdbc:mysql://localhost:3308/servlet_usermanager";
    String username = "root";
    String password = "";

    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("connect successfully!");
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return conn;
    }

    public List<CourseModel> getAll(int userId) {
        List<CourseModel> courses = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement =
                connection.prepareStatement("SELECT * FROM courses WHERE id NOT IN (SELECT users_courses.courseId FROM users_courses WHERE users_courses.userId = ?);");) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String code = resultSet.getString("code");
                String name = resultSet.getString("name");
                Date start_time = resultSet.getDate("start_time");
                Date end_time = resultSet.getDate("end_time");
                CourseModel courseModel = new CourseModel();
                courseModel.setId(id);
                courseModel.setCode(code);
                courseModel.setName(name);
                courseModel.setStart_time(new java.sql.Date(start_time.getTime()));
                if (end_time != null) {
                    courseModel.setEnd_time(new java.sql.Date(end_time.getTime()));
                }
                courses.add(courseModel);
            }
            resultSet.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return courses;
    }

    public void create(CourseModel courseModel) {
        Connection connection = getConnection();
        String insert = "insert into courses(code, name, start_time, end_time) values(?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(insert);
            ps.setString(1, courseModel.getCode());
            ps.setString(2, courseModel.getName());
            ps.setDate(3, new java.sql.Date(courseModel.getStart_time().getTime()));
            ps.setDate(4, new java.sql.Date(courseModel.getEnd_time().getTime()));
            ps.execute();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public CourseModel getCourseById(int id) {
        Connection connection = getConnection();
        String sql = "select * from courses where id = ?";
        CourseModel courseModel = new CourseModel();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String code = resultSet.getString("code");
                String name = resultSet.getString("name");
                Date start_time = resultSet.getDate("start_time");
                Date end_time = resultSet.getDate("end_time");

                courseModel.setId(id);
                courseModel.setCode(code);
                courseModel.setName(name);
                courseModel.setStart_time(new java.sql.Date(start_time.getTime()));
                if (end_time != null) {
                    courseModel.setEnd_time(new java.sql.Date(end_time.getTime()));
                }
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return courseModel;
    }

    public void update(CourseModel courseModel) {
        Connection connection = getConnection();
        String update = "update courses set code = ?, name = ?, start_time = ?, end_time = ? where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(update);
            ps.setString(1, courseModel.getCode());
            ps.setString(2, courseModel.getName());
            ps.setDate(3, new java.sql.Date(courseModel.getStart_time().getTime()));
            ps.setDate(4, new java.sql.Date(courseModel.getEnd_time().getTime()));
            ps.setInt(5, courseModel.getId());
            ps.execute();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public void delete(int id) {
        Connection connection = getConnection();
        String sql = "delete from courses where id = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            preparedStatement.execute();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void createUserCourse(int userId, int courseId) {
        Connection connection = getConnection();
        String insert = "insert into users_courses(userId, courseId) values(?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(insert);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.execute();
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public List<String> getCourseNameByUserId(int userId) {
        Connection connection = getConnection();
        List<String> arrlist = new ArrayList<>();
        String select = "SELECT courses.name FROM courses INNER " +
                "JOIN " +
                "users_courses on" +
                " courses.id = " +
                "users_courses" +
                ".courseId INNER JOIN users ON users.id = users_courses.userId WHERE users.id = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(select);
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                arrlist.add(resultSet.getString("name"));
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return arrlist;
    }
    public List<CourseModel> getCourseByUserId(int userId) {
        Connection connection = getConnection();
        List<CourseModel> courses = new ArrayList<>();
        String select = "SELECT courses.id, courses.name, courses.code, courses.start_time, courses.end_time FROM " +
                "courses INNER " +
                "JOIN " +
                "users_courses on" +
                " courses.id = " +
                "users_courses" +
                ".courseId INNER JOIN users ON users.id = users_courses.userId WHERE users.id = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(select);
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String code = resultSet.getString("code");
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                Date end_time = resultSet.getDate("end_time");
                Date start_time = resultSet.getDate("start_time");
                CourseModel courseModel = new CourseModel();
                courseModel.setId(id);
                courseModel.setCode(code);
                courseModel.setName(name);
                courseModel.setStart_time(new java.sql.Date(start_time.getTime()));
                if (end_time != null) {
                    courseModel.setEnd_time(new java.sql.Date(end_time.getTime()));
                }
                courses.add(courseModel);
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return courses;
    }
}
