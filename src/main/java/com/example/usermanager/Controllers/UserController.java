package com.example.usermanager.Controllers;

import com.example.usermanager.Models.CourseModel;
import com.example.usermanager.Models.UserModel;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserController {
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

    public static String encryptThisString(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] messageDigest = md.digest(input.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            StringBuilder hashText = new StringBuilder(no.toString(16));
            while (hashText.length() < 32) {
                hashText.insert(0, "0");
            }
            return hashText.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean login(String email, String password) {
        String hasPassword = encryptThisString(password);
        String sql = "select * from users where email = ? and password = ?";
        Connection connection = getConnection();
        boolean check = false;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hasPassword);
            ResultSet resultSet = ps.executeQuery();
            while (resultSet.next()) {
                check = true;
                break;
            }
            ps.close();
            resultSet.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return check;
    }

    public List<UserModel> getAll() {
        List<UserModel> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("select * from users");) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");

                users.add(new UserModel(id, name, email, country));
            }
            resultSet.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }

    public void create(UserModel userModel) {
        Connection connection = getConnection();
        String insert = "insert into users(name, email, password, country) values(?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
            String hasPassword = encryptThisString(userModel.getPassword());
            ps.setString(1, userModel.getName());
            ps.setString(2, userModel.getEmail());
            ps.setString(3, hasPassword);
            ps.setString(4, userModel.getCountry());

            ps.execute();
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                userModel.setId(generatedKeys.getInt(1));
            }
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

    public UserModel getUserById(int id) {
        Connection connection = getConnection();
        String sql = "select * from users where id = ?";
        UserModel userModel = new UserModel();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String country = resultSet.getString("country");
                String password = resultSet.getString("password");

                userModel.setId(id);
                userModel.setName(name);
                userModel.setCountry(country);
                userModel.setPassword(password);
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return userModel;
    }

    public void update(UserModel userModel) {
        Connection connection = getConnection();
        String update = "update users set name = ?, country = ?, password = ? where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(update);
            ps.setString(1, userModel.getName());
            ps.setString(2, userModel.getCountry());
            ps.setString(3, userModel.getPassword());
            ps.setInt(4, userModel.getId());
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
        String sql = "delete from users where id = ?";
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
}
