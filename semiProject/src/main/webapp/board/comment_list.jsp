<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>comment_list</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
table {
 width: 100%;
}
</style>
</head>
<body>
  <table>
    <c:forEach var="row" items="${list}">
      <tr>
        <td style="font-size: 13px;">
		   ${row.writer}
		   (<fmt:formatDate value="${row.reg_date}" pattern="yyyy-MM-dd hh:mm:ss" />)
        </td>
      </tr>
      <tr>
        <td style="font-size: 15px; border-bottom: 1px solid #eaeaea;">
          ${row.content}
        </td>
      </tr>
    </c:forEach>
  </table>
</body>
</html>