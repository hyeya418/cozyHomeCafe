<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${sessionScope.userid==null && sessionScope.admin_userid==null}">
 <script>
  alert("로그인하신 후 사용가능합니다.");
  location.href="${path}/shop/login.jsp";
 </script>
</c:if>
