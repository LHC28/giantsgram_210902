<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="uploadBox">
	<div class="uploadBoxTitle d-flex align-items-center justify-content-center">
		<h3 class="font-weight-bold">게시글 쓰기</h3>
	</div>
	<div class="uploadBoxContent d-flex justify-content-center align-items-center">
		<div>
			<textarea cols="50" rows="3" id="content" class="form-control" style="border:none; font-size:20px;" placeholder="내용을 입력해주세요."></textarea>
			<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg"><br>
			<div class="d-flex">
				<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
				<div id="fileName" class="ml-2"></div>
			</div>
			<input type="button" class="btn form-control postBtn mt-3" value="게시"> 
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		// 이미지 업로드 버튼 클릭
		$('#fileUploadBtn').on('click',function(e){
			e.preventDefault();
			$('#file').click(); // 버튼 클릭과 동시에 같이 클릭한 효과
		})
		$('#file').on('change',function(e){
			// 유효성 검사
			let name = e.target.files[0].name; // 이미지 이름
			// 확장자
			let extention = name.split(".");
			if(extention.length<2 || (extention[extention.length-1] != 'gif'
				&& extention[extention.length-1] != 'png'
				&& extention[extention.length-1] != 'jpg'
				&& extention[extention.length-1] != 'jpeg')){
				alert("이미지 파일만 업로드할 수 있습니다.");
				$(this).val(''); // input에 들어간 파일을 없애주는 역할.
				return;
			}
			$('#fileName').text(name); // 이미지 파일 등록시 div안에 name을 가져온다.
		})
		
		// 게시글 입력칸 클릭시 글자 입력해달라는 문구 없애기
		$('#content').on('click',function(e){
			$('#content').val('');
		});
		// 게시글 업로드
		$('.postBtn').on('click',function(e){
			// 유효성 검사
			let content = $('#content').val();
			if(content.length<1){
				alert("내용을 먼저 입력하세요.");
				return;
			}
			let file = $('#file')[0].files[0];
			var formData = new FormData();
			formData.append('file',file);
			formData.append('content', content);
			$.ajax({
				type:'post'
				,url:'/post/create'
				,data:formData
				,enctype: 'multipart/form-data'
				,processData: false
				,contentType: false
				,success: function(data){
					if(data.result=='success'){
						location.href='/timeline/post_list_view'
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});
</script>