<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href='${cPath }/resources/fullcalendar_premium/main.css' rel='stylesheet' />
<script src='${cPath }/resources/fullcalendar_premium/main.js'></script>
<script src='${cPath }/resources/fullcalendar_premium/locales-all.js'></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" ></script>
<%-- <script src="${cPath }/resources/bootstrap-select/bootstrap-select.min.js"></script> --%>
<%-- <script src="${cPath }/resources/bootstrap-select/defaults-ko_KR.min.js"></script> --%>
<%-- <link rel="stylesheet" href="${cPath }/resources/bootstrap-select/bootstrap-select.min.css"> --%>

<style>
/* 	.bootstrap-select>select.bs-select-hidden, select.bs-select-hidden, select.selectpicker { */
/*      display: block!important;  */
/* } */
	#scheduleMainContent{
		background-color: white;
		border-top-left-radius: 20px;
	    border-top-right-radius: 20px;
	    border-bottom-right-radius: 20px;
	    border-bottom-left-radius: 20px;
	    padding: 50px;
	}
	
	.scheduleMainContent_header{
		display: flex;
		justify-content: space-between;
	}
	
	.scheduleMainContent_header h2{
		font-weight: 900;
	}
	
	#calendar {
	  margin: 0 auto;
	}
	
	a{
		color: black;
	}
	
	.scheduleAddOne_header, .scheduleAddBatch_header{
		border-bottom: 1px solid #e0e0e0;
	    padding: 16px;
	    display: flex;
	    justify-content: space-between;
	    font-size: 1.3em;
	    font-weight: 600;
	}
	
	.scheduleAddOne_main{
		padding: 16px;
	}
	
	.form-group.row {
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
	
	.fc-toolbar-chunk{
		display: flex;
		align-items: center;
	}
	
	.fc-toolbar-chunk h2.fc-toolbar-title {
		margin: 20px;
	}
	
	.fc-toolbar-chunk button.fc-next-button.fc-button.fc-button-primary{
		margin: 0;
	}
	
	.workEvent {
		background-color: #3788d8;
	}
	
	.workEvent:hover {
		background-color: #3788d8;
	}
	
	.holidayEvent{
		background-color: #2d7c13;
	}
	
	.holidayEvent:hover{
		background-color: #2d7c13;
	}
	
	i{
		font-family: 'Nanum Gothic', sans-serif;
		font-style: normal;
	}
	
	.inputAndError{
		display: flex;
		flex-direction: column;
	}
	
	.addBatch .modal-dialog{
		width: 70%;
		max-width: 70%;
	}
	
	.scheduleAddBatch_content{
		display: flex;
		padding: 20px;
/* 		flex: 1 1; */
	}
	
	.scheduleAddBatch_main{
		width: 40%;
	}

	#batch_calendarAndCover{
		position: relative;
		width: 60%;
	}
	
	#batch_cover{
		position: absolute;
		width: 100%;
		height: 100%;
		cursor: not-allowed;
		top: 0;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
		background-color: rgba( 255, 255, 255, 0.8 );
	}
	
	#batch_cover h4{
		font-weight: 600;	
	}
	
	.scheduleAddBatch_footer, .scheduleAddOne_footer{
		border-top: 1px solid #e0e0e0;
	}
	
	.closeBtn_modalBatch, .closeBtn_modalOne{
		cursor: pointer;
	}
	
	table tbody tr td.userClicked.fc-daygrid-day.fc-day{
		background-color: #50A1F2;
	}
	
	td.fc-daygrid-day.fc-day{
		cursor: pointer;	
	}
	
	
	tr td.crashed_td.fc-daygrid-day.fc-day{
		background-color: rgba( 0, 0, 0, 0.8 );
		z-index: 999;
		cursor: not-allowed;
	}
	
	.fc .fc-daygrid-day.fc-day-today{
		background-color: white;
	}
	
	.fc .fc-daygrid-day.fc-day-today.userClicked{
		background-color: #50A1F2;
	}
	
	.header_buttons{
		display: flex;
	}
	
	.scheduleAddOne_footer{
		display: flex;
		justify-content: space-between;
		padding: 12px 16px;
	}
	
</style>
<section id="scheduleMainContent">
	<div class="scheduleMainContent_header">
		<h2>????????????</h2>
		<div class="header_buttons">
			<form method="post" id="excelForm" action="${cPath}/workSchedule/excel">
				<input type="hidden" name="inputMonth" id="excelMonth">
				<button class="btn btn-success btn-icon-text" id="excelDownload">
					Excel ??????
					<i class="ti-file btn-icon-append"></i>
				</button>
			</form>
			<button id="scheduleBatchAddBtn" class="btn btn-dark">???????????? ?????? ????????????</button>
		</div>
	</div>
	
	<div id='calendar'></div>
</section>
<!-- ???????????? ???????????? ???????????? -->
<div class="modal addBatch"> 
	<div class="modal-dialog"> 
		<div class="modal-content">
		 	<div class="scheduleAddBatch_header">
		 		<span class="addBatch_spanHeader">???????????? ????????????</span>
		 		<span class="closeBtn_modalBatch">x</span>
		 	</div>
		 	<div class="scheduleAddBatch_content">
			 	<div class="scheduleAddBatch_main">
			 		<form:form modelAttribute="schedule" id="scheduleAddBatchForm" method="post" action="${cPath}/hr/workSchedule/batch">
			 			<div class="form-group row">
						    <label  class="col-sm-2 col-form-label">??????</label>
						    <div class="col-sm-7">
						    	<select name="empIdss[]" class="addBatch_Select" multiple="true" >
						    		<c:forEach items="${empList }" var="emp">
						    		<option class="addBatch_option_empId" value="${emp.empId }" >${emp.empName }</option>
						    		</c:forEach>
						    	</select>
						      	<span class="error"></span>
						    </div>
						</div>
			 			<div id="addBatch_timeInput">
			 				<div class="form-group row">
							    <label class="col-sm-2 col-form-label">??????(??????)</label>
							    <div class="col-sm-7 inputAndError">
							    	<form:input path="scShour" class="eachTime" type="number" maxlength="2" placeholder="HH" value="09"/>
									<span class="error"></span>
							    </div>
			 				</div>
						    <div class="form-group row">
							    <label class="col-sm-2 col-form-label">??????(???)</label>
							    <div class="col-sm-7 inputAndError">
							    	<form:input path="scSminute" class="eachTime" type="number" maxlength="2" placeholder="HH" value="00"/>
									<span class="error"></span>
							    </div>
			 				</div>
			 				<div class="form-group row">
							    <label class="col-sm-2 col-form-label">??????(??????)</label>
							    <div class="col-sm-7 inputAndError">
							    	<form:input path="scEhour" class="eachTime" type="number" maxlength="2" placeholder="HH" value="18"/>
									<span class="error"></span>
							    </div>
			 				</div>
			 				<div class="form-group row">
							    <label class="col-sm-2 col-form-label">??????(???)</label>
							    <div class="col-sm-7 inputAndError">
							    	<form:input path="scEminute" class="eachTime" type="number" maxlength="2" placeholder="HH" value="00"/>
									<span class="error"></span>
							    </div>
			 				</div>
			 				<div class="form-group row" >
		 					<button id="addBatch_submitBtn" class="btn btn-info" style="width: 80%; font-size: 1.3em;" disabled>???????????? ????????????</button>
			 				</div>
						</div>
	
			 		</form:form>
			 	</div>
			 	<div id="batch_calendarAndCover">
				 	<div id='batch_calendar' class="batch_calendar"></div>
				 	<div id="batch_cover"><h4>????????? ??????????????? ????????? ???, ??????????????? ??????????????????.</h4></div>
			 	</div>
		 	</div>
		</div>
	</div> 
</div>


	
<!-- ???????????? ?????? modal ?????? -->
<div class="modal addOne"> 
	<div class="modal-dialog"> 
		<div class="modal-content">
		 	<div class="scheduleAddOne_header">
		 		<span class="addOne_spanHeader"></span>
		 		<span class="closeBtn_modalOne">x</span>
		 	</div>
		 	<div class="scheduleAddOne_main">
		 		<form:form modelAttribute="schedule" id="scheduleAddOneForm" method="post" action="${cPath}/hr/workSchedule/insert">
		 			<div class="form-group row">
					    <label  class="col-sm-2 col-form-label">??????</label>
					    <div class="col-sm-7">
					    	<form:select path="empId">
					    		<c:forEach items="${empList }" var="emp">
					    		<form:option class="addOne_option_empId" value="${emp.empId }" >${emp.empName }</form:option>
					    		</c:forEach>
					    	</form:select>
					      	<span class="error"></span>
					    </div>
					</div>
		 			<div id="addOne_timeInput">
		 				<div class="form-group row">
						    <label class="col-sm-2 col-form-label">??????(??????)</label>
						    <div class="col-sm-7 inputAndError">
						    	<form:input path="scShour" class="eachTime" type="number" maxlength="2" placeholder="HH" value="9"/>
								<span class="error"></span>
						    </div>
		 				</div>
					    <div class="form-group row">
						    <label class="col-sm-2 col-form-label">??????(???)</label>
						    <div class="col-sm-7 inputAndError">
						    	<form:input path="scSminute" class="eachTime" type="number" maxlength="2" placeholder="HH" value="9"/>
								<span class="error"></span>
						    </div>
		 				</div>
		 				<div class="form-group row">
						    <label class="col-sm-2 col-form-label">??????(??????)</label>
						    <div class="col-sm-7 inputAndError">
						    	<form:input path="scEhour" class="eachTime" type="number" maxlength="2" placeholder="HH" value="9"/>
								<span class="error"></span>
						    </div>
		 				</div>
		 				<div class="form-group row">
						    <label class="col-sm-2 col-form-label">??????(???)</label>
						    <div class="col-sm-7 inputAndError">
						    	<form:input path="scEminute" class="eachTime" type="number" maxlength="2" placeholder="HH" value="9"/>
								<span class="error"></span>
						    </div>
		 				</div>
					</div>
		 			<div class="form-group row">
					    <label  class="col-sm-2 col-form-label">????????????</label>
					    <div class="addOneMemoDIV col-sm-7">
					      <form:textarea path="scMemo" rows="" cols=""></form:textarea>
					    </div>
					</div>
					<input name="scSdate" type="hidden" value="">
					<span class="error"></span>
					<input name="scEdate" type="hidden" value="">
					<span class="error"></span>
		 		</form:form>
		 	</div>
		 	<div class="scheduleAddOne_footer">
		 		<button id="addOne_deleteBtn" class="btn btn-outline-danger btn-fw">????????????</button>
		 		<div>
			 		<button class="btn btn-outline-secondary btn-fw closeBtn_modalOne">??????</button>
			 		<button id="addOne_submitBtn" class="btn btn-info">??????</button>		 		
		 		</div>
		 	</div>
		</div>
	</div> 
</div>

<script src="${cPath }/resources/js/makeErrorMessage.js"></script>

<!--  ???????????? ????????? ???????????? -->
<script>
  // ????????? ??????
  let calendar = null;
  let batchCalendar = null;
  //??????????????? ????????? ??????.
  let clicked_dateList = []; 
  
  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    
	    // event ???????????? ??????.
	    let month_events = [];
	    let event = null;
	    <c:if test="${not empty schedules }">
			<c:forEach items="${schedules }" var="schedule">
			event = {
						classNames: ['workEvent'],
						title: '${schedule.empName}, ${schedule.scStime} - ${schedule.scEtime}',
						start: '${schedule.scSdate}T${schedule.scStime}',
						end: '${schedule.scEdate}T${schedule.scEtime}',
						id: '${schedule.scId}',
						resourceId: '${schedule.empId}',
						allDay: false,
						source: {
							'empId': '${schedule.empId}',
							'empName': '${schedule.empName}',
							'empNo': '${schedule.empNo}',
							'scStime': '${schedule.scStime}',
							'scEtime': '${schedule.scEtime}',
							'scSdate': '${schedule.scSdate}',
							'scEdate': '${schedule.scEdate}',
							'scMemo': '${schedule.scMemo}',
							'scSort': '${schedule.scSort}',
							'resourceId': '${schedule.empId}'
						}
					}
			month_events.push(event);
			</c:forEach>
		</c:if>
		<c:if test="${not empty holiList }">
			<c:forEach items="${holiList }" var="schedule">
			event = {
						classNames: ['holidayEvent'],
						title: "${schedule.empName} - ${schedule.scSort == 'amHoli' ? '??????(??????)' : schedule.scSort == 'pmHoli' ? '??????(??????)' : '??????'}",
						start: '${schedule.scSdate}T${schedule.scStime}',
						end: '${schedule.scEdate}T${schedule.scEtime}',
						id: '${schedule.scId}',
						resourceId: '${schedule.empId}',
						allDay: false,
						source: {
							'empId': '${schedule.empId}',
							'empName': '${schedule.empName}',
							'empNo': '${schedule.empNo}',
							'scStime': '${schedule.scStime}',
							'scEtime': '${schedule.scEtime}',
							'scSdate': '${schedule.scSdate}',
							'scEdate': '${schedule.scEdate}',
							'scMemo': '${schedule.scMemo}',
							'scSort': '${schedule.scSort}',
							'resourceId': '${schedule.empId}'
						}
					}
			month_events.push(event);
			</c:forEach>
		</c:if>
		
		// resources ???????????? ??????.
		let employee_list = [];
		let empJson = ${empJson};
		let emp = null;
		empJson.forEach(emp => {
			emp = {
				'id': emp.empId,
				'title': emp.empName,
				'wh': 0,
				'whText': '0h'
			};
			employee_list.push(emp);
		})
		
		
		// calendar ??????.
	    calendar = new FullCalendar.Calendar(calendarEl, {
		      schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
		      eventContent: function(arg) {
		    	  let text = document.createElement('i');
				  text.innerHTML = arg.event.title;
		 
		    	  let arrayOfDomNodes = [ text ]
		    	  return { domNodes: arrayOfDomNodes }
		    	},
			  
		      height: "auto",
		      headerToolbar: {
		        left: 'today',
		        center: 'prev title next',
		        right: 'dayGridMonth customWeek resourceTimelineDay'
		      },
		      views: {
		    	    customWeek: {
		    	      type: 'resourceTimelineWeek',
		    	      duration: { weeks: 1 },
		              slotDuration: { days: 1 }
		    	    }
		      },
		      // ???,???,??? ???????????????(view??? ???????????????) ?????????. eventContent??? ????????? ?????? ????????????.
		      datesSet: function(info) {
		    	let resourceAPIS = info.view.calendar.getResources();
		    	resourceAPIS.forEach(resourceAPI => {
		    		resourceAPI.setExtendedProp('wh', 0);
		    		resourceAPI.extendedProps.wh = 0;
		    		resourceAPI.extendedProps.whText = 0 + "??????";
		    	})
	
		    	let all_events = info.view.calendar.getEvents();
		    	let selectedView_events = [];
		    	all_events.filter(
		    		function(event) {
		    			return event.extendedProps.source.scSort == '' || event.extendedProps.source.scSort == null; 
		    		}		
		    	).forEach(event => {
		    		console.log(event.extendedProps.source.scSort);
		    		if(info.start <= event.start && info.end >= event.end){
	    			  // ???????????? ?????? ??????.
		  	    	  let eachWorkHour = (event.end - event.start)/1000/60/60;
		  	    	  let sumWH = event.getResources()[0].extendedProps.wh + eachWorkHour;
		  	    	  event.getResources()[0].setExtendedProp('wh', sumWH);
		  	    	  event.getResources()[0].extendedProps.wh = sumWH;
		  	    	  event.getResources()[0].extendedProps.whText = sumWH + "??????";
		    		}
		    	})
		    	
		      },
		      initialDate: new Date(),
		      locale: 'ko',
		      navLinks: true, // can click day/week names to navigate views
		      selectable: true,
		      selectMirror: true,
		      slotMinTime: '07:00',
		      slotMaxTime: '20:00',
		      
		      //???????????? ????????? ?????????, ???????????? ???????????? ?????? ????????????.
		      select: function(arg){
		    	  addOneModal(arg);
		      },
		      
		      //???????????? ?????? ??????
		      resourceAreaWidth: '15%',
		      resourceAreaColumns: [
		        {
		          group: true,
		          field: 'title',
		          headerContent: '?????????'
		        },
		        {
		          field: 'whText',
		          headerContent: '????????????'
		        }
		      ],
		      
		      resources: employee_list,
		      //???????????? ????????? ????????? ?????????, ??????????????? ??????,?????? ???????????? ?????? ?????????
		      eventClick: function(arg) {
		    	  let scSort = arg.event.extendedProps.source.scSort;
		    	  if(scSort == null || scSort == ''){
			    	  updateOneModal(arg);		    		  
		    	  }
		      },
		      editable: false,
		      eventResourceEditable: false,
		      dayMaxEvents: false, // allow "more" link when too many events
		      events: month_events 
		      
	    }); // calendar ?????? ???
	    calendar.render();
    	
    	// ????????? ?????????
	    $('#calendar button.fc-prev-button').on('click', function(){
// 	    	monthScheduleAjax(calendar.getDate());
	    })
	    
	    // ????????? ?????????
	    $('#calendar button.fc-next-button').on('click', function(){
// 	    	monthScheduleAjax(calendar.getDate());
	    })
// ???????????? calendar ???
	    
	    
// ???????????? calendar ??????
	     var batchCalendarEl = document.getElementById('batch_calendar');
	    
	    batchCalendar = new FullCalendar.Calendar(batchCalendarEl, {
	      schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
	      height: "auto",
	      headerToolbar: {
	    	left: '',
	        center: 'prev title next',
	        right: ''
	      },
	      initialDate: new Date(),
	      locale: 'ko',
	      selectable: false,
	      unselectAuto: false,   
	      selectMirror: false,
	      unselectCancel: ".batch_calendar",
	      editable: false,
	      eventResourceEditable: false,
	      dayMaxEvents: true 
	    }); // ???????????? ????????? ?????? ???
    	
	    
	    $('#batch_calendar').on('click', '.fc-daygrid-day.fc-day', function(event){
	    	let target_td = $(event.target).closest("td");
	    	if(target_td.hasClass('crashed_td')){
	    		return false;
	    	}
	    	
	    	let clicked_date = target_td.data('date');
	    	if(target_td.hasClass("userClicked")){
	    		target_td.removeClass("userClicked");
	    		for(let i = 0; i < clicked_dateList.length; i++) {
    			  if(clicked_dateList[i] === clicked_date)  {
    				  clicked_dateList.splice(i, 1);
    			    i--;
    			  }
    			}
	    		if(clicked_dateList.length == 0){
	    			batchSubmitBtn.attr('disabled', true);
	    		}
	    	}else{
	    		target_td.addClass("userClicked");	    		
	    		clicked_dateList.push(clicked_date);
	    		batchSubmitBtn.attr('disabled', false);
	    	}
	    })
	    
	    
    	// ????????? ?????????
	    $('.addBatch').on('click', '#batch_calendar button.fc-prev-button', function(){
	    	batchValidate(batchCalendar.getDate());
	    })
	    
	    // ????????? ?????????
	    $('.addBatch').on('click', '#batch_calendar button.fc-next-button', function(){
	    	batchValidate(batchCalendar.getDate());
	    })
    
  });
  
  // ??? ?????????????????? ?????? ajax??????.
  // ???????????? ???,??? ?????? ????????? ????????? ?????????.
  let monthScheduleAjax = function(inputMonth){
	  $.ajax({
		url: '${cPath}/hr/workSchedule',
		data: {'inputMonth': inputMonth},
		dataType: 'json',
		method: 'get',
		success: function(resp){
			
			// ????????? ????????? ?????? ??????(db??????, fullcalendar??????)
			let events = calendar.getEvents();
			events.forEach(eachEvent => {
				eachEvent.remove();
			})
			
			// ????????? ????????? ??????(db??????, fullcalendar???)
			let event = null;
			resp.forEach(schedule => {
				event = {
						title: schedule.empName + ', ' + schedule.scStime + ' - ' + schedule.scEtime,
						start: schedule.scSdate + 'T' + schedule.scStime,
						end: schedule.scEdate + 'T' + schedule.scEtime,
						id: schedule.scId,
						resourceId: schedule.empId,
						source: {
							'empId': schedule.empId,
							'empName': schedule.empName,
							'empNo': schedule.empNo,
							'scStime': schedule.scStime,
							'scEtime': schedule.scEtime,
							'scSdate': schedule.scSdate,
							'scEdate': schedule.scEdate,
							'scMemo': schedule.scMemo,
							'resourceId': schedule.empId
						}
				}
				calendar.addEvent(event);
			})
		}
	  })
  }
  

</script>


<script>

	const modalForm = $('#scheduleAddOneForm');
	const addBatchForm = $('#scheduleAddBatchForm');
	
	const insert_inputs = $('#scheduleAddOneForm input[name]');
	const addBatch_inputs = $('#scheduleAddBatchForm input[name]');
	const addBatch_selectAndInputs = $('#scheduleAddBatchForm :input[name]');
	const addBatch_select = $('#scheduleAddBatchForm select');
	const addBatch_options = $('#scheduleAddBatchForm select option');
	const batch_cover = $('#batch_cover');
	
	let sdateInput = $('#scheduleAddOneForm input[name=scSdate]');
	let edateInput = $('#scheduleAddOneForm input[name=scEdate]');
	let modal_spanHeader = $('.addOne_spanHeader');
	let addOneModal_inputs = $('#addOne_timeInput input');
	let addOneModal_spans = $('#addOne_timeInput span');
	let addOne_empOptions = $('.addOne_option_empId');
	let addOne_memoTextArea = $('.addOneMemoDIV #scMemo');
	
	let modalSubmitBtn = $('#addOne_submitBtn');
	let batchSubmitBtn = $('#addBatch_submitBtn');
	
	$('#excelDownload').on('click', function(){
		$('#excelMonth').val(calendar.getDate());
		$('#excelForm').submit();
	})
	
// 	???????????? ???????????? ??????
	batchSubmitBtn.on('click', function(event){
		event.preventDefault();
		let??formSerializeArray??=??$('#scheduleAddBatchForm').serializeArray();
		formSerializeArray.push({name: 'clickedDateList', value: clicked_dateList});
		console.log(formSerializeArray);
		$.ajax({
			url: '${cPath}/hr/workSchedule/batch',
			method: 'post',
			dataType: 'text',
			data: formSerializeArray,
			success: function(resp){
// 				console.log(resp);
				if(resp == 'success'){
					Swal.fire({
						  icon: 'success',
						  title: '?????? ??????',
						  showConfirmButton: false,
						  timer: 1500
					})
					location.reload();
				}else if(resp == 'fail'){
					Swal.fire({
     				   icon: 'error',
     				   title: '????????????: ?????? ??????',
     				   text: '?????? ?????? ?????? ??????????????????.',
     				   showConfirmButton: false,
     				   timer: 1500
     				})
				}
			},
			error: function(error){
// 				console.log(error);
			}
		})
	})

	
	
	// ?????? ???????????? 
	let closeBtn_modalBatch = $('.closeBtn_modalBatch').on('click', function(){
		$('div.addBatch').modal('hide');
	})
	// ?????? ???????????? 
	let closeBtn_modalOne = $('.closeBtn_modalOne').on('click', function(){
		$('div.addOne').modal('hide');		
	})
	
	// ???????????? ??????????????? ????????? ????????? ajax???????????????.
	addBatch_select.on('change', function(){
		batchValidate(batchCalendar.getDate());
	})
	// ???????????? ??????????????? ????????? ????????? ajax???????????????.
	addBatch_inputs.on('focusout', function(){
		batchValidate(batchCalendar.getDate());
	})
	
	addBatch_inputs.on('input', function(){
		batchSubmitBtn.attr('disabled', true);
	})
	
	// ???????????? ?????????????????? ??????????????? ???????????? ajax
	let batchValidate = function(inputMonth){
		let empIds = [''];
		addBatch_options.each(function(index, option){
			if(option.selected){
				empIds.push(option.value);
			}
		});
		

		$.ajax({
			url: '${cPath}/hr/workSchedule/batch/inputValidate',
			data: {
				'empIdss': empIds,
				'scShour': $('#addBatch_timeInput #scShour').val(),
				'scSminute': $('#addBatch_timeInput #scSminute').val(),
				'scEhour': $('#addBatch_timeInput #scEhour').val(),
				'scEminute': $('#addBatch_timeInput #scEminute').val(),
				'inputMonth': inputMonth
			},
			dataType: 'json',
			method: 'post',
			success: function(resp){
				if(resp.HAS_ERROR == "OK"){
					makeErrorMsg(resp, addBatch_selectAndInputs);
					batch_cover.css('display', 'flex');
					batchSubmitBtn.attr('disabled', true);
					return false;
				}

				if(resp.retValue == 'success'){
					allResetErrorMsg(addBatch_selectAndInputs);
					if(empIds.length == 1){
						batch_cover.css('display', 'flex');
						batchSubmitBtn.attr('disabled', true);
						return false;
					}
										
					// ????????? ????????? ?????? ??????(db??????, fullcalendar??????)
					let events = batchCalendar.getEvents();
					events.forEach(eachEvent => {
						eachEvent.remove();
					})
					
					// ????????? ????????? ??????(db??????, fullcalendar???)
					let event = null;
					let scheduleList = JSON.parse(resp.scheduleList);
					scheduleList.forEach(schedule => {
						event = {
							title: schedule.empName,
							start: schedule.scSdate,
							id: schedule.scId,
							className: 'crashed_emp',
							source: {
								'empId': schedule.empId,
								'empName': schedule.empName
							},
							backgroundColor: 'rgba( 0, 0, 0, 0)' 
						}
						batchCalendar.addEvent(event);
					})
					
					$('td .fc-daygrid-day.fc-day').removeClass('crashed_td');
					$('td .fc-daygrid-day.fc-day').removeClass('userClicked');
					
					$('.crashed_emp').closest('.fc-daygrid-day.fc-day').addClass('crashed_td');
					clicked_dateList = [];
					batch_cover.css('display', 'none');
					batchSubmitBtn.attr('disabled', true);
					return false;					
				}
			},
			error: function(error){
// 				console.log(error);
			}
		})
	}
	
	// ?????? ???????????? ?????? ???????????? ??????
	$('#scheduleBatchAddBtn').on('click', function(){
		$('div.addBatch').on('shown.bs.modal', function (event) {
			batchCalendar.render();
		});
		$('div.addBatch').modal('show');
	})
	
	
	// ?????? ???????????? ?????? ???????????? ?????? 
	let addOneModal = function(arg){
		
		addOne_deleteBtn[0].style.display = "none";
		modalForm[0].action = '${cPath}/hr/workSchedule/insert';
		modalSubmitBtn[0].innerText = '??????';
		
		let startStr = null;
		if(arg.view.type == "resourceTimelineDay"){
			startStr = arg.startStr.substr(0, arg.startStr.indexOf('T'));
		}else{
			startStr = arg.startStr;
		}
		let spanHeaderText = '???????????? ????????????: ' + startStr;			
		sdateInput.val(startStr);
		edateInput.val(startStr);
		$('.addOne_spanHeader').text(spanHeaderText);
		
		//?????? ?????? ?????????
		if(arg.resource != undefined){
			let emp_id = arg.resource.id;			
			addOne_empOptions.each(function(index, option){
				if(emp_id == option.value){
					option.selected = true;
					return false;
				}
			})
		}
		
		
		addOneModal_inputs[0].value = '09';
		addOneModal_inputs[1].value = '00';
		addOneModal_inputs[2].value = '18';
		addOneModal_inputs[3].value = '00';
		addOne_memoTextArea[0].value = '';
		
		//??????????????? ?????????
		addOneModal_spans.each(function(index, span){
			span.innerText = '';
		})
		
		$('div.addOne').modal();
	}
	
	
	let clicked_scId = null;
	// ?????? ???????????? ?????? ???????????? ??????
	let updateOneModal = function(arg){
		addOne_deleteBtn[0].style.display = "block";
		clicked_scId = arg.event.id;
		modalForm[0].action = '${cPath}/hr/workSchedule/update?scId=' + clicked_scId;
		modalSubmitBtn[0].innerText = '???????????? ??????';
		let source = arg.event.extendedProps.source;
		sdateInput.val(source.scSdate);
		edateInput.val(source.scSdate);
		let spanHeaderText = source.empName + '??? ???????????? ????????????: ' + source.scSdate;
		modal_spanHeader.text(spanHeaderText);

		addOne_empOptions.each(function(index, option){
			if(source.empId == option.value){
				option.selected = true;
				return false;
			}
		})
		
		//?????? ?????? ?????????
		addOneModal_inputs[0].value = source.scStime.split(":")[0];
		addOneModal_inputs[1].value = source.scStime.split(":")[1];
		addOneModal_inputs[2].value = source.scEtime.split(":")[0];
		addOneModal_inputs[3].value = source.scEtime.split(":")[1];
		addOne_memoTextArea[0].value = source.scMemo;
		
		//??????????????? ?????????
		addOneModal_spans.each(function(index, span){
			span.innerText = '';
		})
		
		$('div.addOne').modal();
		
	}
	
	
	$('#addOne_submitBtn').on('click', function(){
		addOneForm.submit();
	})
	
	let addOne_deleteBtn = $('#addOne_deleteBtn').on('click', function(){
		addOneForm[0].action = '${cPath}/hr/workSchedule/delete?scId='+clicked_scId;
		addOneForm.submit();
	})
	
	// DB??? ???????????? ????????????
	let addOneForm = $('#scheduleAddOneForm').ajaxForm({
		dataType: 'json',
		method: 'post',
		success: function(resp){
			if(resp.retValue == 'success'){
// 				monthScheduleAjax(calendar.getDate());
				if(resp.retMessage == 'insert'){
					let schedule =  JSON.parse(resp.schedule);
					let new_event = {
						classNames: ['workEvent'],
						title: schedule.empName + ', ' + schedule.scStime + ' - ' + schedule.scEtime,
						start: schedule.scSdate + 'T' + schedule.scStime,
						end: schedule.scEdate + 'T' + schedule.scEtime,
						id: schedule.scId,
						resourceId: schedule.empId,
						source: {
							'empId': schedule.empId,
							'empName': schedule.empName,
							'empNo': schedule.empNo,
							'scStime': schedule.scStime,
							'scEtime': schedule.scEtime,
							'scSdate': schedule.scSdate,
							'scEdate': schedule.scEdate,
							'scMemo': schedule.scMemo,
							'scSort': schedule.scSort,
							'resourceId': schedule.empId
						}
					}
					calendar.addEvent(new_event);
					Swal.fire({
  					  icon: 'success',
  					  title: '?????? ??????',
  					  showConfirmButton: false,
  					  timer: 1500
					})
				}else if(resp.retMessage == 'delete'){
					let event = calendar.getEventById(clicked_scId);
					event.remove();
					Swal.fire({
  					  icon: 'success',
  					  title: '?????? ??????',
  					  showConfirmButton: false,
  					  timer: 1500
					})
				}else{
					let event = calendar.getEventById(clicked_scId);
					event.remove();
					let schedule =  JSON.parse(resp.schedule);
					let new_event = {
						classNames: ['workEvent'],
						title: schedule.empName + ', ' + schedule.scStime + ' - ' + schedule.scEtime,
						start: schedule.scSdate + 'T' + schedule.scStime,
						end: schedule.scEdate + 'T' + schedule.scEtime,
						id: schedule.scId,
						resourceId: schedule.empId,
						source: {
							'empId': schedule.empId,
							'empName': schedule.empName,
							'empNo': schedule.empNo,
							'scStime': schedule.scStime,
							'scEtime': schedule.scEtime,
							'scSdate': schedule.scSdate,
							'scEdate': schedule.scEdate,
							'scMemo': schedule.scMemo,
							'scSort': schedule.scSort,
							'resourceId': schedule.empId
						}
					}
					calendar.addEvent(new_event);
					Swal.fire({
  					  icon: 'success',
  					  title: '?????? ??????',
  					  showConfirmButton: false,
  					  timer: 1500
					})
				}
				$('div.addOne').modal('hide');
// 				location.reload();
				return false;					
			}else if(resp.retValue == 'exist'){
				Swal.fire({
					  icon: 'error',
					  title: '?????? ??????????????? ???????????????.',
					  showConfirmButton: false,
					  timer: 1500
				})
			}
			if(resp.HAS_ERROR == "OK"){
				makeErrorMsg(resp, insert_inputs);	
			}
		}
	});
	
</script>



