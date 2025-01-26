package lk.ijse.computerdoctorecom;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.computerdoctorecom.DTO.Product;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetProduct", value = "/get-product")
public class GetProduct extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM products");
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Product> productList = new ArrayList<>();
            while (resultSet.next()) {
                int id = resultSet.getInt("product_id");
                String name = resultSet.getString("product_name");
                String description = resultSet.getString("product_description");
                String image = resultSet.getString("product_image");
                int category = Integer.parseInt(resultSet.getString("category_id"));
                int qty = resultSet.getInt("product_qty");
                double price = resultSet.getInt("product_price");
                productList.add(new Product(id,name, description, image, qty, price,category));
                System.out.println(id+" "+name+" "+description+" "+image+" "+category+" "+qty+" "+price);
            }
            for (Product product : productList) {
                System.out.println(product);
            }
            req.getServletContext().setAttribute("productList", productList);
            req.getRequestDispatcher("product-page.jsp").forward(req, resp);
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
