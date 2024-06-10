<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:13 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DAO.WIFI_HISTORYDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<%
    String ID = request.getParameter("ID");

    WIFI_HISTORYDAO historyDao = new WIFI_HISTORYDAO();
    int affected = historyDao.delete(Integer.valueOf(ID));
%>

<script>
    <%
        String text = affected > 0 ? "위치 히스토리 데이터를 삭제하였습니다." : "위치 히스토리 데이터를 삭제하지 못했습니다.";
    %>
    alert("<%= text %>");
    location.href = "history.jsp";
</script>
</body>
</html>