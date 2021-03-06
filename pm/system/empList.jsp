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
		<span>?????? ??????</span>
		<c:if test="${authMem.memRole == 'ROLE_ADMIN' or authMem.memRole == 'ROLE_SYM'}">
			<button class="btn btn-warning btn-fw empAddForm">
			?????? ????????????  <img  id="dummy" class="ani-icon" src="${cPath }/resources/animated_icon/id.gif">
			</button>	
		</c:if>
	</div>
	<div class="custom-control custom-switch">
	  <input type="checkbox" class="custom-control-input" id="customSwitch1">
	  <label class="custom-control-label" for="customSwitch1">????????? ??????</label>
	</div>
	<div class="empCount">
		<span>??? ?????????: ${fn:length(empList) }</span>
	</div>
	<table class="table">
		<thead class="table thead-white">
			<th>????????????</th>
			<th>??????</th>
			<th>??????</th>
			<th>??????</th>
			<th>??????</th>
			<th>?????????</th>
			<th>?????????</th>
			<th>?????????</th>
			<th>?????????</th>
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

<!-- ?????? ?????? modal ?????? -->
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
					    <label for="empPass" class="col-sm-2 col-form-label">????????????</label>
					    <div class="col-sm-7">
					      <form:input path="empPass" type="password" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empName" class="col-sm-2 col-form-label">??????</label>
					    <div class="col-sm-7">
					      <form:input path="empName" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empHp" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empHp" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empMail" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empMail" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empSdate" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empSdate" type="date" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empEdate" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empEdate" type="date" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empDep" class="col-sm-2 col-form-label">??????</label>
					    <div class="col-sm-7">
					      <form:input path="empDep" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empAdd1" class="col-sm-2 col-form-label">??????</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd1" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empAdd2" class="col-sm-2 col-form-label">????????????</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd2" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="memRole" class="col-sm-2 col-form-label">??????</label>
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
						<button type="button" id="update_submitBtn" class="btn btn-info">????????????</button>
						<button type="button" id="delete_submitBtn" class="btn btn-danger">????????????</button>
					</div>
		 		</form:form>
		 	</div>
		</div>
	</div> 
</div>


<!-- ?????? insert????????? ?????? -->
<div class="modal insertModal"> 
	<div class="modal-dialog"> 
		<div class="modal-content">
		 	<div class="empAddForm_header">
		 		<span>?????? ????????????</span>
		 		<div>
			 		<button id="dummyBtn" class="btn btn-info">?????????</button>
			 		<span class="closeBtn_insert">x</span>
		 		</div>
		 	</div>
		 	<div class="empAddForm_main">
		 		<form:form modelAttribute="employee" id="newEmpForm" method="post" action="${cPath }/system/insert">
		 			<div class="form-group row">
					    <label for="empId" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empId" class="form-control form-control-sm newEmpId" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empPass" class="col-sm-2 col-form-label">????????????</label>
					    <div class="col-sm-7">
					      <form:input path="empPass" type="password" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empName" class="col-sm-2 col-form-label">??????</label>
					    <div class="col-sm-7">
					      <form:input path="empName" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empHp" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empHp" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empMail" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empMail" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empSdate" class="col-sm-2 col-form-label">?????????</label>
					    <div class="col-sm-7">
					      <form:input path="empSdate" type="date" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
		 			<div class="form-group row">
					    <label for="empDep" class="col-sm-2 col-form-label">??????</label>
					    <div class="col-sm-7">
					      <form:input path="empDep" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="empAdd1" class="col-sm-2 col-form-label">??????</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd1" type="text" class="form-control"/>
			      		  <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="empAdd2" class="col-sm-2 col-form-label">????????????</label>
					    <div class="col-sm-7">
					      <form:input path="empAdd2" type="text" class="form-control" />
					      <span class="error"></span>
					    </div>
					</div>
					<div class="form-group row">
					    <label for="memRole" class="col-sm-2 col-form-label">??????</label>
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
						<button type="button" id="add_submitBtn" class="btn btn-info">????????????</button>
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
		$('.insertModal #empName').val('?????????');
		$('.insertModal #empHp').val('010-4379-0852');
		$('.insertModal #empMail').val('doerdream@naver.com');
		$('.insertModal #empSdate').val('2022-06-14');
		$('.insertModal #empDep').val('??????');
		$('.insertModal #empAdd1').val('??????????????? ????????? ????????????32??? 35 ????????????');
		$('.insertModal #empAdd2').val('402???');
		$('.insertModal #memRole').val('ROLE_A');
	})

	const insert_inputs = $('.insertModal :input[name]');
	const update_inputs = $('.updateModal :input[name]');
	const update_spanHeader = $('.update_spanHeader');
	const updateForm_spans = $('div.updateModal').find('span.error');
	const tbodyEmpList = $('#empList');
	let empListJSON = ${empJson};
	
	// ?????? ???????????? 
	let closeBtn_insert = $('.closeBtn_insert').on('click', function(){
		$('div.insertModal').modal('hide');		
	})
	// ?????? ???????????? 
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
	// ?????? ?????? ????????? ?????????
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
				update_spanHeader[0].innerHTML = emp.empName + '??? ?????? ????????????';
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
					  title: '?????? ??????',
					  showConfirmButton: false,
					  timer: 1500
				})
				return false;
			}else if(resp.retValue == 'delete_success'){
				location.href = '${cPath}/system/employee';
				Swal.fire({
					  icon: 'success',
					  title: '?????? ??????',
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
	
	//?????? ?????? ????????? ?????????
	$('.empAddForm').on('click', function(){
		$('div.insertModal').modal();		
	})
	
	// ????????? ???????????? ajax
	let idCheckFn = function(target){
		let targetId = target.value.trim(); 
		let spanTag = target.nextSibling.nextSibling;
		spanTag.className = 'error';
		if(targetId.length == 0 || targetId == ''){
		}
		else if(targetId.length < 5 || targetId.length > 13){
			spanTag.innerHTML = '5~13?????? ?????? ???????????????.'
		}else{
			$.ajax({
				url:'${cPath}/system/insert/idcheck',
				data: { "empId": targetId},
				dataType: 'text',
				method: 'get',
				success: function(resp){
					if(resp == "INVALID"){
						spanTag.innerHTML = '?????? ???????????? ID?????????.';
					}else{
						spanTag.innerHTML = '??????????????? ID?????????.';		
						spanTag.className = 'possible';
					}
				}
			})
		}
	}
	
	// id???????????? ?????????????????? ????????????????????? ajax
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
