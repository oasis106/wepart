package kr.or.ddit.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of= {"fcode", "billNo"})
public class MBillDetailVO {
	public MBillDetailVO(MBillVO billVO) {
		super();
		this.billVO = billVO;
		this.billNo=billVO.getBillNo();
		this.feeNo=billVO.getFeeNo();
	}
	@NotBlank
	private Integer fcode;
	@NotBlank
	private String billNo;
	private Integer btailPrice;
	private Integer btailTax;
	private Integer btailSum;
	private String billYm;
	private String use;
	private String unitPrice;
	
	private String feeNo;
	private HouseVO houseVO;
	private MBillVO billVO;
	private List<FeecodeVO> fCodeList;
	
	private String fname;
}
