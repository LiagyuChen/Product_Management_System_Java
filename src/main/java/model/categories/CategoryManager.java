package model.categories;

import com.google.gson.*;
import java.io.*;
import java.util.*;

public class CategoryManager {
    private List<CategoryProducts> productLists;
    private Gson gson;
    private int lastCategoryID = 0, lastproductID = 0;

    public CategoryManager() {
        productLists = new ArrayList<CategoryProducts>();
        gson = new GsonBuilder().setPrettyPrinting().create();
    }
    public int getLastproductID() {
        return lastproductID;
    }
    public int getLastCategoryID() {
        return lastCategoryID;
    }

    public void createCategory(String name, int ID) {
        productLists.add(new CategoryProducts(name, ID));
    }

    public void deleteCategory(CategoryProducts productList) {
        productLists.remove(productList);
    }

    public void renameCategory(CategoryProducts productList, String newName) {
        productList.setName(newName);
    }

    public void addProduct(CategoryProducts productList, ProductInterface product) {
        productList.addProduct(product);
    }

    public void removeProduct(CategoryProducts productList, ProductInterface product) {
        productList.removeProduct(product);
    }

    public void editProduct(CategoryProducts productList, ProductInterface oldProduct, ProductInterface newProduct) {
        productList.editProduct(oldProduct, newProduct);
    }

    public List<CategoryProducts> getProductCategorys() {
        return productLists;
    }

    public void loadFromFile(String filename) {
        try (Reader reader = new FileReader(filename)) {
            JsonElement jsonElement = JsonParser.parseReader(reader);
            if (jsonElement.isJsonNull() || jsonElement.isJsonPrimitive() || jsonElement.getAsJsonObject().entrySet().isEmpty()) {
                System.out.println("The file is empty or has an invalid format.");
                return;
            }

            // Get JSON File Content
            JsonObject jsonObject = jsonElement.getAsJsonObject();
            for (String cateID : jsonObject.keySet()) {
                JsonObject listObject = jsonObject.getAsJsonObject(cateID);
                int cateIDInt = Integer.parseInt(cateID);
                if (cateIDInt > lastCategoryID) lastCategoryID = cateIDInt;
                String listName = listObject.get("CategoryName").getAsString();
                CategoryProducts productList = new CategoryProducts(listName, cateIDInt);

                JsonObject productsObject = listObject.getAsJsonObject("CategoryProducts");

                // Parse The Product Information to form Product Objects
                for (String productID : productsObject.keySet()) {

                    JsonObject productObject = productsObject.getAsJsonObject(productID);

                    int ProductID = Integer.parseInt(productID);
                    if (ProductID > lastproductID) lastproductID = ProductID;

                    String ProductName = productObject.get("ProductName").getAsString();
                    String ProductStore = productObject.get("StoreName").getAsString();
                    String ProductImg = productObject.get("ProductImg").getAsString();
                    int ProductStyleNum = Integer.parseInt(productObject.get("StyleNum").getAsString());
                    int ProductStockValue = Integer.parseInt(productObject.get("StockValue").getAsString());
                    float ProductReview = Float.parseFloat(productObject.get("AverageReview").getAsString());

                    // Create Product Objects according to the number of styles
                    if (ProductStyleNum < 1) handleErrorStyleNum();
                    else if (ProductStyleNum == 1) {
                        String ProductData = productObject.get("ProductData").getAsString();
                        SingleStyleProduct product = new SingleStyleProduct(ProductID, ProductName, ProductStore, ProductImg, ProductStyleNum, ProductStockValue, ProductReview, ProductData);
                        productList.addProduct(product);
                    } else {
                        JsonObject ProductData = productObject.get("ProductData").getAsJsonObject();
                        HashMap<String, String> map = new HashMap<>();
                        for (HashMap.Entry<String, JsonElement> tempData : ProductData.entrySet()) {
                            String key = tempData.getKey();
                            String value = tempData.getValue().toString().replace("\"", "");
                            map.put(key, value);
                        }
                        MultipleStylesProduct product = new MultipleStylesProduct(ProductID, ProductName, ProductStore, ProductImg, ProductStyleNum, ProductStockValue, ProductReview, map);
                        productList.addProduct(product);
                    }
                }
                productLists.add(productList);
            }
            System.out.println("File Data Load Success!");
        } catch (IOException e) {
            System.err.println("Error: Could not read data file.");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Error: Could not parse data file!!!" + "\n" + e);
        }
        lastCategoryID++;
        lastproductID++;
    }

    public void saveToFile(String filename) {
        try (Writer writer = new FileWriter(filename)) {
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            JsonObject jsonLists = new JsonObject();
            for (CategoryProducts productList : productLists) {
                JsonObject jsonproductList = new JsonObject();
                String listName = productList.getName();
                int listID = productList.getID();
                List<ProductInterface> products = productList.getProducts();
                JsonObject jsonproducts = new JsonObject();
                for (ProductInterface product : products) {
                    // Create a new JSON object from the productLists
                    JsonObject jsonproduct = new JsonObject();
                    int productStyleNum = product.getStyleNum();
                    jsonproduct.addProperty("ProductName", product.getName());
                    jsonproduct.addProperty("StoreName", product.getStore());
                    jsonproduct.addProperty("ProductImg", product.getImage());
                    jsonproduct.addProperty("StyleNum", productStyleNum);
                    jsonproduct.addProperty("StockValue", product.getStockValue());
                    jsonproduct.addProperty("AverageReview", product.getReview());

                    if (productStyleNum == 1) {
                        SingleStyleProduct sproduct = (SingleStyleProduct) product;
                        jsonproduct.addProperty("ProductData", sproduct.getData());
                    } else {
                        MultipleStylesProduct mproduct = (MultipleStylesProduct) product;
                        JsonObject combinedDataObj = new JsonObject();
                        for (Map.Entry<String, String> entry : mproduct.getData().entrySet()) {
                            combinedDataObj.addProperty(entry.getKey(), entry.getValue());
                        }
                        JsonElement combinedData = JsonParser.parseString(combinedDataObj.toString());
                        jsonproduct.add("ProductData", combinedData);
                    }
                    // Add the new JSON object to the outside JSON object
                    jsonproducts.add(Integer.toString(product.getID()), jsonproduct);
                }
                // Add the outside JSON object to the JSON file
                jsonproductList.addProperty("CategoryName", listName);
                jsonproductList.add("CategoryProducts", jsonproducts);
                jsonLists.add(Integer.toString(listID), jsonproductList);
            }
            gson.toJson(jsonLists, writer);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Error Handlers
    private void handleErrorStyleNum() {
        System.out.println("Style Number Error!");
    }
}
