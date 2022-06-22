package kr.or.ddit.bill.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.bill.service.MBillService;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MBillVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/bill/pay")
public class MBillPayment {

	@Inject
	private MBillService mbService;
	
	@PostMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String payment(
		MBillVO mbillVO
	) {
		log.info("전달받은 결제정보::::::::::{}", mbillVO);
		String retValue = null;
		ServiceResult result = mbService.modifyBillPaydate(mbillVO);
		switch(result) {
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
