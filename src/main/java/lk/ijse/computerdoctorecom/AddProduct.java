package lk.ijse.computerdoctorecom;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import javax.sql.DataSource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)

@WebServlet(name = "AddProduct", value = "/add-product")
public class AddProduct extends HttpServlet {
    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("add product Called");
        try {
            String name = req.getParameter("productName");
            System.out.println(name);
            String description = req.getParameter("description");
            System.out.println(description);
            int qty = Integer.parseInt(req.getParameter("qty"));
            System.out.println(qty);
            double price = Double.parseDouble(req.getParameter("price"));
            int categoryID = Integer.parseInt(req.getParameter("category"));
            System.out.println(categoryID +"this is category ID");
            System.out.println(name + " " + description + " " + qty + " " + price + " " );

            Part filepart = req.getPart("productImage");
            String imageFileName = filepart.getSubmittedFileName();

            String uploadDir = "/Users/charithharsha/Documents/projects /advance API development/computerDoctorEcom/src/main/webapp/assets/images/products";
            File imageFile = new File(uploadDir + File.separator + imageFileName);

            String location = "assets/images/products/" + imageFileName;

            try (InputStream inputStream = filepart.getInputStream()){
                Files.copy(inputStream, imageFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO products (product_name,product_image,product_description,product_qty,product_price,category_id) VALUES (?,?,?,?,?,?)");
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, location);
            preparedStatement.setString(3, description);
            preparedStatement.setInt(4, qty);
            preparedStatement.setDouble(5, price);
            preparedStatement.setInt(6, categoryID);
            int i = preparedStatement.executeUpdate();
            connection.close();
            if (i > 0) {

                resp.sendRedirect("product-page.jsp?productAdded=Product Save Success&action=get-product");
                System.out.println("Product saved");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
