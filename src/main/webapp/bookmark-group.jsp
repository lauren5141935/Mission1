<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:14 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="DAO.BOOKMARK_GROUPDAO" %>
<%@ page import="DTO.BOOKMARK_GROUPDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>

    <style>
        #link-list {
            margin-bottom: 20px;
        }

        #table-list {
            font-family: Arial, Helvetica, sans-serif;
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
            background-color:WHITE;
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
<h1>북마크 그룹 관리</h1>

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

<button onclick="location.href='bookmark-group-add.jsp';">
    북마크 그룹 이름 추가
</button>

<table id="table-list">
    <thead>
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>순서</th>
        <th>등록일자</th>
        <th>수정일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <%
        BOOKMARK_GROUPDAO bookmarkGroupDao = new BOOKMARK_GROUPDAO();
        if (bookmarkGroupDao.count() == 0) {
    %>
    <tr>
        <td colspan="6">
            데이터가 존재하지 않습니다.
        </td>
    </tr>
    <%
    } else {
        List<BOOKMARK_GROUPDTO> bookmarkGroupDtoList = bookmarkGroupDao.selectList();
        for (BOOKMARK_GROUPDTO item : bookmarkGroupDtoList) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String regDate = sdf.format(item.getREGISTER_DT());
            String uptDate = item.getUPDATE_DT() == null ? "" : sdf.format(item.getUPDATE_DT());
    %>
    <tr>
        <td>
            <%= item.getID() %>
        </td>
        <td>
            <%= item.getNAME() %>
        </td>
        <td>
            <%= item.getSEQUENCE() %>
        </td>
        <td>
            <%= regDate %>
        </td>
        <td>
            <%= uptDate %>
        </td>
        <td>
            <a href="bookmark-group-edit.jsp?id=<%= item.getID() %>">
                수정
            </a>
            <a href="bookmark-group-delete.jsp?id=<%= item.getID() %>">
                삭제
            </a>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
</body>
</html>
