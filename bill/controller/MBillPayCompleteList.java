package kr.or.ddit.bill.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.bill.dao.MBillDAO;
import kr.or.ddit.security.MemberVOWrapper;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("bill/payCompleteList")
public class MBillPayCompleteList {
	
	@Inject
	private MBillDAO mbDAO;
	
	@GetMapping
	public String payList(
		Model model
		, Authentication authentication
	) {
		if(authentication.getPrincipal() instanceof MemberVOWrapper) {
			MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
			List<MBillVO> pcList = mbDAO.payCompleteList(auth.getPayerNo());
			model.addAttribute("pcList", pcList);
		}
		return "member/lej/bill/payCompleteList";
	}
	
}
