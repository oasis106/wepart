package kr.or.ddit.bill.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.bill.dao.MBillDAO;
import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MBillVO;

@Service
public class MBillServiceImpl implements MBillService {
	
	@Inject
	private MBillDAO mbDAO;
	
	@Override
	public ServiceResult modifyBillPaydate(MBillVO mbillVO) {
		int rowcnt = mbDAO.updateBillPayDate(mbillVO);
		ServiceResult result = null;
		if(rowcnt > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAIL;
		}
		
		return result;
	}

}
