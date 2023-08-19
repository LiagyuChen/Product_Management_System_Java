<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Item</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Search Item</h1>
<form action="SearchServlet" method="get">
    <label for="searchTerm">Search Term:</label>
    <input type="text" name="searchTerm"><br>
    <input type="submit" value="Search">
</form>
<a href="itemList.jsp">Back to Item List</a>
</body>
</html>
