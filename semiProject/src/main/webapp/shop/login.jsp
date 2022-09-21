<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>login</title>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<%@ include file="../include/header.jsp" %>
<c:if test="${param.message=='error'}">
<script>
	alert("아이디 또는 비밀번호가 일치하지 않습니다.");
</script>
</c:if>
<c:if test="${param.message=='logout'}">
<script>
	alert("로그아웃되었습니다.");
</script>
</c:if>

<script type="text/javascript">
$(function() {
	//입력검증
	$("#btnLogin").click(function() {
		var userid=$("#userid").val();
		var pw1=$("#pw1").val();
		
		if(userid=="") {
			alert("아이디를 입력하세요.");
			$("#userid").focus();
			return;
		}
		if(pw1=="") {
			alert("비밀번호를 입력하세요.");
			$("#pw1").focus();
			return;
		}
		document.form1.submit();
	});
	//아이디 저장
	//저장된 쿠키 조회
	var cookie_userid = getCookie("userid");
	//저장된 쿠키가 있으면
	if(cookie_userid != ""){
		$("#userid").val(cookie_userid);
		//html방식으로 체크박스에 체크상태로 설정
		$("#chkSave").attr("checked", 'checked');
	}
	//로그인 버튼 클릭
	$("#btnLogin").click(function() {
		if($("#chkSave").is(":checked")){//체크박스에 체크가 되어있다면
			saveCookie($("#userid").val());
		}else{//체크박스에 체크가 되어있지 않다면
			saveCookie("");
		}
	});
	
	//아이디 저장 클릭
	$("#chkSave").click(function() {
		if($("#chkSave").is(":checked")){//체크박스에 체크가 되어있다면
			if(!confirm("로그인 정보를 저장하시겠습니까?")){
				$("#chkSave").prop("checked", true);//자바스크립트방식으로 체크박스에 체크상태로 기억
			}
		}
	});
});

//저장된 쿠키를 검사
function getCookie(cname) {
	var cookie = document.cookie + ";";
	var idx = cookie.indexOf(cname, 0);
	console.log(cname);
	console.log(cookie);
	console.log(idx);

	var val = "";
	if (idx != -1){
		console.log(idx + "," + cookie.length);
		//showCookies=값; userid=이름; 을 substring으로 발췌함
		cookie = cookie.substring(idx, cookie.length);
		begin = cookie.indexOf("=", 0) + 1;
		end = cookie.indexOf(";", begin);
		console.log(begin + ","+ end);
		val = cookie.substring(begin, end);
	}
	return val;
}

//setCookie(쿠키변수명, 쿠키값, 유효날짜)
function setCookie(name, value, days){
	var today = new Date();
	//쿠키의 유효시간 설정
	today.setDate(today.getDate() + days);
	//쿠키변수명=쿠키값;path=저장경로;expires=쿠키유효기간;
	document.cookie = name + "=" + value + ";path=${path};expires="+today.toGMTString()+";";
}

function saveCookie(id){
	if(id != ""){
		setCookie("userid", id, 7);//7일
	}else{
		setCookie("userid", id, -1);//삭제
	}
}
</script>
<style type="text/css">
#page {
 text-align: center;
 margin: auto;
}

main {
 height: 400px;
 width: 20%;
 margin: auto;
}

#chkSave {
 font-size: 12px;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>
	<div id="page" class="text-center">
		<main class="form-signin">
			<form method="post" name="form1"
				action="${path}/login_servlet/login.do">
				<h1 class="h3 mb-3 fw-normal">로그인</h1>

				<div class="form-floating">
					<input name="userid" id="userid" class="form-control"
						placeholder="아이디를 입력하세요" required> <label>아이디</label>
				</div>
				<div class="form-floating">
					<input type="password" name="pw1" class="form-control"
						placeholder="비밀번호를 입력하세요." required> <label>비밀번호</label>
				</div>

				<div class="checkbox mb-3">
					<label> <input type="checkbox" id="chkSave"
						value="remember-me"> 아이디 저장
					</label>
				</div>
				<button type="button" id="btnLogin"
					class="w-100 btn btn-lg btn-primary">Sign in</button>
			</form>
			<br>
			<ul class="list-group">
				<li class="list-group-item"><a href="${path}/shop/join.jsp"
					style="text-decoration: none; color: black;">회원가입</a></li>
				<li class="list-group-item"><a
					href="${path}/shop/remind_id.jsp"
					style="text-decoration: none; color: black;">아이디찾기</a></li>
				<li class="list-group-item"><a
					href="${path}/shop/remind_pw.jsp"
					style="text-decoration: none; color: black;">비밀번호찾기</a></li>
			</ul>
		</main>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>