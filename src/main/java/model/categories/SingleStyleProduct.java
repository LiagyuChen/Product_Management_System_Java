package model.categories;

public class SingleStyleProduct extends Product<String> {
    public SingleStyleProduct(int ProductID, String ProductName, String ProductStore, String ProductImg, int ProductStyleNum,
                              int ProductStockValue, float ProductReview, String ProductData) {
        super(ProductID, ProductName, ProductStore, ProductImg, ProductStyleNum, ProductStockValue, ProductReview, ProductData);
    }
}
