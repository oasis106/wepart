package kr.or.ddit.pm.workSchedule.controller;

import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.pm.workSchedule.dao.ScheduleDAO;
import kr.or.ddit.vo.PmEmpVO;
import kr.or.ddit.vo.ScheduleSearchVO;
import kr.or.ddit.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/workSchedule/excel")
public class WsExcelDownload {
	
	@Inject
	private ScheduleDAO scDAO;
	
	@PostMapping
	public String excelDownload(
		Model model
  		, HttpServletRequest request
        , HttpServletResponse response
        , ScheduleSearchVO scSearchVO
	) {
		log.info("출력하는 월:::::::{}", scSearchVO);
		scSearchVO.makeSearchMonth(scSearchVO.getInputMonth());
		List<PmEmpVO> scList = scDAO.monthScheduleForExcel(scSearchVO);
		Calendar cal = Calendar.getInstance();
		cal.setTime(scSearchVO.getInputMonth());
		cal.set(Calendar.DAY_OF_MONTH,1);
		log.info("캘린더::::::{}", cal);
		log.info("1일 요일::::::{}", cal.get(Calendar.DAY_OF_WEEK));
		log.info("마지막날::::::{}", cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		int oneday = cal.get(Calendar.DAY_OF_WEEK); // 일:1, 월:2, 화:3 ,... 요일을 1~7의 숫자로 나타냄.
		int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH); //30일인지, 31일인지 28일인지 나타냄.
		
		// 여기서 엑셀파일을 생성해서, 모델에 담아줘야함.
		Workbook wb = new HSSFWorkbook();
		Sheet sheet1 = wb.createSheet("근무일정");
		
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
		cell.setCellValue("사원번호");
		cell.setCellStyle(headStyle);
		cell = header.createCell(2);
		cell.setCellValue("직원명");
		cell.setCellStyle(headStyle);
		cell = header.createCell(3);
		cell.setCellValue("직무");
		cell.setCellStyle(headStyle);
		cell = header.createCell(4);
		cell.setCellValue("시작/종료");
		cell.setCellStyle(headStyle);
		int dayNumber = 5;
		oneday--;
		for(int i=1; i<=lastday; i++) {
//			(oneday % 7) + 1 ==> 1~7이 나옴. 단, 원래 4가 수요일이지만, 3이 수요일이 되어야함.
			cell = header.createCell(dayNumber);
			switch((oneday % 7) + 1) {
			case 1:
				cell.setCellValue(i + "/" + "일");
				break;
			case 2:
				cell.setCellValue(i + "/" + "월");
				break;
			case 3:
				cell.setCellValue(i + "/" + "화");
				break;
			case 4:
				cell.setCellValue(i + "/" + "수");
				break;
			case 5:
				cell.setCellValue(i + "/" + "목");
				break;
			case 6:
				cell.setCellValue(i + "/" + "금");
				break;
			case 7:
				cell.setCellValue(i + "/" + "토");
				break;
			}
			cell.setCellStyle(headStyle);
			oneday++;
			dayNumber++;

		}
		
		
		CellStyle columnCenter = wb.createCellStyle();
		columnCenter.setAlignment(HorizontalAlignment.CENTER);
		
		CellStyle columnRight = wb.createCellStyle();
		columnRight.setAlignment(HorizontalAlignment.RIGHT);
		
		
		for(PmEmpVO emp : scList) {
			for(ScheduleVO eachSchedule : emp.getScheduleList()) {
//				log.info("근무일정::::::::{}", eachSchedule);
				
			}
			Row row = sheet1.createRow(rowCnt++);
			cell = row.createCell(1);
			cell.setCellValue(emp.getEmpNo());
			cell.setCellStyle(columnCenter);
			
			cell = row.createCell(2);
			cell.setCellValue(emp.getEmpName());
			cell.setCellStyle(columnCenter);
			
			cell = row.createCell(3);
			cell.setCellValue(emp.getEmpDep());
			cell.setCellStyle(columnCenter);
		}
		
		model.addAttribute("submitFile", wb);
		model.addAttribute("month", scSearchVO.getSearchMonth());
		
		
		return "downloadExcel";
	}
	
}
