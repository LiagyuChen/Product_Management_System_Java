package servlets;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

import model.Model;
import model.ModelFactory;

@WebServlet("/renameCategory.html")
public class RenameCategoryServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        int cateID = Integer.parseInt(request.getParameter("renameCateID"));
        String newCateName = request.getParameter("new-cate-name");

        try {
            model.renameCategory(cateID, newCateName);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("http://localhost:8080/index.html");
    }
}

