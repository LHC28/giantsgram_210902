<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pageBox">
	<div class="pageBoxHeader d-flex justify-content-center">
		<div class="d-flex pageBoxHeaderPicture">
			<img src="${user.imagePath}" alt="" width="150px" height="150px" style="border-radius:70%;"> 
		</div>
		<div class="pageBoxHeaderContent d-flex align-items-center">
			<div>
				<div class="d-flex">
					<div style="font-size:20px;">${user.nickname }</div>
					<a href="/user/change_profile_view"><input type="button" class="btn goProfileBtn ml-3" value="프로필 편집"></a>
				</div>
				<div class="d-flex mt-3" style="font-size:15px;">
					<div>게시물 <a href="#" class="mr-3">${postCount}</a></div>
					<div>친구 <a href="#">${friendCount}</a></div>
				</div>
			</div>
		</div>
	</div>
	<div></div>
	<%-- 향후 추가할 수 있을듯... --%>
	<div class="contentChoiceBox"></div>
	<div class="d-flex justify-content-between flex-wrap">
		<c:forEach var="post" items="${postList }">
		<div class="mb-3">
			<img src="${post.imagePath}" alt="게시글 사진" width="293px" height="293px">
		</div>
		</c:forEach>
		
	</div>
</div>
