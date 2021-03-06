<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sectionBox d-flex">
	<%-- 게시글 나열 --%>
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
				<a href="#" class="moreBtn" data-toggle="modal" data-target="#moreModal" data-post-id="${timeline.post.id}">
					<img src="/static/images/more-icon.png" alt="더보기 버튼" width="30px" height="30px">
				</a>
			</div>
			
		</div>
		<%-- 이미지 여러 개 --%>
		<c:if test="${timeline.uploadFiles.size() ne 1 && timeline.uploadFiles.size() ne 0}">
		<div class="timelinePicture">
			<a href="/post/post_view?postId=${timeline.post.id}">
			<ul class="bxslider">
				<c:forEach var="file" items="${timeline.uploadFiles }">
				<li><img src="${file.imagePath }" class="timelinePicture" /></li>
				</c:forEach>
			</ul>
			</a>
		</div>
		</c:if>
		<c:if test="${timeline.uploadFiles.size() eq 1}">
			<a href="/post/post_view?postId=${timeline.post.id}">
			<c:forEach var="file" items="${timeline.uploadFiles}">
			<img src="${file.imagePath}" alt="게시글 사진" class="timelinePicture">
			</c:forEach>
			</a>
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
			<%-- 댓글이 있는 경우 갯수 표시 --%>
			<c:if test="${timeline.commentList.size() ne 0 }">
			<div class="entireCommentBtn mt-1 ml-2 mb-3">${timeline.commentList.size()}개 댓글</div>
			</c:if>
			<%-- 댓글이 없는 경우 갯수 표시 --%>
			<c:if test="${timeline.commentList.size() eq 0 }">
			<div class="entireCommentBtn mt-1 ml-2 mb-3">0개 댓글</div>
			</c:if>
			<c:forEach var="comment" items="${timeline.commentList }">
			<div class="d-flex justify-content-between mb-1">
				<div class="d-flex">
					<div class="font-weight-bold ml-2">${comment.nickname }</div>
					<div class="ml-3">${comment.content }</div>
				</div>
				
				<c:if test="${userId eq comment.userId}">
				<div>
					<a href="#" class="deleteCommentBtn" onclick="return false" data-comment-id="${comment.id}">
						<span class="mr-2 commentDeleteFont">댓글 삭제</span>
					</a>
				</div>
				</c:if>
			</div>
			</c:forEach>
			<%--<div class="dateFont ml-2 mb-2">1일 전</div> --%>
		</div>
		<div class="commentAddBox d-flex align-items-center">
			<img src="/static/images/comment.svg" alt="번경예정" width="20px" height="20px" class="ml-1">
			<input type="text" class="form-control commentBar ml-1" placeholder="댓글 달기...">
			<input type="button" class="btn commentAddBtn ml-2" value="게시" data-user-id="${userId }" data-post-id="${timeline.post.id }" >
		</div>
	</div>
	</c:forEach>
	</div>
	
	<%-- 타임라인 오른쪽 친구창 --%>
	<div class="d-flex">
		<div class="friendBoxPosition"></div>
		<div class="friendBox ml-4">
			<div class="ml-2 mt-2 mb-2">
				<div class="d-flex align-items-center justify-content-between">
					<div class="d-flex">
						<c:if test="${not empty imagePath}">
						<img src="${imagePath}" alt="프로필 사진" class="friendboxProfilePicture">
						</c:if>
						<c:if test="${empty imagePath}">
						<img src="/static/images/user.png" alt="프로필 사진" class="friendboxProfilePicture">
						</c:if>
						<div class="friendBoxPorfile d-flex align-items-center ml-3">
							<div>
								<div class="font-weight-bold">${nickname}</div>
								<div class="friendBoxPorfileName">${name}</div>
							</div>
						</div>
					</div>
					<a href="/user/sign_out" id="logoutBtn">
						<div class="mr-2 logoutBtnFont">로그아웃</div>
					</a>
				</div>
				
				<div class="d-flex justify-content-between mt-4 mb-2 allFriendBtnHeader">
					<div class="allFriendFont">친구 추천</div>
					<a href="#" class="allFriendBtn" data-toggle="modal" data-target="#allFriendModal">
						<div class="font-weight-bold mr-1">모두 보기</div>
					</a>
				</div>
				<%-- 반복해서 5개 추가 예정 --%>
				<c:forEach var="notFriend" items="${notFriendList}">
				<div class="d-flex align-items-center justify-content-between ml-1 mb-2">
					<div class="d-flex align-items-center">
						<c:if test="${notFriend.imagePath ne null }">
						<img src="${notFriend.imagePath}" alt="프로필 사진" class="friendboxFriendPicture">
						</c:if>
						<c:if test="${notFriend.imagePath eq null }">
						<img src="/static/images/user.png" alt="프로필 사진" class="friendboxFriendPicture">
						</c:if>
						<div class="ml-2">
						<%-- /page/user_page_view?userId=${notFriend.user.id } get방식으로 하기 --%>
							<a href="/page/user_page_view?userId=${notFriend.id}">
								<div class="notFriendNicknameFont">${notFriend.nickname }</div>
							</a>
							<%-- 추후 추가 예정
							<div style="font-size:10px; color:rgb(217,217,217);">팬145 외 00명이 친구입니다.</div>
							 --%>
						</div>
					</div>
					<a href="#" class="addFriendBtn" data-user-id="${notFriend.id }">
						<div class="mr-1 addFriendBtnFont">친구 추가</div>
					</a>
				</div>
				</c:forEach>
			</div>
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

<%-- 친구창에 대한 modal --%>
<div class="modal" id="allFriendModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
		<div class="modal-content">
			<%-- Modal 창 안에 내용 넣기 --%>
			<div class="w-100">
				<div class="d-flex align-items-center justify-content-center friendModalTitle mb-2">
					<div>친구</div>
				</div>
				
				<%-- 친구 리스트 가져오기 --%>
				<c:forEach var="friend" items="${friendList}">
					<div class="d-flex align-items-center justify-content-between">
						<div class="d-flex">
							<div class="ml-2">
								<c:if test="${friend.user.imagePath ne null}">
								<img src="${friend.user.imagePath}" alt="친구 프로필 사진" width="30px" height="30px" class="friendImage">
								</c:if>
								<c:if test="${friend.user.imagePath eq null}">
								<img src="/static/images/user.png" alt="친구 프로필 사진" width="30px" height="30px" class="friendImage">
								</c:if>
							</div>
							<div class="ml-2">
								<div class="friendNickname">${friend.user.nickname}</div>
								<div class="friendUserName">${friend.user.name }</div>
							</div>
						</div>
						<input type="button" class="btn deleteFriendBtn" value="친구 삭제" data-friend-id="${friend.user.id}">
					</div>
				</c:forEach>
				
				<div class="border-top d-flex align-items-center justify-content-center deleteFriendCancel mt-2">
					<%-- data-dismiss: 모달창 닫힘 --%>
					<a href="#" class="cancel" data-dismiss="modal"><span class="friendModalCancelFont">취소</span></a> <%-- 클릭할 수 있는 영역을 넓히기 위해 d-block --%>
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
			// 게시글 id
			let postId = $(this).data('post-id');
			// 댓글 내용
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
			let commentId = $(this).data("commentId");
			$.ajax({
				type:'post'
				,url:'/comment/comment_delete'
				,data:{'commentId':commentId}
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
		
		$('.moreBtn').on('click', function(e){
			let postId = $(this).data('post-id');
			$('#moreModal').data('post-id',postId);
		})
		
		// modal 창의 삭제하기 클릭시
		// 더보기에서 글삭제 클릭
		$('#moreModal .del-post').on('click', function(e) {
			e.preventDefault();
			let postId = $('#moreModal').data('post-id');
			// 확인용
			//alert(postId);
			
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
		
		
		
		// 친구 추가
		$('.addFriendBtn').on('click', function(e){
			let friendId = $(this).data("user-id"); 
			
			$.ajax({
				type:'post'
				,url:'/friend/friend_add'
				,data:{'friendId':friendId}
				,success: function(data){
					if(data.result=="success"){
						location.reload();
					}else{
						alert("친구 추가에 실패하였습니다. 관리자에게 문의해주세요.")
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		// 친구 모두 보기
		$('.allFriendBtn .del-post').on('click', function(e) {
			e.preventDefault();
			
			let postId = $('.allFriendBtn').data('post-id');
			$.ajax({
				type:'post'
				,url:'/post/post_delete'
				,data: {"postId":postId}
				,success: function(data) {
					if (data.result == 'success') {
						location.reload();
					}else if(data.result=='fail'){
						alert("자신의 게시물만 삭제 가능합니다.");
					}else{
						alert("게시물 삭제에 실패하였습니다. 관리자에게 문의해주세요.")
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		// 친구 모두 보기에서 친구 삭제를 클릭한 경우
		$('#allFriendModal .deleteFriendBtn').on('click', function(e){
			let friendId = $(this).data('friend-id');
			$.ajax({
				type:'post'
				,url:'/friend/friend_delete'
				,data:{'friendId':friendId}
				,success: function(data){
					if(data.result=='success'){
						location.reload();
					}else{
						alert("친구삭제에 실패하였습니다. 관리자에게 문의해주세요.");
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		$('.bxslider').bxSlider( {
			<%--
			기본값만 활용해도 사용가능하다. 해당 옵션은 공부가 필요할듯 하다.
			mode: 'horizontal',// 가로 방향 수평 슬라이드
			speed: 500, // 이동 속도를 설정
			pager: true, // 현재 위치 페이징 표시 여부 설정
			moveSlides: 1, // 슬라이드 이동시 개수
			slideWidth: 100px, // 슬라이드 너비
			minSlides: 1, // 최소 노출 개수
			maxSlides: 10, // 최대 노출 개수
			slideMargin: 5, // 슬라이드간의 간격
			auto: true, // 자동 실행 여부
			autoHover: true, // 마우스 호버시 정지 여부
			controls: true, // 이전 다음 버튼 노출 여부
			infiniteLoop: true // 마지막 페이지에서 맨 앞으로
			--%>
			
		});


		
	});
</script>