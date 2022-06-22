package kr.or.ddit.fileupload.view;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadViewCK extends AbstractView {

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse resp) throws Exception {
		File saveFile = (File) model.get("saveFile");
		if(!saveFile.exists()) {
			//404: Not Found
			resp.sendError(404, saveFile.getName()+"에 해당하는 파일이 없음.");
			return ;
		}
		String fileName = "downloadFile";
		fileName = URLEncoder.encode(fileName, "UTF-8");
		fileName = fileName.replace("+", " ");
		resp.setHeader("Content-Disposition", "attatchment;filename=\"" + fileName + "\"");
		resp.setHeader("Content-Length", saveFile.length()+"");
		try(
			// writer는 문자열을 출력할 때 쓰는거고, outputStream은 byte로 출력할때 사용한다.
			OutputStream os = resp.getOutputStream();
		){
			FileUtils.copyFile(saveFile, os);
			return ;
		}

	}
	
}
