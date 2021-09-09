<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sectionBox d-flex">
	<%-- 게시글 나열하기 --%>
	<div>
	<c:forEach var="timeline" items="${timelineList}">
	<div class="timelineBox">
		<div class="timelineTitleBox d-flex align-items-center justify-content-between">
			<div class="d-flex align-items-center">
				<c:if test="${not empty timeline.user.imagePath}">
				<a href="#"><img src="${timeline.user.imagePath}" alt="프로필 사진" class="propileImage ml-2"></a>
				</c:if>
				<c:if test="${empty timeline.user.imagePath}">
				<a href="#"><img src="/static/images/user.png" alt="프로필 사진" class="propileImage ml-2"></a>
				</c:if>
				<a href="#"><div class="ml-2">${timeline.user.nickname}</div></a>
			</div>
			<%-- modal 창 띄울 버튼 만들 곳 --%>
			<div class="d-flex align-items-center">
				<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-post-id="${timeline.post.id}">
					<img src="/static/images/more-icon.png" alt="더보기 버튼" width="30px" height="30px">
				</a>
			</div>
		</div>
		<c:if test="${not empty timeline.post.imagePath}">
		<div class="timelinePicture">
			<img src="${timeline.post.imagePath}" alt="게시글 사진" style="width:614px; height:614px;">
		</div>
		</c:if>
		<div class="timelineIconBox d-flex align-items-center">
			<div class="d-flex">
				<%-- 좋아요 클릭 --%>
				<a href="#" onclick="return false" class="likeBtn" data-user-id="${userId}" data-post-id="${timeline.post.id }">
				<c:if test="${timeline.likeClick eq false }">
					<img src = "/static/images/heart-icon1.png" width="20px" height="20px" class="ml-2">
				</c:if>
				<c:if test="${timeline.likeClick eq true }">
					<img src = "/static/images/heart-icon2.png" width="20px" height="20px" class="ml-2">
				</c:if>
					<img src = "/static/images/comment.svg" width="20px" height="20px" class="ml-2">
				</a>
				<div class="ml-3">좋아요 <span class="font-weight-bold">${timeline.like}</span>개</div>
				
			</div>
		</div>
		<div>
			<div class="d-flex">
				<div class="font-weight-bold ml-2">${timeline.user.nickname}</div>
				<div class="ml-3">${timeline.post.content }</div>
			</div>
			<%-- 댓글 갯수 --%>
			<c:if test="${timeline.commentList.size() ne 0 }">
			<div class="entireCommentBtn mt-1 ml-2 mb-3">${timeline.commentList.size()}개 댓글</div>
			</c:if>
			<c:forEach var="comment" items="${timeline.commentList }">
			<div class="d-flex justify-content-between mb-1">
				<div class="d-flex">
					<div class="font-weight-bold ml-2">${comment.userName }</div>
					<div class="ml-3">${comment.content }</div>
				</div>
				<c:if test="${userId eq timeline.post.userId}">
				<div>
					<a href="#" class="deleteCommentBtn" onclick="return false" data-post-id="${timeline.post.id}">
						<span class="mr-2" style="font-size:10px; color:red;">댓글 삭제</span>
					</a>
				</div>
				</c:if>
			</div>
			</c:forEach>
			<div class="dateFont ml-2 mb-2">1일 전</div>
		</div>
		<div class="commentAddBox d-flex align-items-center">
			<img src="/static/images/comment.svg" alt="번경예정" width="20px" height="20px">
			<input type="text" class="form-control commentBar ml-1" placeholder="댓글 달기...">
			<input type="button" class="btn commentAddBtn ml-2" value="게시" data-user-id="${userId }" data-post-id="${timeline.post.id }" >
		</div>
	</div>
	</c:forEach>
	</div>
	
	<div class="friendBox ml-4">
		<div class="ml-2 mt-2 mb-2">
			<div class="d-flex">
				<img src="/static/images/player.jpg" alt="프로필 사진" class="friendboxProfilePicture">
				<div class="friendBoxPorfile d-flex align-items-center ml-3">
					<div>
						<div class="font-weight-bold">팬이에요</div>
						<div style="color:grey;">가나다</div>
					</div>
				</div>
			</div>
			<div class="d-flex justify-content-between mt-4 mb-2" style="font-size:12px;">
				<div style="color:rgb(217,217,217); font-size:13px; font-weight:bold;">친구 추천</div>
				<a href="#"><div style="font-weight:bold;" class="mr-1">모두 보기</div></a>
			</div>
			<%-- 반복해서 5개 추가 예정 --%>
			<div class="d-flex align-items-center justify-content-between ml-1">
				<div class="d-flex align-items-center">
					<img src="/static/images/player.jpg" alt="프로필 사진" class="friendboxFriendPicture">
					<div class="ml-2">
						<div style="font-size:12px; font-weight:bold;">팬123</div>
						<div style="font-size:10px; color:rgb(217,217,217);">팬145 외 00명이 친구입니다.</div>
					</div>
				</div>
				<a href="#"><div style="color:rgb(255,122,47); font-size:13px;" class="mr-1">친구 추가</div></a>
			</div>
		</div>
	</div>
</div>

<div class="modal" id="moreModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
		<div class="modal-content">
			<%-- Modal 창 안에 내용 넣기 --%>
			<div class="w-100">
				<div class="my-3 text-center">
					<a href="#" class="del-post d-block">삭제하기</a><%-- 클릭할 수 있는 영역을 넓히기 위해 d-block --%>
				</div>
				<div class="border-top py-3 text-center">
					<%-- data-dismiss: 모달창 닫힘 --%>
					<a href="#" class="cancel d-block" data-dismiss="modal">취소</a> <%-- 클릭할 수 있는 영역을 넓히기 위해 d-block --%>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		
		// 댓글 추가 기능
		$('.commentAddBtn').on('click', function(e){
			let userId = $(this).data('user-id');
			let postId = $(this).data('post-id');
			let content = $('.commentBar').val();
			$.ajax({
				type:'post'
				,url:'/comment/comment_create'
				,data:{'userId':userId, 'postId':postId, 'content':content}
				,success: function(data){
					location.reload();
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}  
			});
		});
		
		// 댓글 삭제 기능
		$('.deleteCommentBtn').on('click', function(e){
			let postId = $(this).data("post-id");
			
			$.ajax({
				type:'post'
				,url:'/comment/comment_delete'
				,data:{'postId':postId}
				,success: function(data){
					if(data.result=='success'){
						location.reload();
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				} 
			});
		});
		
		// 좋아요 기능
		$('.likeBtn').on('click',function(e){
			// 해당 게시글 좋아요 버튼에서 userId와 postId 가져오기
			let userId = $(this).data('user-id');
			let postId = $(this).data('post-id');
			
			$.ajax({
				type:'post'
				,url:'/like/like_click'
				,data:{'userId':userId, 'postId':postId}
				,success: function(data){
					location.reload(); // 새로고침하면 해당 좋아요 버튼도 바뀔 것임.
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				} 
			});
		})
		
		// modal 창의 삭제하기 클릭시
		// 더보기 > 글삭제 클릭
		$('#moreModal .del-post').on('click', function(e) {
			e.preventDefault();
			
			let postId = $('.more-btn').data('post-id');
			
			$.ajax({
				type:'post'
				,url:'/post/post_delete'
				,data: {"postId":postId}
				,success: function(data) {
					if (data.result == 'success') {
						location.reload();
					}else{
						alert("자신의 게시물만 삭제 가능합니다.");
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});
</script>