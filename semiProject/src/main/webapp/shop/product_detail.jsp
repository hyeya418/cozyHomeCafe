<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>product_detail</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
main {
 min-height: 500px;
}

#product_box {
 margin: 0 36%;
 width: 700px;
}

</style>
<link rel="stylesheet" type="text/css" href="css/basic.css">
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>
	<div id="page">
		<main>
			<div id="product_box">
				<table>
					<tr>
						<td><h2>상품정보</h2></td>
					</tr>
					<tr>
						<td><img src="${path}/shop/images/${dto.filename}"
							width="300px" height="300px" style="border-radius: 20px;"></td>
						<td align="center">
							<table style="line-height: 30px; margin-left: 20px;">
								<tr>
									<td style="font-size: 12px;">상품명</td>
									<td style="font-size: 18px; font-weight: bold;">${dto.product_name}</td>
								</tr>
								<tr>
									<td style="font-size: 12px;">가격</td>
									<td style="font-size: 16px;"><fmt:formatNumber
											value="${dto.price}" pattern="#,###,###" /></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td style="font-size: 13px;">${dto.description}</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2">
										<form name="form1" method="post"
											action="${path}/cart_servlet/insert.do">
											<input type="hidden" name="product_code"
												value="${dto.product_code}"> <select name="amount"
												class="form-select" style="width: 60px; display: inline;">
												<c:forEach begin="1" end="10" var="i">
													<option value="${i}">${i}</option>
												</c:forEach>
											</select>&nbsp;개
											<button type="submit" id="btnCart" class="btn btn-primary">장바구니에
												담기</button>
										</form>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</main>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>