<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="postBox d-flex">
	<div class="postPicture">
	
	</div>
	<div class="postContentBox">
		<div class="postHeader d-flex justify-content-between">
			<div class="d-flex align-items-center p-2">
				<div>
					<img src="/static/images/player.jpg" width="50px" height="50px" style="border-radius:70%;">
				</div>
				<a href="#"><div class="ml-2">팬이에요</div></a>
			</div>
			<div class="d-flex align-items-center">
				<img src="/static/images/more-icon.png" alt="" width="30px" height="30px">
			</div>
		</div>
		<%-- 크기 고정 넘어가면 스크롤을 통해 아래로 내려갈 수 있도록 한다. --%>
		<div class="postContent">
			<div class="d-flex p-2">
				<img src="/static/images/player.jpg" width="50px" height="50px" style="border-radius:70%;">
				<div class="ml-2">
					<a href="#" class="font-weight-bold">팬이에요</a> 2010년 우승했던 그때가 그립네요... 올해 1위 유지하고 있는데 이대로 지구 우승갑시다!!! 그리고 월드시리즈까지 달려!!!
				</div>
			</div>
		</div>
		<div class="postIcon p-3">
			<div class="d-flex">
				<img src="/static/images/heart-icon1.png" width="25px" height="25px" class="mr-2">
				<img src="/static/images/comment.svg" width="25px" height="25px" class="mr-2">
				<div class="font-weight-bold">좋아요 00개</div>
			</div>
			<div class="font-weight-bold mt-2" style="font-size:15px; color:rgb(217,217,217);">1시간 전</div>
		</div>
		<div class="postComment p-2 d-flex align-items-center">
			<img src="/static/images/comment.svg" width="25px" height="25px">
			<input type="text" class="form-control" placeholder="댓글 달기..." style="border:none;">
			<input type="button" class="btn" value="게시" style="background-color:rgb(255,122,47); color:white;">
		</div>
	</div>
</div>