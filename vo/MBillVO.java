package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of="billNo")
public class MBillVO implements Comparable<MBillVO> {
	public MBillVO(String feeNo, List<HouseVO> houseList) {
		super();
		this.feeNo = feeNo;
		this.houseList = houseList;
	}
	
	public MBillVO(String feeNo, HouseVO houseVO,List<FeecodeVO> fCodeList) {
		super();
		this.feeNo = feeNo;
		this.payerNo = houseVO.getPayerNo();
		this.fCodeList = fCodeList;
		
	}
	
	@NotBlank
	private String billNo;
	private String billDline;
	private String billPaydate;
	private Integer billPaysum;
	private Integer billSum;
	private Integer billOversum;
	private Integer billDebt;
	private String billOday;
	private Integer billRatio;
	private String billState;
	private String billYm;
	@NotBlank
	private long payerNo;
	@NotBlank
	private String feeNo;
	
	
	public List<MBillVO> getsetBillList(String feeNo, List<HouseVO> houseList,List<FeecodeVO> fCodeList) {
		this.billList=new ArrayList<>();
		for(HouseVO houseVO:houseList) {
			MBillVO bilVO =new MBillVO(feeNo,houseVO,fCodeList);
			this.billList.add(bilVO);
		}
		return billList;
	}
	private List<MBillDetailVO> btailList;
	private List<MBillVO> billList;
	private List<HouseVO> houseList;
	private List<FeecodeVO> fCodeList;
	
	//전월 고지서
	private MBillVO preMonth;
	
	//에너지 사용요금 리스트
	private Integer energyFee;


	@Override
	public int compareTo(MBillVO o) {
		return billNo.compareTo(o.getBillNo());
	}
}
