<button class="header-search-submit" type="submit" name="Search">Search</button>

document.querySelector('.header-search-submit').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.search-result').style.display = 'flex';
        });


        function submitForm(event) {
                    // Prevent default form submission behavior
                    event.preventDefault();

                    // Replace form with iframe
                    var form = document.querySelector('form');
                    var iframe = document.createElement('iframe');
                    iframe.src = form.action;
                    form.parentNode.replaceChild(iframe, form);
                  }

                  // Listen for form submission event and call submitForm function
                  var form = document.querySelector('form');
                  form.addEventListener('submit', submitForm);




        <div>
            <button class="add-item">Add Item</button>
        </div>
        <% Model model = ModelFactory.getModel(); %>
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

              <div id="item-content-section"></div>

              <div id="list-name-section"></div>

              <div id="combine-section"></div>

              <label for="item-id">Item ID: <%= "Item ID " + model.getMaxItemID() %></label>
              <button class="cancel" type="cancel">Cancel</button>
              <button class="submit" type="submit">Add Item</button>
            </form>
          </div>
        </div>

        script

        <a href="#" class="item-rename">Rename</a>
        <!-- rename items -->
            <div class="rename-page">
                <div class="rename-page-content">
                    <h2>Rename this List: </h2>
                    <form action="itemChangeServlet" method="POST">
                        <label for="item-content">Input New Item Name:</label>
                        <input type="text" id="item-content" name="item-content" placeholder="List Name should be unique">
                        <button class="rename-cancel" type="cancel">Cancel</button>
                        <button class="rename-submit" type="submit"  name="Rename">Confirm</button>
                    </form>
                </div>
            </div>


         // item rename
                 var renameLists = document.querySelectorAll(".item-rename");
                 for (var i = 0; i < renameLists.length; i++) {
                     renameLists[i].addEventListener("click", function() {
                         document.querySelector('.rename-page').style.display = 'flex';
                     })
                 };
                 document.querySelector('.rename-page .rename-submit').addEventListener('click', function(e) {
                     e.preventDefault();
                     document.querySelector('.rename-page').style.display = 'none';
                 });
                 document.querySelector('.rename-page .rename-cancel').addEventListener('click', function(e) {
                     e.preventDefault();
                     document.querySelector('.rename-page').style.display = 'none';
                 });







        // add an event listener to the search input field
        $('#searchQuery').on('input', function() {
            // get the search query
            var searchQuery = $(this).val();

            // make an AJAX request to the Search servlet
            $.ajax({
                url: 'Search',
                type: 'POST',
                data: { searchQuery: searchQuery },
                success: function(response) {
                    // parse the response JSON data
                    var searchData = JSON.parse(response);

                    // get the search results container
                    var searchResults = $('.search-result ul');

                    // clear the search results container
                    searchResults.empty();

                    // check if there are any search results
                    if (searchData.listResult.length > 0 || searchData.itemResult.length > 0) {
                        // loop through the list results
                        $.each(searchData.listResult, function(index, listResult) {
                            // create a new list item for the search result
                            var listItem = $('<li>');
                            // create a new link for the search result
                            var listLink = $('<a>', {
                                class: 'search-result-list',
                                href: 'listItem.jsp?id=' + listResult.id,
                                text: '[List] ' + listResult.name
                            });
                            // add the link to the list item
                            listItem.append(listLink);
                            // add the list item to the search results container
                            searchResults.append(listItem);
                        });

                        // loop through the item results
                        $.each(searchData.itemResult, function(index, itemResult) {
                            // create a new list item for the search result
                            var listItem = $('<li>');
                            // create a new link for the search result
                            var listLink = $('<a>', {
                                class: 'search-result-list',
                                href: 'listItem.jsp?id=' + itemResult.id,
                                text: '[Item] ' + itemResult.name
                            });
                            // add the link to the list item
                            listItem.append(listLink);
                            // add the list item to the search results container
                            searchResults.append(listItem);
                        });
                    } else {
                        // if there are no search results, display a message
                        var noResults = $('<li>', {
                            html: '<a class="search-result-list" href="index.html">No Results Found</a>'
                        });
                        // add the message to the search results container
                        searchResults.append(noResults);
                    }
                },
                error: function(xhr, status, error) {
                    // handle the AJAX error
                    console.log(xhr.responseText);
                }
            });
        });


        <div class="search-result">
                    <ul>
                        <%
                        List<ListItems> searchListResult = (List<ListItems>) request.getAttribute("searchListResult");
                        List<Item> searchItemResult = (List<Item>) request.getAttribute("searchItemResult");
                        System.out.println("JSP:  "+searchListResult+searchItemResult);

                        if (searchListResult != null) {
                            for (ListItems thislist : searchListResult) { %>
                              <li><a class="search-result-list" href="listItem.jsp?id=<%= thislist.getID() %>"><%= "[List]   " + thislist.getName() %></a></li>
                         <%  } }
                        if (searchItemResult != null) {
                            for (Item thisitem : searchItemResult) { %>
                              <li><a class="search-result-list" href="listItem.jsp?id=<%= thisitem.getID() %>"><%= "[Item]   " + thisitem.getName() %></a></li>
                         <%  } }
                        if (searchListResult == null && searchItemResult == null) { %>
                            <li><a class="search-result-list" href="index.html">No Result Found</a></li>
                         <% } %>
                    </ul>
                </div>


const form = document.getElementById('searchForm');
            const frame = document.getElementsByName('searchFrame')[0];

            form.addEventListener('input', () => {
                frame.contentWindow.location.reload();
                form.submit();
            });




<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Objects" %>
<%@ page import="model.itemlist.*" %>
<%@ page import="model.Model" %>
<%@ page import="model.ModelFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="index.css">
</head>

<body>
    <% Model model = ModelFactory.getModel(); %>
    <!-- Header section -->
    <header>
        <h1>List Items</h1>
        <form action="Search" method="POST" target="searchFrame">
            <input class="header-search" type="text" name="searchQuery" placeholder="Enter full list/item name" required>
            <button class="header-search-submit" type="submit" name="Search">SearchB</button>
        </form>
        <iframe src="" frameborder="0" name="searchFrame"></iframe>
        <!-- item search result list -->
        <div class="search-result">
            <ul>
                <%
                List<ListItems> searchListResult = (List<ListItems>) request.getAttribute("searchListResult");
                List<Item> searchItemResult = (List<Item>) request.getAttribute("searchItemResult");
                System.out.println("JSP:  "+searchListResult+searchItemResult);
                if (searchListResult != null) {
                for (ListItems thislist : searchListResult) { %>
                <li><a class="search-result-list" href="listItem.jsp?id=<%= thislist.getID() %>"><%= "[List]   " + thislist.getName() %></a></li>
                <% }}
                if (searchItemResult != null) {
                for (Item thisitem : searchItemResult) { %>
                <li><a class="search-result-list" href="listItem.jsp?id=<%= thisitem.getID() %>"><%= "[Item]   " + thisitem.getName() %></a></li>
                <% }}
                 if (searchListResult == null && searchItemResult == null) { %>
                 <li><a class="search-result-list" href="index.html">No Result Found</a></li>
                 <% } %>
            </ul>
        </div>
    </header>

    <script>
        // search result
        document.querySelector('.header-search').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.search-result').style.display = 'flex';
        });



    </script>
</body>
</html>









Add list:
document.querySelector('.modal .submit').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'none';
        });

Rename list:
        document.querySelector('.rename-page .rename-submit').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.rename-page').style.display = 'none';
        });

Delete list:
document.querySelector('.delete-page .delete-submit').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.delete-page').style.display = 'none';
        });


        <!-- rename list -->
                <div class="rename-page">
                    <div class="rename-page-content">
                        <h2>Rename this List:</h2>
                        <form action="/listChange.html" method="POST">
                            <label for="new-list-name">Input New List Name:</label>
                            <input type="text" id="new-list-name" name="new-list-name" placeholder="List Name should be unique">
                            <button class="rename-cancel" type="cancel">Cancel</button>
                            <button class="rename-submit" type="submit"  name="Rename">Confirm</button>
                            <input type="hidden" name="listid" value="${param['listid']}">
                            <input type="hidden" name="changeType" value="rename">
                        </form>
                    </div>
                </div>


                <a href="#" class="list-delete" onclick="deleteList(<%= thislist.getID() %>);">Delete</a>
                                            <a href="#" class="list-rename"  onclick="renameList(<%= thislist.getID() %>);">Rename</a>
