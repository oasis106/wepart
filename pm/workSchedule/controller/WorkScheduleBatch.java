package kr.or.ddit.pm.workSchedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.constraints.NotEmpty;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.workSchedule.service.ScheduleService;
import kr.or.ddit.utils.MakeErrorMessage;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.vo.ScheduleBatchVO;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;

@Slf4j
@Controller
@RequestMapping("hr/workSchedule/batch")
public class WorkScheduleBatch {

	@Inject
	private ScheduleService scService;
	
	@Inject
	private MakeErrorMessage mem;
	

	@PostMapping(value="inputValidate",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, String> inputValidate(
		@RequestParam(value="empIdss[]") @NotEmpty List<String> empIds
		, @Validated(InsertGroup.class) ScheduleBatchVO scbatchVO
		, Errors errors
	) {
		scbatchVO.setEmpIds(empIds);
		Map<String, String> errorMap = new HashMap<>();
		String retValue = null;
		
		if(errors.hasErrors()) {
			errorMap = mem.makeMessage(errors);
		}else {
			if(empIds.size() > 1) {
				List<ScheduleVO> schedules = scService.retrieveScheduleMonth_batch(scbatchVO);
				JSONArray jsonArray = new JSONArray();
				jsonArray.addAll(schedules);
				errorMap.put("scheduleList", jsonArray.toString());
			}
			retValue = "success";
		}
		
		errorMap.put("retValue", retValue);
		return errorMap;
	}
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String batchInsert(
		@RequestParam(value="empIdss[]") @NotEmpty List<String> empIds
		, @Validated(InsertGroup.class) ScheduleBatchVO scbatchVO
	) {
		log.info("직원목록:::{}",empIds);
		log.info("스케쥴배치VO::::::{}", scbatchVO);
		scbatchVO.setEmpIds(empIds);
		scbatchVO.setScheduleList();
		for(ScheduleVO scVO : scbatchVO.getScheduleList()) {
			log.info("스케쥴:::::::{}", scVO);
		}
		ServiceResult retValue = scService.createBatchWork(scbatchVO);
		String result = null;
		switch(retValue) {
		case OK:
			result = "success";
			break;
		case FAIL:
			result = "fail";
			break;
		}
		
		return result;
	}
}
