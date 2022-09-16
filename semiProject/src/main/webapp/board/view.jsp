<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>review_view</title>
<%@ include file="../include/header.jsp" %>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
	comment_list();//댓글 리스트
	$("#btnList").click(function() {//목록 버튼
		location.href="${path}/board_servlet/list.do";
	});
	$("#btnReply").click(function() {//답변 버튼
		document.form1.action="${path}/board_servlet/reply.do";
		document.form1.submit();
	});
	$("#btnEdit").click(function() {//수정/삭제 버튼
		document.form1.action="${path}/board_servlet/pass_check.do";
		document.form1.submit();
	});
	
});

function comment_add(){
	var param="board_num=${dto.num}&writer="+$("#writer").val()
				+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/board_servlet/comment_add.do",
		data: param,
		success: function(){//콜백함수(댓글 저장이 완료된 후 호출)
			$("#writer").val("");
			$("#content").val("");
			comment_list();//댓글 등록 후 목록 갱신
		}
	});
}
function comment_list(){
	$.ajax({
		type: "post",
		url: "${path}/board_servlet/commentList.do",
		data: "num=${dto.num}",
		success: function(result){
			$("#commentList").html(result);
		}
	});
}
</script>
<style type="text/css">
#page {
 width: 70%;
 margin: auto;
}

main {
 height: auto;
}

#review_box {
 width: 100%;
}

#board {
 margin: auto; 
 border-collapse: collapse; 
 width: 63%;
 height: auto;
 font-size: 14px;
 text-align: center;
 line-height: 40px;
 border: 1px solid #eaeaea;
}

#board td{ 
 border-top : 1px solid  #eaeaea; 
 border-bottom : 1px solid  #eaeaea; 
 height: 20px;
}

#comment_board {
 margin: auto; 
 border-collapse: collapse; 
 width: 63%;
 height: auto;
 font-size: 14px;
 line-height: 40px;
}

#writer, #content {
 width: 90%;
 height: 28px;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

 <div id="page">
	
    <main>
		<div id="review_box">
			<form name="form1" method="post">
			<table id="board">
			  <tr>
			    <td colspan="4" align="center"><h2>리뷰</h2></td>
			  </tr>
			  <tr>
			    <td>작성일</td>
			    <td>${dto.reg_date}</td>
			    <td>조회수</td>
			    <td>${dto.readcount}</td>
			  </tr>
			  <tr>
			   <td>작성자</td>
			   <td colspan="3">${dto.writer}</td>
			  </tr>
			  <tr>
			   <td>제목</td>
			   <td colspan="3">${dto.subject}</td>
			  </tr>
			  <tr>
			   <td colspan="4">
			    <c:if test="${dto.filesize>0}">
		         <img src="${path}/board/review/${dto.filename}" width="300px" height="300px" style="border-radius: 20px;">
			    </c:if>
			   </td>
			  </tr>
			  <tr style="line-height: 300px;">
			   <td>본문</td>
			   <td colspan="3">
			     ${dto.content}
			   </td>
			  </tr>
			  <c:if test="${sessionScope.userid != null}">
			  <tr>
			   <td>비밀번호</td>
			   <td colspan="3">
			    <input type="password" name="passwd" class="form-control" required style="width: 200px;">
			    <c:if test="${param.message =='error'}">
			     <span style="color:red;">
			      비밀번호가 일치하지 않습니다.
			     </span>
			    </c:if>
			   </td>
			  </tr>
			  </c:if>
			  <tr>
			   <td colspan="4" align="center">
			    <input type="hidden" name="num" value="${dto.num}">
			    <c:if test="${sessionScope.userid != null}">
				  <button type="button" class="btn btn-primary" id="btnEdit">수정</button>
			      <button type="button" class="btn btn-secondary" id="btnReply">답변</button>
			    </c:if>
			    <button type="button" class="btn btn-secondary" id="btnList">목록</button>
			   </td>
			  </tr>
			</table>
			</form>

			<!-- 댓글 쓰기 폼 -->
			<table id="comment_board">
			 <colgroup>
			  <col width="20%">
			  <col width="70%">
			  <col width="10%">
			 </colgroup>
			 <tr>
			   <td colspan="3" style="font-weight: bold; font-size: 16px;">댓글</td>
			 </tr>
			 <tr>
			  <td><input id="writer" class="form-control" placeholder="작성자" ></td>
			  <td><input class="form-control" placeholder="내용을 입력하세요" id="content"></td>
			  <td>
			   <button type="button" id="btnSave" class="btn btn-primary btn-sm" onclick="comment_add()">등록</button>
			  </td>
			 </tr>
			 <tr>
			  <!-- 댓글 목록 -->
			  <td colspan="3"><div id="commentList"></div></td>
			 </tr>
			</table>
    	</div>
    </main>
    
</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>