package servlets;

import java.io.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.categories.*;
import model.Model;
import model.ModelFactory;

@WebServlet("/index.html")
public class ViewCategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        List<CategoryProducts> cates = model.GetAllCates();

        request.setAttribute("categories", cates);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }
}

