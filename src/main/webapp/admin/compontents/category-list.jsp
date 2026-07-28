<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: tranv
  Date: 7/28/2026
  Time: 1:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/category/update"><button>Add</button></a>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Mã</th>
        <th>Tên</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${categories}" var="c">
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
