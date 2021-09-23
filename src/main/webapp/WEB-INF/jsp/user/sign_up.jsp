<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<%-- css --%>
	<link rel="stylesheet" type="text/css" href="/static/css/signup_style.css">
</head>
<body>
	<div id = "wrap" class="d-flex align-items-center justify-content-center">
		<div class="signUpBox">
			<div class="d-flex align-items-center justify-content-center">
				<div>
					<div class="d-flex justify-content-center">
						<h1 class="p-2 mt-4">Giantsgram</h1>
					</div>
					<div class="text-center subtitleFont">가입해서 자이언츠 팬들과<br>소통해요.</div>
					<hr class="col-9">
					<div class="inputBox">
						<div class="d-flex justify-content-center">
							<div class="mt-2">
								<div class="d-flex mb-2">
									<input type="text" id="loginId" class="form-control inputBoxFont1" placeholder="아이디를 입력하세요.">
									<input type="button" id="duplicatedId" class="btn form-control ml-2" value="중복 확인"> 
								</div>
								<input type="password" id="password" class="form-control inputBoxFont mb-2" placeholder="8자 이상비밀번호를 입력하세요.">
								<input type="password" id="confirmPassword" class="form-control inputBoxFont mb-2" placeholder="비밀번호를 다시 입력하세요.">
								<input type="text" id="name" class="form-control inputBoxFont mb-2" placeholder="이름을 입력하세요.">
								<input type="text" id="phoneNumber" class="form-control inputBoxFont mb-2" placeholder="전화번호를 입력하세요.">
								<input type="text" id="email" class="form-control inputBoxFont mb-2" placeholder="이메일를 입력하세요.">
								<div class="warningFont d-none">아이디가 중복되거나 7자 이하입니다.</div>
								<div class="greenFont d-none">사용 가능한 아이디입니다.</div>
								<input type="button" class="btn signUpBtn w-100 mt-3" value="회원가입">
							</div>
						</div>
						<hr>
						<div class="text-center findFont mb-3">계정이 있으신가요? <a href="/user/sign_in_view">로그인</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	$(document).ready(function(){
		// 중복 확인 버튼을 누른 경우
		$('#duplicatedId').on("click", function(e){
			let loginId = $('#loginId').val();
			if(loginId==''){
				alert("아이디를 입력해주세요.");
				return;
			}
			
			$.ajax({
				type:'post'
				,data:{"loginId":loginId}
				,url:'/user/duplicated_id'
				,success: function(data){
					if(data.result==true){
						$('.warningFont').addClass('d-none');
						$('.greenFont').removeClass('d-none');
					}else if(data.result==false){
						$('.warningFont').removeClass('d-none');
						$('.greenFont').addClass('d-none');
					}
				},error: function(e){
					alert(e);
				}
			});
		});
		
		// 회원가입 버튼을 누르는 경우
		$('.signUpBtn').on('click', function(e){
			// 유효성 검사
			let loginId = $('#loginId').val();
			if(loginId==''){
				alert("아이디를 입력해주세요.");
				return;
			}else if(loginId.length<8){
				alert("아이디를 8자 이상 입력해주세요.");
				return;
			}
			
			let password = $('#password').val();
			if(password==''){
				alert("비밀번호를 입력해주세요.");
				return;
			}else if(password.length<8){
				alert("비밀번호를 8자리 이상 눌러주세요.")
				return;
			}
			let confirmPassword = $('#confirmPassword').val();
			if(confirmPassword==('')){
				alert("비밀번호 확인을 입력해주세요.");
				return;
			}
			if(password!=confirmPassword){
				alert("비밀번호가 일치하지 않습니다.");
				$('#comfirmPassword').val('');
				return;
			}
			let name = $('#name').val();
			if(name==''){
				alert("이름을 입력해주세요.");
				return;
			}
			let phoneNumber = $('#phoneNumber').val();
			if(phoneNumber==''){
				alert("전화번호를 입력해주세요.");
				return;
			}else if(phoneNumber.length<11){
				alert("정확한 전화번호를 다시 입력해주세요.");
				return;
			}
			let email = $('#email').val();
			if(email==''){
				alert("이메일을 입력해주세요.")
				return;
			}
			
			$.ajax({
				type:'post'
				,url:'/user/sign_up'
				,data:{"loginId":loginId, "password":password, "name":name, "phoneNumber":phoneNumber, "email":email}
				,success: function(data){
					if(data.result=="success"){
						alert("회원가입 성공");
						location.href="/user/sign_in_view"
					}else{
						alert("회원가입 실패... 관리자에게 문의해주세요.");
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});
</script>
</html>