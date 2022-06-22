<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href='${cPath }/resources/fullcalendar_premium/main.css' rel='stylesheet' />
<script src='${cPath }/resources/fullcalendar_premium/main.js'></script>
<script src='${cPath }/resources/fullcalendar_premium/locales-all.js'></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" ></script>


<style>

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
/* 		display: flex; */
/* 		flex-direction: column; */
/* 		justify-content: center; */
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
	
	#scheduleBatchAddBtn{
		display: flex;
		align-items: center;
	}
	
	#scheduleBatchAddBtn .mdi{
		font-size: 1.3em;
		margin-right: 8px;
	}
	
	#scheduleAddBatchForm{
		font-size: 1.5rem;
		text-align: center;
		margin-top: 100px;
	}
	.form-group.row{
		font-size: 1.5rem;
		margin-top: 20px;
	} 
	
	.form-group.row label{
		font-size: 1.5rem;
	} 
	
	
	
</style>
<section id="scheduleMainContent">
	<div class="scheduleMainContent_header">
		<h2>근무일정</h2>
		<div class="header_buttons">
			<form method="post" id="excelForm" action="${cPath}/workSchedule/excel">
				<input type="hidden" name="inputMonth" id="excelMonth">
				<button class="btn btn-success btn-icon-text" id="excelDownload">
					Excel 파일
					<i class="ti-file btn-icon-append"></i>
				</button>
			</form>
			<button id="scheduleBatchAddBtn" class="btn btn-primary"><i class="mdi mdi-airplane"></i>휴가 생성 요청</button>
		</div>
	</div>
	
	<div id='calendar'></div>
</section>
<!-- 근무일정 일괄추가 모달영역 -->
<div class="modal addBatch"> 
	<div class="modal-dialog"> 
		<div class="modal-content">
		 	<div class="scheduleAddBatch_header">
		 		<span class="addBatch_spanHeader">휴가 생성 요청하기</span>
		 		<span class="closeBtn_modalBatch">x</span>
		 	</div>
		 	<div class="scheduleAddBatch_content">
			 	<div class="scheduleAddBatch_main">
			 		<form:form modelAttribute="schedule" id="scheduleAddBatchForm" method="post" action="${cPath}/hr/workSchedule/batch">
			 			<div class="form-group row">
						    <label  class="col-sm-2 col-form-label">휴가 분류</label>
						    <div class="col-sm-7">
						    	<select name="scSort" id="selectSort">
						    		<option value="amHoli">오전반차(4h, 0.5일)</option>
						    		<option value="pmHoli">오후반차(4h, 0.5일)</option>
						    		<option value="full">연차(8h, 1일)</option>						    		
						    	</select>
						      	<span class="error"></span>
						    </div>
						</div>
				 		<span class="remainHoli">남은연차 : <fmt:formatNumber value="${authForHoli.empHoli}" pattern="0.0"/></span>
						<div class="form-group row" >
		 					<button id="addBatch_submitBtn" class="btn btn-success" style="width: 80%; font-size: 1.3em;" disabled>휴가요청 등록</button>
			 			</div>
			 		</form:form>
			 	</div>
			 	<div id="batch_calendarAndCover">
				 	<div id='batch_calendar' class="batch_calendar"></div>
			 	</div>
		 	</div>
		</div>
	</div> 
</div>


<script src="${cPath }/resources/js/makeErrorMessage.js"></script>

<!--  메인화면 캘린더 스크립트 -->
<script>
  // 캘린더 설정
  let calendar = null;
  let batchCalendar = null;
  //일괄추가에 선택한 날짜.
  let clicked_dateList = []; 
  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    
	    // event 추가하는 로직.
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
						title: "${schedule.empName} - ${schedule.scSort == 'amHoli' ? '반차(오전)' : schedule.scSort == 'pmHoli' ? '반차(오후)' : '연차'}",
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
		
		// resources 추가하는 로직.
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
		
		
		// calendar 설정.
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
	      // 월,주,일 클릭했을때(view를 변경했을때) 작동함. eventContent가 작동한 후에 작동한다.
	      datesSet: function(info) {
	    	let resourceAPIS = info.view.calendar.getResources();
	    	resourceAPIS.forEach(resourceAPI => {
	    		resourceAPI.setExtendedProp('wh', 0);
	    		resourceAPI.extendedProps.wh = 0;
	    		resourceAPI.extendedProps.whText = 0 + "시간";
	    	})

	    	let all_events = info.view.calendar.getEvents();
	    	let selectedView_events = [];
	    	all_events.filter(
	    		function(event) {
	    			return event.extendedProps.source.scSort == '' || event.extendedProps.source.scSort == null; 
	    		}		
	    	).forEach(event => {
	    		if(info.start <= event.start && info.end >= event.end){
    			  // 근로시간 계산 하기.
	  	    	  let eachWorkHour = (event.end - event.start)/1000/60/60;
	  	    	  let sumWH = event.getResources()[0].extendedProps.wh + eachWorkHour;
	  	    	  event.getResources()[0].setExtendedProp('wh', sumWH);
	  	    	  event.getResources()[0].extendedProps.wh = sumWH;
	  	    	  event.getResources()[0].extendedProps.whText = sumWH + "시간";
	    		}
	    	})
	    	
	      },
	      initialDate: new Date(),
	      locale: 'ko',
	      navLinks: true, // can click day/week names to navigate views
	      selectable: false,
	      selectMirror: true,
	      slotMinTime: '07:00',
	      slotMaxTime: '20:00',
	      //직원목록 컬럼 추가
	      resourceAreaWidth: '15%',
	      resourceAreaColumns: [
	        {
	          group: true,
	          field: 'title',
	          headerContent: '직원명'
	        },
	        {
	          field: 'whText',
	          headerContent: '근무시간'
	        }
	      ],
	      
	      resources: employee_list,
	      editable: false,
	      eventResourceEditable: false,
	      dayMaxEvents: false, // allow "more" link when too many events
	      events: month_events 
	    }); // calendar 설정끝
	    calendar.render();
    	
    	// 이전달 클릭시
	    $('#calendar button.fc-prev-button').on('click', function(){
// 	    	monthScheduleAjax(calendar.getDate());
	    })
	    
	    // 다음달 클릭시
	    $('#calendar button.fc-next-button').on('click', function(){
// 	    	monthScheduleAjax(calendar.getDate());
	    })
// 메인화면 calendar 끝
	    
	    
// 일괄추가 calendar 시작
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
	    }); // 일괄추가 캘린더 설정 끝
    	
	    
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
	    
	    
    	// 이전달 클릭시
	    $('.addBatch').on('click', '#batch_calendar button.fc-prev-button', function(){
	    	$('td .fc-daygrid-day.fc-day').removeClass('crashed_td');
			$('td .fc-daygrid-day.fc-day').removeClass('userClicked');
			
			$('.crashed_emp').closest('.fc-daygrid-day.fc-day').addClass('crashed_td');
			clicked_dateList = [];
			batchSubmitBtn.attr('disabled', true);
	    })
	    
	    // 다음달 클릭시
	    $('.addBatch').on('click', '#batch_calendar button.fc-next-button', function(){
	    	$('td .fc-daygrid-day.fc-day').removeClass('crashed_td');
			$('td .fc-daygrid-day.fc-day').removeClass('userClicked');
			
			$('.crashed_emp').closest('.fc-daygrid-day.fc-day').addClass('crashed_td');
			clicked_dateList = [];
			batchSubmitBtn.attr('disabled', true);
	    })
    
  });
  
  // 월 변경할때마다 보낼 ajax요청.
  // 해당월과 앞,전 월의 이벤트 목록을 가져옴.
  let monthScheduleAjax = function(inputMonth){
	  $.ajax({
		url: '${cPath}/hr/workSchedule',
		data: {'inputMonth': inputMonth},
		dataType: 'json',
		method: 'get',
		success: function(resp){
			
			// 기존의 이벤트 모두 삭제(db말고, fullcalendar에서)
			let events = calendar.getEvents();
			events.forEach(eachEvent => {
				eachEvent.remove();
			})
			
			// 새로운 이벤트 등록(db말고, fullcalendar에)
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
	const addBatchForm = $('#scheduleAddBatchForm');

	const addBatch_inputs = $('#scheduleAddBatchForm input[name]');
	const addBatch_selectAndInputs = $('#scheduleAddBatchForm :input[name]');
	const addBatch_select = $('#scheduleAddBatchForm select');
	const addBatch_options = $('#scheduleAddBatchForm select option');
	const batch_cover = $('#batch_cover');
	let selectSort = $('#selectSort');
	
	let batchSubmitBtn = $('#addBatch_submitBtn');
	
	$('#excelDownload').on('click', function(){
		$('#excelMonth').val(calendar.getDate());
		$('#excelForm').submit();
	})
	
// 	휴가 일괄추가 등록
	batchSubmitBtn.on('click', function(event){
		if(selectSort.val() != 'full'){
			if(clicked_dateList.length/2 > '${authForHoli.empHoli}'){
				Swal.fire({
  				   icon: 'error',
  				   title: '사용 가능한 연차개수가 부족합니다.',
  				   showConfirmButton: false,
  				   timer: 1500
  				})
				return false;
			}
		}else{
			if(clicked_dateList.length > '${authForHoli.empHoli}'){
				Swal.fire({
  				   icon: 'error',
  				   title: '사용 가능한 연차개수가 부족합니다.',
  				   showConfirmButton: false,
  				   timer: 1500
  				})
				return false;
			}			
		}
		event.preventDefault();
		let formSerializeArray = $('#scheduleAddBatchForm').serializeArray();
		formSerializeArray.push({name: 'clickedDateList', value: clicked_dateList});
		$.ajax({
			url: '${cPath}/emp/holi/batchInsert',
			method: 'post',
			dataType: 'text',
			data: formSerializeArray,
			success: function(resp){
// 				console.log(resp);
				if(resp == 'success'){
					Swal.fire({
					  icon: 'success',
					  title: '등록 완료',
					  showConfirmButton: false,
					  timer: 1500
					})
					location.reload();
				}else if(resp == 'fail'){
					Swal.fire({
     				   icon: 'error',
     				   title: '서버오류: 저장 실패',
     				   text: '잠시 후에 다시 시도해주세요.',
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

	
	
	// 모달 닫기버튼 
	let closeBtn_modalBatch = $('.closeBtn_modalBatch').on('click', function(){
		$('div.addBatch').modal('hide');
	})
	
	
	// 휴가일정 추가 모달여는 함수
	$('#scheduleBatchAddBtn').on('click', function(){
		$('div.addBatch').on('shown.bs.modal', function () {
			batchCalendar.render();
			let events = batchCalendar.getEvents();
			events.forEach(eachEvent => {
				eachEvent.remove();
			})
			
			let event = null;
			let myHolidays = ${myHolidays};
			myHolidays.forEach(schedule => {
				let titleName = schedule.scSort == 'full' ? '연차' : (schedule.scSort == 'amHoli' ? '반차(오전)' : '반차(오후)') 
				event = {
					title: titleName,
					start: schedule.scSdate,
					id: schedule.scId,
					className: 'crashed_emp',
					backgroundColor: 'rgba( 0, 0, 0, 0)' 
				}
				batchCalendar.addEvent(event);
			})
			
			$('td .fc-daygrid-day.fc-day').removeClass('crashed_td');
			$('td .fc-daygrid-day.fc-day').removeClass('userClicked');
			
			$('.crashed_emp').closest('.fc-daygrid-day.fc-day').addClass('crashed_td');
			clicked_dateList = [];
		});
		$('div.addBatch').modal('show');
	})
	
	
	
</script>



