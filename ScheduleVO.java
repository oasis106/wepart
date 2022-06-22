package kr.or.ddit.vo;

import java.util.List;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Data
@EqualsAndHashCode(of="scId")
public class ScheduleVO {
	
	private String scId;
	private String scSort;
	@NotBlank(groups= {InsertGroup.class,UpdateGroup.class})
	private String scSdate;
	@NotBlank(groups= {InsertGroup.class,UpdateGroup.class})
	private String scEdate;
	private String scMemo;
	@NotBlank
	private String empId;
	
	@NotNull(groups= {InsertGroup.class,UpdateGroup.class})
	@Min(value=0)
	@Max(value=23)
	private Integer scShour;
	@NotNull(groups= {InsertGroup.class,UpdateGroup.class})
	@Min(value=0)
	@Max(value=59)
	private Integer scSminute;
	
	@NotNull(groups= {InsertGroup.class,UpdateGroup.class})
	@Min(value=0)
	@Max(value=23)
	private Integer scEhour;
	@NotNull(groups= {InsertGroup.class,UpdateGroup.class})
	@Min(value=0)
	@Max(value=59)
	private Integer scEminute;
	
	
	private String empNo;
	private String empName;
	private String scStime;
	private String scEtime;
	private String empDep;
	private String scReqdate;
	private String scState;
	private String holiId;
	
	
	
	public void setDate() {
		scSdate = scSdate + " " + scShour + ":" + scSminute + ":00";
		scEdate = scEdate + " " + scEhour + ":" + scEminute + ":00";
	}
	
	public void setDate(String eachDate, Integer scShour, Integer scSminute
			, Integer scEhour, Integer scEminute) {
		scSdate = eachDate + " " + scShour + ":" + scSminute + ":00";
		scEdate = eachDate + " " + scEhour + ":" + scEminute + ":00";
	}
	
}
