package kr.or.ddit.notice.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.validate.InsertGroup;
import kr.or.ddit.validate.UpdateGroup;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice/update/{ntNo}")
public class NoticeUpdate {
	
	@Inject
	private NoticeService noticeService;
	
	@GetMapping()
	public String updateForm(@PathVariable String ntNo, Model model) {
		NoticeVO temp = new NoticeVO();
		temp.setNtNo(ntNo);
		NoticeVO notice = noticeService.retrieveNotice(temp);
		log.info("파일목록::::::::::::::::{}", notice.getAttatchList());
		model.addAttribute("notice", notice);
		return "admin/lej/notice/updateForm";
	}
	
	@PostMapping()
	public String updateProcess(
		@Validated(UpdateGroup.class) @ModelAttribute("notice") NoticeVO notice
		, Errors errors
		, RedirectAttributes redirectAttributes
	) {
		
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = noticeService.modifyNotice(notice);
			switch (result) {
			case OK:
				viewName = "redirect:/notice/"+notice.getNtNo();
				redirectAttributes.addFlashAttribute("success", notice);
				break;
			case FAIL:
				viewName = "admin/lej/notice/updateForm";
				redirectAttributes.addFlashAttribute("message", "서버 오류");
				break;
			}
		}else {
			viewName = "admin/lej/notice/updateForm";
		}
		return viewName;
	}
	
}
