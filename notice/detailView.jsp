<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<style>
	/* img{
		display: block;
		max-width: 100%;
	} */

	#noticeHeader{
		border-bottom: 1px solid #e0e0e0; 
		margin-bottom: 20px;
	}
	
	ul{
		list-style: none;
		padding: 0;
	}
	
	.btn{
		padding: 4px;
		font-size: 0.9em;
	}
	
	.heart{
		font-size: 1.5em;
	}
	
	.etcBox{
		display: flex;
		justify-content: space-between;
	}
	
	.etc_left{
		display: flex;
	}
	
	.like_area, .comment_area, .etc_right{
		display: flex;
		align-items: center;
	}
	
	.like_area{
		margin-right: 20px;
		cursor: pointer;
	}
	
	.etc_text{
		margin-left: 4px;
	}
	
	#noticeArea{
		padding: 30px;
		border: 1px solid black;
	}
	
	.recomment{
		padding-left: 46px;
	}
	
	.comment_nick_box{
		font-weight: 900;
		display: flex;
		align-items: center;
	}
	
	.comment_text_box{
		font-weight: normal;
	}
	
	.comment_info_box{
		font-size: 0.8em;
	}
	
	.writerSign{
		border: 2px solid red;
		border-radius: 30px;
		color: red;
 		padding: 2px; 
		font-size: 0.7em;
		margin-left: 4px;
	}
	
	.comment_item {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-top: 1px solid #e0e0e0;
		position: relative;
	}
	
	.comment_item.writeBox.updateForm {
		position: absolute;
		left: 0;
		top: 0;
		z-index: 999;
		width: 100%;
		background: white;
	}
	
	.comment_box{
		padding: 12px;
	}
	
	.comment_info_button{
		margin-right: 4px;
	}
	
	.comment_writeBox{
		padding: 8px 16px 16px 16px;
		border: 2px solid #e0e0e0;
		border-radius: 6px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.comment_inbox_name{
		font-weight: 900;
	}

	.comment_inbox{
		display: flex;
		flex-direction: column;
 		width: 90%; 
	}


	.comment_inbox_text{
		overflow: hidden;
		overflow-wrap: break-word;
		resize: none;
		border: none;
		outline: none;
   		width: 100%;   
	}
	
	.comment_btnDIV{
		font-size: 1.2em;
		display: flex;
	}
	
	.comment_item.writeBox{
		padding: 12px 0px 12px 46px;
	}
	
	.comment_writeBox{
		width: 100%;
	}
	
	#commentSection #comment_list .comment_cancelBtn{
		background: inherit;
		color: #888888;
		border: none;
	}
	
	#fileTable{
		width: 70%;
		margin-top: 50px;
		margin-bottom: 50px;
	}
	
	.addedFiles{
	border: 1px solid #e0e0e0;
	}
	
	.addedFilesTd{
		display: flex;
		justify-content: space-between;
		align-items: center;
		
		width: 100%;
		padding: 0px 0px 0px 20px;
/* 		margin-bottom: 20px; */
	}
	
	.addedFilesTd div{
		display: flex;
		align-items: center;
	}
	
	.material-symbols-outlined {
		margin-right: 12px;
		font-weight: normal;
	}
	
	.fileDownload{
		background: inherit;
		font-size: 2.0em;
	}
	

</style>
<article id="noticeArea">
	<section id="noticeHeader">
		<c:if test="${authMem.memRole != 'ROLE_USER' && authMem.empId == notice.empId}">
			<button id="updateNotice" class="btn btn-primary">수정</button>
			<button id="deleteNotice" class="btn btn-primary">삭제</button>
		</c:if>
		<h2>${notice.ntTitle }</h2>
		<div class="writerInfo">
	<!-- 		<img class="thumb"> -->
			<div class="profile_area">
				<div class="profile_info">${notice.empId }</div>
				<div class="article_info">${notice.ntCreate }</div>
			</div>
		</div>
	</section>
	
	<section id="noticeContent">
		<div class="content_area">
			${notice.ntContent }
		</div>
		<table id="fileTable">
			<c:if test="${not empty notice.attatchList}">
				<c:forEach items="${notice.attatchList }" var="attatch">
					<tr class="addedFiles">
						<td class="addedFilesTd">
							<div>
								<span class="material-symbols-outlined">folder</span>
								<span>${attatch.attFilename }</span>
							</div>
							<button type="button" id="${attatch.attNo }" data-file="${attatch.attSavename }"  class="fileDownload btn material-symbols-outlined">download</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div class="etcBox">
			<div class="etc_left">
				<div class="like_area">
					<span class="heart">
						<c:if test="${notice.likeYN == 'Y' }">
							❤
						</c:if>
						<c:if test="${notice.likeYN == 'N' }">
							🤍
						</c:if>
					</span>
					<span class="etc_text">좋아요 ${notice.ntLike }</span>
				</div>
				<div class="comment_area">
					<span class="material-symbols-outlined">comment</span>
					<span class="etc_text"> </span>
				</div>
			</div>
			<div class="etc_right">신고</div>
		</div>
	</section>
	
	<section id="commentSection">
		<ul id="comment_list"> 
<!-- 				댓글  영역 -->
		</ul>
		<div class="comment_writeBox">
			<div class="comment_inbox">
				<span class="comment_inbox_name">${authMem.memRole == 'ROLE_USER' ? authMem.memId : authMem.empId }</span>
				<textarea class="comment_inbox_text" rows="1" placeholder="댓글을 남겨보세요"></textarea>
			</div>
			<div class="comment_btnDIV">
				<button class="btn btn-primary comment_addBtn">등록</button>
			</div>
		</div>
	</section>
</article>



<script>
	$(function(){
		const commentSection = $('#commentSection');
		const comment_ul = $('#comment_list');
		const notice_number = '${notice.ntNo}';
		const notice_empId = '${notice.empId}';
		
		$('.fileDownload').on('click', function(){
			let file = this.dataset.file;
			let attNo = this.id;
			location.href = '${cPath}/12/fileDownload.do?file=' + file + '&attNo=' + attNo;
		})
		
		$('#deleteNotice').on('click', function(){
			location.href = '${cPath}/notice/delete/' + notice_number;
		})
		
		$('#updateNotice').on('click', function(){
			location.href = '${cPath}/notice/update/' + notice_number;
		})
		
		
		// 댓글 수정요청
		commentSection.on('click', '.comment_updateBtn', function(event){
			let textValue = $('.comment_inbox_text').val().trim();
			if(textValue == ''){
				return false;
			}
			let updateId = this.dataset.updateid;
			$.ajax({
				url: '${cPath}/notice/'+notice_number+'/'+updateId,
				dataType: 'text',
				method: 'post',
				data: {
					"ntContent": textValue
				},
				success: function(resp){
					if(resp == "success"){
						commentAjax();
					}
				}
			})
		})
		
		// 댓글수정버튼 클릭시 수정폼 불러오기
		commentSection.on('click', '.updateComment', function(event){
			
			$('.comment_cancelBtn').click();
			if(resetComment == false){
				resetComment = true;
				return false;
			}
			let targetLi = this.parentNode.parentNode.parentNode;
			let placeText = this.parentNode.previousSibling.previousSibling.innerText;
			let cparent = targetLi.dataset.cparent;
			let updateId = targetLi.id;
			let newLi = document.createElement('li');
			if(cparent == undefined){
				newLi.className = 'comment_item writeBox updateForm';				
			}else{
				newLi.className = 'comment_item writeBox updateForm recomment';	
			}
			
			let commentForm = `
				<div class="comment_writeBox">
					<div class="comment_inbox">
						<span class="comment_inbox_name">${authMem.memRole == 'ROLE_USER' ? authMem.memId : authMem.empId }</span>
						<textarea class="comment_inbox_text" rows="1" placeholder="댓글을 남겨보세요">`+ placeText +`</textarea>
					</div>
					<div class="comment_btnDIV">						
						<button class="btn btn-primary comment_cancelBtn">취소</button>
						<button class="btn btn-primary comment_updateBtn" data-updateid=`+ updateId +`>등록</button>
					</div>
				</div>
			`;
			newLi.innerHTML = commentForm;
			targetLi.appendChild(newLi);
			
			
		});
		
		
		commentSection.on('click', '.deleteComment', function(event){
			if(!confirm("선택한 댓글을 삭제할까요??")){
				return false;
			}
			let ntNo = this.parentNode.parentNode.parentNode.id;
			$.ajax({
				url: '${cPath}/notice/delete/notice_number',
				dataType: 'text',
				data:{
					"ntNo" : ntNo
				},
				method: 'post',
				success: function(resp){
					console.log(resp);
					if(resp == "success"){
						commentAjax();
					}
				}
			})
			
			
		});
		
		// 댓글 등록요청.
		commentSection.on('click', '.comment_addBtn', function(event){
			let textValue = this.parentNode.previousSibling.previousSibling.childNodes[3].value.trim();
			if(textValue == ''){
				return false;
			}
			let cparent = this.dataset.cparent;
			$.ajax({
				url: '${cPath}/notice/new/${notice.ntNo}',
				dataType: 'text',
				data: { 
						"ntParent": notice_number,
						"ntCparent": cparent,
						"ntTitle": '.',
						"ntContent": textValue
				},
				method: 'post',
				success: function(resp){
					console.log(resp);
					if(resp == "success"){
						commentAjax();
					}
				}
			})
		});
		
		// false: 현재 댓글창 유지하겠다는 의미.
		// true: 새 댓글창 열겠다는 의미.
		let resetComment = true;
		// 댓글 취소버튼 클릭시
		comment_ul.on('click', '.comment_cancelBtn', function(event){
			let commentLi = this.parentNode.parentNode.parentNode;
			let textValue = this.parentNode.previousSibling.previousSibling.childNodes[3].value;
			if(textValue == null || textValue  == ''){
				commentLi.remove();		
			}else{
				if(confirm("입력된 댓글내용을 삭제할까요??")){
					commentLi.remove();
				}else{
					resetComment = false;
				}
			}
		})
		
		//댓글쓰기 버튼 클릭시. 등록폼 띄워줌.
		comment_ul.on('click', '.addComment', function(event){
			$('.comment_cancelBtn').click();
			if(resetComment == false){
				resetComment = true;
				return false;
			}
			
			let newLi = document.createElement('li');
			newLi.className = 'comment_item writeBox';

			let cparentLi = this.parentNode.parentNode.parentNode;
			let cparentId = cparentLi.dataset.cparent;
			let cparent_data = '';
			if(cparentId != undefined){
				cparent_data = cparentId;
			}else{
				cparent_data = cparentLi.id;
			}
			
			let commentForm = `
					<div class="comment_writeBox">
						<div class="comment_inbox">
							<span class="comment_inbox_name">${authMem.memRole == 'ROLE_USER' ? authMem.memId : authMem.empId }</span>
							<textarea class="comment_inbox_text" rows="1" placeholder="댓글을 남겨보세요"></textarea>
						</div>
						<div class="comment_btnDIV">						
							<button class="btn btn-primary comment_cancelBtn">취소</button>
							<button class="btn btn-primary comment_addBtn" data-cparent="`+ cparent_data +`">등록</button>
						</div>
					</div>
			`;
			newLi.innerHTML = commentForm;
			
			// nextSibling이 존재하면, 그요소에 insertBefore해주고
			// null이면, ul에 appendChild 해주면됨.
			let targetLi = this.parentNode.parentNode.parentNode.nextSibling.nextSibling;
			if(targetLi){
				comment_ul[0].insertBefore(newLi, targetLi);
			}else{
				comment_ul[0].appendChild(newLi);
			}
		});
		
		//댓글 등록폼에 입력시 이벤트.
		commentSection.on('input', '.comment_inbox_text', function(){
			let textHeight = this.scrollHeight;
			$(this).css('height', textHeight);
		})

		
		//좋아요버튼 클릭시 이벤트.
		let likeText = $('.like_area .etc_text');
		let likeImg = $('.like_area .heart');
		let likeBtn = $('.like_area').on('click', function(){
			$.ajax({
				url: '${cPath}/notice/${notice.ntNo}/like',
				method: 'post',
				dataType: 'json',
				success: function(response){
					console.log(response);
					if(response.likeYN == "Y"){
						likeImg.html('❤');
					}else{
						likeImg.html('🤍');
					}

					let newLikeText = '좋아요 ' + response.ntLike;
					likeText.html(newLikeText);
	
				}
			})
		});
		
		
		
		
		let commentText = $('.comment_area .etc_text');
		
		// 댓글목록을 비동기요청으로 가져오는 함수
		let commentAjax = function(){
			$('.comment_inbox_text').val('');
			$.ajax({
				url: '${cPath}/notice/${notice.ntNo}/comments',
				method: 'get',
				dataType: 'json',
				success: function(response){

					let commentList = '';
					let comment_cnt = 0;
					response.forEach((comment) => {
						let writerSign = '';
						if(comment.empId == notice_empId){
							writerSign = `<span class="writerSign">작성자</span>`;
						}
						let deleteBtn = '';
// 						console.log(comment.empId);
// 						console.log('${authUser}');
						if(comment.empId == "${authMem.memRole == 'ROLE_USER' ? authMem.memId : authMem.empId}"){
							deleteBtn = `
								<button type="button" class="btn btn-primary comment_info_button updateComment">수정</button>
								<button type="button" class="btn btn-primary comment_info_button deleteComment">삭제</button>
							`;
						}
						// 원댓글
						let eachComment = `
							<li class="comment_item" id="`+ comment.ntNo +`">
								<div class="comment_box">
									<div class="comment_nick_box">`+ comment.empId + writerSign +`</div>
									<div class="comment_text_box">`+ comment.ntContent +`</div>
									<div class="comment_info_box">
										<span class="comment_info_date">`+ comment.ntCreate +`</span>
										<button type="button" class="btn btn-primary comment_info_button addComment">답글쓰기</button>`
										+ deleteBtn +
									`</div>
									<div class="comment_tool"></div>
								</div>
								
							</li>
						`;
						commentList += eachComment; // 댓글목록에 추가
						
						// 대댓글 가져오기
						comment.recommentList.forEach((recomment) => {
	// 						console.log(recomment);
							writerSign = '';
							if(recomment.empId == notice_empId){
								writerSign = `<span class="writerSign">작성자</span>`;
							}
							
							let deleteBtn = '';
							if(recomment.empId == '${authMem.memRole == 'ROLE_USER' ? authMem.memId : authMem.empId}'){
								deleteBtn = `
									<button type="button" class="btn btn-primary comment_info_button updateComment">수정</button>
									<button type="button" class="btn btn-primary comment_info_button deleteComment">삭제</button>
								`;
							}
							let eachRecomment = `
								<li class="comment_item recomment" id="`+ recomment.ntNo +`" data-cparent="`+ comment.ntNo +`">
									<div class="comment_box">
										<div class="comment_nick_box">`+ recomment.empId + writerSign +`</div>
										<div class="comment_text_box">`+ recomment.ntContent +`</div>
										<div class="comment_info_box">
											<span class="comment_info_date">`+ recomment.ntCreate +`</span>
											<button type="button" class="btn btn-primary comment_info_button addComment">답글쓰기</button>`
											+ deleteBtn +
										`</div>
										<div class="comment_tool"></div>
									</div>
								</li>
							`;
							commentList += eachRecomment; // 댓글목록에 추가(대댓글로 들어감.)
							comment_cnt++; // 댓글갯수 카운트
						})
	
						comment_cnt++; // 댓글갯수 카운트
					});
	
					let newCommentText = '댓글 ' + comment_cnt;
					commentText.html(newCommentText);
					comment_ul.html(commentList);
				}
			}) // ajax 끝
		} // commentAjax() 끝
		
		
		// 댓글목록을 비동기요청으로 가져오는 함수
		commentAjax();
		
	})
	
</script>











