<%--
  Created by IntelliJ IDEA.
  User: laurenhyobinjung
  Date: 6/1/24
  Time: 11:16 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="DTO.BOOKMARK_LISTDTO" %>
<%@ page import="DAO.BOOKMARK_LISTDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String GROUP_ID = request.getParameter("GROUP_ID");
    String MGR_NO = request.getParameter("MGR_NO");

    if (GROUP_ID.equals("none")) {
        response.sendRedirect(request.getHeader("Referer"));
        return;
    }

    BOOKMARK_LISTDTO bookmarkDto = new BOOKMARK_LISTDTO();
    bookmarkDto.setGROUP_ID(Integer.parseInt(GROUP_ID));
    bookmarkDto.setMGR_NO(MGR_NO);

    BOOKMARK_LISTDAO bookmarkDao = new BOOKMARK_LISTDAO();
    int affected = bookmarkDao.upsert(bookmarkDto);
%>

<script>
    <%
        String text = affected > 0 ? "북마크에 데이터를 추가하였습니다." : "북마크에 데이터를 추가하지 못했습니다.";
    %>
    alert("<%= text %>");
    location.href = "bookmark-list.jsp";
</script>
</body>
</html>
