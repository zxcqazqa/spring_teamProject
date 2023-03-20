package com.jafa.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.FileNameMap;
import java.net.URLConnection;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FileController {
	
	@GetMapping("/memImgDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> memImgDisplay(String id, String imageFileName) throws IOException{
		File file = new File("c:/file01_spring/"+id, imageFileName);
		if(!file.exists()) {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
		HttpHeaders headers = new HttpHeaders();
		FileNameMap fileNameMap = URLConnection.getFileNameMap();
		headers.add("Content-Type", fileNameMap.getContentTypeFor(imageFileName));
		return new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),headers,HttpStatus.OK);
	}
	
	@GetMapping("/imgDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> imgDisplay(String imageFileName,String bno) throws IOException{
		File file = new File("c:/file01_spring/"+bno, imageFileName);
		if(!file.exists()) {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
		HttpHeaders headers = new HttpHeaders();
		FileNameMap fileNameMap = URLConnection.getFileNameMap();
		headers.add("Content-Type", fileNameMap.getContentTypeFor(imageFileName));
		return new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),headers,HttpStatus.OK);
	}
	//파인다운로드
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	//파일다운로드 미디어타입 지정
	public ResponseEntity<Resource> download(@RequestHeader("User-Agent") String userAgent,
			String imageFileName) throws UnsupportedEncodingException{
	
		Resource resource = new FileSystemResource("c:/file01_spring/"+imageFileName);
		if(!resource.exists()) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		//다운로드시 파일이름 처리
		HttpHeaders headers = new HttpHeaders();
		String downloadName = new String(resource.getFilename().getBytes("UTF-8"),"ISO-8859-1");
		headers.add("Content-Disposition", "attach;fileName="+downloadName);
		return new ResponseEntity<Resource>(resource,headers,HttpStatus.OK);
	}
	
	private static final String REPO_PATH = "c:/file01_spring/";
	private static final String bookServicePathName = "book/";
	
	@GetMapping("/bookImgDisplay")
	@ResponseBody
	public ResponseEntity<byte[]> bookImgDisplay(String category, int no, String imageFileName) throws IOException{
		File file = new File(REPO_PATH+bookServicePathName+category+"/"+no, imageFileName);
		if(!file.exists()) {
			return new ResponseEntity<byte[]>(HttpStatus.NOT_FOUND);
		}
		HttpHeaders headers = new HttpHeaders();
		FileNameMap fileNameMap = URLConnection.getFileNameMap();
		headers.add("Content-Type", fileNameMap.getContentTypeFor(imageFileName));
		return new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),headers,HttpStatus.OK);
	}
	
}
