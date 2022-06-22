package kr.or.ddit.pm.employee.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.employee.service.EmpService;
import kr.or.ddit.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/system/delete")
public class EmployeeDelete {

	@Inject
	private EmpService empService;
	
	@PostMapping(value="{empId}", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, String> deleteEmployee(
		@ModelAttribute("employee") EmployeeVO empVO
		, @PathVariable String empId
	) {
		Map<String, String> errorMap = new HashMap<>();
		String retValue = null;
		empVO.setEmpId(empId);
		ServiceResult result = empService.removeEmp(empVO);
		switch (result) {
		case OK:
			retValue = "delete_success";
			break;
		case FAIL:
			retValue = "serverError";
			break;
		case NOTEXIST:
			retValue = "notexist";
			break;
		}
		errorMap.put("retValue", retValue);
		return errorMap;
	}
	
}
