package kr.or.ddit.bill.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.bill.dao.EnergyDAO;
import kr.or.ddit.member.dao.MemberDAO;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.security.MemberVOWrapper;
import kr.or.ddit.vo.EnergyMBDetailVO;
import kr.or.ddit.vo.EnergyReadVO;
import kr.or.ddit.vo.EnergySearchVO;
import kr.or.ddit.vo.MBillDetailVO;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.ReadVO;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;

@Slf4j
@Controller
@RequestMapping("/bill/energy")
public class EnergyRetrieveController {

	@Inject
	private EnergyDAO eDAO;
	
	@Inject
	private MemberDAO mbDAO;
	
	@GetMapping
	public String energyMain(
		Authentication authentication
		, Model model
	) {
		if(authentication.getPrincipal() instanceof MemberVOWrapper) {
			MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();	
			
			EnergySearchVO esVO = new EnergySearchVO();
			esVO.setPayerNo(auth.getPayerNo());
			List<EnergySearchVO> esList = eDAO.allBillSearchList(auth.getPayerNo());
			
			List<MBillVO> myFeeList = eDAO.myFeeListForYear(esVO);
			for(MBillVO mbillVO : myFeeList) {
				int energyFee = 0;
				for(MBillDetailVO detailVO : mbillVO.getBtailList()) {
					energyFee += detailVO.getBtailSum();
				}
				mbillVO.setEnergyFee(energyFee);
			}
			
			List<MBillVO> avgFeeList = eDAO.feeAVGForYear(esVO);
			for(MBillVO mbillVO : avgFeeList) {
				int energyFee = 0;
				for(MBillDetailVO detailVO : mbillVO.getBtailList()) {
					energyFee += detailVO.getBtailSum();
				}
				mbillVO.setEnergyFee(energyFee);
			}
			
			Collections.sort(myFeeList);
			Collections.sort(avgFeeList);
			
			model.addAttribute("esList", esList);
			model.addAttribute("myFeeList", myFeeList);
			model.addAttribute("avgFeeList", avgFeeList);
			
		}else if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			return "redirect:/";
		}
		
		return "member/lej/bill/energyList";
	}
	
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> allEnergyList(
		EnergySearchVO esVO
		, Authentication authentication
	){
		MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();	
		esVO.setPayerNo(auth.getPayerNo());
		esVO.setlastYearMonth6(esVO.getMonth6());
		JSONArray jsonArray = new JSONArray();
		List<EnergyMBDetailVO> myBillList = eDAO.myFeeListForMonth(esVO);
		List<EnergyMBDetailVO> avgBillList = eDAO.feeAVGForMonth(esVO);
		List<EnergyReadVO> myUsageList = eDAO.myUsageWithMonth(esVO);
		List<EnergyReadVO> avgUsageList = eDAO.usageAVGMonth(esVO);
		List<EnergyMBDetailVO> lastYearBillList = eDAO.myFeeList_LastYear(esVO);
		
		Map<String, Object> retMap = new HashMap<>();
		retMap.put("myBillList", jsonArray.fromObject(myBillList));			
		retMap.put("avgBillList", jsonArray.fromObject(avgBillList));			
		retMap.put("myUsageList", jsonArray.fromObject(myUsageList));			
		retMap.put("avgUsageList", jsonArray.fromObject(avgUsageList));			
		retMap.put("lastYearBillList", jsonArray.fromObject(lastYearBillList));			

		
		return retMap;
	}
}

