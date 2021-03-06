<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
	.site-section{
		padding: 50px 0;
	}
	
	#billSection.card{
		padding: 20px;
		width: 90%;
		border: 10px solid;
	}
	
	.container.content{
	    margin: 0;
	    padding: 0;
	    max-width: 100%;
	    width: 100%;
	    height: 100vh;
	}

	

	tbody tr td:nth-child(2), tbody tr td:nth-child(3){
		text-align: right;
	}
	
	.costInfo_wrap{
		display: flex;
		flex-direction: row;
		width: 100%;
		font-size: 1.5em;
	}
	
	.costdataBox{
		background-color: #EDEDED;
		display: flex;
		padding: 15px;
		width: 35%;
		border-radius: 12px 0 0 12px;
	}
	
	.costpayBox{
		border: 6px solid #EDEDED;
		width: 65%;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		border-radius: 0 12px 12px 0;
	}
	
	.costpayBox div{
		height: 45%;
		display: flex;
		justify-content: space-between;
		padding: 0 12px;
	}
	
	.costpayBox div:nth-child(1){
		align-items: flex-end;
	}
	
	.costpayBox div .costPay{
		margin-right: 20px;
	}
	
	.dayBox{
		background-color: #0276f8;
		color: white;
		border-radius: 6px;
		width: 5vw;
		height: 5vw;
		text-align: center;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
	
	.dayBox p{
		margin-bottom: 0;
	}
	
	.endBox {
		display: flex;
		flex-direction: column;
		align-items: center;
 		justify-content: center; 
 		width: 75%; 
	}
	
	.endBox .deadline{
		color: #0276f8;
	}
	
	thead {
		text-align: center;
	}
	
	#mainTbody tr td{
		width: 25%;
	}
	
	.sumUp{
		width: 0px;
		height: 0px;
		border-top:20px solid none;
		border-bottom:20px solid red;
		border-right: 13px solid transparent;
		border-left: 13px solid  transparent;
		margin-right: 12px;
	}
	
	.sumDown{
		width: 0px;
		height: 0px;
		border-top:20px solid skyblue;
		border-bottom:20px solid none;
		border-right: 13px solid transparent;
		border-left: 13px solid  transparent;
		margin-right: 12px;
	}
	
	.sumDIV{
		display: flex;	
		align-items: center;
 		justify-content: center; 
		text-align: center;
	}
	
	#billSection .mb-3 {
		width: 25%;
		height: 50px;
		margin: auto;
		font-size: 1.2em;
		
	}
	.custom-select{
		height: 100%;
		border-radius: 50px;
		text-align: center;
	}
	
	.custom-select:focus{
/* 		border-color: #ced4da; */
	}
	
	.fname{
		cursor: pointer;
	}
	
	.modal{
/* 		width: 100vw; */
	}
	
	.modal-dialog{
		max-width: 85%;
		width: 85%;
	}
	
	.detailHeader{
		background-color: #404040;
		color: white;
		font-family: Roboto,RobotoDraft,Helvetica,Arial,sans-serif;
	    font-size: .875rem;
	    letter-spacing: .2px;
	    font-weight: 500;
	}
	
	
	.detailHeaderWrapped{
		padding: 0 10px 0 20px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: 40px;
	}
	
	.detailHeaderWrapped .modalCloseBtn{
		background-color: transparent;
		outline: none;
		border: none;
		color: white;
	}
	
	.detailMain{
		display: flex;
		flex-direction: column;
	}
	

	
	.detailMain .detail_table{
		width: 70%;
		margin: auto;
	}
	
	#detail_tbody tr td:nth-child(1){
		text-align: center;
	}
	
	.modalCloseBtn{
		cursor: pointer;
	}
	
	.excelDIV{
		display: flex;
		justify-content: flex-end;
	}
	
	#billSection > .billContainer{
		padding: 0;
	}
	
	.card-header{
		font-weight: 600;
	}
	
	.btn{
		height: 60px;
	    font-weight: 600;
    	font-size: 1.5rem;
    	border-radius: 20px;
    	margin-right: 12px;
	}
	
	
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script type="text/javascript"
   src="https://service.iamport.kr/js/iamport.payment-1.1.8.js"></script>
	
	
<section id="billSection" class="card">
	<div class="input-group mb-3">
		<select name="month" class="custom-select" id="selectMonth">
			<c:if test="${not empty billList }">
				<c:forEach items="${billList }" var="eachBill">
					<option value="${fn:substring(eachBill.billNo,1,7)}">
						${fn:substring(eachBill.billNo,1,5)}??? ${fn:substring(eachBill.billNo,5,7)}???
					</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
	
	<div class="costInfo_wrap">
		<div class="costdataBox">
			<div class="dayBox">
	<!-- 		strong ?????? D-?????? -->
				<strong></strong>
	<!-- 			p?????? ?????? ????????? / ????????? -->
				<p></p>
			</div>
			<div class="endBox">
				<span>???????????????</span>
				<span class="deadline"></span>
			</div>
		</div>
		<div class="costpayBox">
			<div>
	<!-- 			????????? ???????????? -->
				<span class="text"></span>
				<span class="costPay"></span>
			</div>
			<div>
				<span class="text">???????????? ??????</span>
				<span class="costPay"></span>
			</div>
		</div>
	</div>
	
	
<!-- 	?????? ?????????????????? -->
	<div class="billContainer"> 
		<div class="row my-3"> 
			<div class="col"> 
				<div class="excelDIV">
					<button class="btn btn-primary" id="billPayBtn" >????????????</button>
					<button class="btn btn-primary" id="downloadExcel" data-month="" data-href="">????????? ??????</button>
				</div>
			</div> 
		</div> 
		<div class="row my-2">
			<div class="col"> 
				<div class="card"> 
					<div class="card-header">
						?????? 1?????? ????????? ??????
					</div>
					<div class="card-body">
						<canvas id="myChart" height="100"></canvas> 
					</div> 
				</div> 
			</div> 
		</div> 
	</div>


	
	
	<div class="card">
		<div class="card-header">????????? ????????? ????????????</div>
		<div class="card-body">
			<table class="table table-bordered">
				<thead class="table thead-light">
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
				</thead>
				<tbody id="mainTbody">
					
				</tbody>
			</table>
		</div>
	</div>
	
	
<!-- 	????????? ?????? -->
	<div class="modal"> 
		<div class="modal-dialog"> 
			<div class="modal-content">
			 	<div class="detailHeader">
			 		<div class="detailHeaderWrapped">		 		
				 		<span class="detailHeader_title">?????????</span>
				 		<button class="modalCloseBtn">x</button>
			 		</div>
			 	</div>
			 	<div class="detailMain">
			 		<div class="container"> 
						<div class="row my-3"> 
							<div class="col"> 
								<h4 class="detailMain_title">????????? ?????? ??????</h4> 
							</div> 
						</div> 
						<div class="row my-2">
							<div class="col"> 
								<div class="card"> 
									<div class="card-body">
										<canvas id="detailChart" height="100"></canvas> 
									</div> 
								</div> 
							</div> 
						</div> 
					</div>
			 		<div class="detail_table">
				 		<table class="table table-bordered">
				 			<thead class="table thead-dark">
				 				<th>???</th>
				 				<th>?????????</th>
				 				<th>???????????? ??????</th>
				 			</thead>
				 			<tbody id="detail_tbody">
				 				
				 			</tbody>
				 		</table>
				 	</div>
			 	</div>
			</div>
		</div> 
	</div>
	


</section>


<script>
	$(function(){
		
		const tbody = $('#mainTbody');
		const selectMonth = $('#selectMonth');
		const deadlineSpan = $('.deadline');
		const costpayBox = $('.costpayBox');
		const costpay = costpayBox.find('.costPay');
		const costMonthText = costpayBox.find('.text')[0];
		const costPaySumText = costpayBox.find('.text')[1];
		const monthOptions = $('#selectMonth').find('option');
		const dayBox = $('.dayBox');
		const dayBoxPtag = dayBox.find('p');
		const modalHeader_title = $('.detailHeader_title');
		const modalMain_title = $('.detailMain_title');
		const today = new Date(); 
		const year_ = today.getFullYear(); // ??????
		let month_ = today.getMonth() + 1;  // ???
		let date_ = today.getDate();  // ??????
		
		if(month_ < 10)	month_ = '0' + month_;
		if(date_ < 10)	date_ = '0' + date_;		
		const todaySTR = year_ + '-' + month_ + '-' + date_;
		const modal_tbody = $('#detail_tbody');
	
		
		
		let excelBtn = $('#downloadExcel').on('click', function(){
			location.href = this.dataset.href;
		})

		
	
		
		
	    let context = document.getElementById('myChart');
	    let detail_context = document.getElementById('detailChart');

		// ?????? ?????? ?????????
	    let labels = [];
	    let myBill = [];
	    <c:if test="${not empty oneYearBillList }">
			<c:forEach items="${oneYearBillList }" var="eachBill">
				labels.push('${fn:substring(eachBill.billNo,1,5)}??? ${fn:substring(eachBill.billNo,5,7)}???');
				myBill.push('${eachBill.billSum}');			
			</c:forEach>
		</c:if>
		let avgBill = [];
		<c:if test="${not empty avgList}">
			<c:forEach items="${avgList}" var="monthAVG">
				avgBill.push('${monthAVG.billSum}');
			</c:forEach>
		</c:if>

	    
	    let myChart = new Chart(context, {
	        type: 'bar', // ????????? ??????
	        data: { // ????????? ????????? ?????????
	            labels : labels,
	            datasets: [
	            	{ //?????????
	                    label: '?????????', //?????? ??????
	                    fill: false, // line ????????? ???, ??? ????????? ???????????? ???????????????
	                    data: myBill,
	                    backgroundColor: 'rgb(255, 99, 132, 0.5)',
	                    borderColor: 'rgb(255, 99, 132)',
	                    tension: 0
	            	},
	            	{
	            		type: 'line',
	            		label: '???????????? ??????',
	            		fill: false,
	            		data: avgBill,
	            		backgroundColor: 'rgb(40, 152, 196)',
	            		borderColor: 'rgb(40, 152, 196)',
	            		tension: 0
	            	}
	            	]
	        },
	        options: {
	        	//????????? ?????? ????????????
	        	scales:{
	        		yAxes:[{
	        			ticks: {
	        				userCallback: function(value, index, values){
	        					value = value.toString();
	        					value = value.split(/(?=(?:...)*$)/);
	        					value = value.join(',');
	        					
	        					return value;
	        				}
	        			}
	        		}]
	        	}
	        }
	    }); // ?????? ?????? ????????? ???
		
	    $('.modalCloseBtn').on('click', function(){
	    	$('div.modal').modal('hide')
	    })
	    
	    
	    let detailChart = new Chart(detail_context, {}); // ????????? ???????????????
	    
		// ????????? ?????????
		tbody.on('click', '.fname', function(){
			let clicked_fcode = this.dataset.fcode;
			let clicked_fname = this.innerText;

			// ??? ????????? ?????? ???????????? ajax
			$.ajax({
				url: '${cPath}/bill/detail',
				data: {
					"fcode": clicked_fcode,
					"month": selectMonth.val()
				},
				dataType: 'json',
				method: 'get',
				success: function(myDetail){
					
					// ??????????????? ?????? ???????????? ????????? ajax
					$.ajax({
						url: '${cPath}/bill/detailAVG',
						data: {
							"fcode": clicked_fcode,
							"month": selectMonth.val()
						},
						dataType: 'json',
						method: 'get',
						success: function(detailAVG){
							let trs = [];
							
							let data_avg = [];
							let detail_labels = [];
							detailAVG.forEach((eachDetail, index) => {
								data_avg.push(eachDetail.btailSum);
								detail_labels.push(eachDetail.billMonth.substring(0,4)+'??? '+eachDetail.billMonth.substring(4,6)+'???');
								let tr = `<tr>
											<td>`+detail_labels[index]+`</td>
											<td>`+(myDetail[index] ? myDetail[index].toLocaleString() : 0)+`</td>
											<td>`+(eachDetail.btailSum ? eachDetail.btailSum.toLocaleString() : 0)+`</td>
										</tr>`;
								trs.push(tr);
							});
							modalHeader_title.html(clicked_fname);
							modalMain_title.html(clicked_fname);
							modal_tbody.html(trs);
							
							// ????????? ???????????????
							let plugins = {
							        type: 'bar', // ????????? ??????
							        data: { // ????????? ????????? ?????????
							            labels : detail_labels,
							            datasets: [
							            	{ //?????????
							                    label: '?????????', //?????? ??????
							                    fill: false, // line ????????? ???, ??? ????????? ???????????? ???????????????
							                    data: myDetail,
							                    backgroundColor: 'rgb(255, 99, 132, 0.5)',
							                    borderColor: 'rgb(255, 99, 132)',
							                    tension: 0
							            	},
							            	{
							            		type: 'line',
							            		label: '???????????? ??????', //?????? ??????
							                    fill: false, // line ????????? ???, ??? ????????? ???????????? ???????????????
							                    data: data_avg,
							                    backgroundColor: 'rgb(40, 152, 196)',
							            		borderColor: 'rgb(40, 152, 196)',
							                    tension: 0
							            	}	
							            ]
							        },
							        options: {
							        	scales:{
							        		yAxes:[{
							        			ticks: {
							        				userCallback: function(value, index, values){
							        					value = value.toString();
							        					value = value.split(/(?=(?:...)*$)/);
							        					value = value.join(',');
							        					return value;
							        				}
							        			}
							        		}]
							        	}
							        }
							    };
							// ???????????? ????????? ?????? ??????????????? ????????? ?????????.
							detailChart.destroy();
							detailChart = new Chart(detail_context, plugins);
							
						    $('div.modal').modal();		
						} // ???????????? ???????????? ????????? success ???
					})
				}
			})
				
		}) // ????????? ???
		
		
		// bill ajax ?????? ??????
		let billAjax = function(month, preMonth){
			
			$.ajax({
				url: '${cPath}/bill/month',
				data: {
					'month' : month
				},
				dataType: 'json',
				method: 'get',
				success: function(curBill){
					
					$.ajax({
						url: '${cPath}/bill/month',
						data: {
							'month' : preMonth
						},
						dataType: 'json',
						method: 'get',
						success: function(preBill){
							excelBtn[0].dataset.month = month;
							excelBtn[0].dataset.href = '${cPath}/mbillExcelDownload?month='+month;

							let temp = month.substr(4);
							let realMonth = temp[0] == '0' ? temp.substr(1) : temp;
							let dline = curBill.billDline;
							let tmp_oversum = curBill.billOversum ? curBill.billOversum.toLocaleString() : 0;
							let tmp_paysum = curBill.billPaysum ? curBill.billPaysum.toLocaleString() : 0;
							let tmp_billsum = curBill.billSum ? curBill.billSum.toLocaleString() : 0;
							if(todaySTR >= dline){
								// ???????????? ???????????????.
								if(curBill.billPaydate == null){
									// ????????? ????????????, ????????? ????????? ???????????????.
									dayBoxPtag.html('?????????');				
									costPaySumText.innerHTML = "???????????? ??????"
									costpay[1].innerHTML = tmp_oversum + '???';
									billPayBtn[0].style.display = 'inline-block';
									billPayBtn.data('fee', tmp_oversum);
									billPayBtn.data('billno', curBill.billNo);
								}else{
									// ????????? ?????????, ??????????????? ????????????.
									dayBoxPtag.html('??????');	
									costPaySumText.innerHTML = "(????????????)";
									billPayBtn[0].style.display = 'none';
									if(dline > curBill.billPaydate){
										costpay[1].innerHTML = tmp_paysum + '???';										
									}else {										
										costpay[1].innerHTML = tmp_oversum + '???';										
									}
								}			
							}else{
								//???????????? ???????????????. D-?????? ???????????? ?????? ???????????????.
								if(curBill.billPaydate == null){
									// ????????? ????????????, ????????? ????????? ???????????????.
									dayBoxPtag.html('?????????');			
									costPaySumText.innerHTML = "???????????? ??????"
									costpay[1].innerHTML = tmp_billsum + '???';
									billPayBtn[0].style.display = 'inline-block';
									billPayBtn.data('fee', tmp_billsum);
									billPayBtn.data('billno', curBill.billNo);
								}else{
									// ????????? ?????????, ??????????????? ????????????.
									dayBoxPtag.html('??????');		
									costPaySumText.innerHTML = "(????????????)"
									costpay[1].innerHTML = tmp_paysum + '???';
									billPayBtn[0].style.display = 'none';
								}
							}
							dline = dline.substring(0,4) + '??? ' + dline.substring(5,7) + '??? ' + dline.substring(8,10) + '???';

							deadlineSpan.html(dline);
							costMonthText.innerHTML = realMonth + '?????? ?????? ??????';
							costpay[0].innerHTML = tmp_billsum + '???';
							let trs = [];
							let detailList = curBill.btailList;
							let preDetailList = preBill.btailList;
							if(preBill.billNo == null){
								detailList.forEach((detail, index)=>{
									let tr = "<tr>";
									tr += "<td class='fname' data-fcode="+ detail.fcode +">" + detail.fname + "</td>";
									tr += "<td>" + (detail.btailSum ? detail.btailSum.toLocaleString() : 0) + "</td>";
									tr += "<td>-</td>";
									tr += "<td>-</td>";
									tr += "</tr>";
									trs.push(tr);
								});
							}else{
								detailList.forEach((detail, index)=>{
									console.log(detail);
									let tr = "<tr>";
									tr += "<td class='fname' data-fcode="+ detail.fcode +">" + detail.fname + "</td>";
									tr += "<td>" + (detail.btailSum ? detail.btailSum.toLocaleString() : 0) + "</td>";
									let compareSum = detail.btailSum;
									if(preDetailList[index] == undefined){
										tr += "<td>-</td>";
									}else{
										tr += "<td>" + (preDetailList[index].btailSum ? preDetailList[index].btailSum.toLocaleString() : 0) + "</td>";										
										compareSum = detail.btailSum - preDetailList[index].btailSum;
									}
									if(compareSum > 0){
										tr += "<td><div class='sumDIV'><div class='sumUp'></div>" + compareSum.toLocaleString() + "</div></td>";										
									}else if(compareSum < 0){
										tr += "<td><div class='sumDIV'><div class='sumDown'></div>" + compareSum.toLocaleString() + "</div></td>";																				
									}else{
										tr += "<td><div class='sumDIV'>0</div></td>";
									}
									tr += "</tr>";
									trs.push(tr);
								});
							}
							tbody.html(trs);
						} // ????????? bill success ???
					}) // ????????? bill ajax ???
					
				} // ????????? bill success ???
			}) // ????????? bill ajax ???
			
		} // bill ajax ???????????? ???
		
		
		// ??????????????? ????????? ????????? ????????? ?????? ?????? ????????? ????????? ???????????? ?????? ??????
		let month = monthOptions[monthOptions.length-1].value;
		let preMonth = '';
		monthOptions.each(function(index, option){
			if(month == option.value){
				if(index == 0){
					return false;
				}
				preMonth = monthOptions[index-1].value;
				return false;
			}
		})
		
		billAjax(month, preMonth);
		selectMonth.val(monthOptions[monthOptions.length-1].value);
		
		// ??? ????????? ?????????.
		selectMonth.on('change', function(){
			let month = this.value;
			let preMonth = '';

			monthOptions.each(function(index, option){
				if(month == option.value){
					if(index == 0){
						return false;
					}
					preMonth = monthOptions[index-1].value;
					return false;
				}
			})
			// ?????? ????????? ????????? ??? index??? ????????? ????????? ?????????.
			billAjax(month, preMonth);
		}) 
		// select "change"????????? ???
		
		// ?????? ??????
		let billPayBtn = $('#billPayBtn').on('click', function(){
			let payBillNo = $(this).data('billno');
			let fee = $(this).data('fee');
			let bill_title = selectMonth.val().substr(0,4)+'??? '+selectMonth.val().substr(4,2)+'??? ?????????';
			fee = fee.replace(/[^\d]+/g, "");
			var IMP = window.IMP;
			IMP.init("imp91672119"); // ???: imp00000000
			// IMP.request_pay(param, callback) ????????? ??????
		    IMP.request_pay({ // param
		        pg: "html5_inicis",
		        pay_method: "card",
		        name: bill_title,
		        amount: 100,
		        buyer_name: '?????????',
		        buyer_email: 'doerdrea@gmail.com'
		    }, function (rsp) { // callback
			    	let msg = '';
			    	if (rsp.success) {
					   //console.log(msg);	
		               // ??????????????? ???????????? ???????????? DB??? ???????????? ??????
		               // ??????????????? ??????????????? ???????????? ?????? ?????????.
		               console.log("????????????!!!");
		    		console.log(rsp.pay_method);
		               $.ajax({
		            	   url: '${cPath}/bill/pay',
		            	   type: 'post',
		            	   data: {
		            		   'billNo': payBillNo,
		            		   'billPaysum': fee
		            	   },
		            	   dataType: 'text',
		            	   success: function(resp){
		            		   if(resp == 'success'){
		            			    let month = selectMonth.val();
		            				let preMonth = '';
		            				monthOptions.each(function(index, option){
		            					if(month == option.value){
		            						if(index == 0){
		            							return false;
		            						}
		            						preMonth = monthOptions[index-1].value;
		            						return false;
		            					}
		            				})
		            			   billAjax(month, preMonth);
		            				Swal.fire({
		            					  icon: 'success',
		            					  title: '?????? ??????',
		            					  showConfirmButton: false,
		            					  timer: 1500
	            					})
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
		            		   console.log(error);
		            	   }
		               }) // ajax???
		            } else {
		            	Swal.fire({
         				   icon: 'error',
         				   title: rsp.error_msg,
         				   showConfirmButton: false,
         				   timer: 1500
         				})
		            }
			    	
		    });
		  
		})
		// ?????? ???
		
	})
</script>