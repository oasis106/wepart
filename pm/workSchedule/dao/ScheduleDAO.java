package kr.or.ddit.pm.workSchedule.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.HoliBatchVO;
import kr.or.ddit.vo.HoliVO;
import kr.or.ddit.vo.PmEmpVO;
import kr.or.ddit.vo.ScheduleBatchVO;
import kr.or.ddit.vo.ScheduleSearchVO;
import kr.or.ddit.vo.ScheduleVO;

@Mapper
public interface ScheduleDAO {
	
	/**
	 * 휴가, 근무일정을 저장한다.
	 * @param scVO
	 * @return
	 */
	public int insertWork(ScheduleVO scVO);
	
	/**
	 * 근무일정 일괄추가
	 * @param scbatchVO
	 * @return
	 */
	public int insertBatchWork(ScheduleBatchVO scbatchVO);
	
	/**
	 * 휴가요청 일괄추가
	 * @param scbatchVO
	 * @return
	 */
	public int insertBatchHoli(ScheduleBatchVO scbatchVO);
	
	/**
	 * 휴가요청 승인시, 스케쥴목록에 일괄추가
	 * @param holiList
	 * @return
	 */
	public int insertBatchHoliForSchedule(List<HoliVO> holiList);
	
	/**
	 * 휴가일정 추가할때, 직원의 남은 연차개수를 차감한다.
	 * @param empId
	 * @return
	 */
	public int minusEmpHoli(HoliVO holiVO);
	
	/**
	 * 휴가요청 취소 혹은 거절했을때, 차감했던 직원의 연차개수를 원래대로 복구한다.
	 * @param holiVO
	 * @return
	 */
	public int plusEmpHoli(HoliVO holiVO);
	
	/**
	 * 하루에 직원당 1개의 근무만 등록하기위해, 근무일정이 있나 확인한다.
	 * @param scVO
	 * @return 0보다 크면 근무일정이 이미있음.
	 */
	public int checkWork(ScheduleVO scVO);
	
	/**
	 * 휴가, 근무일정을 수정한다.
	 * @param scVO
	 * @return
	 */
	public int updateWork(ScheduleVO scVO);
	
	public int deleteWork(ScheduleVO scVO);
	
	/**
	 * 하나의 근무일정을 가져온다.
	 * @param scVO
	 * @return
	 */
	public ScheduleVO selectOneSchedule(String scId);
	
	/**
	 * 입력받은 달과, 앞뒤 1달씩 총 3달의 스케쥴을 가져온다.
	 * @param scSearchVO
	 * @return
	 */
	public List<ScheduleVO> monthSchedule(ScheduleSearchVO scSearchVO);
	
	/**
	 * 등록된 모든 근무일정을 가져온다.
	 * @param scSearchVO
	 * @return
	 */
	public List<ScheduleVO> allWorkSchedule(ScheduleSearchVO scSearchVO);
	
	/**
	 * 로그인한 계정의 모든 근무일정을 가져온다.
	 * @param scSearchVO
	 * @return
	 */
	public List<ScheduleVO> myAllWorkSchedule(String empId);
	/**
	 * 등록된 모든 휴가일정을 가져온다.
	 * @param scSearchVO
	 * @return
	 */
	public List<ScheduleVO> allHoliSchedule(ScheduleSearchVO scSearchVO);
	
	/**
	 * 로그인한 계정의 모든 휴가일정을 가져온다.
	 * @param scSearchVO
	 * @return
	 */
	public List<ScheduleVO> myAllHoliSchedule(String empId);
	
	public List<ScheduleVO> monthSchedule_Batch(ScheduleBatchVO scBatchVO);
	
	/**
	 * 휴가요청 모달창에 쓰기위한 쿼리.
	 * 로그인한 직원의 모든 휴가내역을 가져옴.
	 * @param empId
	 * @return
	 */
	public List<ScheduleVO> holiday_Batch(String empId);
	
	/**
	 * 로그인한 직원의 모든 휴가요청내역을 가지고온다.
	 * @param empId
	 * @return
	 */
	public List<HoliVO> holiday_requestList(String empId);
	
	public List<HoliVO> allEmp_requestList();
	
	public int updateHolidayState(HoliVO holiVO);
	
	/**
	 * 입력받은 한달의 스케쥴을 가져온다.
	 * @param scSearchVO
	 * @return
	 */
	public List<PmEmpVO> monthScheduleForExcel(ScheduleSearchVO scSearchVO);
	
	/**
	 * 재직중인 직원의 목록을 가져온다.
	 * @return
	 */
	public List<EmployeeVO> workEmpList();
	
	/**
	 * 퇴사한 직원의 목록을 가져온다.
	 * @return
	 */
	public List<EmployeeVO> retireEmpList();
	
	/**
	 * holiId(한번의 휴가요청)에 해당하는 모든 휴가일정을 조회함.
	 * @param holiId
	 * @return
	 */
	public List<HoliVO> selectHolidayByHoliId(String holiId);
	
	/**
	 * holiId로 요청신청한 empId를 가져옴.
	 * @param holiId
	 * @return
	 */
	public String getEmpIdByHoliId(String holiId);
	
	
}
