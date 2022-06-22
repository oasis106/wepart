package kr.or.ddit.notice.controller;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.security.MemberVOWrapper;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice/new")
public class NoticeInsert {

	@Inject
	private NoticeService service;
	
	@ModelAttribute("notice")
	public NoticeVO notice(){
		return new NoticeVO();
	}
	
	@GetMapping
	public String form() {
		return "admin/lej/notice/insertForm";
	}
	
	@PostMapping
	public String insertNotice(
		@Validated(InsertGroup.class) @ModelAttribute("notice") NoticeVO notice
		, Errors errors
		, RedirectAttributes redirectAttributes
		, Authentication authentication
	) {
		log.info("글번호:{}\n제목:{}\n부모글번호:{},\n작성자아이디:{}", notice.getNtNo(), notice.getNtTitle(), notice.getNtParent(), notice.getEmpId());
		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
			notice.setEmpVO(auth);
		}else if(authentication.getPrincipal() instanceof MemberVOWrapper) {
			MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
			notice.setMemberVO(auth);	
		}
		
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createNotice(notice);
			
			switch (result) {
			case OK:
				viewName = "redirect:/notice";
				redirectAttributes.addFlashAttribute("success", notice);
				break;
			case FAIL:
				viewName = "admin/lej/notice/insertForm";
				redirectAttributes.addFlashAttribute("message", "서버 오류");
				break;
			}
		}else {
			viewName = "admin/lej/notice/insertForm";
		}
		return viewName;
	}
	
	
	@PostMapping(value="{ntNo}", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String insertComment(
		@PathVariable("ntNo") String ntNo
		, @ModelAttribute("notice") NoticeVO notice
		, Authentication authentication
	) {
		
		log.info("댓글정보:::::::::::::: {}", notice);
		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
			notice.setEmpVO(auth);
		}else if(authentication.getPrincipal() instanceof MemberVOWrapper) {
			MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
			notice.setMemberVO(auth);	
		}
		
		
		ServiceResult result = service.createNotice(notice);
		String retValue = "";
		switch (result) {
		case OK:
			retValue = "success";
			break;
		case FAIL:
			retValue = "fail";
		}
		
		return retValue;
	}
	
}
