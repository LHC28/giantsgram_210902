<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
					아이디 찾기
				</div>
				<div class="findIdBoxContent mt-5 d-flex justify-content-center">
					<div>
						<div class="fintIdBoxContentBox mt-3 d-flex align-items-center">
							<input type="text" id="name" class="form-control" placeholder="이름을 입력하세요.">
						</div>
						<div class="fintIdBoxContentBox mt-3 d-flex align-items-center">
							<input type="text" id="email" class="form-control" placeholder="이메일을 입력하세요.">
						</div>
						<div class="fintIdBoxContentBox mt-3 d-flex align-items-center">
							<input type="button" class="btn btn-primary findIdBtn" value="아이디 찾기">
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
		$('.findIdBtn').on('click', function(e){
			// 아이디와 이메일 값 가져오기
			let name = $('#name').val();
			let email = $('#email').val();
			
			// 유효성 검사
			if(name==''){
				alert("이름을 입력하세요.");
				return;
			}
			if(email==''){
				alert("이메일을 입력하세요.");
				return;
			}
			
			// ajax 통신을 이용한 값 넘기기
			$.ajax({
				type: 'post'
				,url: '/user/find_id'
				,data: {'name':name, 'email':email}
				,success: function(data){
					if(data.result=="success"){
						alert("loginId는 "+data.loginId+" 입니다.")
						location.href="/user/sign_in_view";
					}else if(data.result=="fail") {
						alert("이름과 이메일을 다시 확인해주세요.");
						location.reload();
					}else{
						alert("아이디를 찾는데 실패하였습니다. 관리자에게 문의해주세요.");
					}
				},error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});
</script>