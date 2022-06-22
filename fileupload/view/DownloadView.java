package kr.or.ddit.fileupload.view;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.attatch.dao.AttatchDAO;
import kr.or.ddit.vo.AttatchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class DownloadView extends AbstractView {
	
	@Inject
	private AttatchDAO dao;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model
			, HttpServletRequest request,
			HttpServletResponse resp) throws Exception {
		
		log.info("여기왔음==================================1");
		File saveFile = (File) model.get("saveFile");
		log.info("세이브파일:::::::::::::::::{}", saveFile);
		if(!saveFile.exists()) {
			resp.sendError(404, saveFile.getName()+"에 해당하는 파일이 없음.");
			return;
		}
		int attNo = (int) model.get("attNo");
		AttatchVO attatch = dao.selectAttach(attNo);
		
		String fileName = (String) attatch.getAttFilename();
		fileName = URLEncoder.encode(fileName, "UTF-8");
		fileName = fileName.replace("+", " ");
		resp.setHeader("Content-Disposition", "attatchment;filename=\""+fileName+"\"");
		resp.setHeader("Content-Length", saveFile.length()+"");
		try(
			OutputStream os = resp.getOutputStream();	
		){
			FileUtils.copyFile(saveFile, os);
			return;
		}
	}

}
