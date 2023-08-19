<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Add Item</title>
  </head>
  <body>
    <h1>Add Item</h1>
    <form method="post" action="ItemServlet">
      <label for="name">Name:</label>
      <input type="text" id="name" name="name"><br>
      <label for="list">List:</label>
      <select id="list" name="list">
        <c:forEach items="${itemLists}" var="itemList">
          <option value="${itemList.id}">${itemList.name}</option>
        </c:forEach>
      </select><br>
      <label for="url">URL:</label>
      <input type="text" id="url" name="url"><br>
      <label for="image">Image:</label>
      <input type="text" id="image" name="image"><br>
      <label for="text">Text:</label>
      <textarea id="text" name="text"></textarea><br>
      <input type="submit" value="Add Item">
    </form>
  </body>
</html>
