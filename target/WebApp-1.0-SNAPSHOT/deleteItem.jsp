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
    <div class="delete-page">
        <div class="delete-page-content">
            <h3>Are you sure to delete this item?</h3>
            <div class="item-delete-note">Note: All the contents in this item will also be deleted!</div>
            <form action="itemChangeServlet" method="POST">
                <button class="delete-cancel" type="cancel">Cancel</button>
                <button class="delete-submit" type="submit"  name="Delete">Delete</button>
            </form>
        </div>
    </div>

    <script>
        var deleteLists = document.querySelectorAll(".item-delete");
        for (var i = 0; i < deleteLists.length; i++) {
            deleteLists[i].addEventListener("click", function() {
                document.querySelector('.delete-page').style.display = 'flex';
            })
        };
        document.querySelector('.delete-page .delete-submit').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.delete-page').style.display = 'none';
        });
        document.querySelector('.delete-page .delete-cancel').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('.delete-page').style.display = 'none';
        });
    </script>
</body>
</html>