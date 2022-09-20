<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>mypage_edit</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<script type="text/javascript">
$(function() {
	$("#btnUpdate").click(function() {
		var pw1=$("#pw1").val();
		var pw2=$("#pw2").val();
		var name=$("#name").val();
		var tel=$("#tel").val();
		var email=$("#email").val();
		if(pw1=="") {
			alert("비밀번호를 입력하세요.");
			$("#pw1").focus();
			return;
		}
		if(pw2=="") {
			alert("비밀번호 확인 입력하세요.");
			$("#pw2").focus();
			return;
		}
		//비밀번호 조건 (영문자, 숫자, 특수기호(~!@#$%^&*)를 모두 사용해서 8~20자리로 입력)
		var exp2 = /^(?=.*[a-z])(?=.*[~!@#$%^&*])(?=.*\d).{8,20}$/;
		if(!exp2.test(pw1)) {
			alert("비밀번호는 영문자, 숫자, 특수기호(~!@#$%^*)를 모두 사용해서 8~12자리로 입력하세요.");
			$("#pw1").focus();
			return;
		}	
		if(pw1!=pw2) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			return false;
		}
		if(name=="") {
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		}
		//이름 조건
		var exp3 = /^[가-힣]+$/;
		if(!exp3.test(name)) {
			alert("이름은 한글만 입력하세요.");
			$("#name").focus();
			return;
		}
		if(tel=="") {
			alert("전화번호를 입력하세요.");
			$("#tel").focus();
			return;
		}
		//전화번호 조건
		var exp4 = /^[0-9]{3}[0-9]{3,4}[0-9]{4}$/;
		if(!exp4.test(tel)) {
			alert("전화번호 형식이 맞지 않습니다. ex) 01012345678");
			$("#tel").focus();
			return;
		}
		if(email=="") {
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return;
		}
		//이메일 조건
		var exp5 = /^[a-z0-9]{2,}@[a-z0-9]{2,}\.[a-z]{2,}$/;
		if(!exp5.test(email)) {
			alert("이메일 형식이 맞지 않습니다. ex) abc@gmail.com");
			$("#email").focus();
			return;
		}
		document.form1.action="${path}/member_servlet/update.do";
		document.form1.submit();
	});
});
</script>
<style type="text/css">
#page {
 margin: auto;
}
main {
 height: auto;
 margin-bottom: 20px;
}

#edit_box {
 margin-left: 37%;
 width: 100%;
}
</style>
</head>
<body>
<%@ include file="../include/menubar.jsp" %>
<%@ include file="../include/menu.jsp" %>
	<div id="page">
		<main>
			<div id="edit_box">
				<form name="form1" method="post">
					<table style="line-height: 40px; width: 500px;">
						<tr>
							<td colspan="2"><h3>정보 수정</h3></td>
						</tr>
						<tr>
							<td style="font-size: 12px;">아이디</td>
							<td style="font-weight: bold;">${dto.userid}</td>
						</tr>
						<tr>
							<td style="font-size: 12px;">비밀번호</td>
							<td><input type="password" class="form-control" name="pw1"
								id="pw1"></td>
						</tr>
						<tr>
							<td style="font-size: 12px;">비밀번호 확인</td>
							<td><input type="password" class="form-control" name="pw2"
								id="pw2"></td>
						</tr>
						<tr>
							<td style="font-size: 12px;">이름</td>
							<td><input name="name" class="form-control" id="name"
								value="${dto.name}"></td>
						</tr>
						<tr>
							<td style="font-size: 12px;">전화번호</td>
							<td><input name="tel" class="form-control" id="tel"
								value="${dto.tel}"></td>
						</tr>
						<tr>
							<td style="font-size: 12px;">이메일</td>
							<td><input name="email" class="form-control" id="email"
								value="${dto.email}"></td>
						</tr>
						<tr>
							<td style="font-size: 12px;">가입일자</td>
							<td style="font-weight: bold;">${dto.join_date}</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="hidden"
								name="userid" value="${dto.userid}">
								<button type="button" id="btnUpdate"
									class="w-100 btn btn-lg btn-primary">수정</button></td>
						</tr>
					</table>
				</form>
			</div>
		</main>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>