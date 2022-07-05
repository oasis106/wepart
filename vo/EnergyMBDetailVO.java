package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@EqualsAndHashCode(of= {"fcode", "billNo"})
public class EnergyMBDetailVO {
	private Integer fcode;
	private Integer btailSum;
	private String billNo;
}
