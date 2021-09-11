<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
	<div class="d-flex justify-content-center">
		<div id="headerBox" class="d-flex align-items-center justify-content-between">
			<a href="/timeline/post_list_view" class="homeLogo"><h3>Giantsgram</h3></a>
			<div class="iconBox d-flex align-items-center justify-content-end">
				<c:if test="${empty loginId }">
				<a href="/timeline/post_list_view"><img src = "/static/images/user.png" alt="홈버튼" width="30px" height="30px" class="mr-3 ml-2"></a>
				</c:if>
				<c:if test="${not empty loginId}">
				<a href="/post/add_post"><img src = "/static/images/pencil.png" alt="게시글 등록 버튼" width="30px" height="30px" class="ml-2"></a>
				<a href="/timeline/post_list_view"><img src = "/static/images/home button.svg" alt="홈버튼" width="30px" height="30px" class="ml-2"></a>
				<a href="/page/my_page_view"><img src ="/static/images/user.png" alt="홈버튼" width="30px" height="30px" class="mr-3 ml-2"></a>
				</c:if>
			</div>
		</div>
	</div>
</header>
<%-- 칸 띄우기용 --%>
<div id="emptyHeader"></div>