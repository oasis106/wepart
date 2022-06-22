package kr.or.ddit.pm.workSchedule.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.auth.dao.AuthenticateDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.workSchedule.service.ScheduleService;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.ScheduleBatchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp/holi/batchInsert")
public class EmpHoliScheduleInsert {

	@Inject
	private ScheduleService scService;
	
	
	@PostMapping
	@ResponseBody
	public String holiBatchInsert(
		@ModelAttribute("schedule") ScheduleBatchVO scbatchVO
		, Authentication authentication
	) {
		
		log.info("전달받은 휴가데이터:::::::{}", scbatchVO);
		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
			scbatchVO.setEmpId(auth.getEmpId());
			scbatchVO.makeHolidayList(auth.getEmpId());
			log.info("변환후 휴가데이터:::::::{}", scbatchVO);
			ServiceResult result = scService.createBatchHoli(scbatchVO);
			String retValue = null;
			switch(result) {
			case OK:
				retValue = "success";
				break;
			case FAIL:
				retValue = "fail";
				break;
			}
			
			return retValue;
			
		}
		return "noAccess";
	}
	
}
