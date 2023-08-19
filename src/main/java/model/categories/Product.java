package model.categories;

public abstract class Product<T> implements ProductInterface {
    private int ProductID, ProductStyleNum, ProductStockValue;
    private String ProductName, ProductStore, ProductImg;
    private float ProductReview;
    private T ProductData;

    public Product(int ProductID, String ProductName, String ProductStore, String ProductImg, int ProductStyleNum,
                   int ProductStockValue, float ProductReview, T ProductData) {
        this.ProductID = ProductID;
        this.ProductName = ProductName;
        this.ProductStore = ProductStore;
        this.ProductImg = ProductImg;
        this.ProductStyleNum = ProductStyleNum;
        this.ProductStockValue = ProductStockValue;
        this.ProductReview = ProductReview;
        this.ProductData = ProductData;
    }

    @Override
    public int getID() {
        return ProductID;
    }
    @Override
    public String getName() {
        return ProductName;
    }
    @Override
    public void changeName(String name) {
        this.ProductName = name;
    }
    @Override
    public String getStore() {
        return ProductStore;
    }
    @Override
    public void changeStore(String store) {
        this.ProductStore = store;
    }
    @Override
    public String getImage() {
        return ProductImg;
    }
    @Override
    public void changeIamge(String image) {
        this.ProductImg = image;
    }
    @Override
    public int getStyleNum() {
        return ProductStyleNum;
    }
    @Override
    public void changeStyleNum(int styleNum) {
        this.ProductStyleNum = styleNum;
    }
    @Override
    public int getStockValue() {
        return ProductStockValue;
    }
    @Override
    public void changeStockValue(int stockValue) {
        this.ProductStockValue = stockValue;
    }
    @Override
    public float getReview() {
        return ProductReview;
    }
    @Override
    public void changeReview(float review) {
        this.ProductReview = review;
    }

    public T getData() {
        return ProductData;
    }
    public void changeData(T data) {
        this.ProductData = data;
    }
}
