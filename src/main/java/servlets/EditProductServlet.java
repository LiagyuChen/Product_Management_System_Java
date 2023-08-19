package servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Model;
import model.ModelFactory;

@WebServlet(urlPatterns = "/editProduct.html")
public class EditProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        int cateid = Integer.parseInt(request.getParameter("editCategoryID"));
        int productID = Integer.parseInt(request.getParameter("editProductID"));
        String newProductName = request.getParameter("newName");

        String newProductStore = request.getParameter("newStore");
        String newProductImg = request.getParameter("newImage");
        int newProductStockValue = Integer.parseInt(request.getParameter("newStock"));
        float newProductReview = Float.parseFloat(request.getParameter("newReview"));
        int newProductStyleNum = Integer.parseInt(request.getParameter("newStyleNum"));

        if (newProductStyleNum < 1) System.out.println("Invalid Style Num!");
        else if (newProductStyleNum == 1) {
            try {
                String newContent = request.getParameter("newContent");
                model.editProduct(cateid, productID, newProductName, newProductStore, newProductImg, newProductStyleNum, newProductStockValue, newProductReview, newContent);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else {
            HashMap<String, String> elementMap = new HashMap<>();
            String styleNames = request.getParameter("edit-style-name" );
            String styleDescs = request.getParameter("edit-style-description");
            String[] styleNameList = styleNames.split(";");
            String[] styleDescList = styleDescs.split(";");
            if (styleNameList.length <= 1 || styleDescList.length <= 1 || styleNames.equals("") || styleDescs.equals("")) {
                elementMap.put("StyleName1", "");
                elementMap.put("StyleDesc1", "");
                elementMap.put("StyleName2", "");
                elementMap.put("StyleDesc2", "");
            } else {
                if (!(styleNameList.length == newProductStyleNum && styleDescList.length == newProductStyleNum)) {
                    newProductStyleNum = Math.min(styleNameList.length, styleDescList.length);
                }
                for (int i = 0; i < newProductStyleNum; i++) {
                    if (styleNameList[i] != null && !styleNameList[i].equals("")) elementMap.put("StyleName" + i, styleNameList[i]);
                    if (styleDescList[i] != null && !styleDescList[i].equals("")) elementMap.put("StyleDesc" + i, styleDescList[i]);
                }
            }
            try {
                model.editProduct(cateid, productID, newProductName, newProductStore, newProductImg, newProductStyleNum, newProductStockValue, newProductReview, elementMap);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        response.sendRedirect("http://localhost:8080/categoryProduct.html?cateid=" + cateid);
    }
}

