package servlets;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

import model.Model;
import model.ModelFactory;

@WebServlet("/deleteCategory.html")
public class DeleteCategoryServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();
        int listID = Integer.parseInt(request.getParameter("deleteCategoryID"));

        try {
            model.deleteCategory(listID);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("http://localhost:8080/index.html");
    }
}

