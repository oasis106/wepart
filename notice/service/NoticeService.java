package kr.or.ddit.notice.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MyPagingVO;
import kr.or.ddit.vo.NoticeVO;

public interface NoticeService {

	public ServiceResult createNotice(NoticeVO notice);
	
	public ServiceResult modifyNotice(NoticeVO notice);
	
	public ServiceResult removeNotice(NoticeVO notice);
	
	public void uploadAttatches(NoticeVO notice);
	
	public NoticeVO retrieveNotice(NoticeVO notice);
	
	public void retrieveNoticeAll(MyPagingVO<NoticeVO> notice);
	
	public void likeActive(NoticeVO notice);
	
	public List<NoticeVO> retrieveCommentList(String ntNo);
	
	public ServiceResult removeComment(String ntNo);
	
	public ServiceResult updateComment(NoticeVO notice);
}
