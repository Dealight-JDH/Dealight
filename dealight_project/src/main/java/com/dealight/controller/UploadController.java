package com.dealight.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dealight.domain.StoreImgVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	// ������ ������ ��θ� �����Ѵ�.
	final static private String ROOT_FOLDER = "C:\\Users\\kjuio\\Desktop\\ex05\\";
	
	
	// ���� �ٸ� ��ο� ������ �����ϰ�, ������ �����Ѵ�.
	// ������ ��¥�� ������ ���� file path �����. root_folder / yyyy / mm / dd / 
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-",File.separator);
	}
	
	// �ش� ������ �̹��� �������� �ƴ����� �����Ѵ�.
	private boolean checkImageType(File file) {
		try {
			
			// probe content type�� �ش� ������ Ÿ���� ��ȯ�Ѵ�.
			String contentType = Files.probeContentType(file.toPath());
			
			//  omage�� �����ϴ����� Ȯ���ϰ� ������ true�� ��ȯ�Ѵ�.
			return contentType.startsWith("image");
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// �������, �޴��� �����ؼ� �޾ƾ��� ��.
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = ROOT_FOLDER;
		
		// uploadFile��  multipartFile�� �ɰ��� ó���Ѵ�.
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------------------------");
			
			// ���ε�� ������ ������
			log.info("Upload File Name : " + multipartFile
					.getOriginalFilename());
			
			// ���ε�� ������ ũ��
			log.info("Upload File Size : " + multipartFile.getSize());
			
			// path�� ��� + ���ϸ����� �����ȴ� (ex: c:\\user\\a.jpg)
			// ���
			File saveFile = new File(uploadFolder, multipartFile
					.getOriginalFilename());
			
			try {
				
				// �ش� ������ �����Ѵ�.
				multipartFile.transferTo(saveFile);
			} catch (Exception e ) {
				log.error(e.getMessage());
			}
		}
		
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		
		log.info("upload ajax");
		
	}
	
	// ȭ�鿡�� input file���� image�� upload�ϸ� ����ҿ� ������ �ȴ�.
	// ������ DB�� �ٷ� ������ ������ �ʴ´�.
	// ����� �̹��� ��ü�� ����Ʈ�� ��ȯ�Ѵ�.
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreImgVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		// �̹��� ����� ��ȯ �޴´�.
		List<StoreImgVO> list = new ArrayList<>();
		
		log.info("upload store img post................");
		
		String uploadFolder = ROOT_FOLDER;
		
		// �ش� ��¥�� ���� ��θ� �����´�.
		String uploadFolderPath = getFolder();
		// make folder -----------------
		// File(���,���)�� ��ο� ��θ� �����ִ� ������ �Ѵ�.
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		log.info("upload path : " + uploadPath);
		
		// �ش� ��ΰ� ������, �����.
		// make yyyy/MM/dd folder
		if(uploadPath.exists() == false) {
			log.info("maker dir....");
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			// DB�� �־��ֱ� ���� ��ü�� �������ش�.
			StoreImgVO storeImg = new StoreImgVO();
			
			log.info("------------------------------------");
			
			log.info("Upload File Name : " + multipartFile
					.getOriginalFilename());
			
			log.info("Upload File Size : " + multipartFile.getSize());
			
			// ���� �̸��� �����´�.
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName
					.lastIndexOf("\\") + 1);
			
			log.info("only file name : " + uploadFileName);
			
			// ������ ���� �̸��� �������ش�.
			storeImg.setFileName(uploadFileName);
			
			// ������ �����̸��� ������ֱ� ���ؼ� uuid�� ������ش�.
			UUID uuid = UUID.randomUUID();
			
			// �����̸��� uuid + _�� �����ش�.
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			try {
				//File saveFile = new File(uploadFolder, uploadFileName);
				
				// ����� ��ο� �̸�(UUID�� ������)�� file�� �����Ѵ�.
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				// uuid�� ���� �����Ѵ�.
				storeImg.setUuid(uuid.toString());
				
				// ��ε� ���� �������ش�.
				storeImg.setUploadPath(uploadFolderPath);
				
				// check image type file
				if(checkImageType(saveFile)) {
					
					// �̹����� �´����� �������ش�.
					storeImg.setImage(true);
					
					// ����ڿ��� ������ ������� �����Ѵ�. 
					// ��δ� �Ȱ���, ���ϸ� �տ��� "s_"�� �ٿ��ش�.
					// �ƿ�ǲ��Ʈ��(����?)�� �ش� �����͸� ��Ƶд�.
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					// ����� �����簡 ������� ������ش�.
					// multipartfile�� inputstream���� ���Ƶ帮�� ������ width, height�� �ȼ������� ���� thumbnail�� �״�� �������ش�.
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100,100);
					
					// �ƿ�ǲ ��Ʈ���� �ݾ��ش�.
					thumbnail.close();
				}
				
				// add to list
				list.add(storeImg);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			} // end catCH
		} // end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	// ����� ������ ȭ�鿡 �����ش�.
	// byte[]�� ��ȯ�Ѵ�.
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		log.info("fileName : " + fileName);
		
		File file = new File(ROOT_FOLDER + fileName);
		
		log.info("file: " + file);
		
		// ȭ�鿡�� byte�� ���ش�.
		ResponseEntity<byte[]> result = null;
		
		try {
			
			// ��ȯ�� http�� ����� �ۼ��Ѵ�.
			HttpHeaders header = new HttpHeaders();
			// header �̸� : ��� value
			// Content-Type : img..  
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			// file�� �����ؼ� byte array�� ��ȯ�ϰ� ��ȯ���ش�.
			// header�� ���� ��� ���¸� ��ȯ�Ѵ�.
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// �ٿ�ε带 �� �� �ִ� ����� �����Ѵ�.
	// OCTET�� 8���� ��Ʈ�� �ѵ� ���� ���� ���Ѵ�. 1byte�� �� 8��Ʈ�� �ǹ������� �����Ƿ� �̷��� �� ����Ѵ�.
	// �ش� ��Ȳ������ byte stream�� �����ϴ� type���� ������شٰ� �����ϸ� �ȴ�.
	
	@GetMapping(value ="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		
		log.info("downlad file: " + fileName);
		
		// �ش� ��ο� �����̸�(uuid����)�� ���� ��� ���� ��θ� �����´�.
		Resource resource = new FileSystemResource(ROOT_FOLDER + fileName);
		
		log.info("resource : " + resource);

		// �ش��ϴ� ������ ������ ���� �������� ��ȯ�Ѵ�.
		/*
		if(resource.exists() == false) {
			log.info("false..............");
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		*/
		// ���ҽ� ���ϸ�(uuid ����)�� �����Ѵ�.
		String resourceName = resource.getFilename();
		
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.lastIndexOf("_") + 1);
		
		log.info("resourceOriginalName : " + resourceOriginalName);
		
		log.info("resource : " + resourceName);
		
		// ����� ������ش�.
		HttpHeaders headers = new HttpHeaders();
		
		log.info("headers : " + headers);
		
		try {
			
			String downloadName = null;
			
			// ���� ������ ������ ���� downloadName�� �����Ѵ�.
			if(userAgent.contains("Trident")) {
				
				log.info("IE browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replace("\\+", " ");
				
				log.info("IE name : " + downloadName);
				
			} else  if(userAgent.contains("Edge")){
				
				log.info("Edge browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");
				
				log.info("Edge name : " + downloadName);
				
			} else {
				
				log.info("Chrome browser");
				
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
			}

			// �ٿ�ε�� ����Ǵ� �̸��� ����
			// �ٿ�ε�� ����Ǵ� �̸��� ��ġ�� ���� ���� ����
			headers.add("Content-Disposition", "attachment; filename="+ downloadName);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	
	// ������ �����Ѵ�.
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		
		log.info("deleteFile : " + fileName);
		
		File file;
		
		try {
			file = new File(ROOT_FOLDER + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			// �̹��� ������ ��� �������ϵ� ���� �������ش�.
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName);
				
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}

}