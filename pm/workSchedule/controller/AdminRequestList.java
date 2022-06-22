package kr.or.ddit.pm.workSchedule.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.auth.dao.AuthenticateDAO;
import kr.or.ddit.pm.workSchedule.dao.ScheduleDAO;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.HoliVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("hr/request")
public class AdminRequestList {

	@Inject
	private ScheduleDAO sDAO;
	
	@Inject
	private AuthenticateDAO atDAO;
	
	@GetMapping
	public String list(
		Model model
		, Authentication authentication
	) {
		EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
		EmployeeVO authForHoli = atDAO.selectEmployeeForAuth(auth);
		List<HoliVO> reqList = sDAO.allEmp_requestList();
		for(HoliVO holiVO : reqList) {
			log.info("휴가요청목록::::::{}", holiVO);			
		}
		model.addAttribute("reqList", reqList);
		
		return "admin/lej/pm/admin/requestList";
	}
	
}
