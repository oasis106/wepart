package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of= {"holiId, scSdate"})
public class HoliVO {

	private String holiId;
	private String scSort;
	private String scSdate;
	private String scEdate;
	private String empId;
	private String scMemo;
	private String scReqdate;
	private String scState;
	
	private List<HoliVO> reqList;
	private String empNo;
	private String empName;
	private float scheduleLength;
	private String startScId; 
	
}
