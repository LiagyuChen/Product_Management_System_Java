<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Objects" %>
<%@ page import="model.itemlist.*" %>
<%@ page import="model.Model" %>
<%@ page import="model.ModelFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="index.css?v=1.1">
</head>

<body>
    <% Model model = ModelFactory.getModel(); %>
    <jsp:include page="/header.jsp"/>

    <!-- Main section -- lists -->
    <main>
        <!-- add list -->
        <div class="add-list-button-div">
            <button class="add-item">Add List</button>
        </div>
        <div class="modal" style="position: absolute; z-index: 5;">
            <div class="modal-content">
                <h2>Add List</h2>
                <form action="addList.html" method="POST">
                    <label for="item-content">List Name:</label>
                    <input type="text" id="item-content" name="addListName">
                    <label for="list-id" name="listID">List ID: <% String listID = model.getMaxListID() + ""; out.print(listID); %></label>
                    <button class="cancel" type="button">Cancel</button>
                    <input type="submit" class="submit" value="Add">
                </form>
            </div>
        </div>

        <!-- all lists -->
        <div class="content-container">
            <% 
            List<ListItems> lists = (List<ListItems>) request.getAttribute("lists");
               if (lists != null) {
                int thislistid;
               for(ListItems thislist : lists) { 
                System.out.println("jspListID: "+thislist.getID());
                thislistid = thislist.getID();
                %>
                <div class="content-block">
                    <a href="listItem.html?lsid=<%= thislist.getID() %>" class="content-block-a">
                        <div class="block-name"><%= thislist.getName() %></div>
                        <div class="block-info"><%= thislist.getItems().size() %> items inside</div>
                        <div class="block-actions">
                            <!-- delete list -->
                            <a href="#" class="list-delete" data-listid-delete="<%= thislistid %>">Delete</a>
                            <div class="delete-page">
                                <div class="delete-page-content">
                                    <h3>Are you sure to delete this list?</h3>
                                    <div class="list-delete-note">Note: All the items in this list will also be deleted!</div>
                                    <form action="deleteList.html" method="POST">
                                        <input type="hidden" name="deletelistid" id="deletelistid" value="">
                                        <input type="submit" class="delete-submit" value="Delete">
                                        <button class="delete-cancel" type="cancel">Cancel</button>
                                    </form>
                                </div>
                            </div>

                            <!-- rename list -->
                            <a href="#" class="list-rename" data-listid="<%= thislistid %>">Rename</a>
                            <div class="rename-page">
                                <div class="rename-page-content">
                                    <h2>Rename this List:</h2>
                                    <form action="renameList.html" method="POST">
                                        <label for="new-list-name">Input New List Name:</label>
                                        <input type="text" id="new-list-name" name="new-list-name" placeholder="List Name should be unique">
                                        <button class="rename-cancel" type="cancel">Cancel</button>
                                        <input type="hidden" name="renamelistid" id="renamelistid" value="">
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
        // Show modal when add item button is clicked
        document.querySelector('.add-item').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'flex';
        });

        // Hide modal when close button is clicked

        document.querySelector('.modal .cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.modal').style.display = 'none';
        });

        function deleteList(listId) {
            // Call your delete servlet passing the list ID as a query parameter
            window.location.href = "index?listid=" + listId;
        }

        function renameList(listId) {
            // Call the rename page passing the list ID as a query parameter
            window.location.href = "index?listid=" + listId;
        }

        // list rename
        var renameLists = document.querySelectorAll(".list-rename");
        for (var i = 0; i < renameLists.length; i++) {
            renameLists[i].addEventListener("click", function() {
                document.querySelector('.rename-page').style.display = 'flex';
            })
        };

        const renameButtons = document.querySelectorAll('.list-rename');
        renameButtons.forEach(button => {
            button.addEventListener('click', (event) => {
                const listId = button.getAttribute('data-listid');
                const hiddenInput = document.querySelector('#renamelistid');
                hiddenInput.value = listId;
            });
        });

        document.querySelector('.rename-page .rename-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.rename-page').style.display = 'none';
        });

        // list delete
        var deleteLists = document.querySelectorAll(".list-delete");
        for (var i = 0; i < deleteLists.length; i++) {
            deleteLists[i].addEventListener("click", function() {
                document.querySelector('.delete-page').style.display = 'flex';
            })
        };

        const deleteButtons = document.querySelectorAll('.list-delete');
        deleteButtons.forEach(button => {
            button.addEventListener('click', (event) => {
                const listId2 = button.getAttribute('data-listid-delete');
                const hiddenInput2 = document.querySelector('#deletelistid');
                hiddenInput2.value = listId2;
            });
        });

        document.querySelector('.delete-page .delete-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.delete-page').style.display = 'none';
        });


    </script>
</body>
</html>
