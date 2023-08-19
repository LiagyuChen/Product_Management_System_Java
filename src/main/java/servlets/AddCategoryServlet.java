package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Model;
import model.ModelFactory;

@WebServlet(urlPatterns = "/addCategory.html")
public class AddCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        String listName = request.getParameter("addCategoryName");
        try {
            model.createCategory(listName);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("http://localhost:8080/index.html");
    }
}

