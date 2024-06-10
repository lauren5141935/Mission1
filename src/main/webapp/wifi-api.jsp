<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:24 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Service.WIFI" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<style>
    * {
        text-align: center;
    }
</style>
<body>
<%
    WIFI wifi = new WIFI();
    wifi.init();
    wifi.saveBatch();
%>

<h1><%= wifi.total() %>개의 WIFI 정보를 정상적으로 저장하였습니다.</h1>
<a href="index.jsp">홈으로 가기</a>
</body>
</html>
