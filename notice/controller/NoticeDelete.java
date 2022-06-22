package kr.or.ddit.notice.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice/delete")
public class NoticeDelete {
	
	@Inject
	private NoticeService noticeService;
	
	@GetMapping("{ntNo}")
	public String noticeDelete(
		@PathVariable("ntNo") String ntNo
		, Authentication authentication
		, RedirectAttributes redirectAttributes
	) {
		
		NoticeVO temp = new NoticeVO();
		temp.setNtNo(ntNo);
		NoticeVO notice = noticeService.retrieveNotice(temp);
		String viewName = "redirect:/notice";

		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
			if(auth.getEmpId().equals(notice.getEmpId())) {
				ServiceResult result = noticeService.removeNotice(notice);
				switch (result) {
				case FAIL:
					redirectAttributes.addFlashAttribute("message", "서버 오류입니다.");
					break;
				}
			}else {
				redirectAttributes.addFlashAttribute("message", "작성자 본인만 삭제 가능.");
			}
		}else {
			redirectAttributes.addFlashAttribute("message", "관리자만 삭제 가능.");
		}
		
		return viewName;
	}
	
	@PostMapping(value="{ntNo}", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String deleteComment(
		@RequestParam String ntNo
	) {
		log.info("전달받은 값::::::::::{}", ntNo);
		ServiceResult result = noticeService.removeComment(ntNo);
		String retValue = "";
		switch (result) {
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
