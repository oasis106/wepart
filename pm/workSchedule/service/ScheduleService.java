package kr.or.ddit.pm.workSchedule.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.HoliVO;
import kr.or.ddit.vo.ScheduleBatchVO;
import kr.or.ddit.vo.ScheduleSearchVO;
import kr.or.ddit.vo.ScheduleVO;

public interface ScheduleService {
	
	
	public ServiceResult createWork(ScheduleVO scVO);
	
	public ServiceResult createBatchWork(ScheduleBatchVO scbatchVO);
	
	public ServiceResult createBatchHoli(ScheduleBatchVO scbatchVO);
	
	public ServiceResult modifyWork(ScheduleVO scVO);
	
	public ServiceResult removeWork(ScheduleVO scVO);
	
	public ScheduleVO retrieveScheduleOne(String scId);
	
	public List<ScheduleVO> retrieveScheduleMonth(ScheduleSearchVO scSearchVO);
	
	public List<ScheduleVO> retrieveScheduleAll(ScheduleSearchVO scSearchVO);
	
	public List<ScheduleVO> retrieveHoliScheduleAll(ScheduleSearchVO scSearchVO);
	
	public List<ScheduleVO> retrieveScheduleMonth_batch(ScheduleBatchVO scBatchVO);
	
	public List<ScheduleVO> retrieveHoli_empId(String empId);
	
	public ServiceResult modifyHolidayStateC(HoliVO holiVO);
	
	public ServiceResult modifyHolidayStateN(HoliVO holiVO);
	
	public ServiceResult modifyHolidayStateY(HoliVO holiVO);
}
