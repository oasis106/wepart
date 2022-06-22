package kr.or.ddit.bill.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import kr.or.ddit.vo.MBillDetailVO;
import kr.or.ddit.vo.MBillVO;

public class MBillDetailDAOImpl implements MBillDetailDAO{

	private SqlSessionFactory sqlSessionFactory = CustomSqlSessionFactoryBuilder.getSqlSessionFactory();
	
	@Override
	public int insertMBillDetail(MBillDetailVO billDetailVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertAllMBillDetail(MBillVO bill) {
		try(
			SqlSession sqlSession = sqlSessionFactory.openSession();				
		){
			MBillDetailDAO mapper = sqlSession.getMapper(MBillDetailDAO.class);
			int rowcnt = mapper.insertAllMBillDetail(bill);
			sqlSession.commit();
			return rowcnt;			
		}
	}
	
}
