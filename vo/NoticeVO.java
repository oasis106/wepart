package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;

import org.apache.ibatis.annotations.Delete;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="ntNo")
public class NoticeVO {
	
	private int rnum;
	
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	private String ntNo;
	@NotBlank(groups= {InsertGroup.class, UpdateGroup.class}, message="제목은 필수입력값입니다.")
	private String ntTitle;
	@NotBlank(groups= {InsertGroup.class, UpdateGroup.class}, message="내용은 필수입력값입니다.")
	private String ntContent;
	private String ntCreate;
	private Integer ntHit;
	private Integer ntLike;
	private String ntParent;
	private String empId;
	private String ntCparent;
	private String ntUpdate;
	
	private MemberVO memberVO;
	private EmployeeVO empVO;
	private List<NoticeVO> recommentList; // 한 댓글의 대댓글 리스트를 담을 List
	
	private int startAttNo;
	private List<AttatchVO> attatchList;
	
	private int[] delAttNos;
	
	private MultipartFile[] boFiles;
	
	public void setBoFiles(MultipartFile[] boFiles) {
		if(boFiles==null || boFiles.length==0) return;
		this.boFiles = boFiles;
		this.attatchList = new ArrayList<>();
		if(boFiles[0].isEmpty()) return;
		for(MultipartFile boFile : boFiles) {
			if(boFile.isEmpty()) continue;
			attatchList.add(new AttatchVO(boFile));
		}
	}
	
	//로그인한 회원의 좋아요 여부
	public String likeYN;
	
	// 검색조건
	private String searchDate;
	private String searchType;
	private String searchWord;
	
	
}
