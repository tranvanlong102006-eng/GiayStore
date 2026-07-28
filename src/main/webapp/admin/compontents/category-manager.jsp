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
<form action="${pageContext.request.contextPath}/category/${categoryDetail != null ? 'update' : 'add'}" method="post">
    <div>
        <label>Id</label>
        <input type="text" name="id" value="${categoryDetail.id}" readonly>
    </div>
    <div>
        <label>Mã</label>
        <input type="text" name="code" value="${categoryDetail.code}">
    </div>
    <div>
        <label>Tên</label>
        <input type="text" name="name" value="${categoryDetail.name}">
    </div>
    <button type="submit">${categoryDetail != null ? 'update' : 'add'}</button>
    <a href="${pageContext.request.contextPath}/category/findAll"><button>List</button></a>
</form>
</body>
</html>
