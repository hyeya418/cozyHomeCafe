<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>review_list</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function() {
	$("#btnWrite").click(function() {
		location.href="${path}/board/write.jsp";
	});
});

//클릭한 페이지로 이동
function list(page) {
	location.href="${path}/board_servlet/list.do?curPage="+page;
}
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
	    <c:if test="${sessionScope.userid != null}">
	      <button type="button" id="btnWrite" class="btn btn-primary btn-sm">글쓰기</button>
	    </c:if>
	    <br><br>
	    <form name="form1" method="post" action="${path}/board_servlet/search.do">
	 	  <select name="search_option" class="form-select" style="width: 170px; display: inline;">
	        <option value="writer">작성자</option>
	        <option value="subject">제목</option>
	        <option value="content">내용</option>
	        <option value="all">이름+제목+내용</option>
	 	  </select>
	      <input name="keyword" class="form-control" placeholder="검색어를 입력하세요." style="width: 350px; display: inline;">
	      <button type="submit" class="btn btn-primary btn-sm">검색</button>
	     </form>
	   </div>
	   <table class="table table-hover" id="board">
	   	 <colgroup>
	       <col width="5%">
	       <col width="20%">
	       <col width="45%">
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
	     <c:if test="${dto.show == 'y'}"> 
		     <tr>
			    <td>${dto.num}</td>
				<td>
				<c:if test="${dto.filesize>0}">
				  <a href="${path}/board_servlet/view.do?num=${dto.num}"><img src="${path}/board/review/${dto.filename}" width="100px" height="100px" style="border-radius: 20px;"></a>
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
		   </c:if>
	  	 </c:forEach>
	  	 <!-- 페이지 네비게이션 출력 --> 
	     <tr>
		   <td colspan="9" align="center">
				<!-- 현재페이지가 1보다 크면 [처음]버튼 보이도록 설정 -->
				<c:if test="${page.curPage > 1}">
			    <a href="#" onclick="list('1')" style="text-decoration: none; color: black;">[처음]</a>
	   		    </c:if>	   
			    <!-- 현재블럭이 1보다 크면 [이전]버튼 보이도록 설정 -->
			    <c:if test="${page.curBlock > 1}">
			      <a href="#" onclick="list('${page.prevPage}')" style="text-decoration: none; color: black;">[이전]</a>
				</c:if>
					   
			 	<!-- 블럭시작부터 끝까지 출력, 현재 페이지의 블럭은 red로 처리 -->
				<c:forEach var="num" begin="${page.blockStart}" end="${page.blockEnd}">
				  <c:choose>
					 <c:when test="${num == page.curPage}">
						 <span style="color: red;">${num}</span>
					 </c:when>
					 <c:otherwise>
						 <a href="#" onclick="list('${num}')" style="text-decoration: none; color: black;">${num}</a>
					 </c:otherwise>
							     
				  </c:choose>
				</c:forEach>
					   
				<!-- 현재 블럭이 전체 블럭보다 작으면 [다음]버튼 보이도록 설정 -->
			       <c:if test="${page.curBlock < page.totBlock}">
					  <a href="#" onclick="list('${page.nextPage}')" style="text-decoration: none; color: black;">[다음]</a>
				   </c:if>
				<!-- 현재 페이지가 전체 페이지보다 작으면 [끝]버튼 출력 -->
				   <c:if test="${page.curPage < page.totPage}">
					  <a href="#" onclick="list('${page.totPage}')" style="text-decoration: none; color: black;">[끝]</a>
				   </c:if>
			</td>
		  </tr>
	 </table>
    </main>
    
	<%@ include file="../include/footer.jsp" %>
 </div>
</body>
</html>