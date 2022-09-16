<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>notice_view</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function() {
	comment_list();
	$("#btnList").click(function() {
		location.href="${path}/notice_servlet/list.do";
	});
	$("#btnReply").click(function() {
		document.form1.action="${path}/notice_servlet/reply.do";
		document.form1.submit();
	});
	$("#btnEdit").click(function() {
		document.form1.action="${path}/notice_servlet/pass_check.do";
		document.form1.submit();
	});
	
});

function comment_add(){
	var param="notice_num=${dto.num}&writer="+$("#writer").val()
				+"&content="+$("#content").val();
	$.ajax({
		type: "post",
		url: "${path}/notice_servlet/comment_add.do",
		data: param,
		success: function(){
			$("#writer").val("");
			$("#content").val("");
			comment_list();//댓글 등록 후 목록 갱신
		}
	});
}

function comment_list(){
	$.ajax({
		type: "post",
		url: "${path}/notice_servlet/commentList.do",
		data: "num=${dto.num}",
		success: function(result){
			$("#commentList").html(result);
		}
	});
}
</script>
<style type="text/css">
#page {
 width: 80%;
 margin: auto;
}

main {
 height: auto;
}

#notice_box {
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
 width: 60%;
 height: auto;
 font-size: 14px;
 line-height: 40px;
}

#writer, #content {
 width: 90%;
 height: 28px;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>

 <div id="page">
	
    <main>
    	<div id="notice_box">
			<form name="form1" method="post">
			<table id="board">
			  <tr>
			    <td colspan="4" align="center"><h2>공지사항</h2></td>
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
			  <tr style="line-height: 300px;">
			   <td>본문</td>
			   <td colspan="3">${dto.content}</td>
			  </tr>
			  <c:if test="${sessionScope.admin_userid != null}">
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
			   <td>첨부파일</td>
			   <td colspan="3">
			    <c:if test="${dto.filesize > 0}">
			     ${dto.filename}(${dto.filesize} bytes)
			     <a href="${path}/notice_servlet/download.do?num=${dto.num}">[다운로드]</a>
			    </c:if> 
			   </td>
			  </tr>
			  <tr>
			   <td colspan="4" align="center">
			    <input type="hidden" name="num" value="${dto.num}">
			    <c:if test="${sessionScope.admin_userid != null}">
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
			  <td><input id="writer" class="form-control" placeholder="작성자"></td>
			  <td><input id="content" class="form-control" placeholder="내용을 입력하세요" ></td>
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