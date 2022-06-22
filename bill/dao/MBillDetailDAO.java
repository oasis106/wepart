package kr.or.ddit.bill.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.MBillDetailVO;
import kr.or.ddit.vo.MBillVO;

@Mapper
public interface MBillDetailDAO {
	
	public int insertMBillDetail(MBillDetailVO billDetailVO);
	
	public int insertAllMBillDetail(MBillVO bill);
}
