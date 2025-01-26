package lk.ijse.computerdoctorecom;

import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.sql.DataSource;

@WebServlet(name = "signUpServlet", value = "/sign-up")
public class SignUpServlet extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String encryptedPassword = new BCryptPasswordEncoder().encode(req.getParameter("password"));
        String type = "USER";
        System.out.println(name+" "+email+" "+encryptedPassword);
        try {

            Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO user ( email,name, password,type) VALUES (?, ?, ?,?)");
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, name);
            preparedStatement.setString(3, encryptedPassword);
            preparedStatement.setString(4,type);

            // Execute query and check result
            int i = preparedStatement.executeUpdate();
            connection.close();
            if (i > 0) {
                resp.sendRedirect("sign-up-page.jsp?message=Account created successfully");
            } else {
                resp.sendRedirect("sign-up-page.jsp?error=Account creation failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("sign-up-page.jsp?error=An error occurred");
        }
    }

}