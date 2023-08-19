<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Objects" %>
<%@ page import="model.categories.*" %>
<%@ page import="model.Model" %>
<%@ page import="model.ModelFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="index.css?v=1.4">
</head>

<body>
    <% Model model = ModelFactory.getModel(); %>

    <%-- search --%>
    <header>
        <h1>All categories</h1>
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

    <!-- Main section -- categories -->
    <main>
        <!-- add category -->
        <div class="add-list-button-div">
            <button class="add-item">Add Category</button>
        </div>
        <div class="modal" style="position: absolute; z-index: 5;">
            <div class="modal-content">
                <h2>Add Category</h2>
                <form action="addCategory.html" method="POST">
                    <label for="item-content">Category Name: </label>
                    <input type="text" id="item-content" name="addCategoryName">
                    <label for="list-id" name="cateID">Category ID: <% String cateID = model.getMaxCategoryID() + ""; out.print(cateID); %></label>
                    <button class="cancel" type="cancel">Cancel</button>
                    <input type="submit" class="submit" value="Add">
                </form>
            </div>
        </div>

        <!-- all categories -->
        <div class="content-container">
            <% 
            List<CategoryProducts> cates = (List<CategoryProducts>) request.getAttribute("categories");
               if (cates != null) {
                int thisCateID;
               for(CategoryProducts thisCategory : cates) { 
                thisCateID = thisCategory.getID();
                %>
                <div class="content-block">
                    <a href="categoryProduct.html?cateid=<%= thisCategory.getID() %>" class="content-block-a">
                        <div class="block-name"><%= thisCategory.getName() %></div>
                        <div class="block-info"><%= thisCategory.getProducts().size() %> products</div>
                        <div class="block-actions">
                            <!-- delete category -->
                            <a href="#" class="list-delete" data-cateID-delete="<%= thisCateID %>">Delete</a>
                            <div class="delete-page">
                                <div class="delete-page-content">
                                    <h3>Are you sure to delete this category?</h3>
                                    <div class="list-delete-note">Note: All the products in this category will also be deleted!</div>
                                    <form action="deleteCategory.html" method="POST">
                                        <input type="hidden" name="deleteCategoryID" id="deleteCategoryID" value="">
                                        <input type="submit" class="delete-submit" value="Delete">
                                        <button class="delete-cancel" type="cancel">Cancel</button>
                                    </form>
                                </div>
                            </div>

                            <!-- rename category -->
                            <a href="#" class="list-rename" data-cateID="<%= thisCateID %>">Rename</a>
                            <div class="rename-page">
                                <div class="rename-page-content">
                                    <h2>Rename this Category:</h2>
                                    <form action="renameCategory.html" method="POST">
                                        <label for="new-cate-name">Input New Category Name:</label>
                                        <input type="text" id="new-cate-name" name="new-cate-name" placeholder="Category Name should be unique">
                                        <button class="rename-cancel" type="cancel">Cancel</button>
                                        <input type="hidden" name="renameCateID" id="renameCateID" value="">
                                        <input type="submit" class="rename-submit" value="Rename">
                                    </form>
                                </div>
                            </div>

                        </div>
                    </a>
                </div>
            <% }} %>
        </div>

    </main>


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

        // view list
        function deleteList(cateID) {
            window.location.href = "index?cateid=" + cateID;
        }
        function renameList(cateID) {
            window.location.href = "index?cateid=" + cateID;
        }

        // add list
        document.querySelector('.add-item').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'flex';
        });
        document.querySelector('.modal .cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'none';
        });

        // rename list
        var renamecates = document.querySelectorAll(".list-rename");
        for (var i = 0; i < renamecates.length; i++) {
            renamecates[i].addEventListener("click", function() {
                document.querySelector('.rename-page').style.display = 'flex';
            })
        };
        const renameButtons = document.querySelectorAll('.list-rename');
        renameButtons.forEach(button => {
            button.addEventListener('click', (event) => {
                const cateID = button.getAttribute('data-cateID');
                const hiddenInput = document.querySelector('#renameCateID');
                console.log("hiddenInput.value before: ", hiddenInput.value);
                hiddenInput.value = cateID;
                console.log("hiddenInput.value after: ", hiddenInput.value);
            });
        });
        document.querySelector('.rename-page .rename-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.rename-page').style.display = 'none';
        });

        // delete list
        var deletecates = document.querySelectorAll(".list-delete");
        for (var i = 0; i < deletecates.length; i++) {
            deletecates[i].addEventListener("click", function() {
                document.querySelector('.delete-page').style.display = 'flex';
            })
        };
        const deleteButtons = document.querySelectorAll('.list-delete');
        deleteButtons.forEach(button => {
            button.addEventListener('click', (event) => {
                const cateID2 = button.getAttribute('data-cateID-delete');
                const hiddenInput2 = document.querySelector('#deleteCategoryID');
                hiddenInput2.value = cateID2;
            });
        });
        document.querySelector('.delete-page .delete-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.delete-page').style.display = 'none';
        });
    </script>

</body>
</html>
