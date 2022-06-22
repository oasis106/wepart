package kr.or.ddit.bill.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BillSearchVO;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.detailAVGVO;

@Mapper
public interface MBillDAO {
	
	
	public int insertMBill(MBillVO billVO);
	
	public String recentMBill(long payerNo);
	
	public List<MBillVO> selectMBillList(long payerNo);
	
	public List<MBillVO> selectMBillListOneYear(BillSearchVO bsVO);
	
	public MBillVO selectMBillByMonth(BillSearchVO bsVO);
	
	public MBillVO selectMBillDetail(String billNo);
	
	public List<MBillVO> totalAreaAVG(BillSearchVO bsVO);
	
	public int houseArea(long payerNo);
	
	public List<Integer> detailByHouse(BillSearchVO bsVO);
	
	public List<detailAVGVO> detailAVGByArea(BillSearchVO bsVO);
	
	public int updateBillPayDate(MBillVO mbillVO);
	
	public List<MBillVO> payCompleteList(long payerNo);
	
}
