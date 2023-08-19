package model.categories;

import java.util.ArrayList;

public class CategoryProducts implements CategoryInterface{
    private String name;
    private int ID;
    private ArrayList<ProductInterface> products;

    public CategoryProducts(String name, int ID) {
        this.name = name;
        this.ID = ID;
        this.products = new ArrayList<>();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getID() {
        return ID;
    }

    public ArrayList<ProductInterface> getProducts() {
        return products;
    }

    public void addProduct(ProductInterface product) {
        products.add(product);
    }

    public void removeProduct(ProductInterface product) {
        products.remove(product);
    }

    public void editProduct(ProductInterface oldProduct, ProductInterface newProduct) {
        int index = products.indexOf(oldProduct);
        if (index != -1) {
            products.set(index, newProduct);
        }
    }
}
