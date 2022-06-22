package kr.or.ddit.bill.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.vo.BillSearchVO;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.detailAVGVO;

public class MBillDAOImpl implements MBillDAO {
	
	private SqlSessionFactory sqlSessionFactory = CustomSqlSessionFactoryBuilder.getSqlSessionFactory();
	

	@Override
	public int insertMBill(MBillVO billVO) {
		try(
			SqlSession sqlSession = sqlSessionFactory.openSession();				
		){
			MBillDAO mapper = sqlSession.getMapper(MBillDAO.class);
			int rowcnt = mapper.insertMBill(billVO);
			sqlSession.commit();
			return rowcnt;			
		}
	}

	@Override
	public String recentMBill(long payerNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MBillVO> selectMBillList(long payerNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MBillVO selectMBillByMonth(BillSearchVO bsVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MBillVO selectMBillDetail(String billNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MBillVO> totalAreaAVG(BillSearchVO bsVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int houseArea(long payerNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Integer> detailByHouse(BillSearchVO bsVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<detailAVGVO> detailAVGByArea(BillSearchVO bsVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MBillVO> selectMBillListOneYear(BillSearchVO bsVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateBillPayDate(MBillVO mbillVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MBillVO> payCompleteList(long payerNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
