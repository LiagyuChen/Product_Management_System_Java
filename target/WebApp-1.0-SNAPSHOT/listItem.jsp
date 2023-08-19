<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Objects" %>
<%@ page import="model.itemlist.*" %>
<%@ page import="model.Model" %>
<%@ page import="model.ModelFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="listItem.css">
</head>

<body>
    <% Model model = ModelFactory.getModel(); %>

    <!-- Header section -->
    <jsp:include page="/header.jsp"/>

    <input type="hidden" name="listId" id="listId" value="">
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const listId = urlParams.get('id');
        document.getElementById("listId").value = listId;
    </script>

    <!-- add item -->
    <div>
        <button class="add-item">Add Item</button>
    </div>
    <div class="modal">
        <div class="modal-item-data">
            <h2>Add List Item</h2>
            <form action="addItemServlet" method="POST">
                <label for="item-name">Item Name:</label>
                <input type="text" id="item-name" name="item-name">
                <label for="item-type">Item Type:</label>
                <select id="item-type" name="item-type">
                    <option value="text">Text</option>
                    <option value="image">Image</option>
                    <option value="url">URL</option>
                    <option value="link">List Link</option>
                    <option value="combine">Types Combination</option>
                </select>

                <% if (request.getParameter("item-type") != null && request.getParameter("item-type").equals("text") &&
                request.getParameter("item-type").equals("image") && request.getParameter("item-type").equals("url")) { %>
                <label for="item-content">Item content:</label>
                <input type="text" id="item-content" name="item-content">
                <% } %>

                <% if (request.getParameter("item-type") != null && request.getParameter("item-type").equals("link")) { %>
                <label for="list-name">Add to List:</label>
                <select id="list-name" name="list-name">
                    <% for (ListItems thislist : model.getAllLists()) { %>
                    <option value="<%= thislist.getName() %>"><%= thislist.getName() %></option>
                    <% } %>
                </select>
                <% } %>

                <% if (request.getParameter("item-type") != null && request.getParameter("item-type").equals("combine")) { %>
                <label for="item-num">Element Number:</label>
                <select id="item-num" name="item-num">
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <% for (int i = 0; i < Integer.parseInt(request.getParameter("item-num")); i++) { %>
                <label for="element-combine-type">Element Type <%= i+1 %>:</label>
                <select id="element-combine-type" name="element-combine-type">
                    <option value="text">Text</option>
                    <option value="image">Image</option>
                    <option value="url">URL</option>
                    <option value="link">List Link</option>
                </select>
                <label for="element-combine-content">Element Content <%= i+1 %>:</label>
                <input type="text" id="element-combine-content" name="element-combine-content">
                <% } %>

                <% } %>
                <label for="item-id">Item ID: <%= "Item ID " +model.getMaxItemID() %></label>
                <button class="cancel" type="cancel">Cancel</button>
                <button class="submit" type="submit" name="addItem">Add Item</button>
            </form>
        </div>
    </div>

    <!-- all items -->
    <div class="items">
        <% ListItems list = (ListItems) request.getAttribute("list"); %>
        <% for(ItemInterface item : list.getItems()){ %>
        <div class="itemContainer" onclick="expandItem(event);">
            <div class="item-header">
                <h2 class="item-title"><%= item.getName() %></h2>
                <p class="item-description">Click to view the detail</p>
                <div class="item-actions">
                    <a href="editItem.jsp?id=<%= item.getID() %>" class="item-editing">Edit</a>
                    <a href="deleteItem.jsp?id=<%= item.getID() %>" class="item-delete">Delete</a>
                </div>
            </div>
            <div class="item-data">
                <label class="item-data-label">Item Type: <%= item.getType() %></label><br>
                <label class="item-data-label">Item ID: <%= "Item ID " + item.getID() %></label><br>

                <% if(item.getType().equals("text") || item.getType().equals("url")){ 
                    StringItem sitem = (StringItem) item; %>
                <label class="item-data-label">Item Data:</label>
                <p class="item-data-text"><%= sitem.getData() %></p>

                <% } else if(item.getType().equals("image")){ 
                    StringItem sitem = (StringItem) item; %>
                <div class="item-data-image">
                    <label class="item-data-label">Item Image:</label>
                    <img src="<%= sitem.getData() %>" alt="" width="400px" height="auto" style="display:block; margin:0 auto;">
                </div>

                <% } else if(item.getType().equals("link")){ 
                    StringItem sitem = (StringItem) item; %>
                <label class="item-data-label">The link to other list:</label><br>
                <a href="<%= sitem.getData() %>" class="item-data-link">The link to other list</a>

                <% } else if(item.getType().equals("combine")){ 
                    CombinedItem citem = (CombinedItem) item;
                    HashMap<String, String> map = citem.getData(); %>
                <% for(String key : map.keySet()){ %>
                <label class="item-data-label"><%= key %>:</label>
                <% if(key.equals("text") || key.equals("url")){ %>
                <p class="item-data-text"><%= map.get(key) %></p>
                <% } else if(key.equals("image")){ %>
                <div class="item-data-image">
                    <img src="<%= map.get(key) %>" alt="" width="400px" height="auto" style="display:block; margin:0 auto;">
                </div>
                <% } else if(key.equals("link")){ %>
                <a href="<%= map.get(key) %>" class="item-data-link">The link to other list</a>
                <% } %>
                <% } %>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>

    <!-- delete items -->
    <jsp:include page="/deleteItem.jsp"/>

    <!-- edit items -->
    <jsp:include page="/editItem.jsp"/>

    <script>
        // Expand Item itemContainer
        function expandItem(event) {
            console.log("expendJS:  "+event);
            if (event.target.classList.contains('item-header') || event.target.classList.contains('item-title') ||
            event.target.classList.contains('item-description')) {
                // Get the parent container element
                var container = event.target.closest('.itemContainer');
                // Toggle the expanded class on the container
                container.classList.toggle('expanded');
                // document.querySelector('.item-rename').style.bottom = '-500px'
            }
        }

        // Add Item subpage
        document.querySelector('.add-item').addEventListener('click', function(e) {
                e.preventDefault();
                document.querySelector('.modal').style.display = 'flex';
            });
        // document.querySelector('.modal .submit').addEventListener('click', function(e) {
        //     e.preventDefault();
        //     document.querySelector('.modal').style.display = 'none';
        // });
        document.querySelector('.modal .cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'none';
        });

        // item delete
        var deleteLists = document.querySelectorAll(".item-delete");
        for (var i = 0; i < deleteLists.length; i++) {
            deleteLists[i].addEventListener("click", function() {
                document.querySelector('.delete-page').style.display = 'flex';
            })
        };
        // document.querySelector('.delete-page .delete-submit').addEventListener('click', function(e) {
        //     e.preventDefault();
        //     document.querySelector('.delete-page').style.display = 'none';
        // });
        document.querySelector('.delete-page .delete-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.delete-page').style.display = 'none';
        });

        // item edit
        var editLists = document.querySelectorAll(".item-editing");
        for (var i = 0; i < editLists.length; i++) {
            editLists[i].addEventListener("click", function() {
                document.querySelector('.item-edit').style.display = 'flex';
            })
        };
        // document.querySelector('.item-edit .edit-submit').addEventListener('click', function(e) {
        //     e.preventDefault();
        //     document.querySelector('.item-edit').style.display = 'none';
        // });
        document.querySelector('.item-edit .edit-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.item-edit').style.display = 'none';
        });

        // // search result
        // document.querySelector('.header-search').addEventListener('click', function(e) {
        //     e.preventDefault();
        //     document.querySelector('.search-result').style.display = 'flex';
        // });
        // document.querySelector('.header-search-submit').addEventListener('click', function(e) {
        //     e.preventDefault();
        //     document.querySelector('.search-result').style.display = 'none';
        // });

        // // add event listener to item title
        // document.getElementById("item-title").addEventListener("click", function() {
        //     // get item name
        //     var itemName = this.textContent;
        //     // Create a hidden div to store the item name
        //     var hiddenDiv = document.createElement("div");
        //     hiddenDiv.setAttribute("id", "itemName");
        //     hiddenDiv.setAttribute("style", "display:none");
        //     hiddenDiv.innerHTML = itemName;
        //     document.body.appendChild(hiddenDiv);
        //     // Submit the form with the item name
        //     var form = document.createElement("form");
        //     form.setAttribute("method", "POST");
        //     form.setAttribute("action", "./java/servlets/ChangeItemServlet");
        //     document.body.appendChild(form);

        //     var itemNameInput = document.createElement("input");
        //     itemNameInput.setAttribute("type", "hidden");
        //     itemNameInput.setAttribute("name", "itemName");
        //     itemNameInput.setAttribute("value", itemName);
        //     form.appendChild(itemNameInput);

        //     form.submit();
        // });
    </script>
</body>
</html>
