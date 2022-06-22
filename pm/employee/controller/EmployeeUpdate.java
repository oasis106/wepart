package kr.or.ddit.pm.employee.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.employee.service.EmpService;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.utils.MakeErrorMessage;
import kr.or.ddit.validate.UpdateGroup;
import kr.or.ddit.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/system/update")
public class EmployeeUpdate {
	
	
	@Inject
	private EmpService empService;
	
	@Inject
	private MakeErrorMessage makeEMessage;
	
	@PostMapping(value="{empId}", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, String> updateEmployee(
		@Validated(UpdateGroup.class) @ModelAttribute("employee") EmployeeVO empVO
		, Errors errors
		, @PathVariable String empId
		, Authentication authentication
	){
		
		Map<String, String> errorMap = new HashMap<>();
		String retValue = null;
		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
			if(auth.getMemRole().equals("ROLE_ADMIN")) {
				if(!errors.hasErrors()) {
					// 에러 없음.
					empVO.setEmpId(empId);
					log.info("직원정보::::::{}", empVO);
					ServiceResult result = empService.modifyEmp(empVO);
					switch (result) {
					case OK:
						retValue = "success";
						break;
					case FAIL:
						retValue = "serverError";
						break;
					case PKDUPLICATED:
						retValue = "pkduplicated";
						break;
					}
				}else {
					// 에러 있음.
					log.info("직원정보::::::{}", empVO);
					log.info("에러있음");
					errorMap = makeEMessage.makeMessage(errors);
				}
			}
			else {
				// 접근 불가 에러띄우기
				retValue = "noAccess";
			}
		}else {
			// 접근 불가 에러띄우기
			retValue = "noAccess";
		}
		errorMap.put("retValue", retValue);
		return errorMap;
	}
	
}
