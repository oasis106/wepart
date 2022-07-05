package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MyPagingVO<T> {

	public MyPagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	private int totalRecord;
	private int screenSize = 10;
	private int blockSize = 5;
	private int currentPage;
	
	private int totalPage;
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	
	private T detailCondition;
	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}
	
	private SimpleSearchVO simpleCondition; 
	public void setSimpleCondition(SimpleSearchVO simpleCondition) {
		this.simpleCondition = simpleCondition;
	}
	
	private List<T> dataList;
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (totalRecord + (screenSize-1)) / screenSize;

	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow - screenSize + 1;
		
		
		endPage = (currentPage + (blockSize-1))/blockSize * blockSize;
		startPage = endPage - blockSize +1;
	}
	
	private static final String PTRN = "<li class='page-item'><a class='page-link' href='#' data-page='%d'>%s</a></li>";
	private static final String PTRN_CURRENT = "<li class='page-item active'><a class='page-link' href='#' data-page='%d'>%s</a></li>";
	private static final String PTRN_DISABLED = "<li class='page-item disabled'><a class='page-link'>%s</a></li>";
	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		html.append("<nav aria-label='Page navigation example'><ul class='pagination'>");
		if(startPage > blockSize) {
			html.append(String.format(PTRN, (startPage-blockSize), "이전"));
		}else {
			html.append(String.format(PTRN_DISABLED, "이전"));
		}
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		for(int i=startPage; i<=endPage; i++) {
			if(i == currentPage) {
				html.append(String.format(PTRN_CURRENT, i, i));
			}else {
				html.append(String.format(PTRN, i, i));
			}
		}
		if(endPage < totalPage) {
			html.append(String.format(PTRN, (startPage+blockSize), "다음"));
		}else {
			html.append(String.format(PTRN_DISABLED, "다음"));
		}
		
		html.append("</ul></nav>");
			
		return html.toString();
	}
	
}
