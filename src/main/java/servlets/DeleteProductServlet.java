package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Model;
import model.ModelFactory;

@WebServlet(urlPatterns = "/deleteProduct.html")
public class DeleteProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        String lsid = request.getParameter("deleteCategoryID");
        int cateID = Integer.parseInt(lsid);
        int productID = Integer.parseInt(request.getParameter("deleteProductID"));

        try {
            model.removeProduct(cateID, productID);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect("http://localhost:8080/categoryProduct.html?cateid=" + lsid);
    }
}


