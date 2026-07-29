<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: tranv
  Date: 7/29/2026
  Time: 12:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
  </head>
  <body>
  <form action="${pageContext.request.contextPath}/size/${sizeUpdate != null ? "update" : "add"}" method="post">
      <div>
          <label>Id</label>
          <input type="text" name="id" value="${sizeUpdate.id}" readonly>
      </div>
      <div>
          <label>Mã</label>
          <input type="text" name="code" value="${sizeUpdate.code}">
      </div>
      <div>
          <label>Tên</label>
          <input type="text" name="name" value="${sizeUpdate.name}">
      </div>
      <button type="submit">${sizeUpdate != null ? 'Update' : 'Add'}</button>
  </form>
  <table>
      <thead>
      <tr>
          <th>ID</th>
          <th>Mã</th>
          <th>Tên</th>
          <th>Hành động</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${sizeList}" var="s">
          <tr>
              <td>${s.id}</td>
              <td>${s.code}</td>
              <td>${s.name}</td>
              <td>
                  <a href="${pageContext.request.contextPath}/size/update?id=${s.id}"><button>Update</button></a>
                  <a href="${pageContext.request.contextPath}/size/delete?id=${s.id}"><button>Delete</button></a>
              </td>
          </tr>
      </c:forEach>
      </tbody>
  </body>
</html>
