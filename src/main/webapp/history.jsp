<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:13 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DAO.WIFI_HISTORYDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DTO.WIFI_HISTORYDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>

    <style>
        #link-list {
            margin-bottom: 20px;
        }

        #table-list {
            font-family: Arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #table-list td, #table-list th {
            border: 1px solid #ddd;
            text-align: center;
            font-size: 14px;
            padding: 8px;
        }

        #table-list tr:nth-child(odd) {
            background-color: WHITE;
        }

        #table-list tr:hover {
            background-color: WHITE;
        }

        #table-list th {
            background-color: rgba(47, 191, 90, 0.94);
            padding-top: 12px;
            padding-bottom: 12px;
            color: white;
        }
    </style>
</head>
<body>
<h1>위치 히스토리 목록</h1>

<div id="link-list">
    <a href="index.jsp">홈</a>
    <a> |</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a> |</a>
    <a href="wifi-api.jsp">Open API 와이파이 정보 가져오기</a>
    <a> |</a>
    <a href="bookmark-list.jsp">북마크 보기</a>
    <a> |</a>
    <a href="bookmark-group.jsp">북마크 그룹 관리</a>
</div>

<table id="table-list">
    <thead>
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>조회일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <%
        WIFI_HISTORYDAO wifihistoryDao = new WIFI_HISTORYDAO();
        if (wifihistoryDao.cnt() == 0) {
    %>
    <tr>
        <td colspan="5">
            데이터가 존재하지 않습니다.
        </td>
    </tr>
    <%
    } else {
        List<WIFI_HISTORYDTO> wifihistoryDtoList = wifihistoryDao.selectList();
        for (WIFI_HISTORYDTO item : wifihistoryDtoList) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String strDate = sdf.format(item.getSEARCH_DT());
    %>
    <tr>
        <td>
            <%= item.getID() %>
        </td>
        <td>
            <%= item.getLAT() %>
        </td>
        <td>
            <%= item.getLNT() %>
        </td>
        <td>
            <%= strDate %>
        </td>
        <td>
            <button onclick="deleteID(<%= item.getID() %>);">삭제</button>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

<script>
    function deleteID(ID) {
        location.href = "history-delete.jsp?ID=" + ID;
    }
</script>
</body>
</html>
