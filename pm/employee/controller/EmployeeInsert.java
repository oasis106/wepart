package kr.or.ddit.pm.employee.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.employee.service.EmpService;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.utils.MakeErrorMessage;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/system/insert")
public class EmployeeInsert {
	
	@Inject
	private EmpService empService;
	
	@Inject
	private MakeErrorMessage mem;
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, String> insertEmployee(
		@Validated(InsertGroup.class) @ModelAttribute("employee") EmployeeVO empVO
		, Errors errors
		, Authentication authentication
	) {
		log.info("직원데이터::::::{}", empVO);
		Map<String, String> errorMap = new HashMap<>();
		String retValue = null;
		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
			if(auth.getMemRole().equals("ROLE_ADMIN") || auth.getMemRole().equals("ROLE_SYM")) {
				if(!errors.hasErrors()) {
					// 에러 없음.
					ServiceResult result = empService.insertEmp(empVO);
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
					errorMap = mem.makeMessage(errors);
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
	
	@GetMapping(value="idcheck", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String idCheck(
		String empId
	) {
		String result = "INVALID";
		EmployeeVO empVO = empService.selectEmp(empId);
		if(empVO == null) result = "POSSIBLE";
		
		return result;
		
	}

	
}
