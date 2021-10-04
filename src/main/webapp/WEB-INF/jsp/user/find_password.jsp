<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
	<link rel="stylesheet" type="text/css" href="/static/css/find_id.css">
</head>
<body>
		<div id="wrap" class="d-flex align-items-center justify-content-center">
		<div class="findIdBox d-flex justify-content-center">
			<div>
				<div class="findIdBoxTitle mt-3 d-flex align-items-center justify-content-center">
					비밀번호 찾기
				</div>
				<div class="findIdBoxContent mt-5 d-flex justify-content-center">
					<div>
						<div class="fintIdBoxContentBox mt-3 d-flex align-items-center">
							<input type="text" id="loginId" class="form-control" placeholder="id을 입력하세요.">
						</div>
						<div class="fintIdBoxContentBox mt-3 d-flex align-items-center">
							<input type="text" id="email" class="form-control" placeholder="이메일을 입력하세요.">
							<input type="button" class="btn emailCertBtn" value="인증하기">
							<input type="button" class="btn sendEmailBtn d-none">
						</div>
						<span class="idEmailCheck d-none">id와 이메일을 확인해주세요.</span>
						<input type="text" id="certificationNum" class="form-control mt-2 d-none" placeholder="인증번호을 입력하세요.">
						<div class="fintIdBoxContentBox mt-3 d-flex align-items-center">
							<input type="button" class="btn btn-primary findIdBtn" value="비밀번호 찾기">
						</div>
						<hr>
						<div class="fintIdBoxContentBox d-flex justify-content-center">
							<a href="/user/sign_up_view"><div><span class="findIdBoxSignUp">회원가입</span></a> 하기</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<script>
	$(document).ready(function(){
		
		$('.emailCertBtn').on('click', function(e){
			let loginId = $('#loginId').val();
			let email = $('#email').val();
			
			// 유효성 확인
			if(loginId==''){
				alert("아이디를 입력해주세요.");
				return;
			}
			if(email==''){
				alert("이메일을 입력해주세요.");
				return;
			}
			
			$.ajax({
				type: 'post'
				,url: '/user/email_check'
				,data: {"loginId":loginId, "email":email}
				,success: function(data){
					if(data.result=="success"){
						$('#certificationNum').removeClass('d-none');
						$('.idEmailCheck').addClass('d-none');
						$('.sendEmailBtn').trigger('click');
					}else{
						$('.idEmailCheck').removeClass('d-none');
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		// 비밀번호 찾기 버튼클릭시 비교해야 하기 때문에 전역변수로...
		var num;
		$('.sendEmailBtn').on('click', function(e){
			let email = $('#email').val();
			
			$.ajax({
				type: 'post'
				,url: '/user/send_email'
				,data: {'email':email}
				,success: function(data){
					if(data.result=="success"){
						num = data.num;
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
		
		$('.findIdBtn').on('click', function(e){
			let loginId = $('#loginId').val();
			let certNum = $("#certificationNum").val();
			
			// 유효성 확인
			if(certNum==''){
				alert("인증번호를 입력하세요.");
				return;
			}
			
			if(certNum==num){
				$.ajax({
					type: 'post'
					,url: '/user/change_password'
					,data: {"loginId": loginId}
					,success: function(data){
						if(data.result=="success"){
							alert("비밀번호가 "+data.password+"로 변경되었습니다. \r 로그인 후 비밀번호를 변경해주세요.")
						}
						location.href="/user/sign_in_view"
					},error:function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}else{
				alert("인증번호가 틀렸습니다.");
				location.reload();
			}
		});
		
		
	});
</script>