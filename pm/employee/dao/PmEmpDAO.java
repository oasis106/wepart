package kr.or.ddit.pm.employee.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.security.RolesVO;

@Mapper
public interface PmEmpDAO {
	
	/**
	 * 재직중인 직원의 목록
	 * @return
	 */
	public List<EmployeeVO> selectEmpList();
	
	/**
	 * 검색조건을 받아서, 재직자 혹은 퇴직자의 목록을 가져옴
	 * @return
	 */
	public List<EmployeeVO> selectEmpListWithCategory(String empCategory);
	
	public List<RolesVO> selectRolesList();
	/**
	 * id에 해당하는 직원 검색 
	 * @param empId
	 * @return 직원 1명
	 */
	public EmployeeVO selectEmp(String empId);
	
	/**
	 * 등록할 직원의 정보를 담은 VO
	 * @param empVO
	 * @return 0보다 큰값이면 등록 성공
	 */
	public int insertEmp(EmployeeVO empVO);
	
	public int updateEmp(EmployeeVO empVO);
	
	public int deleteEmp(EmployeeVO empVO);
}
