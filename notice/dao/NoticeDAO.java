package kr.or.ddit.notice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.MyPagingVO;
import kr.or.ddit.vo.NoticeVO;

@Mapper
public interface NoticeDAO {
	
	public int deleteNotice(NoticeVO notice);

	public int insertNotice(NoticeVO notice);
	
	public int updateNotice(NoticeVO notice);
	
	public NoticeVO selectNotice(NoticeVO notice);
	
	public List<NoticeVO> selectNoticeList(MyPagingVO<NoticeVO> paging);
	
	public List<NoticeVO> selectNoticeListForMain();
	
	public int selectTotalRecord(MyPagingVO<NoticeVO> paging);
	
	/**
	 * 조회수 증가
	 * @param notice
	 * @return
	 */
	public int increaseHit(NoticeVO notice);
	
	/**
	 * 좋아요를 누른 상태인지 체크
	 * @param notice
	 * @return 결과 > 0 ? 누른상태 : 안누른상태
	 */
	public int checkLike(NoticeVO notice);
	
	/**
	 * 좋아요 테이블에 데이터 추가
	 * @param notice
	 * @return
	 */
	public int addLike(NoticeVO notice);
	
	/**
	 * 좋아요 테이블에서 데이터 삭제
	 * @param notice
	 * @return
	 */
	public int deleteLike(NoticeVO notice);
	
	/**
	 * 게시글의 좋아요 데이터를 +1함.
	 * @param notice
	 * @return
	 */
	public int plusLike(NoticeVO notice);
	
	/**
	 * 게시글의 좋아요 데이터를 -1함.
	 * @param notice
	 * @return
	 */
	public int minusLike(NoticeVO notice);
	
	/**
	 * 게시글의 좋아요 갯수를 조회함.
	 * @param notice
	 * @return
	 */
	public int countLike(NoticeVO notice);
	
	/**
	 * 게시물의 댓글 목록을 조회함.
	 * @param ntNo 게시글번호
	 * @return 댓글목록
	 */
	public List<NoticeVO> selectCommentList(String ntNo);
	
	public int deleteComment(String ntNo);
	
	/**
	 * 게시물의 댓글 수정
	 * @param ntNo 댓글번호
	 * @return
	 */
	public int updateComment(NoticeVO notice);
}
