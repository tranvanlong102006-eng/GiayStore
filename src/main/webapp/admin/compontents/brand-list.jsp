<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: tranv
  Date: 7/29/2026
  Time: 10:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/brand/${brandUpdate != null ? "update" : "add"}" method="post">
    <div>
        <label>Id</label>
        <input type="text" name="id" value="${brandUpdate.id}" readonly>
    </div>
    <div>
        <label>Mã</label>
        <input type="text" name="code" value="${brandUpdate.code}">
    </div>
    <div>
        <label>Tên</label>
        <input type="text" name="name" value="${brandUpdate.name}">
    </div>
    <button type="submit">${brandUpdate != null ? 'Update' : 'Add'}</button>
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
    <c:forEach items="${brandList}" var="b">
        <tr>
            <td>${b.id}</td>
            <td>${b.code}</td>
            <td>${b.name}</td>
            <td>
                <a href="${pageContext.request.contextPath}/brand/update?id=${b.id}"><button>Update</button></a>
                <a href="${pageContext.request.contextPath}/brand/delete?id=${b.id}"><button>Delete</button></a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
