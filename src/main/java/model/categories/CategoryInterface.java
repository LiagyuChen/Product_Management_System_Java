package model.categories;

import java.util.ArrayList;

public interface CategoryInterface {
    String getName();
    void setName(String name);
    ArrayList<ProductInterface> getProducts();
    int getID();
    void addProduct(ProductInterface product);
    void removeProduct(ProductInterface product);
    void editProduct(ProductInterface oldProduct, ProductInterface newProduct);
}

