package servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ModelFactory;
import model.categories.*;
import model.Model;

@WebServlet(urlPatterns = "/searchElement.html")
public class SearchElementServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        String searchQuery = request.getParameter("searchQuery");

        if (searchQuery.contains("C")) {
            // search item
            if (searchQuery.contains("P")) {
                int itemIdIndex = searchQuery.indexOf("P");
                int listID = Integer.parseInt(searchQuery.substring(1, itemIdIndex));
                int itemID = Integer.parseInt(searchQuery.substring(itemIdIndex + 1));
                ProductInterface searchedItem = model.GetProductByID(itemID);
                if (searchedItem != null) {
                    response.sendRedirect("http://localhost:8080/categoryProduct.html?cateid=" + listID + "#productContainer"+itemID);
                } else {
                    request.setAttribute("searchResult", "1");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                // search list
                int searchedID = Integer.parseInt(searchQuery.substring(1));
                CategoryProducts searchedList = model.GetCategoryByID(searchedID);
                if (searchedList != null) {
                    response.sendRedirect("http://localhost:8080/categoryProduct.html?cateid=" + searchedID);
                } else {
                    request.setAttribute("searchResult", "1");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } else {
            // invalid search
            try {
                throw new Exception("Invalid Search Format!");
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }
}

