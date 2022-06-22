package kr.or.ddit.bill.controller;


import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.bill.dao.MBillDAO;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.security.MemberVOWrapper;
import kr.or.ddit.vo.BillSearchVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.detailAVGVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/bill")
public class MBillRetrieve {
	
	@Inject
	private MBillDAO mbDAO;
	
	@GetMapping("/billList")
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
	
	@GetMapping(value="/month", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public MBillVO searchMonth(
		@ModelAttribute("bsVO")BillSearchVO bsVO
		, Authentication authentication
	) {
		MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
//		log.info("계정정보::::::::{}", auth);
//		log.info("검색정보::::::::{}", bsVO);
		bsVO.setPayerNo(auth.getPayerNo());
		MBillVO monthBill = mbDAO.selectMBillByMonth(bsVO);
		
		if(monthBill == null) {
			monthBill = new MBillVO();
		}
		
		return monthBill;
	}
	
	@GetMapping(value="/detail", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<Integer> detailByHouse(
		@ModelAttribute("bsVO")BillSearchVO bsVO
		, Authentication authentication
	){
		log.info("빌서치::::::::{}", bsVO);
		MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
		bsVO.setPayerNo(auth.getPayerNo());
		
		return mbDAO.detailByHouse(bsVO);
	}
	
	@GetMapping(value="/detailAVG", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<detailAVGVO> detailAVGByArea(
		@ModelAttribute("bsVO")BillSearchVO bsVO
		, Authentication authentication
	){
		MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
		bsVO.setPayerNo(auth.getPayerNo());
		int houseArea = mbDAO.houseArea(auth.getPayerNo());
		bsVO.setHouseArea(houseArea);
		return mbDAO.detailAVGByArea(bsVO);
	}
	
}
