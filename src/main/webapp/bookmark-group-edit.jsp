<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/8/24
  Time: 11:14 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DAO.BOOKMARK_GROUPDAO" %>
<%@ page import="DTO.BOOKMARK_GROUPDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>

    <style>
        #link-list {
            margin-bottom: 20px;
        }

        #table-list {
            font-family: Arial,  sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        #table-list td, #table-list th {
            border: 1px solid WHITE;
            font-size: 14px;
            padding: 8px;
        }

        #table-list tr:nth-child(even) {
            background-color: WHITE;
        }

        #table-list th {
            background-color: rgba(47, 191, 90, 0.94);
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: center;
            color: white;
            width: 20%;
        }
    </style>
</head>
<body>
<h1>북마크 그룹 수정</h1>

<div id="link-list">
    <a href="index.jsp">홈</a>
    <a> |</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a> |</a>
    <a href="wifi-api.jsp">Open API 와이파이 정보 가져오기</a>
    <a> |</a>
    <a href="bookmark-list.jsp"> 북마크 보기</a>
    <a> |</a>
    <a href="bookmark-group.jsp">북마크 그룹 관리</a>
</div>

<%
    String ID = request.getParameter("ID");

    BOOKMARK_GROUPDAO bookmarkGroupDao = new BOOKMARK_GROUPDAO();
    BOOKMARK_GROUPDTO bookmarkGroupDto = bookmarkGroupDao.select(Integer.parseInt(ID));
%>

<form method="post" action="bookmark-group-edit-submit.jsp">
    <table id="table-list">
        <tr>
            <th>북마크 이름</th>
            <td>
                <input type="text" name="name" value="<%= bookmarkGroupDto.getNAME() %>">
            </td>
        </tr>
        <tr>
            <th>순서</th>
            <td>
                <input type="text" name="seq" value="<%= bookmarkGroupDto.getSEQUENCE() %>">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <a href="bookmark-group.jsp">돌아가기</a>
                <a> |</a>
                <input type="submit" name="edit" value="수정">
                <input type="hidden" name="id" value="<%= bookmarkGroupDto.getID() %>">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
