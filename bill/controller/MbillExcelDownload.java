package kr.or.ddit.bill.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.bill.dao.MBillDAO;
import kr.or.ddit.security.MemberVOWrapper;
import kr.or.ddit.vo.BillSearchVO;
import kr.or.ddit.vo.MBillDetailVO;
import kr.or.ddit.vo.MBillVO;
import kr.or.ddit.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MbillExcelDownload {
	
	@Inject
	private MBillDAO mbDAO;
	
	@RequestMapping("/mbillExcelDownload")
	public String excelDownload(
		Model model
		, String month
		, Authentication authentication
	) {
		MemberVO auth = ((MemberVOWrapper) authentication.getPrincipal()).getRealUser();
		BillSearchVO bsVO = new BillSearchVO();
		bsVO.setPayerNo(auth.getPayerNo());
		bsVO.setMonth(month);
		MBillVO monthBill = mbDAO.selectMBillByMonth(bsVO);
		log.info("고지서::::::::{}",monthBill);
		List<MBillDetailVO> btailList = monthBill.getBtailList();
		
		// 여기서 엑셀파일을 생성해서, 모델에 담아줘야함.
		Workbook wb = new HSSFWorkbook();
		Sheet sheet1 = wb.createSheet(month);
		
		//Workbook wb = new XSSFWorkbook();
		CreationHelper createHelper = wb.getCreationHelper();
		int rowCnt = 0;
		
		CellStyle headStyle = wb.createCellStyle();
		headStyle.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		
		// 헤더만들기
		Row header = sheet1.createRow(rowCnt++);
		Cell cell = null;
		cell = header.createCell(1);
		cell.setCellValue("항목");
		cell.setCellStyle(headStyle);
		cell = header.createCell(2);
		cell.setCellValue("금액");
		cell.setCellStyle(headStyle);
		
		
		CellStyle columnCenter = wb.createCellStyle();
		columnCenter.setAlignment(HorizontalAlignment.CENTER);
		
		CellStyle columnRight = wb.createCellStyle();
		columnRight.setAlignment(HorizontalAlignment.RIGHT);
		for(MBillDetailVO detail : btailList) {
			Row row = sheet1.createRow(rowCnt++);
			cell = row.createCell(1);
			cell.setCellValue(detail.getFname());
			cell.setCellStyle(columnCenter);
			
			cell = row.createCell(2);
			cell.setCellValue(detail.getBtailSum());
			cell.setCellStyle(columnRight);
		}
		
		//푸터 만들기
		header = sheet1.createRow(rowCnt++);
		cell = header.createCell(1);
		cell.setCellValue("합계");
		cell.setCellStyle(headStyle);
		cell = header.createCell(2);
		cell.setCellValue(monthBill.getBillSum());
		cell.setCellStyle(headStyle);
		
		model.addAttribute("submitFile", wb);
		model.addAttribute("month", month);
		
		return "downloadExcel";
	}
	
}
