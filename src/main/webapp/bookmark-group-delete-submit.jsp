<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:15 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DAO.BOOKMARK_GROUPDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String ID = request.getParameter("ID");

    BOOKMARK_GROUPDAO bookmarkGroupDao = new BOOKMARK_GROUPDAO();
    int affected = bookmarkGroupDao.delete(Integer.parseInt(ID));
%>

<script>
    <%
        String text = affected > 0 ? "북마크 그룹 데이터를 삭제하였습니다." : "북마크 그룹 데이터를 삭제하지 못했습니다.";
    %>
    alert("<%= text %>");
    location.href = "bookmark-group.jsp";
</script>
</body>
</html>