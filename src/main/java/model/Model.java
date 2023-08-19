package model;

import model.categories.*;
import java.util.*;
import com.google.gson.Gson;
import java.util.List;


public class Model {
    private final String DATA_FILE = "./data/data.json";
    private static CategoryManager productCategoryManager = new CategoryManager();
    private int currentMaxID = 0, currentMaxCategoryID = 0;
    private Gson gson;

    public Model() {
        gson = new Gson();
        loadFromFile();
    }

    // file operations
    public void loadFromFile() {
        productCategoryManager.loadFromFile(DATA_FILE);
        currentMaxID = productCategoryManager.getLastproductID();
        currentMaxCategoryID = productCategoryManager.getLastCategoryID();
    }
    public void saveToFile() {
        productCategoryManager.saveToFile(DATA_FILE);
        System.out.println("Data saved to file.");
    }

    // product operations
    public void addProduct(String categoryName, String ProductName, String ProductStore, String ProductImg, int ProductStyleNum, int ProductStockValue, float ProductReview, String ProductData) throws Exception {
        CategoryProducts thisCategory = GetCategoryByName(categoryName);
        if (thisCategory == null) {
            throw new Exception("No category found with that name.");
        }
        if (ProductStyleNum == 1) {
            SingleStyleProduct product = new SingleStyleProduct(currentMaxID++, ProductName, ProductStore, ProductImg, ProductStyleNum, ProductStockValue, ProductReview, ProductData);
            productCategoryManager.addProduct(thisCategory, product);
        } else {
            throw new Exception("Invalid Product Type!");
        }
        saveToFile();
    }
    public void addProduct(String categoryName, String ProductName, String ProductStore, String ProductImg, int ProductStyleNum, int ProductStockValue, float ProductReview, HashMap<String, String> ProductData) throws Exception {
        CategoryProducts thisCategory = GetCategoryByName(categoryName);
        if (thisCategory == null) {
            throw new Exception("No category found with that name.");
        }
        if (ProductStyleNum > 1) {
            MultipleStylesProduct product = new MultipleStylesProduct(currentMaxID++, ProductName, ProductStore, ProductImg, ProductStyleNum, ProductStockValue, ProductReview, ProductData);
            productCategoryManager.addProduct(thisCategory, product);
        } else {
            throw new Exception("Invalid Product Type!");
        }
        saveToFile();
    }
    public void removeProduct(int CategoryID, int ProductID) throws Exception {
        ProductInterface thisProduct = GetProductByID(ProductID);
        if (thisProduct == null) throw new Exception("No product found with that ID!");
        
        boolean cateFound = false;
        List<CategoryProducts> cates = productCategoryManager.getProductCategorys();
        for (CategoryProducts cate : cates) {
            if (Objects.equals(cate.getID(), CategoryID)) {
                productCategoryManager.removeProduct(cate, thisProduct);
                cateFound = true;
            }
        }
        if (!cateFound) throw new Exception("No category found with that ID!");
        
        saveToFile();
    }
    public void editProduct(int CategoryID, int ProductID, String newName,String newStore, String newImg, int newStyles, int newStocks, float newReview, String newData) throws Exception {
        ProductInterface thisProduct = GetProductByID(ProductID);
        ProductInterface originalProduct = thisProduct;

        if (thisProduct == null) throw new Exception("No product found with that ID!");
        
        if(newStyles > 1) throw new Exception("Product Style Number is not match!");

        // edit product
        SingleStyleProduct product = (SingleStyleProduct) thisProduct;
        if (!newName.equals("")) product.changeName(newName);
        if (!newStore.equals("")) product.changeStore(newStore);
        if (!newImg.equals("")) product.changeIamge(newImg);
        if (newStyles != 0) product.changeStyleNum(newStyles);
        if (newStocks != 0) product.changeStockValue(newStocks);
        if (newReview != 0.0) product.changeReview(newReview);
        if (!newData.equals("")) product.changeData(newData);
        
        // edit category
        boolean productFound = false;
        List<CategoryProducts> cates = productCategoryManager.getProductCategorys();
        for (CategoryProducts cate : cates) {
            if (cate.getID() == CategoryID) {
                productCategoryManager.editProduct(cate, originalProduct, thisProduct);
                productFound = true;
            }
        }
        if (!productFound) throw new Exception("No category found with that ID!");
        
        // save all the changes to the JSON file
        saveToFile();
    }
    public void editProduct(int CategoryID, int ProductID, String newName,String newStore, String newImg, int newStyles, int newStocks, float newReview, HashMap<String, String> newData) throws Exception {
        // edit category
        CategoryProducts thisCate = null;
        List<CategoryProducts> cates = productCategoryManager.getProductCategorys();
        for (CategoryProducts cate : cates) {
            if (cate.getID() == CategoryID) thisCate = cate;
        }
        if (thisCate == null) throw new Exception("No category found with that ID!");

        ProductInterface thisProduct = GetProductByID(ProductID);
        if (thisProduct == null) throw new Exception("No item found with that ID!");

        if(newStyles == 1) throw new Exception("Product Style Number is not match!");

        // edit product
        MultipleStylesProduct product = (MultipleStylesProduct) thisProduct;
        if (!newName.equals("")) product.changeName(newName);
        if (!newStore.equals("")) product.changeStore(newStore);
        if (!newImg.equals("")) product.changeIamge(newImg);
        if (newStyles != 0) product.changeStyleNum(newStyles);
        if (newStocks != 0) product.changeStockValue(newStocks);
        if (newReview != 0.0) product.changeReview(newReview);
        if (!newData.isEmpty()) {
            for (Map.Entry<String, String> entry : newData.entrySet()) {
                product.replaceValue(entry.getKey(), entry.getValue());
            }
        }
        productCategoryManager.editProduct(thisCate, thisProduct, product);

        // save all the changes to the JSON file
        saveToFile();
    }

    // list operations
    public void createCategory(String categoryName) throws Exception {
        if (Objects.equals(categoryName, "")) throw new Exception("Empty Category Name!");
        productCategoryManager.createCategory(categoryName, currentMaxCategoryID);
        currentMaxCategoryID++;
        saveToFile();
    }
    public void deleteCategory(int CategoryID) throws Exception {
        CategoryProducts thisCategory = GetCategoryByID(CategoryID);
        if (thisCategory == null) throw new Exception("No category found with that name.");
        productCategoryManager.deleteCategory(thisCategory);
        saveToFile();
    }
    public void renameCategory(int CategoryID, String newName) throws Exception {
        CategoryProducts thisCategory = GetCategoryByID(CategoryID);
        if (thisCategory == null) throw new Exception("No category found with that name.");
        productCategoryManager.renameCategory(thisCategory, newName);
        saveToFile();
    }

    // auxiliary functions
    public List<CategoryProducts> GetAllCates() {
        return productCategoryManager.getProductCategorys();
    }
    public ProductInterface GetProductByID(int ID) {
        List<CategoryProducts> cates = GetAllCates();
        for (CategoryProducts list : cates) {
            for (ProductInterface item : list.getProducts()) {
                if (item.getID() == ID) return item;
            }
        }
        return null;
    }
    public CategoryProducts GetCategoryByID(int ID) {
        List<CategoryProducts> cates = GetAllCates();
        for (CategoryProducts list : cates) {
            if (list.getID() == ID) {
                return list;
            }
        }
        return null;
    }
    public CategoryProducts GetCategoryByName(String categoryName) {
        List<CategoryProducts> cates = GetAllCates();
        for (CategoryProducts list : cates) {
            if (list.getName().equals(categoryName)) {
                return list;
            }
        }
        return null;
    }

    // used in jsp
    public ArrayList<String> GetALLProductID() {
        List<CategoryProducts> cates = GetAllCates();
        ArrayList<String> ProductIDs = new ArrayList<>();
        for (CategoryProducts list : cates) {
            for (ProductInterface item : list.getProducts()) {
                ProductIDs.add(""+item.getID());
            }
        }
        return ProductIDs;
    }
    public ArrayList<String> GetALLCategoryID() {
        List<CategoryProducts> cates = GetAllCates();
        ArrayList<String> CategoryIDs = new ArrayList<>();
        for (CategoryProducts list : cates) {
            CategoryIDs.add(""+list.getID());
        }
        return CategoryIDs;
    }
    public int getMaxProductID() {
        return currentMaxID;
    }
    public int getMaxCategoryID() {
        return currentMaxCategoryID;
    }
}


