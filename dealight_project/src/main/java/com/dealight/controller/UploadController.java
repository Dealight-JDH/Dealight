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

import com.dealight.domain.AttachFileDTO;
import com.dealight.domain.StoreImgVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

/*
 * 
 *****[김동인] [이현중] 
 * 
 */

@Controller
@Log4j
public class UploadController {

	
	// 파일 경로
	//final static private String ROOT_FOLDER = "C://dealgiht//rds//";
	//final static private String ROOT_FOLDER = "/Users/hyeonjung/Desktop/RDS/";
	private final static String ROOT_FOLDER = "/Users/limjongwoo/upload/dealight/";
	//private final static String ROOT_FOLDER = "/home/ec2-user/Dealight_imgs/upload/dealight/";
	//add param category
	private String getFolder(String category) {

		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = category + "-" + sdf.format(date);
		
		return str.replace("-",File.separator);
	}
	
	private boolean checkImageType(File file) {
		
		try {
			
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//현중----------
	
	@PostMapping(value = "/uploadImgAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<AttachFileDTO> uploadAjaxPost(MultipartFile uploadFile, String category){
		
		AttachFileDTO attachDTO = new AttachFileDTO();
		
		// category/yyyy/MM/dd
		String uploadFolderPath = getFolder(category);
		log.info("uploadFolderPath : "+uploadFolderPath);
		
		//파일경로를 생성한다. (rootfolder / category / yyyy / MM / dd )
		File uploadPath = new File(ROOT_FOLDER, uploadFolderPath);
 		log.info("upload path : " + uploadPath);
 		
 		//파일이름
		String uploadFileName = uploadFile.getOriginalFilename();
		log.info("Upload File Name : " + uploadFile.getOriginalFilename());
		log.info("Upload File Size : " + uploadFile.getSize());
		log.info("Category : " + category);
		
		//파일 경로가 존재하지 않으면 파일경로생성
		if(uploadPath.exists()==false) {
			log.info("uploadPaht mkdir.....");
			uploadPath.mkdirs();
		}
		
		//uuid 생성
		UUID uuid = UUID.randomUUID();
		//기존 파일이름에 uuid 적용
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		attachDTO.setFileName(uploadFileName);
		attachDTO.setUuid(uuid.toString());
		attachDTO.setUploadPath(uploadFolderPath);
		
		try {
			//저장경로 생성
			File saveFile = new File(uploadPath, uploadFileName);
			
			//읽어온 파일을 지정된경로의 파일로 복사한다.
			uploadFile.transferTo(saveFile);
			
			//이미지면 썸내일 생성
			if(checkImageType(saveFile)) {
				
				attachDTO.setImage(true);
				
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
				
				thumbnail.close();
			}
			
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	
		return new ResponseEntity<AttachFileDTO>(attachDTO, HttpStatus.OK);
	}
	
	
	//-------------
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = ROOT_FOLDER;
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------------------------");
			log.info("Upload File Name : " + multipartFile
					.getOriginalFilename());
			
			log.info("Upload File Size : " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile
					.getOriginalFilename());
			
			try {
				
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
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreImgVO>> uploadAjaxPost(MultipartFile[] uploadFile,String category) {
		List<StoreImgVO> list = new ArrayList<>();
		
		log.info("upload store img post................");
		
		String uploadFolder = ROOT_FOLDER;
		
		if(category == null) {
			category = "";
		}
		
		String uploadFolderPath = getFolder(category);
		//String uploadFolderPath = getFolder("brno");
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		log.info("upload path : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			log.info("maker dir....");
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			StoreImgVO storeImg = new StoreImgVO();
			
			log.info("------------------------------------");
			
			log.info("Upload File Name : " + multipartFile
					.getOriginalFilename());
			
			log.info("Upload File Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName
					.lastIndexOf("\\") + 1);
			
			log.info("only file name : " + uploadFileName);
			
			storeImg.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			try {
				//File saveFile = new File(uploadFolder, uploadFileName);
				
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				storeImg.setUuid(uuid.toString());
				
				storeImg.setUploadPath(uploadFolderPath);
				
				// check image type file
				if(checkImageType(saveFile)) {
					
					storeImg.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100,100);
					
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
	
	@PostMapping(value = "/uploadMenuAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreImgVO>> uploadMenuAjaxPost(MultipartFile[] uploadFile) {
		
		List<StoreImgVO> list = new ArrayList<>();
		
		log.info("upload store img post................");
		
		String uploadFolder = ROOT_FOLDER;
		
		String uploadFolderPath = getFolder("");
		//String uploadFolderPath = getFolder("brno");
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		log.info("upload path : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			log.info("maker dir....");
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			StoreImgVO storeImg = new StoreImgVO();
			
			log.info("------------------------------------");
			
			log.info("Upload File Name : " + multipartFile
					.getOriginalFilename());
			
			log.info("Upload File Size : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName
					.lastIndexOf("\\") + 1);
			
			log.info("only file name : " + uploadFileName);
			
			storeImg.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			try {
				//File saveFile = new File(uploadFolder, uploadFileName);
				
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				storeImg.setUuid(uuid.toString());
				
				storeImg.setUploadPath(uploadFolderPath);
				
				// check image type file
				if(checkImageType(saveFile)) {
					
					storeImg.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100,100);
					
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
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		log.info("fileName : " + fileName);
		
		File file = new File(ROOT_FOLDER + fileName);
		
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			// Content-Type : img..  
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			log.info("file: " + file);
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 업로드한 파일 다운로드 로직 
	@GetMapping(value ="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		
		log.info("downlad file: " + fileName);
		
		Resource resource = new FileSystemResource(ROOT_FOLDER + fileName);
		
		log.info("resource : " + resource);

		/*
		if(resource.exists() == false) {
			log.info("false..............");
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		*/
		String resourceName = resource.getFilename();
		
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.lastIndexOf("_") + 1);
		
		log.info("resourceOriginalName : " + resourceOriginalName);
		
		log.info("resource : " + resourceName);
		
		HttpHeaders headers = new HttpHeaders();
		
		log.info("headers : " + headers);
		
		try {
			
			String downloadName = null;
			
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

			headers.add("Content-Disposition", "attachment; filename="+ downloadName);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	// 파일 삭제 로직
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		
		log.info("deleteFile : " + fileName);
		
		File file;
		
		try {
			file = new File(ROOT_FOLDER + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
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