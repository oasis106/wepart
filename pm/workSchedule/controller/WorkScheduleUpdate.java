package kr.or.ddit.pm.workSchedule.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.workSchedule.service.ScheduleService;
import kr.or.ddit.utils.MakeErrorMessage;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("hr/workSchedule/update")
public class WorkScheduleUpdate {

	@Inject
	private ScheduleService scService;
	
	@Inject
	private MakeErrorMessage mem;
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, String> updateWork(
		@Validated(UpdateGroup.class) @ModelAttribute("schedule") ScheduleVO scVO
		, Errors errors
	) {
		log.info("스케쥴:::::::::::::{}", scVO);
		Map<String, String> errorMap = new HashMap<>();
		String retValue = null;
		String retMessage = "update";
		if(!errors.hasErrors()) {
			// 에러 없음.
			ServiceResult result = scService.modifyWork(scVO);
			switch (result) {
			case OK:
				retValue = "success";
				ScheduleVO retSchedule = scService.retrieveScheduleOne(scVO.getScId());
				ObjectMapper mapper = new ObjectMapper();
				String scheduleString;
				try {
					scheduleString = mapper.writeValueAsString(retSchedule);
					errorMap.put("schedule", scheduleString);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				break;
			case FAIL:
				retValue = "serverError";
				break;
			case EXIST:
				retValue = "exist";
				break;
			}
		}else {
			// 에러 있음.
			errorMap = mem.makeMessage(errors);
		}
		errorMap.put("retValue", retValue);
		errorMap.put("retMessage", retMessage);
		return errorMap;
		
	}
	
	
}
