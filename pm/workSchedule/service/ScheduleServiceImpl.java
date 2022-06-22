package kr.or.ddit.pm.workSchedule.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.pm.workSchedule.dao.ScheduleDAO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.HoliVO;
import kr.or.ddit.vo.ScheduleBatchVO;
import kr.or.ddit.vo.ScheduleSearchVO;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Inject
	private ScheduleDAO scDAO;
	
	
	
	@Override
	public ServiceResult createWork(ScheduleVO scVO) {
		ServiceResult result = ServiceResult.FAIL;
		int checkSchedule = scDAO.checkWork(scVO);
		if(checkSchedule > 0) {
			result = ServiceResult.EXIST;
			return result;
		}
		scVO.setDate();
		int rowcnt = scDAO.insertWork(scVO);
		if(rowcnt > 0) {
			result=ServiceResult.OK;
		}
		return result;
	}
	
	@Override
	public ServiceResult modifyWork(ScheduleVO scVO) {
		ServiceResult result = ServiceResult.FAIL;
		ScheduleVO recorded = scDAO.selectOneSchedule(scVO.getScId());
		if(!recorded.getEmpId().equals(scVO.getEmpId())) {
			int checkSchedule = scDAO.checkWork(scVO);
			if(checkSchedule > 0) {
				result = ServiceResult.EXIST;
				return result;
			}
		}
		scVO.setDate();
		int rowcnt = scDAO.updateWork(scVO);
		if(rowcnt > 0) {
			result=ServiceResult.OK;
		}
		
		
		return result;
	}
	
	@Override
	public ServiceResult removeWork(ScheduleVO scVO) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = scDAO.deleteWork(scVO);
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		return result;
	}
	
	@Override
	public ScheduleVO retrieveScheduleOne(String scId) {
		ScheduleVO scVO = scDAO.selectOneSchedule(scId);
		if(scVO == null) {
			throw new PKNotFoundException(String.format("존재하지 않는 근무일정."));
		}
		return scVO;
	}
	

	@Override
	public List<ScheduleVO> retrieveScheduleMonth(ScheduleSearchVO scSearchVO) {
		List<EmployeeVO> empList = scDAO.workEmpList();
		scSearchVO.setEmpList(empList);
		
		if(scSearchVO.getInputMonth() == null) {
			Date today = new Date();
			scSearchVO.makeSearchMonth(today);
		}else {
			scSearchVO.makeSearchMonth(scSearchVO.getInputMonth());
		}
		List<ScheduleVO> schedules = scDAO.monthSchedule(scSearchVO);
		
		return schedules;
	}
	
	@Override
	public List<ScheduleVO> retrieveScheduleAll(ScheduleSearchVO scSearchVO) {
		List<EmployeeVO> empList = scDAO.workEmpList();
		scSearchVO.setEmpList(empList);

		List<ScheduleVO> schedules = scDAO.allWorkSchedule(scSearchVO);
		
		return schedules;
	}
	
	@Override
	public List<ScheduleVO> retrieveHoliScheduleAll(ScheduleSearchVO scSearchVO) {
		List<EmployeeVO> empList = scDAO.workEmpList();
		scSearchVO.setEmpList(empList);

		List<ScheduleVO> schedules = scDAO.allHoliSchedule(scSearchVO);
		
		return schedules;
	}

	

	@Override
	public List<ScheduleVO> retrieveScheduleMonth_batch(ScheduleBatchVO scBatchVO) {
		
		if(scBatchVO.getInputMonth() == null) {
			Date today = new Date();
			scBatchVO.makeSearchMonth(today);
		}else {
			scBatchVO.makeSearchMonth(scBatchVO.getInputMonth());
		}
		List<ScheduleVO> schedules = scDAO.monthSchedule_Batch(scBatchVO);
		
		return schedules;
	}

	@Override
	public ServiceResult createBatchWork(ScheduleBatchVO scbatchVO) {
		int rowcnt = scDAO.insertBatchWork(scbatchVO);
		ServiceResult result = ServiceResult.FAIL;
		if(rowcnt > 0) result = ServiceResult.OK;
		
		return result;
	}

	@Override
	public List<ScheduleVO> retrieveHoli_empId(String empId) {
		
		return scDAO.holiday_Batch(empId);
	}

	@Override
	public ServiceResult createBatchHoli(ScheduleBatchVO scbatchVO) {
		int rowcnt = scDAO.insertBatchHoli(scbatchVO);
		ServiceResult result = ServiceResult.FAIL;
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}


	@Override
	public ServiceResult modifyHolidayStateC(HoliVO holiVO) {
		int rowcnt = scDAO.updateHolidayState(holiVO);
		if(rowcnt > 0) {
			return  ServiceResult.OK;
		}
		return ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyHolidayStateN(HoliVO holiVO) {
		int rowcnt = scDAO.updateHolidayState(holiVO);
		if(rowcnt > 0) {
			return  ServiceResult.OK;
		}
		return ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyHolidayStateY(HoliVO holiVO) {
		ServiceResult result = ServiceResult.FAIL;
		int rowcnt = scDAO.updateHolidayState(holiVO);
		if(rowcnt > 0) {
			String tmpSort = holiVO.getScSort();
			if(!tmpSort.equals("full")) {
				holiVO.setScheduleLength(rowcnt/2.0f);				
			}else {
				holiVO.setScheduleLength(rowcnt);								
			}
			List<HoliVO> holiList = scDAO.selectHolidayByHoliId(holiVO.getHoliId());
			
			int scheduleCnt = scDAO.insertBatchHoliForSchedule(holiList);
			if(scheduleCnt > 0) {
				String empId = scDAO.getEmpIdByHoliId(holiVO.getHoliId());
				holiVO.setEmpId(empId);
				scDAO.minusEmpHoli(holiVO);
				result = ServiceResult.OK;
			}
		}
		return result;
	}




	


}
