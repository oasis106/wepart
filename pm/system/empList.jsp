<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
	#empMainContent{
		background-color: white;
		border-top-left-radius: 20px;
	    border-top-right-radius: 20px;
	    border-bottom-right-radius: 20px;
	    border-bottom-left-radius: 20px;
	    padding: 50px;
	}

	.empList_Header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-weight: 600;
		text-align: center;
		margin-bottom: 20px;
	}
	.empList_Header>span{
		font-size: 1.5em;
	}
	
	
	.empCount{
		margin-top: 20px;
		font-weight: 600;
	}
	
	.empUpdateForm_header{
		border-bottom: 1px solid #e0e0e0;
	    padding: 16px;
	    display: flex;
	    justify-content: space-between;
	    font-size: 1.3em;
	    font-weight: 600;
	}
	
	.empUpdateForm_main{
		padding: 16px;
	}
	
	.empAddForm_header{
		border-bottom: 1px solid #e0e0e0;
		padding: 16px;
		display:flex;
		justify-content: space-between;
 		font-size: 1.3em; 
		font-weight: 600;
	}
	
	.empAddForm_main{
		padding: 16px;
	}
	
	.form-group.row{
		display: flex;
		align-items: center;
		justify-content: space-around;
	}
	
	.col-sm-2.col-form-label{
		margin-bottom: 0;
		white-space: nowrap;
	}
	
	.error{
		color: red;
	}
	
	.possible{
		color: green;
	}
	
	#empList tr:hover{
		background: #F8F9FA;
	}
	
	#add_submitBtn{
		width: 85%;
		background-color: #4B49AC;
   		border: none;
	}
	
	#update_submitBtn, #delete_submitBtn{
		width: 45%;
	}
	.form-group.row.submitBtnArea{
		margin-bottom: 0;
		display: flex;
		justify-content: space-evenly;
	}
	
	.closeBtn_insert, .closeBtn_update{
		cursor: pointer;
	}
	
	.modal{
		font-size: 1.5rem;
	}

	.form-group.row label{
		font-size: 1.5rem;
	}
	
	.form-group.row input{
		font-size: 1.5rem;
	}
	
	.form-group.row select{
		font-size: 1.5rem;
	}
	
	.form-group.row option{
		font-size: 1.5rem;
	}
	
	.btn{
		font-size: 1.5rem;
	}
.ani-icon{
	width: 30px;
	height: 30px;
	margin: inherit;
	border-style: outset;
	border-radius: 20%;
}
	select.form-control{
		color: black;
	}
</style>

<section id="empMainContent">
	<div class="empList_Header">
		<span>직원 관리</span>
		<c:if test="${authMem.memRole == 'ROLE_ADMIN' or authMem.memRole == 'ROLE_SYM'}">
			<button class="btn btn-warning btn-fw empAddForm">
			직원 추가하기  <img  id="dummy" class="ani-icon" src="${cPath }/resources/animated_icon/id.gif">
			</button>	
		</c:if>
	</div>
	<div class="custom-control custom-switch">
	  <input type="checkbox" class="custom-control-input" id="customSwitch1">
	  <label class="custom-control-label" for="customSwitch1">퇴사자 보기</label>
	</div>
	<div class="empCount">
		<span>총 직원수: ${fn:length(empList) }</span>
	</div>
	<table class="table">
		<thead class="table thead-white">
			<th>사원번호</th>
			<th>이름</th>
			<th>계정</th>
			<th>직책</th>
			<th>권한</th>
			<th>입사일</th>
			<th>퇴사일</th>
			<th>연락처</th>
			<th>이메일</th>
		</thead>
		<tbody id="empList">
			<c:if test="${not empty empList }">
				<c:forEach items="${empList }" var="emp">
					<tr data-account="${emp.empId }">
						<td>${emp.empNo }</td>
						<td>${emp.empName }</td>
						<td>${emp.empId }</td>
						<td>${emp.empDep }</td>
						<td>${emp.memRole }</td>
						<td>${emp.empSdate }</td>
						<td>${emp.empEdate }</td>
						<td>${emp.empHp }</td>
						<td>${emp.empMail }</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</section>

<!-- 직원 수정 modal 영역 -->
<div class="modal updateModal"> 
	<div class="modal-dialog"> 
		<div class="modal-content">
		 	<div class="empUpdateForm_header">
		 		<span class="update_spanHeader"></span>
		 		<span class="closeBtn_update">x</span>
		 	</div>
		 	<div class="empUpdateForm_main">
		 		<form:form modelAttribute="employee" id="updateEmpForm" method="post" action="${cPath }/system/update/">
		 			<div class="form-group row">
					    <label for="empPass" class="col-sm-2 col-form-label">비밀번호</label>
					    <div class="col-sm-7">
					      <form:input path="empPass" type="password" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empName" class="col-sm-2 col-form-label">이름</label>
					    <div class="col-sm-7">
					      <form:input path="empName" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empHp" class="col-sm-2 col-form-label">연락처</label>
					    <div class="col-sm-7">
					      <form:input path="empHp" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empMail" class="col-sm-2 col-form-label">이메일</label>
					    <div class="col-sm-7">
					      <form:input path="empMail" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empSdate" class="col-sm-2 col-form-label">입사일</label>
					    <div class="col-sm-7">
					      <form:input path="empSdate" type="date" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empEdate" class="col-sm-2 col-form-label">퇴사일</label>
					    <div class="col-sm-7">
					      <form:input path="empEdate" type="date" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empDep" class="col-sm-2 col-form-label">직무</label>
					    <div class="col-sm-7">
					      <form:input path="empDep" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empAdd1" class="col-sm-2 col-form-label">주소</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd1" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empAdd2" class="col-sm-2 col-form-label">상세주소</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd2" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="memRole" class="col-sm-2 col-form-label">권한</label>
					    <div class="col-sm-7">
					      <form:select path="memRole" type="text" class="form-control">
					      	<c:forEach items="${roleList }" var="role">
					      		<form:option value="${role.authority }">${role.description }</form:option>
					      	</c:forEach>
					      </form:select>
					      <span class="error"></span>
					    </div>
					</div>
					
					<div class="form-group row submitBtnArea">
						<button type="button" id="update_submitBtn" class="btn btn-info">저장하기</button>
						<button type="button" id="delete_submitBtn" class="btn btn-danger">삭제하기</button>
					</div>
		 		</form:form>
		 	</div>
		</div>
	</div> 
</div>


<!-- 직원 insert모달창 영역 -->
<div class="modal insertModal"> 
	<div class="modal-dialog"> 
		<div class="modal-content">
		 	<div class="empAddForm_header">
		 		<span>직원 추가하기</span>
		 		<div>
			 		<button id="dummyBtn" class="btn btn-info">데이터</button>
			 		<span class="closeBtn_insert">x</span>
		 		</div>
		 	</div>
		 	<div class="empAddForm_main">
		 		<form:form modelAttribute="employee" id="newEmpForm" method="post" action="${cPath }/system/insert">
		 			<div class="form-group row">
					    <label for="empId" class="col-sm-2 col-form-label">아이디</label>
					    <div class="col-sm-7">
					      <form:input path="empId" class="form-control form-control-sm newEmpId" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empPass" class="col-sm-2 col-form-label">비밀번호</label>
					    <div class="col-sm-7">
					      <form:input path="empPass" type="password" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empName" class="col-sm-2 col-form-label">이름</label>
					    <div class="col-sm-7">
					      <form:input path="empName" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empHp" class="col-sm-2 col-form-label">연락처</label>
					    <div class="col-sm-7">
					      <form:input path="empHp" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empMail" class="col-sm-2 col-form-label">이메일</label>
					    <div class="col-sm-7">
					      <form:input path="empMail" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empSdate" class="col-sm-2 col-form-label">입사일</label>
					    <div class="col-sm-7">
					      <form:input path="empSdate" type="date" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empDep" class="col-sm-2 col-form-label">직무</label>
					    <div class="col-sm-7">
					      <form:input path="empDep" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="empAdd1" class="col-sm-2 col-form-label">주소</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd1" type="text" class="form-control"/>
			      		  <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="empAdd2" class="col-sm-2 col-form-label">상세주소</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd2" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="memRole" class="col-sm-2 col-form-label">권한</label>
					    <div class="col-sm-7">
					      <form:select path="memRole" type="text" class="form-control">
					      	<c:forEach items="${roleList }" var="role">
					      		<form:option value="${role.authority }">${role.description }</form:option>
					      	</c:forEach>
					      </form:select>
					      <span class="error"></span>
					    </div>
					</div>
				      
					<div class="form-group row submitBtnArea">
						<button type="button" id="add_submitBtn" class="btn btn-info">추가하기</button>
					</div>
		 		</form:form>
		 	</div>
		</div>
	</div> 
</div>


<script src="${cPath }/resources/js/makeErrorMessage.js"></script>
<script>
	flatpickr("#empSdate");
	flatpickr("#empEdate");
	
	$('#dummyBtn').on('click', function(){
		$('.insertModal #empId').val('newadmin');
		$('.insertModal #empPass').val('1234');
		$('.insertModal #empName').val('아이유');
		$('.insertModal #empHp').val('010-4379-0852');
		$('.insertModal #empMail').val('doerdream@naver.com');
		$('.insertModal #empSdate').val('2022-06-14');
		$('.insertModal #empDep').val('경리');
		$('.insertModal #empAdd1').val('서울특별시 마포구 와우산로32길 35 벙글빌딩');
		$('.insertModal #empAdd2').val('402호');
		$('.insertModal #memRole').val('ROLE_A');
	})

	const insert_inputs = $('.insertModal :input[name]');
	const update_inputs = $('.updateModal :input[name]');
	const update_spanHeader = $('.update_spanHeader');
	const updateForm_spans = $('div.updateModal').find('span.error');
	const tbodyEmpList = $('#empList');
	let empListJSON = ${empJson};
	
	// 모달 닫기버튼 
	let closeBtn_insert = $('.closeBtn_insert').on('click', function(){
		$('div.insertModal').modal('hide');		
	})
	// 모달 닫기버튼 
	let closeBtn_update = $('.closeBtn_update').on('click', function(){
		$('div.updateModal').modal('hide');		
	})
	
	let empToggleBtn = $('#customSwitch1').on('click', function(){
		this.classList.toggle('retire');
		let empCategory = 'work';
		if(this.classList.contains('retire')){
			empCategory = 'retire';
		}
		$.ajax({
			url:'${cPath}/system/employeeCategory',
			data: {'empCategory' : empCategory} ,
			dataType: 'json',
			method: 'get',
			success: function(resp){
				let trs = [];
				resp.empList.forEach(emp => {
					let tr = `
						<tr data-account="`+emp.empId+`">
							<td>`+emp.empNo+`</td>
							<td>`+emp.empName+`</td>
							<td>`+emp.empId+`</td>
							<td>`+emp.empDep+`</td>
							<td>`+emp.memRole+`</td>
							<td>`+(emp.empSdate == null ? '' : emp.empSdate)+`</td>
							<td>`+(emp.empEdate == null ? '' : emp.empEdate)+`</td>
							<td>`+(emp.empHp == null ? '' : emp.empHp)+`</td>
							<td>`+(emp.empMail == null ? '' : emp.empMail)+`</td>
						</tr>
					`;
					trs.push(tr);
				});
				tbodyEmpList.html(trs);
				empListJSON = resp.empJson;
				
			},
			error: function(error){
				console.log(error);
			}
		})
	});
	
	let targetEmpId = null;
	// 직원 수정 모달창 띄우기
	$('#empList').on('click', 'tr', function(){
		updateForm_spans.each(function(index, span){
			span.innerHTML = '';
		});
		targetEmpId = this.dataset.account;
		empListJSON.forEach((emp, index) => {
			if(emp.empId == targetEmpId){
				let keys = Object.keys(emp);
				update_inputs.each(function(index, input){
					input.value = emp[input.name];
				});
				updateEmpForm[0].action = '${cPath }/system/update/' + targetEmpId;
				update_spanHeader[0].innerHTML = emp.empName + '의 정보 수정하기';
			}
		})
		$('div.updateModal').modal();		
	})
	
	let updateEmpForm = $('#updateEmpForm').ajaxForm({
		dataType: 'json',
		method: 'post',
		success: function(resp){
			if(resp.HAS_ERROR == "OK"){
				makeErrorMsg(resp, update_inputs);			
				return false;
			}
			if(resp.retValue == 'success'){
				location.href = '${cPath}/system/employee';
				Swal.fire({
					  icon: 'success',
					  title: '수정 성공',
					  showConfirmButton: false,
					  timer: 1500
				})
				return false;
			}else if(resp.retValue == 'delete_success'){
				location.href = '${cPath}/system/employee';
				Swal.fire({
					  icon: 'success',
					  title: '삭제 성공',
					  showConfirmButton: false,
					  timer: 1500
				})
			}

		}
	})
	
	$('#update_submitBtn').on('click', function(){
		updateEmpForm[0].action = '${cPath }/system/update/' + targetEmpId;
		updateEmpForm.submit();
	})
	
	$('#delete_submitBtn').on('click', function(){
		updateEmpForm[0].action = '${cPath }/system/delete/' + targetEmpId;
		updateEmpForm.submit();
	})
	
	//직원 등록 모달창 띄우기
	$('.empAddForm').on('click', function(){
		$('div.insertModal').modal();		
	})
	
	// 아이디 중복체크 ajax
	let idCheckFn = function(target){
		let targetId = target.value.trim(); 
		let spanTag = target.nextSibling.nextSibling;
		spanTag.className = 'error';
		if(targetId.length == 0 || targetId == ''){
		}
		else if(targetId.length < 5 || targetId.length > 13){
			spanTag.innerHTML = '5~13자만 사용 가능합니다.'
		}else{
			$.ajax({
				url:'${cPath}/system/insert/idcheck',
				data: { "empId": targetId},
				dataType: 'text',
				method: 'get',
				success: function(resp){
					if(resp == "INVALID"){
						spanTag.innerHTML = '이미 존재하는 ID입니다.';
					}else{
						spanTag.innerHTML = '사용가능한 ID입니다.';		
						spanTag.className = 'possible';
					}
				}
			})
		}
	}
	
	// id인풋태그 포커스아웃시 아이디중복체크 ajax
	$('.newEmpId').on('focusout', function(){
		idCheckFn(this);
	})
	
	let newEmpForm = $('#newEmpForm').ajaxForm({
		dataType: 'json',
		method: 'post',
		success: function(resp){
			if(resp.retValue == 'success'){
				location.href = '${cPath}/system/employee';
				return false;
			}
			if(resp.HAS_ERROR == "OK"){
				console.log(insert_inputs);
				makeErrorMsg(resp, insert_inputs);				
			}
			let inputTag = document.querySelector('.newEmpId');
			idCheckFn(inputTag);
		}
	});
	
	$('#add_submitBtn').on('click', function(){
		newEmpForm.submit();
	})

</script>
