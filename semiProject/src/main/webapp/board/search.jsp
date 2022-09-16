<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>review_search</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function() {
	$("#btnWrite").click(function() {
		location.href="${path}/board/write.jsp";
	});
	$("#btnList").click(function() {
		location.href="${path}/board_servlet/list.do";
	});
});
</script>
<style type="text/css">
main {
 height: auto;
}

#title_box {
 text-align: center;
 padding-bottom: 20px;
}

#board {
 margin: auto; 
 width: 60%;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
 <div id="page"> 
	<%@ include file="../include/menu.jsp" %>
	
    <main>
      <div id="title_box">
	    <h1>REVIEW BOARD</h1>
	    <span style="font-size: 14px;">※해당 게시판은 회원만 작성할 수 있습니다. &nbsp;</span>
	    <button type="button" class="btn btn-primary btn-sm" id="btnList">목록</button>
	    <c:if test="${sessionScope.userid != null}">
	      <button id="btnWrite" class="btn btn-primary btn-sm">글쓰기</button>
	    </c:if>
	    <br><br>
		 <form name="form1" method="post" action="${path}/board_servlet/search.do">
		   <select name="search_option" class="form-select" style="width: 170px; display: inline;">
		    <c:choose>
		      <c:when test="${search_option == 'writer'}">
		        <option value="writer" selected>이름</option>
		        <option value="subject">제목</option>
		        <option value="content">내용</option>
		        <option value="all">이름+제목+내용</option>
		      </c:when>
		      <c:when test="${search_option == 'subject'}">
		        <option value="writer">이름</option>
		        <option value="subject" selected>제목</option>
		        <option value="content">내용</option>
		        <option value="all">이름+제목+내용</option>
		      </c:when>
		      <c:when test="${search_option == 'content'}">
		        <option value="writer">이름</option>
		        <option value="subject">제목</option>
		        <option value="content" selected>내용</option>
		        <option value="all">이름+제목+내용</option>
		      </c:when>
		      <c:when test="${search_option == 'all'}">
		        <option value="writer">이름</option>
		        <option value="subject">제목</option>
		        <option value="content">내용</option>
		        <option value="all" selected>이름+제목+내용</option>
		      </c:when>
		    </c:choose>
		   </select>
		   <input name="keyword" class="form-control" value="${keyword}" style="width: 350px; display: inline; text-align: left;">
		   <button type="submit" class="btn btn-primary btn-sm">검색</button>
		 </form>
	   </div>
	   <table class="table table-hover" id="board">
	   	 <colgroup>
	       <col width="5%">
	       <col width="30%">
	       <col width="35%">
	       <col width="10%">
	       <col width="15%">
	       <col width="5%">
	     </colgroup>
	     <tr>
	       <th>번호</th>
	       <th>&nbsp;</th>
	       <th>제목</th>
	       <th>작성자</th>
	       <th>작성일</th>
	       <th>조회수</th>
	     </tr>
	   <c:forEach var="dto" items="${list}">
	     <tr>
		    <td>${dto.num}</td>
			<td>
			<c:if test="${dto.filesize>0}">
			  <img src="${path}/board/review/${dto.filename}" width="100px" height="100px">
			</c:if>
			</td>
			<td>
			<!-- 답글 들여쓰기 -->
			<c:forEach var="i" begin="1" end="${dto.re_level}">
			   &nbsp;&nbsp;
			</c:forEach>
			  <a href="${path}/board_servlet/view.do?num=${dto.num}" style="text-decoration: none; color: black;">${dto.subject}</a>
			  <!-- 댓글 개수 표시 -->
			  <c:if test="${dto.comment_count > 0}">
			    <span style="color: red;">(${dto.comment_count})</span>
			  </c:if>
			</td>
			<td>${dto.writer}</td>
			<td>${dto.reg_date}</td>
			<td>${dto.readcount}</td>
		 </tr>
		   </c:forEach>
	   </table>
    </main>
    
	<%@ include file="../include/footer.jsp" %>
 </div>

</body>
</html>