package kr.or.ddit.vo;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import kr.or.ddit.validate.InsertGroup;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
public class ScheduleBatchVO {
	
	private List<String> empIds;
	@NotNull(groups=InsertGroup.class)
	@Min(value=0)
	@Max(value=23)
	private Integer scShour;
	@NotNull(groups=InsertGroup.class)
	@Min(value=0)
	@Max(value=59)
	private Integer scSminute;
	@NotNull(groups=InsertGroup.class)
	@Min(value=0)
	@Max(value=23)
	private Integer scEhour;
	@NotNull(groups=InsertGroup.class)
	@Min(value=0)
	@Max(value=59)
	private Integer scEminute;
	
	private String searchMonth;
	private Date inputMonth;
	private List<String> clickedDateList;
	private List<ScheduleVO> scheduleList;
	private String startScId;
	
	private String scSort;
	private String empId;
	private float scheduleLength;
	
	public void setScheduleList() {
		scheduleList = new ArrayList<>();
		for(String empId : empIds) {
			for(String eachDate : clickedDateList) {
				ScheduleVO scVO = new ScheduleVO();
				scVO.setEmpId(empId);
				scVO.setDate(eachDate, scShour, scSminute, scEhour, scEminute);
				scheduleList.add(scVO);
			}
		}
	}
	
	public void makeHolidayList(String empId) {
		scheduleList = new ArrayList<>();
		for(String eachDate : clickedDateList) {
			ScheduleVO scVO = new ScheduleVO();
			scVO.setEmpId(empId);
			switch(scSort) {
			case "amHoli":
				scVO.setDate(eachDate, 9, 00, 13, 00);
				break;
			case "pmHoli":
				scVO.setDate(eachDate, 14, 00, 18, 00);
				break;
			case "full":
				scVO.setDate(eachDate, 9, 00, 18, 00);
				break;
			}
			scVO.setScSort(scSort);
			scheduleList.add(scVO);
		}
	}
	
	public void makeSearchMonth(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY/MM");
		searchMonth = sdf.format(date);
	}
}
