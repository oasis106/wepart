package kr.or.ddit.pm.employee.service;

import java.util.List;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.EmployeeVO;

public interface EmpService {
	/**
	 * 재직중인 직원의 목록
	 * @return
	 */
	public List<EmployeeVO> selectEmpList();
	
	/**
	 * 등록할 직원의 정보를 담은 VO
	 * @param empVO
	 * @return OK : 성공, FAIL : 실패, PKDUPLICATED : PK 중복
	 */
	public ServiceResult insertEmp(EmployeeVO empVO);
	
	/**
	 * 수정할 직원의 정보를 담은 VO
	 * @param empVO
	 * @return OK : 성공, FAIL : 실패
	 */
	public ServiceResult modifyEmp(EmployeeVO empVO);
	
	/**
	 * 삭제할 직원의 정보를 담은 VO
	 * @param empVO
	 * @return OK : 성공, FAIL : 실패, NOTEXIST : 존재하지 않는 계정
	 */
	public ServiceResult removeEmp(EmployeeVO empVO);
	
	/**
	 * id에 해당하는 직원 검색.
	 * @param empId
	 * @return 직원 1명
	 */
	public EmployeeVO selectEmp(String empId);
	
	
}
