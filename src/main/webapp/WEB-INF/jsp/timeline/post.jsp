<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="postBox d-flex">
	<div class="postPicture">
		<%-- 이미지가 하나인 경우 --%>
		<c:if test="${timeline.uploadFiles.size() eq 1 }">
		<c:forEach var="file" items="${timeline.uploadFiles}">
		<img src="${file.imagePath }" alt="게시글 사진" width="598px" height="598px">
		</c:forEach>
		</c:if>
		<%-- 이미지가 2개 이상인 경우 --%>
		<c:if test="${timeline.uploadFiles.size() ne 0 && timeline.uploadFiles.size() ne 1}">
		<ul class="bxslider">
			<c:forEach var="file" items="${timeline.uploadFiles }">
			<li><img src="${file.imagePath }" alt="게시글 사진" width="598px" height="598px" /></li>
			</c:forEach>
		</ul>
		</c:if>
		
		
		<%-- 적절한 파일 찾아 넣기 --%>
		<c:if test="${timeline.uploadFiles.size() eq 0 }">
		<img src="/static/images/user.png" alt="게시글 사진" width="598px" height="598px">
		</c:if>
	</div>
	<div class="postContentBox">
		<div class="postHeader d-flex justify-content-between">
			<div class="d-flex align-items-center p-2">
				<div class="borderRadius70">
					<c:if test="${not empty timeline.user.imagePath}">
					<img src="${timeline.user.imagePath }" width="50px" height="50px" class="postHeaderImage">
					</c:if>
					<c:if test="${empty timeline.user.imagePath}">
					<img src="/static/images/user.png" width="50px" height="50px" class="postHeaderImage">
					</c:if>
				</div>
				<%-- 로그인한 유저의 id와 게시글의 id가 같은 경우 나의 페이지로 --%>
				<c:if test="${userId eq timeline.post.userId }">
				<a href="/page/my_page_view"><div class="ml-2">${timeline.user.nickname }</div></a>
				</c:if>
				<c:if test="${userId ne timeline.post.userId }">
				<a href="/page/user_page_view?userId=${timeline.post.userId}"><div class="ml-2">${timeline.user.nickname }</div></a>
				</c:if>
			</div>
			<%-- 게시글 modal 창 띄우기 --%>
			<div class="d-flex align-items-center">
				<a href="" class="moreBtn" data-toggle="modal" data-target="#moreModal" data-post-id="${timeline.post.id}" data-user-id="${timeline.user.id}">
					<img src="/static/images/more-icon.png" alt="" width="30px" height="30px">
				</a>
			</div>
		</div>
		<%-- 크기 고정 넘어가면 스크롤을 통해 아래로 내려갈 수 있도록 한다. --%>
		<div class="postContent p-2">
			<div class="d-flex align-items-center">
				<c:if test="${not empty timeline.user.imagePath}">
				<img src="${timeline.user.imagePath }" width="50px" height="50px" class="postContentImage">
				</c:if>
				<c:if test="${empty timeline.user.imagePath}">
				<img src="/static/images/user.png" width="50px" height="50px" class="postContentImage">
				</c:if>
				<div class="ml-2">
					<c:if test="${userId eq timeline.post.userId }">
					<a href="/page/my_page_view" class="font-weight-bold">${timeline.user.nickname}</a>
					</c:if>
					<c:if test="${userId ne timeline.post.userId }">
					<a href="/page/user_page_view?userId=${timeline.post.userId}" class="font-weight-bold">${timeline.user.nickname}</a>
					</c:if>
				</div>
			</div>
			<div class="mt-2"> ${timeline.post.content}</div>
			<div class="mt-5"></div>
			<%-- 댓글이 보이는 부분 --%>
			<c:forEach var="comment" items="${timeline.commentList}">
			<div class="d-flex justify-content-between align-items-center mt-2">
				<div class="d-flex">
					<a href="/page/user_page_view?userId=${comment.userId}"><div class="font-weight-bold">${comment.nickname}</div></a>
					<div class="ml-2">${comment.content}</div>
				</div>
				<c:if test="${comment.userId eq userId }">
				<a href="" class="commentDeleteBtn" data-post-id="${comment.postId}" data-comment-id="${comment.id}" data-user-id="${comment.userId }"><div class="commentDeleteFont">댓글 삭제</div></a>
				</c:if>
			</div>
			</c:forEach>
		</div>
		<div class="postIcon p-3">
			<div class="d-flex">
				<%-- 좋아요 버튼 --%>
				<a href="" class="likeBtn" data-user-id="${timeline.user.id }" data-post-id="${timeline.post.id }">
					<c:if test="${timeline.likeClick eq false }">
					<img src="/static/images/heart-icon1.png" width="25px" height="25px" class="mr-2">
					</c:if>
					<c:if test="${timeline.likeClick eq true }">
					<img src="/static/images/heart-icon2.png" width="25px" height="25px" class="mr-2">
					</c:if>
				</a>
				<img src="/static/images/comment.svg" width="25px" height="25px" class="mr-2">
				<div class="font-weight-bold">좋아요 ${timeline.like}개</div>
			</div>
			<%-- 향후 추가 예정 --%>
			<%--<div class="font-weight-bold mt-2" style="font-size:15px; color:rgb(217,217,217);">1시간 전</div> --%>
		</div>
		<%-- 댓글 버튼 --%>
		<div class="postComment p-2 d-flex align-items-center">
			<img src="/static/images/comment.svg" width="25px" height="25px">
			<input type="text" class="form-control postCommentBox" placeholder="댓글 달기...">
			<input type="button" class="btn postCommentBtn"
				value="게시" data-user-id="${userId}" data-post-id="${timeline.post.id}">
		</div>
	</div>
</div>

<%-- 게시글에 대한 modal --%>
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
		
		// 게시글 ...버튼 클릭시 modal
		$('.moreBtn').on('click', function(e){
			let postId = $(this).data('post-id');
			let userId = $(this).data('user-id');
			$('#moreModal').data('post-id',postId);
			$('#moreModal').data('user-id',userId);
		})
		
		// modal 창의 삭제하기 클릭시
		// 더보기에서 글삭제 클릭
		$('#moreModal .del-post').on('click', function(e) {
			e.preventDefault();
			let postId = $('#moreModal').data('post-id');
			let userId = $('#moreModal').data('user-id');
			$.ajax({
				type:'post'
				,url:'/post/post_delete'
				,data: {"postId":postId}
				,success: function(data) {
					if (data.result == 'success') {
						// 자신의 게시글 페이지로 이동
						location.href="/page/my_page_view";
					}else{
						alert("자신의 게시물만 삭제 가능합니다.");
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		// 좋아요 클릭시
		$('.likeBtn').on('click', function(e){
			let userId = $(this).data('user-id');
			let postId = $(this).data('post-id');
			
			$.ajax({
				type:'post'
				,url:'/like/like_click'
				,data: {'userId':userId, 'postId':postId}
				,success: function(data){
					if(data.result=='success'){
						location.reload();
					}else{
						alert("좋아요 버튼 클릭에 문제가 발생하였습니다. 관리자에게 문의해주세요.")
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		// 댓글 달기
		$('.postCommentBtn').on('click', function(e){
			// 유저와 게시글의 id가져오기
			let userId = $(this).data('user-id');
			let postId = $(this).data('post-id');
			// 댓글 내용 가져오기
			let content = $('.postCommentBox').val();
			
			$.ajax({
				type: 'post'
				,url: '/comment/comment_create'
				,data: {'userId':userId, 'postId':postId, 'content':content}
				,success: function(data){
					if(data.result=='success'){
						location.reload();
					}else{
						// 향후 실패했을시 필요하면 활용.
						alert("댓글 달기에 실패하였습니다. 관리자에게 문의해주세요.");
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		// 댓글 삭제
		$('.commentDeleteBtn').on('click',function(e){
			let postId = $(this).data('post-id');
			let commentId = $(this).data('commentId');
			
			$.ajax({
				type: 'post'
				,url: '/comment/comment_delete'
				,data: {'commentId':commentId}
				,success: function(data){
					if(data.result=='success'){
						location.reload();
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		$('.bxslider').bxSlider( {
			
		});
		
	});
</script>