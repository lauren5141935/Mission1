<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 5/25/24
  Time: 7:28 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DTO.WIFIDTO" %>
<%@ page import="DAO.WIFIDAO" %>
<%@ page import="DAO.BOOKMARK_GROUPDAO" %>
<%@ page import="DTO.BOOKMARK_GROUPDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보 구하기</title>

    <style>
        #link-list {
            margin-bottom: 20px;
        }

        #bookmark-list {
            margin-bottom: 5px;
        }

        #bookmark-list select {
            float: left;
            margin-right: 5px;
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

        #table-list tr:nth-child(odd) {
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
<h1>와이파이 정보 구하기</h1>

<div id="link-list">
    <a href="index.jsp">홈</a>
    <a> |</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a> |</a>
    <a href="wifi-api.jsp">Open API 와이파이 정보 가져오기</a>
    <a> |</a>
</div>

<%
    String MGR_NO = request.getParameter("MGR_NO");
    String dist = request.getParameter("dist");

    WIFIDAO wifiDao = new WIFIDAO();
    WIFIDTO wifiDto = wifiDao.select(MGR_NO);

    BOOKMARK_GROUPDAO bookmarkGroupDao = new BOOKMARK_GROUPDAO();
    List<BOOKMARK_GROUPDTO> bookmarkGroupDtoList = bookmarkGroupDao.selectList();
%>

<div id="bookmark-list">
    <form action="bookmark-add-submit.jsp" method="post" id="bookmark-form">
        <select name="GROUP_ID">
            <option value="none" selected>북마크 그룹 이름 선택</option>
            <%
                for (BOOKMARK_GROUPDTO item : bookmarkGroupDtoList) {
            %>
            <option value="<%= item.getID() %>">
                <%= item.getNAME() %>
            </option>
            <%
                }
            %>
        </select>

        <input type="submit" value="북마크 추가하기">
        <input type="hidden" name="MGR_NO" value="<%= MGR_NO %>">
    </form>
</div>

<table id="table-list">
    <tr>
        <th>거리(Km)</th>
        <td><%= dist %>
        </td>
    </tr>
    <tr>
        <th>관리번호</th>
        <td><%= wifiDto.getMGR_NO() %>
        </td>
    </tr>
    <tr>
        <th>자치구</th>
        <td><%= wifiDto.getWrdofc() %>
        </td>
    </tr>
    <tr>
        <th>와이파이명</th>
        <td><%= wifiDto.getMainNm() %>
        </td>
    </tr>
    <tr>
        <th>도로명주소</th>
        <td><%= wifiDto.getAdres1() %>
        </td>
    </tr>
    <tr>
        <th>상세주소</th>
        <td><%= wifiDto.getAdres2() %>
        </td>
    </tr>
    <tr>
        <th>설치위치(층)</th>
        <td><%= wifiDto.getInstlFloor() %>
        </td>
    </tr>
    <tr>
        <th>설치유형</th>
        <td><%= wifiDto.getInstlTy() %>
        </td>
    </tr>
    <tr>
        <th>설치기관</th>
        <td><%= wifiDto.getInstlMby() %>
        </td>
    </tr>
    <tr>
        <th>서비스구분</th>
        <td><%= wifiDto.getSvcSe() %>
        </td>
    </tr>
    <tr>
        <th>망종류</th>
        <td><%= wifiDto.getCmcwr() %>
        </td>
    </tr>
    <tr>
        <th>설치년도</th>
        <td><%= wifiDto.getCnstcYear() %>
        </td>
    </tr>
    <tr>
        <th>실내외구분</th>
        <td><%= wifiDto.getInoutDoor() %>
        </td>
    </tr>
    <tr>
        <th>WIFI 접속환경</th>
        <td><%= wifiDto.getRemars3() %>
        </td>
    </tr>
    <tr>
        <th>X좌표</th>
        <td><%= wifiDto.getLNT() %>
        </td>
    </tr>
    <tr>
        <th>Y좌표</th>
        <td><%= wifiDto.getLAT() %>
        </td>
    </tr>
    <tr>
        <th>작업일자</th>
        <td><%= wifiDto.getWorkDttm() %>
        </td>
    </tr>
</table>
</body>
</html>
