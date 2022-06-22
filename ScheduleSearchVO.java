package kr.or.ddit.vo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleSearchVO {

	private String searchMonth;
	private String searchWeek;
	private String searchDay;
	
	private Date inputMonth;
	private List<EmployeeVO> empList;
	private String empId;
	
	public void makeSearchMonth(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY/MM");
		searchMonth = sdf.format(date);
	}
	
	
}
