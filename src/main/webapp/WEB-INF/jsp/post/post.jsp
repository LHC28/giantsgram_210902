<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="uploadBox">
	<div class="uploadBoxTitle d-flex align-items-center justify-content-center">
		<h3 class="font-weight-bold">게시글 쓰기</h3>
	</div>
	<div class="uploadBoxContent d-flex justify-content-center align-items-center">
		<div>
			<textarea cols="50" rows="3" id="content" class="form-control uploadBoxContentTextarea" placeholder="내용을 입력해주세요."></textarea>
			
			<%-- multiple속성을 주어야 여러 개 선택이 가능하다고 한다. --%>
			<form id="uploadForm" method="post" action="/post/create" enctype="multipart/form-data">
				<input type="file" name="images" multiple="multiple" class="d-none" accept=".gif, .jpg, .png, .jpeg"><br>
			</form>
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
			$('input[name=images]').click(); // 버튼 클릭과 동시에 같이 클릭한 효과
		})
		
		// 파일 선택
		var inputFileList = new Array();
		
		$('input[name=images]').on('change',function(e){
			<%--
			// 유효성 검사
			let name = e.target.files[0].name; // 이미지 이름
			--%>
		    let fileList = $(this)[0].files;
		    
		    var files = e.target.files;
		    var filesArr = Array.prototype.slice.call(files);
		    
		    filesArr.forEach(function(f){
		    	var reader = new FileReader();
		    	reader.onload = function(e){
		    		console.log("onload.."+ f);
		    		inputFileList.push(f);
		    	}
		    	reader.readAsDataURL(f);
		    })
		    
		    let name="";
		    for(var i=0;i < fileList.length;i++){
		        var file = fileList[i];
		     	// 확장자 검사
		        let extention = file.name.split(".");
				if(extention.length<2 || (extention[extention.length-1] != 'gif'
					&& extention[extention.length-1] != 'png'
					&& extention[extention.length-1] != 'jpg'
					&& extention[extention.length-1] != 'jpeg')){
					alert("이미지 파일만 업로드할 수 있습니다.");
					$(this).val(''); // input에 들어간 파일을 없애주는 역할.
					return;
				}
		        name+=file.name+" ";
		    }
			$('#fileName').text(name); // 이미지 파일 등록시 div안에 name을 가져온다.
		})
		
		<%-- 코드 변경으로 필요 없어짐... 
		// 게시글 입력칸 클릭시 글자 입력해달라는 문구 없애기
		$('#content').on('click',function(e){
			$('#content').val('');
		});
		--%>
		
		// 게시글 업로드 수행
		$('.postBtn').on('click',function(e){
			// fileList가 있는지 확인용
			//alert(fileList[1].name);
			
			// 유효성 검사
			let content = $('#content').val();
			if(content.length<1){
				alert("내용을 먼저 입력하세요.");
				return;
			}
			
			//let file = $('#file')[0].files[0];
			
			//formData.append('file',file);
			
			console.log("inputFileList : "+inputFileList);
			//let formData = new FormData($('#uploadForm')[0]);
			let formData = new FormData();
			
			for(let i=0; i<inputFileList.length; i++){
				formData.append("images",inputFileList[i]);
			}
			
			formData.append("content", content);
			
			//let fileList = new FormData($('#file')[0]);
			//let fileList = $('#file')[0].files;
			//let formData = new FormData();
			

			//formData.append('fileList',fileList);
			//formData.append('content', content);
				
			$.ajax({
				type: 'post'
				,url: '/post/create'
				,data: formData
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