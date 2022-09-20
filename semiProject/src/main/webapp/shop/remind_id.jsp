<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>remind_id</title>
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
$(function(){
		$("#btnCheckId").click(function(){
			var email = $("#email");
			
			if(email.val()==""){
				alert("이메일을 입력해 주세요.");
				email.focus();
				return;
			}
			
			var exp5 = /^[a-z0-9]{2,}@[a-z0-9]{2,}\.[a-z]{2,}$/;
			if(!exp5.test(email.val())){
				alert("이메일 형식이 잘못되었습니다.");
				email.focus();
				return;
			}
			
			var param = "email="+$("#email").val();
			
			$.ajax({
				type : "post",
				url : "${path}/login_servlet/remind_id.do",
				data : param,
				success : function(result){
					alert(result);
					$("#email").val("");
				}
			});
		});
	});
</script>
<style type="text/css">
#page {
 text-align: center;
 margin: auto;
}

main {
 height: 300px;
}

#input-box {
 width: 25%;
 margin: auto;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>
	<div id="page">
		<main>
			<div id="input-box">
				<h2>아이디찾기</h2>
				<p>가입할 때 사용한 이메일 주소를 입력해 주세요.</p>
				<div class="form-floating">
					<input name="email" id="email" class="form-control"
						placeholder="이메일" required> <label>이메일
						입력(abc@gmail.com)</label>
				</div>
				<br>
				<button type="button" id="btnCheckId" class="btn btn-primary">Find</button>
				<button type="button" id="btnBack" class="btn btn-primary"
					onclick="history.back()">Back</button>
			</div>
		</main>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>