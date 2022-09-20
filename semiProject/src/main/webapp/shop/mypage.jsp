<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>mypage</title>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/session_check.jsp" %>
<script type="text/javascript">
$(function(){
 	$("#btnDelete").click(function() {
		if(confirm("정말 탈퇴하시겠습니까?")) {
			location.href="${path}/shop/mypage_delete.jsp";
		}
	}); 
});
</script>
<style type="text/css">
#page {
 margin: auto;
}

main {
 width: 30%;
 margin-left: 37%;
 height: auto;
}

</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>
	<div id="page">
		<main>
			<div class="container text-center">
				<div class="row row-cols-2" id="mybox">
					<div class="col-lg-6"
						style="width: 250px; height: 250px; background: #7FC7AF; position: relative;">
						<a href="${path}/cart_servlet/list.do"
							style="font-size: 16px; font-weight: bold; color: white; text-decoration: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">장바구니</a>
					</div>
					<div class="col-lg-6"
						style="width: 250px; height: 250px; background: #DAD8A7; position: relative;">
						<a href="#"
							style="font-size: 16px; font-weight: bold; color: white; text-decoration: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">주문내역</a>
					</div>
					<div class="col-lg-6"
						style="width: 250px; height: 250px; background: #FF9E9D; position: relative;">
						<a
							href="${path}/member_servlet/view.do?userid=${sessionScope.userid}"
							style="font-size: 16px; font-weight: bold; color: white; text-decoration: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">정보수정</a>
					</div>
					<div class="col-lg-6"
						style="width: 250px; height: 250px; background: #9fc3ea; position: relative;">
						<a href="#" id="btnDelete"
							style="font-size: 16px; font-weight: bold; color: white; text-decoration: none; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">회원탈퇴</a>
					</div>
				</div>
			</div>
		</main>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>