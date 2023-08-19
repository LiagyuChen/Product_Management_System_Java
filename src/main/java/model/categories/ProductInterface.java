package model.categories;

public interface ProductInterface {
    int getID();
    String getName();
    void changeName(String name);
    String getStore();
    void changeStore(String store);
    String getImage();
    void changeIamge(String image);
    int getStyleNum();
    void changeStyleNum(int styleNum);
    int getStockValue();
    void changeStockValue(int stockValue);
    float getReview();
    void changeReview(float review);
}
