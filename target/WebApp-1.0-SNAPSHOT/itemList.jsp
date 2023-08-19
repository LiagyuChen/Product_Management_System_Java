<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Item Lists</title>
  </head>
  <body>
    <h1>Item Lists</h1>
    <table>
      <tr>
        <th>List Name</th>
        <th>View Items</th>
        <th>Edit List</th>
        <th>Delete List</th>
      </tr>
      <c:forEach items="${itemLists}" var="itemList">
        <tr>
          <td>${itemList.name}</td>
          <td><a href="ItemListServlet?id=${itemList.id}">View Items</a></td>
          <td><a href="editItem.jsp?id=${itemList.id}">Edit List</a></td>
          <td><a href="ItemListServlet?action=delete&id=${itemList.id}">Delete List</a></td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>
