<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:13 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DTO.WIFIDTO" %>
<%@ page import="DAO.WIFIDAO" %>
<%@ page import="DTO.WIFI_HISTORYDTO" %>
<%@ page import="DAO.WIFIDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.WIFI_HISTORYDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <title>와이파이 정보 구하기</title>

    <style>
        #link-list {
            margin-bottom: 20px;
        }

        #form-list {
            margin-bottom: 10px;
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
<h1>와이파이 정보 구하기</h1>

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

<form method="get" action="index.jsp" id="form-list">
    <label>
        LAT: <input type="text" id="LAT" name="LAT" value="0.0">
    </label>
    <label>
        LNT: <input type="text" id="LNT" name="LNT" value="0.0">
    </label>
    <input type="button" value="내 위치 가져오기" onclick="getLocation();">
    <input type="submit" value="근처 WIFI 정보 보기">
</form>

<table id="table-list">
    <thead>
    <tr>
        <th>거리(Km)</th>
        <th>관리번호</th>
        <th>자치구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내외구분</th>
        <th>WIFI 접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>
    </thead>
    <tbody>
    <%
        String LAT = request.getParameter("LAT");
        String LNT = request.getParameter("LNT");

        double LATValue = 0.0;
        double LNTValue = 0.0;

        if (LAT != null && !LAT.isEmpty()) {
            try {
                LATValue = Double.parseDouble(LAT);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (LNT != null && !LNT.isEmpty()) {
            try {
                LNTValue = Double.parseDouble(LNT);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        if (LATValue == 0.0 && LNTValue == 0.0) {
    %>
    <tr>
        <td colspan="17">위치 정보를 입력한 후에 조회해 주세요.</td>
    </tr>
    <%
    } else {
        WIFI_HISTORYDTO wifihistoryDto = new WIFI_HISTORYDTO();
        wifihistoryDto.setLAT(LATValue);
        wifihistoryDto.setLNT(LNTValue);

        WIFI_HISTORYDAO wifihistoryDao = new WIFI_HISTORYDAO();
        wifihistoryDao.insert(wifihistoryDto);

        WIFIDAO wifiDao = new WIFIDAO();
        List<WIFIDTO> wifiDaoList = wifiDao.selectList(LNTValue, LATValue);

        for (WIFIDTO item : wifiDaoList) {
    %>
    <tr>
        <td>
            <%= item.getDist() %>
        </td>
        <td>
            <%= item.getMGR_NO() %>
        </td>
        <td>
            <%= item.getWrdofc() %>
        </td>
        <td>
            <a href="detail.jsp?MGR_NO=<%= item.getMGR_NO() %>&dist=<%= item.getDist() %>">
                <%= item.getMainNm() %>
            </a>
        </td>
        <td>
            <%= item.getAdres1() %>
        </td>
        <td>
            <%= item.getAdres2() %>
        </td>
        <td>
            <%= item.getInstlFloor() %>
        </td>
        <td>
            <%= item.getInstlTy() %>
        </td>
        <td>
            <%= item.getInstlMby() %>
        </td>
        <td>
            <%= item.getSvcSe() %>
        </td>
        <td>
            <%= item.getCmcwr() %>
        </td>
        <td>
            <%= item.getCnstcYear() %>
        </td>
        <td>
            <%= item.getInoutDoor() %>
        </td>
        <td>
            <%= item.getRemars3() %>
        </td>
        <td>
            <%= item.getLNT() %>
        </td>
        <td>
            <%= item.getLAT() %>
        </td>
        <td>
            <%= item.getWorkDttm() %>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

<script>
    const params = new URLSearchParams(window.location.search)
    const LNT = params.get("LNT")
    const LAT = params.get("LAT")

    if (LNT) {
        const LNTElement = document.getElementById("LNT")
        LNTElement.setAttribute("value", LNT)
    }

    if (LAT) {
        const LATElement = document.getElementById("LAT")
        LATElement.setAttribute("value", LAT)
    }

    function showPosition(position) {
        const LAT = position.coords.latitude;
        const LNT = position.coords.longitude;

        document.getElementById("LAT").value = LAT;
        document.getElementById("LNT").value = LNT;
    }

</script>
</body>
</html>