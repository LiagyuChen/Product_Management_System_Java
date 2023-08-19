<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Objects" %>
<%@ page import="model.categories.*" %>
<%@ page import="model.Model" %>
<%@ page import="model.ModelFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="categoryProduct.css?v=1.1">
</head>

<body>
    <%
    Model model = ModelFactory.getModel();
    String cateid = (String) request.getAttribute("cateid"); 
    %>
    
    <!-- search -->
    <header>
        <h1>All Categories</h1>
        <form id="searchForm" action="searchElement.html" method="POST" onsubmit="return validateInput()">
            <div class="search-note">Note: Search Category: "C" + category id -> to category page<br>     Search Product: "C" + category id + "P" + product id-> to product loaction in the categpory page</div>
            <input class="header-search" type="text" name="searchQuery" placeholder="Enter correct search pattern..." required>
            <input class="header-search-submit" type="submit" name="Search" value="Search">
        </form>
        <% String searchResult = (String) request.getAttribute("searchResult");
        if (searchResult == "1") { %>
        <div class="search-no-list">No Result Found</div>
        <% } %>
    </header>


    <div class="back-to-main"><a href="http://localhost:8080/index.html">Back to main page</a></div>

    <%-- add product --%>
    <div class="add-product-buttons">
        <button type="button" class="add-product1">Add Single Style Product</button>
        <button type="button" class="add-product2">Add Multiple Styles Product</button>
    </div>
    <div class="modal">
        <div class="modal-product-data">
            <h2>Add Product</h2>
            <form action="addProduct.html" method="POST" id="add-product-form">
                <input type="hidden" name="cateID" id="cateID" value="<%= cateid %>">
                <label for="product-name">Product Name:</label>
                <input type="text" id="product-name" name="product-name" required>
                <label for="product-store">Store Name:</label>
                <input type="text" id="product-store" name="product-store" required>
                <label for="product-image">Product Image:</label>
                <input type="text" id="product-image" name="product-image" required>
                <label for="product-stock">Product Stock:</label>
                <input type="text" id="product-stock" name="product-stock" required>
                <label for="product-review">Customer Review:</label>
                <input type="text" id="product-review" name="product-review" required>
                
                <div class="add-product-form1" id="text-form" style="display: none;">
                    <label for="product-style-num">Style Number: 1</label>
                    <input type="hidden" id="product-style-num" name="product-style-num" value="1">
                    <label for="product-content">Product Detail:</label><br>
                    <input type="text" id="product-content" name="product-content">
                </div>
                <div class="add-product-form2" id="combined-form" style="display: none;">
                    <label for="product-style-num">Style Number:</label>
                    <input type="number" id="product-style-num" name="product-style-num-multiple">
                    <label for="style-name" style="margin-right:650px;">All the Style Names (Separate by ";" sign):</label>
                    <input type="text" id="style-name" name="style-name">
                    <label for="style-description" style="margin-right:650px;">All the Style Descriptions (Separate by ";" sign):</label>
                    <input type="text" id="style-description" name="style-description">
                </div>
                <label for="product-id">Product ID: <%= model.getMaxProductID() + 1 %></label>
                <input type="hidden" name="product-id" id="product-id" value="<%= model.getMaxProductID() + 1 %>">
                <input type="submit" class="submit" value="Add">
                <button class="add-cancel" type="cancel">Cancel</button>
            </form>
        </div>
    </div>
    </div>
    
    <script>
        var editproductType;
        const editB = document.querySelectorAll('.product-editing');
    </script>

    <!-- all products -->
    <div class="products">
        <% CategoryProducts category = (CategoryProducts) request.getAttribute("category"); 
        if (category.getProducts().size() == 0) { %>
        <h1 style="font-weight: 700; text-align: center;">No product in this category yet...</h1>
        <% }
        if (category != null) {%>
        <% for(ProductInterface product : category.getProducts()){ %>
        <div class="productContainer" onclick="expandProduct(event);" id="productContainer<%= product.getID() %>">
            <div class="product-header">
            <h2 class="product-title"><%= product.getName() %></h2>
            <p class="product-description">Click to view the detail</p>
            <div class="product-actions">
                <%-- edit product --%>
                <a href="#" class="product-editing" data-product-id-edit="<%= product.getID() %>" product-edit-style-num="<%= product.getStyleNum() %>">Edit</a>
                <div class="product-edit">
                    <div class="product-edit-box">
                        <h2>Edit product</h2>
                        <form action="editProduct.html" method="post">
                            <input type="hidden" name="editCategoryID" id="editCategoryID" value="<%= cateid %>">
                            <p class="product-edit-note">Note: Leave the input bar empty if you do not want to change it!</p>
                            <label for="product-edit-data">New Product Name:</label>
                            <input type="text" id="product-edit-input" name="newName">
                            <label for="product-edit-data">New Store Name:</label>
                            <input type="text" id="product-edit-input" name="newStore">
                            <label for="product-edit-data">New product Image:</label>
                            <input type="text" id="product-edit-input" name="newImage">
                            <label for="product-edit-data">New Stock Value:</label>
                            <input type="text" id="product-edit-input" name="newStock">
                            <label for="product-edit-data">New Customer Review:</label>
                            <input type="text" id="product-edit-input" name="newReview">

                            <%-- edit product specific fields --%>
                            <div id="edit-product-type-specific-fields"></div>
                            <input type="hidden" name="editProductID" id="editProductID" value="">
                            <button class="edit-cancel" type="cancel">Cancel</button>
                            <input type="submit" class="submit" value="Confirm">
                        </form>
                    </div>
                </div>
                <%-- delete product --%>
                <a href="#" class="product-delete" data-product-id-delete="<%= product.getID() %>">Delete</a>
                <div class="delete-page">
                    <div class="delete-page-content">
                        <h3>Are you sure to delete this product?</h3>
                        <div class="product-delete-note">Note: All the contents in this product will also be deleted!</div>
                        <form action="deleteProduct.html" method="POST">
                            <input type="hidden" name="deleteCategoryID" id="deleteCategoryID" value="<%= cateid %>">
                            <input type="hidden" name="deleteProductID" id="deleteProductID" value="">
                            <button class="delete-cancel" type="cancel">Cancel</button>
                            <input type="submit" class="submit" value="Delete">
                        </form>
                    </div>
                </div>
            </div>
            </div>
            <%-- view product --%>
            <div class="product-data">
                <label class="product-data-label">Product Image: </label><br>
                <img src="<%= product.getImage() %>" alt="" width="400px" height="auto" style="display:block; margin:0 auto;">
                <label class="product-data-label">Product ID: <%= product.getID() %></label><br>
                <label class="product-data-label">Product Store Name: <%= product.getStore() %></label><br>
                <label class="product-data-label">Product Stock Value: <%= product.getStockValue() %></label><br>
                <label class="product-data-label">Product Average Customer Review Score: <%= product.getReview() %> / 5.0</label><br>
                <label class="product-data-label">Product Style Number: <%= product.getStyleNum() %></label><br>

                <% if(product.getStyleNum() == 1){ 
                    SingleStyleProduct SProduct = (SingleStyleProduct) product; %>
                    <label class="product-data-label">product Detail:</label>
                    <p class="product-data-text"><%= SProduct.getData() %></p>
                <% } else { 
                    MultipleStylesProduct MProduct = (MultipleStylesProduct) product;
                    HashMap<String, String> map = MProduct.getData();
                    for(int i = 0; i < product.getStyleNum(); i++){ %>
                        <label class="product-data-text">Style Name <%= i %>: <%= map.get("StyleName" + i) %></label><br>
                        <label class="product-data-text">Style Description <%= i %>: <%= map.get("StyleDesc" + i) %></label><br>
                    <% } %>
                <% } %>
            </div>
        </div>
        <% }} %>
        <div class="all-products-spaces"></div>
    </div>



    <script>
        // search
        function validateInput() {
            var input = document.forms["searchForm"]["searchQuery"].value;
            var cateIds = [<%= String.join(",", model.GetALLCategoryID()) %>];
            var productIds = [<%= String.join(",", model.GetALLProductID()) %>];
            var regex1 = /^C\d+(P\d+)?$/;
            var regex2 = /^C\d+$/;

            if (!regex1.test(input) && !regex2.test(input)) {
                alert("Invalid input. Please enter a valid search pattern.");
                return false;
            }
            if (str.indexOf("I") === -1) {
                var cateId = parseInt(input.substring(1));
                if (!cateIds.includes(cateId)) {
                    alert("Category ID not found.");
                    return false;
                }
            } else {
                var cateId = parseInt(input.substring(1, input.indexOf("P")));
                var productId = parseInt(input.substring(input.indexOf("P") + 1));
                if (!cateIds.includes(cateId) || !productIds.includes(productId)) {
                    alert("Product ID not found.");
                    return false;
                }
            }
            return true;
        }

        // view product
        function expandProduct(event) {
            console.log("expendJS:  "+event);
            if (event.target.classList.contains('product-header') || event.target.classList.contains('product-title') ||
            event.target.classList.contains('product-description')) {
                var container = event.target.closest('.productContainer');
                container.classList.toggle('expanded');
            }
        }

        // add product
        document.querySelector('.add-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'none';
        })
        document.querySelector('.add-product1').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'flex';
            document.querySelector(".add-product-form1").style.display = "flex";
            document.querySelector(".add-product-form2").style.display = "none";
        });
        document.querySelector('.add-product2').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'flex';
            document.querySelector(".add-product-form2").style.display = "flex";
            document.querySelector(".add-product-form1").style.display = "none";
        });

        // delete product 
        var deleteLists = document.querySelectorAll(".product-delete");
        for (var i = 0; i < deleteLists.length; i++) {
            deleteLists[i].addEventListener("click", function() {
                document.querySelector('.delete-page').style.display = 'flex';
            })
        };
        document.querySelector('.delete-page .delete-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.delete-page').style.display = 'none';
        });
        const deleteButtons = document.querySelectorAll('.product-delete');
        deleteButtons.forEach(button => {
            button.addEventListener('click', (event) => {
                const productIdDelete = button.getAttribute('data-product-id-delete');
                const hiddenInputDelete = document.querySelector('#deleteProductID');
                hiddenInputDelete.value = productIdDelete;
            });
        });

        // edit product
        var editLists = document.querySelectorAll(".product-editing");
        for (var i = 0; i < editLists.length; i++) {
            editLists[i].addEventListener("click", function() {
                document.querySelector('.product-edit').style.display = 'flex';
            })
        };
        document.querySelector('.product-edit .edit-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.product-edit').style.display = 'none';
        });

        const editButtons = document.querySelectorAll('.product-editing');
        var typeSpecificFields = document.querySelector('#edit-product-type-specific-fields');
        editButtons.forEach(button => {
            button.addEventListener('click', (event) => {
                const productIdEdit = button.getAttribute('data-product-id-edit');
                const hiddenInputEdit = document.querySelector('#editProductID');
                hiddenInputEdit.value = productIdEdit;

                editProductStyleNum = button.getAttribute('product-edit-style-num');
                if (editProductStyleNum == 1) {
                    typeSpecificFields.innerHTML = `
                    <label for="product-edit-data">New product Detail:</label>
                    <input type="text" id="product-edit-input" name="newContent">
                    <input type="hidden" name="newStyleNum" id="newStyleNum" value="1">
                    `;
                } else if (editProductStyleNum > 1) {
                    typeSpecificFields.innerHTML = `
                   <label for="edit-style-name" id="edit-style-name" name="edit-style-name">All the Style Names (Separate by ";" sign):</label>
                   <input type="text" id="edit-style-name" name="edit-style-name">
                   <label for="edit-style-description" id="edit-style-description" name="edit-style-description">All the Style Descriptions (Separate by ";" sign):</label>
                   <input type="text" id="edit-style-description" name="edit-style-description">
                   <input type="hidden" name="newStyleNum" id="newStyleNum" value="2">
                   `;
                }
            });
        });
    </script>
</body>
</html>
