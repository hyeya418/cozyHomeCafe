<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>join</title>
<%@ include file="../include/header.jsp" %>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<script>
$(function() {
	$("#btnJoin").click(function() {
		join_check();
	});
});

function inputIdChk(){
	var form1=document.form1;
	var dbCheckId=document.form1.dbCheckId;
	
	document.form1.idDuplication="idUncheck";
	dbCheckId.disabled=false;
	dbCheckId.style.opacity=1;
	dbCheckId.style.cursor="pointer";
}

function fn_dbCheckId(){
	var form1=document.form1;
	var userid=$("#userid").val();
	
	if(userid.length==0 || userid==""){
		alert("아이디를 입력하세요.");
		$("#userid").focus();
	}else {
		window.open("${path}/join_servlet/dbCheckId.do?userid="+userid,"","width=300, height=300, left=700, top=300");
	}
}

function insert(){
	var param="userid="+$("#userid").val()
	+"&pw1="+$("#pw1").val()
	+"&name="+$("#name").val()
	+"&tel="+$("#tel").val()
	+"&email="+$("#email").val();
	
	$.ajax({
		type : "post",
		url : "${path}/join_servlet/join.do",
		async : false,
		data : param,
		success : function(){
			//입력값 초기화
			$("#userid").val("");
			$("#pw1").val("");
			$("#pw2").val("");
			$("#name").val("");
			$("#tel").val("");
			$("#email").val("");
		}
	});
	document.form1.submit();
	location.href="${path}/shop/login.jsp";
}

function join_check(){
	var form1=document.form1;
	var userid=$("#userid").val();
	var pw1=$("#pw1").val();
	var pw2=$("#pw2").val();
	var name=$("#name").val();
	var tel=$("#tel").val();
	var email=$("#email").val();
	
	if(userid=="") {
		alert("아이디는 필수 입력사항입니다.");
		$("#userid").focus();
		return;
	}
	//아이디 조건
	var exp1 = /^[A-Za-z0-9]{4,10}$/;
	console.log("test: " + exp1.test(userid));
	if(!exp1.test(userid)) {
		alert("아이디는 영문자, 숫자를 사용해서 4~10자리로 입력하세요.");
		$("#userid").focus();
		return;
	}
	
	if(form1.idDuplication.value!="idCheck") {
		alert("아이디 중복확인은 필수입니다.");
		$("#userid").focus();
		return;
	}
	
	if(pw1=="") {
		alert("비밀번호는 필수 입력사항입니다.");
		$("#pw1").focus();
		return;
	}
	if(pw2=="") {
		alert("비밀번호 확인은 필수 입력사항입니다.");
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
	//비밀번호 일치 확인
	if(pw1!=pw2) {
		alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
		return false;
	}
	if(name=="") {
		alert("이름은 필수 입력사항입니다.");
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
		alert("전화번호는 필수 입력사항입니다.");
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
		alert("이메일은 필수 입력사항입니다.");
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
	if(form1.confirm1.checked != true) {
		alert("서비스 이용에 동의해 주세요.")
		$("#confirm1").focus();
		return;
	}
	if(form1.confirm2.checked != true) {
		alert("개인정보 수집에 동의해 주세요.")
		$("#confirm2").focus();
		return;
	}
	alert("가입을 환영합니다. 로그인 페이지로 이동합니다.");
	insert();
}
</script>
<style type="text/css">
#page {
 margin: auto;
}

main {
 margin-left: 37%;
 height: auto;
}

#join-box {
 width: 80%;
}
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>
<div id="page">    
	<main>
		<div id="join-box">
		    <form name="form1" method="post" id="form">
		    	<table>
		    		<tr>
						<td><h1>회원가입</h1></td>
					</tr>
		    		<tr>
		    			<td>
		    			<div class="form-floating" id="id_input">
		    				<input id="userid" class="form-control" name="userid" placeholder="아이디" onkeydown="inputIdChk()" required>
		    				<label>아이디 (영문자+숫자 4~10자)</label>
		    			</div>
		    				<button type="button" class="btn btn-secondary" onclick="fn_dbCheckId()" name="dbCheckId" style="width: 100%">중복확인</button>
		    				<input type="hidden" name="idDuplication" value="idUncheck">
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    			<div class="form-floating">
		    				<input id="pw1" class="form-control" type="password" name="pw1" placeholder="비밀번호" required>
		    				<label>비밀번호 (문자,숫자,특수문자 포함8~20자)</label>
		    			</div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    			<div class="form-floating">
		    				<input id="pw2" class="form-control" type="password" name="pw2" placeholder="비밀번호 재입력" required>
		    				<label>비밀번호 재입력</label>
		    			</div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    			<div class="form-floating">
		    				<input id="name" class="form-control" name="name" placeholder="이름" required>
		    				<label>이름</label>
		    			</div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    			<div class="form-floating">
							<input id="tel" class="form-control" type="tel" name="tel" placeholder="휴대폰 번호" required>
							<label>휴대폰 번호 입력('-'제외)</label>
						</div>
						</td>
		    		</tr>
		    		<tr>
		    			<td>
		    			<div class="form-floating">
		    				<input id="email" class="form-control" type="email" name="email" placeholder="이메일" required>
		    				<label>이메일 입력(abc@gmail.com)</label>
		    			</div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    				<br>
							<p>이용약관 동의<span style="color: red;">(필수)</span></p>
							<div style="border: 1px solid #4d4d4d; width: 500px; height:150px; overflow: auto; white-space: pre; font-size: 10px; color: #808080;">
	제1조(목적) 이 약관은 업체 회사(전자상거래 사업자)가 운영하는 
	 업체 사이버 몰(이하 “몰”이라 한다)에서 제공하는 
	 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 
	 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.
	 
	  ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 
	  그 성질에 반하지 않는 한 이 약관을 준용합니다.」
	 
	제2조(정의)
	 
	  ① “몰”이란 업체 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 
	  이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을
	  거래할 수 있도록 설정한 가상의 영업장을 말하며, 
	  아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
	 
	  ② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 
	  서비스를 받는 회원 및 비회원을 말합니다.
	 
	  ③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이
	   제공하는 서비스를 이용할 수 있는 자를 말합니다.
	 
	  ④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 
	  서비스를 이용하는 자를 말합니다.
	 
	제3조 (약관 등의 명시와 설명 및 개정) 
	 
	  ① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소
	  (소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 
	  전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업 신고번호,
	  개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 00 사이버몰의 
	  초기 서비스화면(전면)에 게시합니다. 
	  다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
	 
	  ② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 
	  청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록
	   별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
	 
	  ③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 
	  「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 
	  「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 
	  「방문판매 등에 관한 법률」,「소비자기본법」 등 관련 법을 위배하지 않는 범위에서
	   이 약관을 개정할 수 있습니다.
	 
	  ④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 
	  현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 
	  다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 
	  최소한 30일 이상의 사전 유예기간을 두고 공지합니다.
	  이 경우 "몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 
	  이용자가 알기 쉽도록 표시합니다. 
	 
	  ⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 
	  적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 
	  다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을
	  제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은
	  경우에는 개정약관 조항이 적용됩니다.
	 
	  ⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 
	  전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 
	  공정거래위원회가 정하는 「전자상거래 등에서의 소비자 보호지침」및 관계법령
	  또는 상관례에 따릅니다.
	 
	제4조(서비스의 제공 및 변경) 
	 
	  ① “몰”은 다음과 같은 업무를 수행합니다.
	 
	    1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
	    2. 구매계약이 체결된 재화 또는 용역의 배송
	    3. 기타 “몰”이 정하는 업무
	 
	  ② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 
	    장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다.
	    이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를
	    명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.
	 
	  ③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화 등의 
	  품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 
	  그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.
	 
	  ④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 
	  다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
	  (생략)
							</div>
						</td>
		    		</tr>
		    		<tr>
		    			<td>
						  <div class="checkbox mb-3">
					      <label>
		    				<input type="checkbox" name="confirm1">동의합니다.
					      </label>
					      </div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
							<p>개인정보 수집 및 이용 동의<span style="color: red;">(필수)</span></p>
							<div style="border: 1px solid #4d4d4d; width: 500px; height:150px; overflow: auto; white-space: pre; font-size: 10px; color: #808080;">
	개인정보처리방침
	
	[차례]
	
	1. 총칙
	2. 개인정보 수집에 대한 동의
	3. 개인정보의 수집 및 이용목적
	4. 수집하는 개인정보 항목
	5. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항
	6. 목적 외 사용 및 제3자에 대한 제공
	7. 개인정보의 열람 및 정정
	8. 개인정보 수집, 이용, 제공에 대한 동의철회
	9. 개인정보의 보유 및 이용기간
	10. 개인정보의 파기절차 및 방법
	11. 아동의 개인정보 보호
	12. 개인정보 보호를 위한 기술적 대책
	13. 개인정보의 위탁처리
	14. 의겸수렴 및 불만처리
	15. 부 칙(시행일) 
	
	1. 총칙
	
	본 업체 사이트는 회원의 개인정보보호를 소중하게 생각하고, 
	회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다. 
	
	1) 회사는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」을 비롯한 
	모든 개인정보보호 관련 법률규정을 준수하고 있으며,
	관련 법령에 의거한 개인정보처리방침을 정하여 이용자 권익 보호에 최선을 다하고 있습니다.
	 
	2) 회사는 「개인정보처리방침」을 제정하여 이를 준수하고 있으며, 
	이를 인터넷사이트 및 모바일 어플리케이션에 
	공개하여 이용자가 언제나 용이하게 열람할 수 있도록 하고 있습니다.
	
	3) 회사는 「개인정보처리방침」을 통하여 귀하께서 제공하시는 
	개인정보가 어떠한 용도와 방식으로 이용되고 있으며 
	개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
	
	4) 회사는 「개인정보처리방침」을 홈페이지 첫 화면 하단에 공개함으로써 
	귀하께서 언제나 용이하게 보실 수 있도록 조치하고 있습니다.
	
	5) 회사는  「개인정보처리방침」을 개정하는 경우
	웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.
	(생략)
							</div>
						</td>
		    		</tr>
		    		<tr>
		    			<td>
						  <div class="checkbox mb-3">
						      <label>
			    				<input type="checkbox"  name="confirm2">동의합니다.
						      </label>
						  </div>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td><br><button type="button" id="btnJoin" class="w-100 btn btn-lg btn-primary">Join</button></td>
		    		</tr>
		    	</table>
		    </form>
		</div>
	</main>
</div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>