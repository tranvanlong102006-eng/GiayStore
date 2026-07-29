<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: tranv
  Date: 7/29/2026
  Time: 11:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/category/${categoryUpdate != null ? 'update' : 'add'}" method="post">
    <div>
        <label>Id</label>
        <input type="text" name="id" value="${categoryUpdate.id}" readonly>
    </div>
    <div>
        <label>Mã</label>
        <input type="text" name="code" value="${categoryUpdate.code}">
    </div>
    <div>
        <label>Tên</label>
        <input type="text" name="name" value="${categoryUpdate.name}">
    </div>
    <button type="submit">${categoryUpdate != null ? 'Update' : 'Add'}</button>
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
    <c:forEach items="${categoryList}" var="c">
        <tr>
            <td>${c.id}</td>
            <td>${c.code}</td>
            <td>${c.name}</td>
            <td>
                <a href="${pageContext.request.contextPath}/category/update?id=${c.id}"><button>Update</button></a>
                <a href="${pageContext.request.contextPath}/category/delete?id=${c.id}"><button>Delete</button></a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
