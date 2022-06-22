package kr.or.ddit.fileupload.view;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadExcel extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model
			, HttpServletRequest req, HttpServletResponse resp)
			throws Exception {
		Workbook submitFile = (Workbook) model.get("submitFile");

		String month = (String) model.get("month");
		String fileName = month + ".xls";	
		fileName = URLEncoder.encode(fileName, "UTF-8");
		fileName = fileName.replace("+", " ");
		resp.setContentType("application/vnd.ms-excel");
		resp.setHeader("Content-Disposition", "attatchment;filename=\"" + fileName + "\"");

		try(
			// writer는 문자열을 출력할 때 쓰는거고, outputStream은 byte로 출력할때 사용한다.
			OutputStream os = resp.getOutputStream();
		){
			submitFile.write(os);
			return ;
		}
	}
	
}
