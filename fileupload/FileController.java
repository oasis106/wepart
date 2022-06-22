package kr.or.ddit.fileupload;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.vo.MBillVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FileController {
	private String saveFolderPath = "C:\\saveFolder";
	
	@RequestMapping(value="/12/fileUpload_Framework.do", method=RequestMethod.POST)
	public String fileUpload(
		@RequestParam("uploader") String uploader
		, @RequestPart MultipartFile uploadFile
		, RedirectAttributes redirectAttributes
		, HttpSession session 
	) throws IOException {
//		uploader, uploadFile
		redirectAttributes.addFlashAttribute("uploader", uploader);
		Map<String, Object> fileMetaData = fileUpload(uploadFile);
		log.info("file meta data : {}", fileMetaData);
		session.setAttribute("uploadFile", fileMetaData);
		return "redirect:/12/fileUploadForm.jsp";
	}
	
	
	@RequestMapping("/12/fileDownload.do")
	public String fileDownload(
		@RequestParam("file") String file
		, @RequestParam("attNo") int attNo
		, Model model
	){
		File saveFolder = new File(saveFolderPath);
		File saveFile = new File(saveFolder, file);
		model.addAttribute("saveFile", saveFile);
		model.addAttribute("attNo", attNo);
//		log.info("일단 여기까지온 ::::::::::::::::::::::::::::{}", file);
		return "downloadView";
	}
	
	@RequestMapping("/12/fileDownloadCK")
	public String fileDownloadCK(@RequestParam("file") String file
			, Model model) {
		
		
		log.info("다운로드 경로 : {}", saveFolderPath);
		// 클라이언트가 이용하는 거임 다운로드는.
		// 그래서 다운받는 경로를 설정하는 게 아니라, 파라미터로 받은 String타입의 file 변수(UID가 담겨있음) 값을, 지정된 경로 saveFolder에서 찾아서,
		// 사용자가 원래 파일명(확장자 포함)으로 바꿔서 다운받는 구조.
		// UID인 파일을 가져와서, 원래 그 파일명으로 바꾸면, 그대로 사용가능함.
		File saveFolder = new File(saveFolderPath);
		log.info("저장경로::::::::{}", saveFolder);
		File saveFile = new File(saveFolder, file);
		log.info("저장명:::::::{}", saveFile);
		model.addAttribute("saveFile", saveFile);
		
		return "downloadViewCK";
	}
	
	private Map<String, Object> fileUpload(MultipartFile uploadFilePart) throws IOException {
		Map<String, Object> metaData = new HashMap<>();
		String originalFilename = uploadFilePart.getOriginalFilename();
		File saveFolder = new File(saveFolderPath);
		String saveName = UUID.randomUUID().toString();
		File saveFile = new File(saveFolder, saveName);
		long fileSize = uploadFilePart.getSize();
		String fileMime = uploadFilePart.getContentType();
		metaData.put("originalFilename", originalFilename);
		metaData.put("saveName", saveName);
		metaData.put("fileSize", fileSize);
		metaData.put("fileMime", fileMime);
		
		uploadFilePart.transferTo(saveFile);
		
		return metaData;
	}
}














