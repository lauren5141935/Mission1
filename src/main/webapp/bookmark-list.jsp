<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:19 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DTO.BOOKMARK_LISTDTO" %>
<%@ page import="DAO.BOOKMARK_LISTDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="DAO.BOOKMARK_GROUPDAO" %>
<%@ page import="DTO.BOOKMARK_GROUPDTO" %>
<%@ page import="DAO.WIFIDAO" %>
<%@ page import="DTO.WIFIDTO" %>
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
            border: 1px solid white;
            text-align: center;
            font-size: 14px;
            padding: 8px;
        }

        #table-list tr:nth-child(odd) {
            background-color: white;
        }

        #table-list tr:hover {
            background-color: antiquewhite;
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
<h1>북마크 보기</h1>

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
        <th>북마크 이름</th>
        <th>와이파이명</th>
        <th>등록일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <%
        BOOKMARK_LISTDAO bookmarkListDao = new BOOKMARK_LISTDAO();
        if (bookmarkListDao.count() == 0) {
    %>
    <tr>
        <td colspan="5">
            데이터가 존재하지 않습니다.
        </td>
    </tr>
    <%
    } else {
        List<BOOKMARK_LISTDTO> bookmarkDtoList = bookmarkListDao.selectList();
        for (BOOKMARK_LISTDTO item : bookmarkDtoList) {
            BOOKMARK_GROUPDAO bookmarkGroupDao = new  BOOKMARK_GROUPDAO();
            BOOKMARK_GROUPDTO bookmarkGroupDto = bookmarkGroupDao.select(item.getID());

            WIFIDAO wifiDao = new WIFIDAO();
            WIFIDTO wifiDto = wifiDao.select(item.getMGR_NO());

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String regDate = sdf.format(item.getREGISTER_DT());
    %>
    <tr>
        <td>
            <%= item.getID() %>
        </td>
        <td>
            <%= bookmarkGroupDto.getNAME() %>
        </td>
        <td>
            <a href="detail.jsp?MGR_NO=<%= wifiDto.getMGR_NO() %>">
                <%= wifiDto.getMainNm() %>
            </a>
        </td>
        <td>
            <%= regDate %>
        </td>
        <td>
            <a href="bookmark-delete.jsp?ID=<%= item.getID() %>">
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