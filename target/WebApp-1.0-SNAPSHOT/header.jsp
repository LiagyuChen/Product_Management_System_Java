<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Objects" %>
<%@ page import="model.itemlist.*" %>
<%@ page import="model.Model" %>
<%@ page import="model.ModelFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- 
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body> --%>
<% Model model = ModelFactory.getModel(); %>
<!-- Header section -->
<header>
    <h1>List Items</h1>
    <form id="searchForm" action="Search" method="POST">
        <input class="header-search" type="text" name="searchQuery" placeholder="Enter full list/item name" required>
        <button class="header-search-submit" type="submit" name="Search">SearchB</button>
    </form>


    <script>
        $(function() {
            $('#searchForm').submit(function(event) {
            event.preventDefault(); // Prevent the default form submission
            $.ajax({
                url: 'Search',
                type: 'POST',
                data: $(this).serialize(), // Serialize the form data
                success: function(response) {
                    $('#searchResultContainer').html(response)
            }})
            })
        })

    </script>

    <!-- item search result list -->
    <div id="searchResultContainer">
        <div class="search-result">
        <ul>
            <%
            List<ListItems> searchListResult = (List<ListItems>) request.getAttribute("searchListResult");
            List<Item> searchItemResult = (List<Item>) request.getAttribute("searchItemResult");
            if (searchListResult != null) {
            for (ListItems thislist : searchListResult) {
            %>
            <li><a class="search-result-list" href="listItem.jsp?id=<%= thislist.getID() %>"><%= "[List]   " + thislist.getName() %></a></li>
            <% } }
            if (searchItemResult != null) {
            for (Item thisitem : searchItemResult) {
            %>
            <li><a class="search-result-list" href="listItem.jsp?id=<%= thisitem.getID() %>"><%= "[Item]   " + thisitem.getName() %></a></li>
            <% } } %>
            <%
            if (searchListResult == null || searchItemResult == null) {
            %>
            <li>No Result Found</li>
            <% } %>
        </ul>
        </div>
    </div>


</header>

<script>
    // search result
    document.querySelector('.header-search').addEventListener('click', function(e) {
        e.preventDefault()
        document.querySelector('.search-result').style.display = 'flex'
    })



</script>
<%-- </body>
</html> --%>
