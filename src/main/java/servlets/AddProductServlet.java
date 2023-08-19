package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Objects;

import model.Model;
import model.ModelFactory;

@WebServlet(urlPatterns = "/addProduct.html")
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Model model = ModelFactory.getModel();

        String newProductName = request.getParameter("product-name");
        String cateid = request.getParameter("cateID");
        String cateName = model.GetCategoryByID(Integer.parseInt(cateid)).getName();
        String newProductStore = request.getParameter("product-store");
        String newProductImg = request.getParameter("product-image");
        int newProductStockValue = Integer.parseInt(request.getParameter("product-stock"));
        float newProductReview = Float.parseFloat(request.getParameter("product-review"));
        int newProductStyleNum = Integer.parseInt(request.getParameter("product-style-num"));
        String newPStyleNumM = request.getParameter("product-style-num-multiple");

        if (Objects.equals(newPStyleNumM, "") || newPStyleNumM == null) {
            // Single Style Product
            try {
                String newContent = request.getParameter("product-content");
                model.addProduct(cateName, newProductName, newProductStore, newProductImg, newProductStyleNum, newProductStockValue, newProductReview, newContent);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        } else {
            // Multiple Styles Products
            newProductStyleNum = Integer.parseInt(newPStyleNumM);
            HashMap<String, String> elementMap = new HashMap<>();
            String styleNames = request.getParameter("style-name" );
            String styleDescs = request.getParameter("style-description");
            String[] styleNameList = styleNames.split(";");
            String[] styleDescList = styleDescs.split(";");
            if (styleNameList.length == 0 || styleDescList.length == 0 || styleNames.equals("") || styleDescs.equals("")) {
                elementMap.put("StyleName1", "");
                elementMap.put("StyleDesc1", "");
            } else {
                System.out.println("BPB");
                if (!(styleNameList.length == newProductStyleNum && styleDescList.length == newProductStyleNum)) {
                    newProductStyleNum = Math.min(styleNameList.length, styleDescList.length);
                }
                for (int i = 0; i < newProductStyleNum; i++) {
                    if (styleNameList[i] != null && !styleNameList[i].equals("")) elementMap.put("StyleName" + i, styleNameList[i]);
                    if (styleDescList[i] != null && !styleDescList[i].equals("")) elementMap.put("StyleDesc" + i, styleDescList[i]);
                }
            }
            try {
                model.addProduct(cateName, newProductName, newProductStore, newProductImg, newProductStyleNum, newProductStockValue, newProductReview, elementMap);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        response.sendRedirect("http://localhost:8080/categoryProduct.html?cateid=" + cateid);
    }
}

