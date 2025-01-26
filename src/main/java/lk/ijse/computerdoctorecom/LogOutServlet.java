package lk.ijse.computerdoctorecom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet(name = "logOutServlet", value = "/logout")
public class LogOutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("logout triggered");
        // Remove the user attribute from the application context
        req.getServletContext().removeAttribute("user");

        // Set response status and optionally a message
        resp.setStatus(HttpServletResponse.SC_OK);

        // Optionally redirect to a login page or send a response message
        resp.getWriter().write("Logged out successfully");
    }
}
