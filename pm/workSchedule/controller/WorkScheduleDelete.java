package kr.or.ddit.pm.workSchedule.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.workSchedule.service.ScheduleService;
import kr.or.ddit.validate.DeleteGroup;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("hr/workSchedule/delete")
public class WorkScheduleDelete {

	@Inject
	private ScheduleService scService;
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, String> insertWork(
		@Validated(DeleteGroup.class) @ModelAttribute("schedule") ScheduleVO scVO
	) {
		log.info("삭제할 스케쥴::: {}", scVO);
		Map<String, String> errorMap = new HashMap<>();
		String retValue = null;
		String retMessage = "delete";
		ScheduleVO valid_scVO = scService.retrieveScheduleOne(scVO.getScId());
		ServiceResult result = scService.removeWork(valid_scVO);
		switch(result) {
		case OK:
			retValue = "success";
			break;
		case FAIL:
			retValue = "serverError";
			break;
		}
		errorMap.put("retValue", retValue);
		errorMap.put("retMessage", retMessage);
		return errorMap;
	}
}
