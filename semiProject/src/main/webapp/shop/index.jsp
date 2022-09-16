<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>index</title>
<script src="${path}/include/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap core CSS -->
<%@ include file="../include/header.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"> 
<script src="${path}/include/jquery-3.6.0.min.js"></script>
<script>
$(function() {
	//팝업창 열기
	var showCookie=getCookie("showCookies");
	if(showCookie != "N") {
		window.open("popup.jsp", "", "width=320,height=350");
	}
	newList();
	noticeList();
	reviewList();
});

function newList() {
	$.ajax({
		type: "post",
		url: "${path}/product_servlet/newList.do",
		async: false,
		success: function(result) {
			$("#newList").html(result);
		}
	});
}

function noticeList() {
	$.ajax({
		type: "post",
		url: "${path}/notice_servlet/newList.do",
		async: false,
		success: function(result) {
			$("#notice").html(result);
		}
	});
}

function reviewList() {
	$.ajax({
		type: "post",
		url: "${path}/board_servlet/newList.do",
		async: false,
		success: function(result) {
			$("#review").html(result);
		}
	});
}

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
</script>
<style type="text/css">
#page {
 height: 2000px;
}

section {
 width: 1280px;
 margin-top: 100px;
}

#newList {
 align-items: center;
 float: none;
}

#notice { 
 float: left;
}

#review {
 float: right;
}

a { text-decoration: none; }
a:hover { opacity: 0.7; }
</style>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<%@ include file="../include/menubar.jsp" %>

<div id="page">

<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="../images/cozy_bg2.jpg" class="d-block w-100">
      <div class="carousel-caption d-none d-md-block">
        <h5>Cozy Home Cafe</h5>
        <p>작은 소품 하나로 나만의 홈카페를 꾸밀 수 있어요.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="../images/cozy_bg.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>Cozy Home Cafe</h5>
        <p>‘홈카페’로 집에서 커피 향과 여유를 즐겨보세요.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="../images/beach.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-none d-md-block">
        <h5>Cozy Home Cafe</h5>
        <p>나를 위한 편안한 공간에서 직접 내린 커피를 즐겨요.</p>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<div class="container">
    <main>
		<div id="newList">
			<!-- 신상품 목록 product_code 내림차순desc -->
		</div>
		<section>
			<div id="notice">
				<!-- 공지사항 목록 num 내림차순desc -->
			</div>
			
			<div id="review">
				<!-- 리뷰 목록 num 내림차순desc -->
			</div>
		</section>
    </main>
    
    
 </div>
</div>

<%@ include file="../include/footer.jsp" %>
</body>
</html>
