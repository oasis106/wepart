package kr.or.ddit.pm.workSchedule.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.auth.dao.AuthenticateDAO;
import kr.or.ddit.pm.employee.dao.PmEmpDAO;
import kr.or.ddit.pm.workSchedule.service.ScheduleService;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.ScheduleSearchVO;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;

@Slf4j
@Controller
@RequestMapping("emp/workSchedule")
public class EmpWorkScheduleList {

	@Inject
	private PmEmpDAO pmDAO;
	
	@Inject
	private ScheduleService scService;
	
	@Inject
	private AuthenticateDAO atDAO;
	
	@ModelAttribute("schedule")
	public ScheduleVO schedulevo() {
		return new ScheduleVO();
	}
	
	@GetMapping
	public String workSchedule(
		Model model
		, Authentication authentication
	){
		List<EmployeeVO> empList = pmDAO.selectEmpList();
		model.addAttribute("empList", empList);
		JSONArray jsonArray = new JSONArray();
		model.addAttribute("empJson", jsonArray.fromObject(empList));
		
		ScheduleSearchVO scSearchVO = new ScheduleSearchVO();
		List<ScheduleVO> schedules = scService.retrieveScheduleAll(scSearchVO);
		model.addAttribute("schedules", schedules);
		
		List<ScheduleVO> holiList = scService.retrieveHoliScheduleAll(scSearchVO);
		model.addAttribute("holiList", holiList);
		
		EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
		List<ScheduleVO> myHolidays = scService.retrieveHoli_empId(auth.getEmpId());
		model.addAttribute("myHolidays", jsonArray.fromObject(myHolidays));
		
		EmployeeVO authForHoli = atDAO.selectEmployeeForAuth(auth);
		model.addAttribute("authForHoli", authForHoli);
		
		return "admin/lej/pm/emp/scheduleList";
	}
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<ScheduleVO> monthWorkSchedule(
		ScheduleSearchVO scSearchVO
	){
		List<ScheduleVO> schedules = scService.retrieveScheduleMonth(scSearchVO);
		log.info("스케쥴:::::::::::::::::::\n{}", schedules);
		return schedules;
	}
	
}
