package servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import model.categories.CategoryProducts;
import model.Model;
import model.ModelFactory;

@WebServlet("/categoryProduct.html")
public class ViewProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        String idParam = request.getParameter("cateid");

        CategoryProducts category = model.GetCategoryByID(Integer.parseInt(idParam));

        request.setAttribute("category", category);
        request.setAttribute("cateid", idParam);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/categoryProduct.jsp");
        dispatcher.forward(request, response);
    }
}

