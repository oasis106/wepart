package kr.or.ddit.pm.employee.service;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.pm.employee.dao.PmEmpDAO;
import kr.or.ddit.vo.EmployeeVO;

@Service
public class EmpServiceImpl implements EmpService {
	
	@Inject
	private PmEmpDAO empDAO;
	
	@Resource(name="authenticationManager")
	private AuthenticationManager authenticationManager;
	
	@Inject
	private PasswordEncoder passwordEncoder;
	
	@Override
	public List<EmployeeVO> selectEmpList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ServiceResult insertEmp(EmployeeVO empVO) {
		ServiceResult result = null;
		EmployeeVO idCheck = selectEmp(empVO.getEmpId());
//		authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(empVO.getEmpId(), empVO.getEmpPass()));
		if(idCheck != null) {
			result = ServiceResult.PKDUPLICATED;
		}else {
			String encoded = passwordEncoder.encode(empVO.getEmpPass());
			empVO.setEmpPass(encoded);
			int rowcnt = empDAO.insertEmp(empVO);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;

		}
		return result;
	}

	@Override
	public EmployeeVO selectEmp(String empId) {
		
		return empDAO.selectEmp(empId);
	}

	@Override
	public ServiceResult modifyEmp(EmployeeVO empVO) {
		ServiceResult result = null;
		if(StringUtils.isNotBlank(empVO.getEmpPass())) {
			String encoded = passwordEncoder.encode(empVO.getEmpPass());
			empVO.setEmpPass(encoded);
		}
		int rowcnt = empDAO.updateEmp(empVO);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		
		return result;
	}

	@Override
	public ServiceResult removeEmp(EmployeeVO empVO) {
		ServiceResult result = null;
		EmployeeVO idCheck = selectEmp(empVO.getEmpId());
		if(idCheck == null) {
			result = ServiceResult.NOTEXIST;
		}else {
			int rowcnt = empDAO.deleteEmp(empVO);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		}
		return result;
	}

}
