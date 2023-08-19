<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Objects" %>
<%@ page import="model.itemlist.*" %>
<%@ page import="model.Model" %>
<%@ page import="model.ModelFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<body>
    <input type="hidden" name="itemId" id="itemId" value="">
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const listId = urlParams.get('id');
        document.getElementById("itemId").value = listId;
    </script>

    <!-- edit items -->
    <%
        Model model = ModelFactory.getModel();
        String itemId = request.getParameter("itemId");
        model.GetItemByID(Integer.parseInt(itemId));
        String type = item.getType();
    %>
    <div class="item-edit">
        <div class="item-edit-box">
            <h2>Edit Item</h2>
            <form action="itemChangeServlet" method="post">
                <p class="item-edit-note">Note: Leave the input bar empty if you do not want to change it!</p>
                <label for="item-edit-data">New Item Name:</label>
                <input type="text" id="item-edit-input" name="newName">
                <% if (type.equals("text") || type.equals("url") || type.equals("image")) { %>
                    <label for="item-edit-data">New Item Content:</label>
                    <input type="text" id="item-edit-input" name="newContent">

                <% } else if (type.equals("link")) { %>
                    <label for="item-edit-data">New Linked List Name:</label>
                    <select id="list-name" name="newLink">
                        <% for (ListItems thislist : Model.getAllLists()) { %>
                        <option value="<%= thislist.getName() %>"><%= thislist.getName() %></option>
                        <% } %>
                    </select>

                <% } else if (type.equals("combine")) { %>
                    <label for="item-edit-data">Number of Combined Elements:</label>
                    <select id="item-num-options" name="numElements">
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                    <%
                    for (int i = 1; i <= Integer.parseInt(request.getParameter("numElements")); i++) {
                    %>
                        <label for="item-edit-data">Type <%= i %>:</label>
                        <select id="item-type" name="type<%= i %>">
                            <option value="text">Text</option>
                            <option value="url">URL</option>
                            <option value="image">Image</option>
                            <option value="link">Link</option>
                        </select>
                        <label for="item-edit-data">Data <%= i %>:</label>
                        <input type="text" id="item-edit-input" name="value<%= i %>">
                    <% } %>
                    <p class="item-edit-note">Note: If the same type is chosen multiple times, only the last data will be stored!</p>
                <% } %>

                <button class="edit-cancel" type="cancel">Cancel</button>
                <button class="edit-submit" type="submit"  name="Edit">Confirm</button>
            </form>
        </div>
    </div>

    <script>
        var editLists = document.querySelectorAll(".item-editing");
        for (var i = 0; i < editLists.length; i++) {
            editLists[i].addEventListener("click", function() {
                document.querySelector('.item-edit').style.display = 'flex';
            })
        };
        document.querySelector('.item-edit .edit-submit').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.item-edit').style.display = 'none';
        });
        document.querySelector('.item-edit .edit-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.item-edit').style.display = 'none';
        });
    </script>
</body>
</html>