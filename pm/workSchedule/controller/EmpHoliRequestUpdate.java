package kr.or.ddit.pm.workSchedule.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.workSchedule.service.ScheduleService;
import kr.or.ddit.vo.HoliVO;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@Controller
@RequestMapping("emp/holi/update")
public class EmpHoliRequestUpdate {
	
	@Inject
	private ScheduleService service;
	
	@PostMapping(value="C")
	@ResponseBody
	public String modifyStateC(
		HoliVO holiVO
	) {
		String retValue = null;
		ServiceResult result = service.modifyHolidayStateC(holiVO);
		switch (result) {
		case OK:
			retValue = "success";
			break;
		case FAIL:
			retValue = "fail";
			break;
		}
		return retValue;
	}
	
	@PostMapping(value="N")
	@ResponseBody
	public String modifyStateN(
		HoliVO holiVO
	) {
		log.info("전달받은 휴가VO::::::::{}", holiVO);
		String retValue = null;
		ServiceResult result = service.modifyHolidayStateN(holiVO);
		switch (result) {
		case OK:
			retValue = "success";
			break;
		case FAIL:
			retValue = "fail";
			break;
		}
		return retValue;
		
	}
	
	@PostMapping(value="Y")
	@ResponseBody
	public String modifyStateY(
		HoliVO holiVO
	) {
		log.info("전달받은 휴가VO::::::::{}", holiVO);
		String retValue = null;
		ServiceResult result = service.modifyHolidayStateY(holiVO);
		switch (result) {
		case OK:
			retValue = "success";
			break;
		case FAIL:
			retValue = "fail";
			break;
		}
		return retValue;
		
	}
	
}
