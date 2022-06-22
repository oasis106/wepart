package kr.or.ddit.bill.service;

import kr.or.ddit.enumpkg.ServiceResult;
import kr.or.ddit.vo.MBillVO;

public interface MBillService {

	public ServiceResult modifyBillPaydate(MBillVO mbillVO);
	
}
