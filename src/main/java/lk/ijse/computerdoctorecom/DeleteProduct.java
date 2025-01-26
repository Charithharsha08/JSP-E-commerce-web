package lk.ijse.computerdoctorecom;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "DeleteProduct", value = "/delete-Product")
public class DeleteProduct extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM product WHERE id = ?");
            preparedStatement.setInt(1, Integer.parseInt(req.getParameter("id")));
            int i = preparedStatement.executeUpdate();
            connection.close();
            if (i > 0) {
                resp.sendRedirect("product.jsp?message=Product deleted successfully");
            } else {
                resp.sendRedirect("product.jsp?error=Product deletion failed");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
