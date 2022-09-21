<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>dbCheckId</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
function sendCheckValue() {
	var openForm=opener.document.form1;
	
	if(document.checkIdForm.checkResult.value=="N") {
		alert("다른 아이디를 입력해주세요.");
		openForm.userid.focus();
		
		window.close();
	}else {
		//중복체크 결과 값 전달
		openForm.idDuplication.value="idCheck";
		openForm.dbCheckId.disabled=true;
		openForm.dbCheckId.style.opacity=0.6;
		openForm.dbCheckId.style.cursor="default";
		window.close();
	}
}
</script>
</head>
<body>
<div>
<h4>ID 중복확인</h4>

<form name="checkIdForm">
 <input name="userid" value="${param.userid}" id="userid" disabled>
 
 <c:choose>
  <c:when test="${result==1}">
  	<p style="color: red">이미 사용중인 아이디입니다.</p>
  	<input type="hidden" name="checkResult" value="N">
  </c:when>
  <c:when test="${result==0}">
  	<p style="color: red">사용가능한 아이디입니다.</p>
  	<input type="hidden" name="checkResult" value="Y">
  </c:when>
  <c:otherwise>
    <p>오류 발생(-1)</p>
    <input type="hidden" name="checkResult" value="N">
  </c:otherwise>
 </c:choose>
 
 <input type="button" onclick="window.close()" value="취소">
 <input type="button" onclick="sendCheckValue()" value="사용하기">
</form>
</div>


</body>
</html>