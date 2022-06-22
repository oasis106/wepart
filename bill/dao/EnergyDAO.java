package kr.or.ddit.bill.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EnergyMBDetailVO;
import kr.or.ddit.vo.EnergyReadVO;
import kr.or.ddit.vo.EnergySearchVO;
import kr.or.ddit.vo.MBillDetailVO;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.ReadVO;

@Mapper
public interface EnergyDAO {
	
	/**
	 * 로그인한 회원의 모든 고지서 년월정보를 가지고온다.
	 * @param payerNo
	 * @return
	 */
	public List<EnergySearchVO> allBillSearchList(long payerNo);
	/**
	 * 로그인한 회원의 해당월 에너지 사용량(전기, 수도, 가스, 난방)
	 * @param esVO
	 * @return
	 */
	public List<EnergyReadVO> myUsageWithMonth(EnergySearchVO esVO);
	
	/**
	 * 로그인한 회원의 최근 1년간,월별 에너지별 사용요금(전기, 수도, 가스, 난방)
	 * @param esVO
	 * @return
	 */
	public List<MBillVO> myFeeListForYear(EnergySearchVO esVO);
	
	public List<EnergyMBDetailVO> myFeeListForMonth(EnergySearchVO esVO);
	
	public List<EnergyMBDetailVO> myFeeList_LastYear(EnergySearchVO esVO);
	
	/**
	 * 로그인한 회원과 동일한 면적에 거주하는 세대들의 평균 에너지 사용량
	 * @param esVO
	 * @return
	 */
	public List<EnergyReadVO> usageAVGMonth(EnergySearchVO esVO);
	
	/**
	 * 로그인한 회원과 동일한 면적에 거주하는 세대들의 최근1년간, 월별 평균 에너지별 사용요금(전기, 수도, 가스, 난방)
	 * @param esVO
	 * @param esVO
	 * @return
	 */
	public List<MBillVO> feeAVGForYear(EnergySearchVO esVO);
	
	public List<EnergyMBDetailVO> feeAVGForMonth(EnergySearchVO esVO);
	

	
}
