package kr.or.ddit.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.validate.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="empId")
public class PmEmpVO {
	
	@NotBlank(groups=InsertGroup.class)
	private String empId;
	@NotBlank(groups=InsertGroup.class)
	private String empPass;
	@NotBlank(groups=InsertGroup.class)
	private String empName;
	@NotBlank(groups=InsertGroup.class)
	private String empDep;
	@NotBlank(groups=InsertGroup.class)
	private String empSdate;
	@NotBlank(groups=InsertGroup.class)
	private String empMail;
	@NotBlank(groups=InsertGroup.class)
	private String empHp;
	private String empNo;
	
	private List<ScheduleVO> scheduleList;
	
}
