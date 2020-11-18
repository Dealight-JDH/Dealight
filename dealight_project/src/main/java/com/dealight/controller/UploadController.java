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
	
	// 파일을 저장할 경로를 지정한다.
	final static private String ROOT_FOLDER = "C:\\Users\\kjuio\\Desktop\\ex05\\";
	
	
	// 매일 다른 경로에 폴더를 생성하고, 파일을 저장한다.
	// 오늘의 날짜를 폴더로 만들 file path 만든다. root_folder / yyyy / mm / dd / 
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-",File.separator);
	}
	
	// 해당 파일이 이미지 파일인지 아닌지를 구분한다.
	private boolean checkImageType(File file) {
		try {
			
			// probe content type은 해당 파일의 타입을 반환한다.
			String contentType = Files.probeContentType(file.toPath());
			
			//  omage로 시작하는지를 확인하고 맞으면 true를 반환한다.
			return contentType.startsWith("image");
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 매장사진, 메뉴를 구분해서 받아야할 듯.
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		String uploadFolder = ROOT_FOLDER;
		
		// uploadFile을  multipartFile로 쪼개서 처리한다.
		for(MultipartFile multipartFile : uploadFile) {
			
			log.info("--------------------------------");
			
			// 업로드된 파일의 원본명
			log.info("Upload File Name : " + multipartFile
					.getOriginalFilename());
			
			// 업로드된 파일의 크기
			log.info("Upload File Size : " + multipartFile.getSize());
			
			// path는 경로 + 파일명으로 결정된다 (ex: c:\\user\\a.jpg)
			// 경로
			File saveFile = new File(uploadFolder, multipartFile
					.getOriginalFilename());
			
			try {
				
				// 해당 파일을 저장한다.
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
	
	// 화면에서 input file으로 image를 upload하면 저장소에 저장이 된다.
	// 하지만 DB에 바로 저장이 되지는 않는다.
	// 저장된 이미지 객체의 리스트를 반환한다.
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<StoreImgVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		// 이미지 목록을 반환 받는다.
		List<StoreImgVO> list = new ArrayList<>();
		
		log.info("upload store img post................");
		
		String uploadFolder = ROOT_FOLDER;
		
		// 해당 날짜의 폴더 경로를 가져온다.
		String uploadFolderPath = getFolder();
		// make folder -----------------
		// File(경로,경로)는 경로와 경로를 합쳐주는 역할을 한다.
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		log.info("upload path : " + uploadPath);
		
		// 해당 경로가 없으면, 만든다.
		// make yyyy/MM/dd folder
		if(uploadPath.exists() == false) {
			log.info("maker dir....");
			uploadPath.mkdirs();
		}
		
		
		for(MultipartFile multipartFile : uploadFile) {
			
			// DB에 넣어주기 위해 객체를 생성해준다.
			StoreImgVO storeImg = new StoreImgVO();
			
			log.info("------------------------------------");
			
			log.info("Upload File Name : " + multipartFile
					.getOriginalFilename());
			
			log.info("Upload File Size : " + multipartFile.getSize());
			
			// 원본 이름을 가져온다.
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName
					.lastIndexOf("\\") + 1);
			
			log.info("only file name : " + uploadFileName);
			
			// 파일의 고유 이름을 저장해준다.
			storeImg.setFileName(uploadFileName);
			
			// 고유한 파일이름을 만들어주기 위해서 uuid를 만들어준다.
			UUID uuid = UUID.randomUUID();
			
			// 파일이름에 uuid + _를 합쳐준다.
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			try {
				//File saveFile = new File(uploadFolder, uploadFileName);
				
				// 저장될 경로와 이름(UUID가 합쳐진)을 file로 저장한다.
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				// uuid는 따로 저장한다.
				storeImg.setUuid(uuid.toString());
				
				// 경로도 따로 저장해준다.
				storeImg.setUploadPath(uploadFolderPath);
				
				// check image type file
				if(checkImageType(saveFile)) {
					
					// 이미지가 맞는지를 저장해준다.
					storeImg.setImage(true);
					
					// 사용자에게 보여줄 썸네일을 제작한다. 
					// 경로는 똑같이, 파일명 앞에는 "s_"를 붙여준다.
					// 아웃풋스트림(버퍼?)에 해당 데이터를 담아둔다.
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					// 썸네일 제조사가 썸네일을 만들어준다.
					// multipartfile을 inputstream으로 빨아드리고 지정된 width, height의 픽셀값으로 만들어서 thumbnail에 그대로 저장해준다.
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100,100);
					
					// 아웃풋 스트림을 닫아준다.
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
	
	
	// 저장된 파일을 화면에 보여준다.
	// byte[]로 반환한다.
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		log.info("fileName : " + fileName);
		
		File file = new File(ROOT_FOLDER + fileName);
		
		log.info("file: " + file);
		
		// 화면에는 byte로 쏴준다.
		ResponseEntity<byte[]> result = null;
		
		try {
			
			// 반환할 http의 헤더를 작성한다.
			HttpHeaders header = new HttpHeaders();
			// header 이름 : 헤더 value
			// Content-Type : img..  
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			// file을 복사해서 byte array로 변환하고 반환해준다.
			// header와 서버 통신 상태를 반환한다.
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	// 다운로드를 할 수 있는 기능을 제공한다.
	// OCTET은 8개의 비트가 한데 모인 것을 말한다. 1byte가 꼭 8비트를 의미하지는 않으므로 이러한 용어를 사용한다.
	// 해당 상황에서는 byte stream을 전달하는 type임을 명시해준다고 생각하면 된다.
	
	@GetMapping(value ="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		
		log.info("downlad file: " + fileName);
		
		// 해당 경로와 파일이름(uuid포함)을 가진 대상 파일 경로를 가져온다.
		Resource resource = new FileSystemResource(ROOT_FOLDER + fileName);
		
		log.info("resource : " + resource);

		// 해당하는 파일이 없으면 에러 페이지를 반환한다.
		/*
		if(resource.exists() == false) {
			log.info("false..............");
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		*/
		// 리소스 파일명(uuid 포함)을 저장한다.
		String resourceName = resource.getFilename();
		
		//remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.lastIndexOf("_") + 1);
		
		log.info("resourceOriginalName : " + resourceOriginalName);
		
		log.info("resource : " + resourceName);
		
		// 헤더를 만들어준다.
		HttpHeaders headers = new HttpHeaders();
		
		log.info("headers : " + headers);
		
		try {
			
			String downloadName = null;
			
			// 유저 브라우저 정보에 따라 downloadName을 변경한다.
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

			// 다운로드시 저장되는 이름을 지정
			// 다운로드시 저장되는 이름이 깨치는 것을 막기 위함
			headers.add("Content-Disposition", "attachment; filename="+ downloadName);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	
	// 파일을 삭제한다.
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		
		log.info("deleteFile : " + fileName);
		
		File file;
		
		try {
			file = new File(ROOT_FOLDER + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			// 이미지 파일인 경우 원본파일도 같이 삭제해준다.
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