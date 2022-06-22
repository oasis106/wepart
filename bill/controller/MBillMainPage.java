package kr.or.ddit.bill.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.bill.dao.MBillDAO;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.security.MemberVOWrapper;
import kr.or.ddit.vo.BillSearchVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/bill")
public class MBillMainPage {
	
	@Inject
	private MBillDAO mbDAO;
	
	@GetMapping
	public String listUI(
		Model model
		, Authentication authentication
	) {

		if(authentication.getPrincipal() instanceof MemberVOWrapper) {
			MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();		
			List<MBillVO> billList = mbDAO.selectMBillList(auth.getPayerNo());
			model.addAttribute("billList", billList);
			
			String recentMonth = mbDAO.recentMBill(auth.getPayerNo());
			int houseArea = mbDAO.houseArea(auth.getPayerNo());
			BillSearchVO bsVO = new BillSearchVO();
			bsVO.setPayerNo(auth.getPayerNo());
			bsVO.setMonth(recentMonth);
			bsVO.setHouseArea(houseArea);
			
			List<MBillVO> oneYearBillList = mbDAO.selectMBillListOneYear(bsVO);
			List<MBillVO> avgList = mbDAO.totalAreaAVG(bsVO);
			model.addAttribute("oneYearBillList", oneYearBillList);
			model.addAttribute("avgList", avgList);
		}else if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			return "redirect:/";
		}
		return "member/lej/bill/billList";
	}
	
}
