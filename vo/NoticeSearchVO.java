package kr.or.ddit.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeSearchVO {
	private String searchDate;
	private String searchType;
	private String searchWord;
}
