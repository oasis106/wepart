package kr.or.ddit.vo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@EqualsAndHashCode(of="attNo")
@ToString(exclude="adaptee")
@NoArgsConstructor
public class AttatchVO {
	private MultipartFile adaptee;
	public AttatchVO(MultipartFile adaptee) {
		super();
		this.adaptee = adaptee;
		this.attFilename = adaptee.getOriginalFilename();
		this.attSavename = UUID.randomUUID().toString();
		this.attMime = adaptee.getContentType();
		this.attSize = adaptee.getSize();
		this.attFancy = FileUtils.byteCountToDisplaySize(attSize);
	}
	
	@NotNull
	private Integer attNo;
	private String boNo;
	@NotBlank
	private String attFilename;
	@NotBlank
	private String attSavename;
	private String attMime;
	@NotNull
	private Long attSize;
	@NotBlank
	private String attFancy;
	private Integer attDownload;
	
	public void saveTo(File saveFolder) throws IOException{
		if(adaptee==null || adaptee.isEmpty()) return;
		adaptee.transferTo(new File(saveFolder, attSavename));
	}
}











