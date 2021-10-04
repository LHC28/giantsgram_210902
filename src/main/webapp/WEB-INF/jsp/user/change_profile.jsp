<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<div class="profileChangeBox">
	<div class="profileChangeBoxTitle d-flex align-items-end justify-content-center">
		<h2>프로필 변경</h2>
	</div>
	<div class="d-flex justify-content-center">
		<div class="profileChangeContentBox d-flex justify-content-center">
			<div>
				<div class="profileChangeContentBoxPart d-flex justify-content-center align-items-end">
					<div class="profileChangeContentBoxPartName d-flex align-items-center justify-content-end">
						<div class="mr-4 font-weight-bold">이름</div>
					</div>
					<input type="text" id="name" class="form-control profileChangeContentBoxPartContent" placeholder="${user.name }">
				</div>
				<div class="profileChangeContentBoxPart d-flex justify-content-center align-items-end">
					<div class="profileChangeContentBoxPartName d-flex align-items-center justify-content-end">
						<div class="mr-4 font-weight-bold">닉네임</div>
					</div>
					<input type="text" id="nickname" class="form-control profileChangeContentBoxPartContent" placeholder="${user.nickname }">
				</div>
				<div class="profileChangeContentBoxPart d-flex justify-content-center align-items-end">
					<div class="profileChangeContentBoxPartName d-flex align-items-center justify-content-end">
						<div class="mr-4 font-weight-bold">전화번호</div>
					</div>
					<input type="text" id="phoneNumber" class="form-control profileChangeContentBoxPartContent" placeholder="${user.phoneNumber }">
				</div>
				<div class="profileChangeContentBoxPart d-flex justify-content-center align-items-end">
					<div class="profileChangeContentBoxPartName d-flex align-items-center justify-content-end">
						<div class="mr-4 font-weight-bold">이메일</div>
					</div>
					<input type="text" id="email" class="form-control profileChangeContentBoxPartContent" placeholder="${user.email }">
				</div>
				<div class="profileChangeContentBoxPartPicture d-flex align-items-center mt-3">
					<c:if test="${user.imagePath eq null }">
					<img src="/static/images/user.png" alt="" width="100px" height="100px" class="ml-2 profileChangeContentBoxPartImage nonPreview">
					<img src="" alt="" width="100px" height="100px" class="ml-2 profileChangeContentBoxPartImage preview d-none">
					</c:if>
					<c:if test="${user.imagePath ne null }">
					<img src="${user.imagePath }" alt="" width="100px" height="100px" class="ml-2 profileChangeContentBoxPartImage nonPreview">
					<img src="" alt="" width="100px" height="100px" class="ml-2 profileChangeContentBoxPartImage preview d-none">
					</c:if>
					<a href="#" onclick="return false" class="profilePictureChange"><div class="profilePictureChangeFont ml-4">프로필 사진 변경</div></a>
					<input type="file" id="file" class="btn profilePictureInput d-none" accept=".gif, .jpg, .png, .jpeg">
				</div>
				<div class="d-flex justify-content-center">
					<input type="button" class="btn profileChangeBtn mt-4" value="변경 완료">
				</div>
			</div>
		</div>
	</div>
</div>
<script>

	<%--
	response.setHeader("Cache-Control", "no-store");  //HTTP 1.1
	repsonse.setHeader("Pragma", "no-cache");  // HTTP 1.1
	response.setDateHeader("Expires",0);  //proxy server
	if (request.getProtocol().equals("HTTP/1.1"))
	    tesponse.setHeader("Cache-Control","no-cache")l
	--%>


	// 사진 선택시 미리보기를 하기 위해 넣는 function
	function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $(expression).attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}

	$(document).ready(function(){
		
		$('.profilePictureChange').on('click',function(e){
			// 프로필 사진 변경 글씨를 클릭하면 파일 선택창도 활성화되도록 하기 위함.
			$('.profilePictureInput').click();
		});
		
		$('.profilePictureInput').change(function(e){
			// 없어도 되지만 있는 경우를 생각해 전역변수로 넣어보았다.
			let picture = e.target.files[0].name;
			
			// 이미지 확장자 유효성 검사
			let extention = picture.split('.');
			if(extention.length<2 || (extention[extention.length-1] != 'gif'
					&& extention[extention.length-1] != 'png'
					&& extention[extention.length-1] != 'jpg'
					&& extention[extention.length-1] != 'jpeg')){
				alert("이미지 파일만 업로드할 수 있습니다.");
				$(this).val(''); // input에 들어간 파일을 없애주는 역할.
				return;
			}
			setImageFromFile(this, '.preview');
			$('.nonPreview').addClass('d-none');
			$('.preview').removeClass('d-none');
		});
		
		// 변경완료 버튼 누를 때.
		$('.profileChangeBtn').on('click', function(e){
			
			// 유효성 검사
			let name = $('#name').val();
			if(name==''){
				alert("이름을 입력해주세요.");
				return;
			}
			
			let nickname = $('#nickname').val();
			if(nickname==''){
				alert("닉네임을 입력해주세요.");
				return;
			}
			
			let phoneNumber = $('#phoneNumber').val();
			if(phoneNumber==''){
				alert("전화번호를 입력해주세요.");
				return;
			}
			
			let email = $('#email').val();
			if(email==''){
				alert("이메일을 입력하세요.");
				return;
			}
			// 사진은 없어도 되기 때문에 제외.
			let picture = $('#file')[0].files[0];
			
			var formData = new FormData();
			formData.append('name',name);
			formData.append('nickname',nickname);
			formData.append('phoneNumber',phoneNumber);
			formData.append('email',email);
			formData.append('picture',picture);
			
			$.ajax({
				type: 'post'
				,url: '/user/profile_change'
				,data: formData
				,enctype: 'multipart/form-data'
				,processData: false
				,contentType: false
				,success: function(data){
					if(data.result=="success"){
						location.href="/page/my_page_view"
					}else{
						alert("프로필 변경에 실패하였습니다. 관리자에게 문의해주세요.");
						//location.href="/page/my_page_view"
					}
					
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});
</script>