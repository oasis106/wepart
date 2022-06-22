package kr.or.ddit.pm.employee.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.pm.employee.dao.PmEmpDAO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.security.RolesVO;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;

@Slf4j
@Controller
@RequestMapping("/system")
public class EmployeeRetrieve {
	
	@Inject
	private PmEmpDAO pmDAO;
	
	@ModelAttribute("employee")
	public EmployeeVO insertForm() {
		return new EmployeeVO();
	}
	
	@SuppressWarnings("static-access")
	@GetMapping("/employee")
	public String employeeList(Model model) {
		
		List<EmployeeVO> empList = pmDAO.selectEmpList();
		List<RolesVO> roleList = pmDAO.selectRolesList();
		JSONArray jsonArray = new JSONArray();
		
		model.addAttribute("empList", empList);
		model.addAttribute("empJson", jsonArray.fromObject(empList));
		model.addAttribute("roleList", roleList);
		
		
		return "admin/lej/pm/system/empList";
	}
	

	@GetMapping(value="/employeeCategory", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> employeeListWithCategory(
		@RequestParam String empCategory
	) {
		log.info("카테고리:::::::{}", empCategory);
		Map<String, Object> retMap = new HashMap<String, Object>();
		List<EmployeeVO> empList = pmDAO.selectEmpListWithCategory(empCategory);
		List<RolesVO> roleList = pmDAO.selectRolesList();
		JSONArray jsonArray = new JSONArray();
		retMap.put("empList", empList);
		retMap.put("roleList", roleList);
		retMap.put("empJson", jsonArray.fromObject(empList));
		
		return retMap;
	}

}
