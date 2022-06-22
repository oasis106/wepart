package kr.or.ddit.pm.workSchedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jxls.common.Context;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.pm.workSchedule.dao.ScheduleDAO;
import kr.or.ddit.vo.ScheduleSearchVO;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

//@Slf4j
//@Controller
//@RequestMapping("/workSchedule/excel")
public class WorkScheduleExcel {
	
	@Inject
	private ScheduleDAO scDAO;
	
	@PostMapping
	public String excelDownload(
		Model model
  		, HttpServletRequest request
        , HttpServletResponse response
        , ScheduleSearchVO scSearchVO
	)  {
//		log.info("출력하는 월:::::::{}", scSearchVO);
//		scSearchVO.makeSearchMonth(scSearchVO.getInputMonth());
//		Map<String, Object> modelMap = new HashMap<String, Object>();
//		List<ScheduleVO> scList = scDAO.monthScheduleForExcel(scSearchVO);
//		
//		Context context = new Context();
//		context.putVar("scList", scList);
//		
//		
//		model.addAttribute("context",context);
//		model.addAttribute("templateName","workSchedule0.xlsx");
//		model.addAttribute("excelName", scSearchVO.getSearchMonth() + " 근무일정");
//		
		
		return "excelView";
	}
	
}
