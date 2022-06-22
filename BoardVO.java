package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO<T> {
	
	private T realBoard;
	private String boNo;
	public BoardVO(T realBoard) {
		super();
		this.realBoard = realBoard;
	}
	
	
}
