<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>list_new</title>
<%@ include file="../include/header.jsp" %>
    <!-- Bootstrap core CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style type="text/css">
#board {
 width: 500px;
}

a:hover {
 opacity: 0.7;
}
</style>
</head>
<body>
    <h3>REVIEW</h3>
    <table class="table table-hover" id="board">
       <colgroup>
         <col width="75%">
         <col width="25%">
       </colgroup>
      <c:forEach var="dto" items="${list}">
      <c:if test="${dto.show == 'y'}"> 
      <tr>
        <td>
          <a href="${path}/board_servlet/view.do?num=${dto.num}" style="text-decoration: none; color: black;">${dto.subject}</a>
        </td>
	    <td>${dto.reg_date}</td>
      </tr>
      </c:if>
      </c:forEach>
    </table>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

</body>
</html>