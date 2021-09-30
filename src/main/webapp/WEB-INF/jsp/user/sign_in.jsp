<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giantsgram</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<%-- css --%>
	<link rel="stylesheet" type="text/css" href="/static/css/style.css">
</head>
<body>
	<div id="wrap">
		<div id="signInBox" class="d-flex justify-content-center align-items-center">
			<div>
				<div class="loginLogo d-flex align-items-center justify-content-center">
					<img src="/static/images/teamLogo1.png" alt="구단 로고" width="350px" height="186px">
				</div>
			</div>
			<div>
			
				<div class="loginFrame d-flex align-items-center">
					<div>
						<form method="post" action="/user/sign_in">
							<div class="loginBox ml-4">
								<h2 class="loginBoxTitle text-center p-4">Giantsgram</h2>
								<div class="d-flex justify-content-center">
									<input type="text" id="loginId" name="loginId" class="form-control col-9 loginText" placeholder="아이디를 입력하세요.">
								</div>
								<div class="d-flex justify-content-center">
									<input type="password" id="password" name="password" class="form-control col-9 mt-3 loginText" placeholder="비밀번호를 입력하세요.">
								</div>
								<div class="d-flex justify-content-center mt-3">
									<input type="submit" class="btn signInBtn col-9 mt-3 loginText" value="로그인">
								</div>
								<hr>
								<div class="d-flex justify-content-center loginWarning d-none">
									<span class="d-none">입력한 아이디 또는 비밀번호가 다릅니다.<br> 확인하고 다시 시도하세요.</span>
								</div>
								<div class="d-flex justify-content-center mt-4 findFont">
									<a href="#" class="mr-4">아이디 찾기</a>
									<a href="#">비밀번호 찾기</a>
								</div>
							</div>
						</form>
						<div class="moveToSignUpBox ml-4 mt-4 d-flex align-items-center justify-content-center">
							<span><a href="/user/sign_up_view" class="font-weight-bold">회원가입</a> 하기</span>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</body>
<script>
	$(document).ready(function(){
		
		$('.signInBtn').on('click', function(e){
			e.preventDefault();
			
			let loginId = $('#loginId').val();
			if(loginId==''){
				alert("아이디를 입력해주세요.");
				return;
			}
			let password = $('#password').val();
			if(password==''){
				alert("비밀번호를 입력하세요.");
				return;
			}
			
			$.ajax({
				type:'post'
				,url:'/user/sign_in'
				,data:{'loginId':loginId, 'password':password}
				,success: function(data){
					if(data.result==true){
						location.href="/timeline/post_list_view"
					}else{
						alert("로그인 실패. 아이디와 비밀번호를 확인해주세요.");
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});
</script>
</html>