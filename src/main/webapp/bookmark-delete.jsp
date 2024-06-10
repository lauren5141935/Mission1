<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 12:30 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DAO.WIFIDAO" %>
<%@ page import="DTO.WIFIDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="DAO.BOOKMARK_LISTDAO" %>
<%@ page import="DTO.BOOKMARK_LISTDTO" %>
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
            font-family: Arial, sans-serif;
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
<h1> 북마크 그룹 관리</h1>

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
    String id = request.getParameter("id");

    BOOKMARK_LISTDAO bookmarklistDao = new BOOKMARK_LISTDAO();
    BOOKMARK_LISTDTO bookmarklistDto = bookmarklistDao.select(Integer.parseInt(id));

    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String REGISTER_DT = simpleDateFormat.format(bookmarklistDto.getREGISTER_DT());

    BOOKMARK_GROUPDAO bookmarkGroupDao = new BOOKMARK_GROUPDAO();
    BOOKMARK_GROUPDTO bookmarkGroupDto = bookmarkGroupDao.select(bookmarklistDto.getGROUP_ID());

    WIFIDAO wifiDao = new WIFIDAO();
    WIFIDTO wifiDto = wifiDao.select(bookmarklistDto.getMGR_NO());
%>

<form method="post" action="bookmark-delete-submit.jsp">
    <table id="table-list">
        <tr>
            <th>북마크 이름</th>
            <td>
                <%= bookmarkGroupDto.getNAME() %>
            </td>
        </tr>
        <tr>
            <th>와이파이명</th>
            <td>
                <%= wifiDto.getMainNm() %>
            </td>
        </tr>
        <tr>
            <th>등록일자</th>
            <td>
                <%= REGISTER_DT %>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <a href="bookmark-list.jsp">돌아가기</a>
                &#124;
                <input type="submit" name="delete" value="삭제">
                <input type="hidden" name="id" value="<%= bookmarklistDto.getID() %>">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
