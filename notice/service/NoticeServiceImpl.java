package kr.or.ddit.notice.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.or.ddit.attatch.dao.AttatchDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.notice.dao.NoticeDAO;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.MyPagingVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeDAO noticeDAO;
	
	@Inject
	private AttatchDAO attatchDAO;
	
	@Value("#{appInfo.attatchPath}")
	private File saveFolder;
	
	@Override
	public ServiceResult createNotice(NoticeVO notice) {
		int rowcnt = noticeDAO.insertNotice(notice);
		ServiceResult result = null;
		if(rowcnt > 0) {
			uploadAttatches(notice);
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}
	
	@Override
	public ServiceResult modifyNotice(NoticeVO notice) {
		ServiceResult result = null;
		int rowcnt = noticeDAO.updateNotice(notice);
		if(rowcnt > 0) {
			deleteAttatches(notice);
			uploadAttatches(notice);
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}
	
	@Override
	public ServiceResult removeNotice(NoticeVO notice) {
//		NoticeVO saved = noticeDAO.selectNotice(notice);
		ServiceResult result = null;
		List<AttatchVO> attatchList = notice.getAttatchList();
		int[] delAttNos = attatchList.stream().mapToInt((attatch)->attatch.getAttNo()).toArray();
		notice.setDelAttNos(delAttNos);
		deleteAttatches(notice);
		
		int rowcnt = noticeDAO.deleteNotice(notice);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}


	@Override
	public void uploadAttatches(NoticeVO notice) {
		List<AttatchVO> attatchList = notice.getAttatchList();
		if(attatchList == null || attatchList.isEmpty()) return;
		
		BoardVO board = new BoardVO(notice);
		board.setBoNo(notice.getNtNo());
		attatchDAO.insertAttatchs(board);
		
		attatchList.forEach((attatch)->{
			try {
				attatch.saveTo(saveFolder);
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		});
			
	}
	
	private void deleteAttatches(NoticeVO notice) {
		int[] delAttNos = notice.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return;
		
		BoardVO board = new BoardVO(notice);
		board.setBoNo(notice.getNtNo());
		
		List<String> saveNames = Arrays.stream(delAttNos).mapToObj((delAttNo)->{
									return attatchDAO.selectAttach(delAttNo).getAttSavename();
								}).collect(Collectors.toList());
		attatchDAO.deleteAttaches(board);
		saveNames.forEach((saveName)->{
			FileUtils.deleteQuietly(new File(saveFolder, saveName));
		});
	}

	@Override
	public NoticeVO retrieveNotice(NoticeVO temp_notice) {
		NoticeVO notice = noticeDAO.selectNotice(temp_notice);
		if(notice == null) {
			throw new PKNotFoundException("해당 게시글은 존재하지 않습니다.");
		}
		notice.setMemberVO(temp_notice.getMemberVO());
		notice.setEmpVO(temp_notice.getEmpVO());
		
		int likeCnt = noticeDAO.checkLike(notice);
		if(likeCnt > 0) {
//			if(notice.getMemberVO() != null) {
//				notice.getMemberVO().setLikeYN("Y");							
//			}else if(notice.getEmpVO() != null) {
//				notice.getEmpVO().setLikeYN("Y");
//			}
			notice.setLikeYN("Y");
		}else {
			notice.setLikeYN("N");			
		}
		noticeDAO.increaseHit(notice);
		
		return notice;
	}
	
	@Override
	public void retrieveNoticeAll(MyPagingVO<NoticeVO> paging) {
		int count = noticeDAO.selectTotalRecord(paging);
		paging.setTotalRecord(count);
		List<NoticeVO> noticeList = noticeDAO.selectNoticeList(paging);
		paging.setDataList(noticeList);
	}

	@Override
	public void likeActive(NoticeVO notice) {
		int likeCnt = noticeDAO.checkLike(notice);
		String likeSet = null;
		if(likeCnt > 0) {
			// 좋아요를 취소해야함.
			// 좋아요테이블에서 데이터를 삭제.
			noticeDAO.deleteLike(notice);
			// 해당게시글의 좋아요 -1
			noticeDAO.minusLike(notice);
			likeSet = "N";
		}else {				
			// 좋아요를 추가해줘야함.
			// 좋아요테이블에 데이터 등록.
			noticeDAO.addLike(notice);
			// 해당게시글의 좋아요 +1
			noticeDAO.plusLike(notice);
			likeSet = "Y";
		}
		notice.setNtLike(noticeDAO.countLike(notice));
		notice.setLikeYN(likeSet);
//		if(notice.getMemberVO() != null) {
//			notice.getMemberVO().setLikeYN(likeSet);					
//		}else if(notice.getEmpVO() != null) {
//			notice.getEmpVO().setLikeYN(likeSet);				
//		}
		
	}

	@Override
	public List<NoticeVO> retrieveCommentList(String ntNo) {
		List<NoticeVO> commentList = noticeDAO.selectCommentList(ntNo);
		return commentList;
	}

	@Override
	public ServiceResult removeComment(String ntNo) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = noticeDAO.deleteComment(ntNo);
		System.out.println(rowcnt);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public ServiceResult updateComment(NoticeVO notice) {
		int rowcnt = noticeDAO.updateComment(notice);
		ServiceResult result = ServiceResult.FAIL;
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}

	

}
