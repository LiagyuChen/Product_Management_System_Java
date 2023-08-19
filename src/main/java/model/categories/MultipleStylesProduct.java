package model.categories;

import java.util.HashMap;

public class MultipleStylesProduct extends Product<HashMap<String, String>> {
    private HashMap<String, String> map;

    public MultipleStylesProduct(int ProductID, String ProductName, String ProductStore, String ProductImg, int ProductStyleNum,
                                 int ProductStockValue, float ProductReview, HashMap<String, String> ProductData) {
        super(ProductID, ProductName, ProductStore, ProductImg, ProductStyleNum, ProductStockValue, ProductReview, ProductData);
        this.map = ProductData;
    }

    public void replaceValue(String key, String newValue) {
        map.put(key, newValue);
    }
}
