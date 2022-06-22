package kr.or.ddit.notice.controller;


import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.security.EmployeeVOWrapper;
import kr.or.ddit.security.MemberVOWrapper;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MemberVO;
import kr.or.ddit.vo.MyPagingVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("notice")
public class NoticeRetrieveController {
	
	@Inject
	private NoticeService noticeService;
	
	@GetMapping
	public String listUI() {
		return "member/lej/notice/noticeList";
	}
	
	@PostMapping(value="{ntParent}/{ntNo}", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String updateComment(
		@ModelAttribute("notice") NoticeVO notice
	) {
		log.info("전달받은 값::::::::::::::{}", notice);
		ServiceResult result = noticeService.updateComment(notice);
		String retValue = null;
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
	
	@GetMapping(produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public MyPagingVO<NoticeVO> listView(
		@RequestParam(value="page", defaultValue="1", required=false) int currentPage
		, @ModelAttribute NoticeVO detailCondition
		
	) {
		MyPagingVO<NoticeVO> paging = new MyPagingVO<>(10, 10);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		noticeService.retrieveNoticeAll(paging);
		return paging;
		
	}
	
	@GetMapping("{ntNo}")
	public String detailView(
		@PathVariable("ntNo") String ntNo
		, Model model
		, Authentication authentication
		, RedirectAttributes redirectAttributes
	) {
//		log.info("어쎈티캐이션:::::::::::{}", authentication);
		// 로그인한 멤버.
		if(authentication == null) {
//			redirectAttributes.addFlashAttribute("message", "로그인이 필요합니다.");
			return "redirect:/login/loginForm";
		}
		
		log.info("로그인한 유저::::::::::\n {}", authentication.getPrincipal());
		NoticeVO temp_notice = new NoticeVO();
		temp_notice.setNtNo(ntNo);
		
		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
//			auth.setLikeYN("N");
			temp_notice.setEmpVO(auth);
		}else if(authentication.getPrincipal() instanceof MemberVOWrapper) {
			MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
//			auth.setLikeYN("N");
			temp_notice.setMemberVO(auth);
		}
		
		//글번호, 로그인한멤버를 담은 NoticeVO를 파라미터로 보냄. 두개말곤 다 빈값임.
		NoticeVO notice = noticeService.retrieveNotice(temp_notice);
		model.addAttribute("notice", notice);

		return "member/lej/notice/detailView";
	}
	
	@PostMapping(value="{ntNo}/like", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public NoticeVO LikeProcess(
		@PathVariable("ntNo") String ntNo
		, Model model
		, Authentication authentication
	) {
		
		NoticeVO notice = new NoticeVO();
		notice.setNtNo(ntNo);
		
		if(authentication.getPrincipal() instanceof EmployeeVOWrapper) {
			EmployeeVO auth = ((EmployeeVOWrapper) authentication.getPrincipal()).getRealUser();
			notice.setEmpVO(auth);
		}else if(authentication.getPrincipal() instanceof MemberVOWrapper) {
			MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
			notice.setMemberVO(auth);	
		}
		
		
		noticeService.likeActive(notice);
		
		return notice;
	}
	
	@GetMapping(value="{ntNo}/comments", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<NoticeVO> commentsList(
		@PathVariable("ntNo") String ntNo
	){
		return noticeService.retrieveCommentList(ntNo);
	}
	
	
	
	
}
