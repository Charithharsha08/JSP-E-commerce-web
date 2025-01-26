package lk.ijse.computerdoctorecom;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.computerdoctorecom.DTO.Category;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetCategory", value = "/GetCategory")
public class GetCategory extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       try {
           Connection connection = dataSource.getConnection();
           PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM category");
           ResultSet resultSet = preparedStatement.executeQuery();
           List<Category> categoryList = new ArrayList<>();

           while (resultSet.next()) {
               int id = resultSet.getInt("category_id");
               String name = resultSet.getString("name");
               String image = resultSet.getString("image");
               categoryList.add(new Category(id,name,image));
               System.out.println(id+" "+name+" "+image +" me category");
           }
           req.getServletContext().setAttribute("categoryCard", categoryList);
           req.getRequestDispatcher("product-page.jsp").forward(req, resp);
           connection.close();
       } catch (Exception e) {
           e.printStackTrace();
       }
    }
}