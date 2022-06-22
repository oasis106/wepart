<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<link rel="stylesheet" href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="${cPath }/resources/js/ckeditor/ckeditor.js"></script>
<style>
	#ntForm{
/* 		width: 70%; */
		margin: auto;
	}
	#ntForm>table{
		width: 100%;
	}
	
	
	.hidden{
		display:none;
	}
	
	.addedFiles{
		background: white;
		border: 1px solid #e0e0e0;
	}
	
	.addedFilesTd{
		display: flex;
		align-items: center;
		justify-content: space-between;
	}
	
	.addedFilesTd div{
		display: flex;
		align-items: center;
	}


	.material-symbols-outlined {
		font-size: 1.5em;
		margin-left: 20px;
		margin-right: 20px;
	}
	
	.error{
		color: #03C75A;
	}

	tr#fileButton {
    position: relative;
    top: 10px;
}

</style>
<div class="profile">
	<div class="card-body">
		<h3 style="text-align: center; padding: 30px;"><strong>공지사항 작성</strong></h3>
		<div>
		
		<form:form modelAttribute="notice" id="ntForm" method="post" enctype="multipart/form-data"> 
			<table id="formTable">
				<tr>
					<td>
						<form:input path="ntTitle" class="form-control" placeholder="제목" />
						<form:errors path="ntTitle" class="error" element="span" />
					</td>
				</tr>
				<tr>
					<td>
						<form:textarea path="ntContent" required="true" class="form-control" />
						<form:errors path="ntContent" class="error" element="span" />
					</td>
				</tr>
			
				<tr id="fileButton">
					<td>
						<button id="fileAddBtn" type="button" class="btn btn-primary">파일 첨부</button>
						<input class="btn btn-primary" type="submit" value="게시물 등록하기">
					</td>
				</tr>

				<tr>
					<td>
						<input class="hidden boFiles" type="file" name="boFiles" data-no=1>
					</td>
				</tr>
				<tr>
					<td>
						<input class="hidden boFiles" type="file" name="boFiles" data-no=2>
					</td>
				</tr>
				<tr>
					<td>
						<input class="hidden boFiles" type="file" name="boFiles" data-no=3>
					</td>
				</tr>
				<tr>
					<td>
						<input class="hidden boFiles" type="file" name="boFiles" data-no=4>
					</td>
				</tr>
				<tr>
					<td>
						<input class="hidden boFiles" type="file" name="boFiles" data-no=5>
					</td>
				</tr>
				
			</table>
		</form:form>
		</div>
	</div>
</div>	



<script>

	CKEDITOR.replace('ntContent', {
		filebrowserImageUploadUrl: "${cPath}/board/image?type=image"
	});
	
	$('#formTable').on('change', '.boFiles', function(event){
		if(event.target.files[0].size>=10*1024*1024){
			alert("첨부파일 사이즈는 10MB 이내로 등록 가능합니다.");
			$(this).val('');
			return false;
		}
		let temp = event.target.value;
		let startIdx = temp.lastIndexOf('\\') + 1;
		let fileName = temp.substring(startIdx);
		let trTag = `<tr class="addedFiles">
						<td class="addedFilesTd">
							<div>
								<span class="material-symbols-outlined">folder</span>
								<span>`+ fileName +`</span>
							</div>
							<button type="button" data-no="` + $(event.target).data('no') + `" class="fileCancel btn material-symbols-outlined">delete</button>
						</td>
					</tr>
					`;
		formTable.append(trTag);
		
		// 파일 추가될 때 텍스트 추가
		if($(event.target).data('no') == 1){
			let newTitle = '<h3 style="text-align: center; padding: 10px;"><strong>업로드 파일 목록</strong></h3>'
			$("#fileButton").after(newTitle);
		}
	});
	
	// 첨부파일 취소
	let formTable = $('#formTable').on('click', '.fileCancel', function(event){
		let clicked = event.target.dataset.no;
		let files = $('.boFiles');
		files.each(function(index, file){
			if(clicked == file.dataset.no){
				$(file).remove();
				event.target.parentNode.parentNode.remove();
				let newInput = `<tr>
									<td>
										<input class="hidden boFiles" type="file" name="boFiles" data-no=`+clicked+`>
									</td>
								</tr>`
				formTable.append(newInput);
				return false;
			}
		})
	})
	

	// 파일첨부버튼 클릭
	$('#fileAddBtn').on('click', function(){
		let files = $('.boFiles');
		let fileMax = false;
		$(files).each(function(index, file){
			if(file.value == '' || file.value == null){
				fileMax = true;
				file.click();
				return false;
			}
		})
		if(fileMax == false){
			alert("첨부파일은 최대 5개까지 업로드 가능합니다.");
		}

	})
	

</script>