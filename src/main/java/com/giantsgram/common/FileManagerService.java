package com.giantsgram.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileManagerService {

	// 로그 찍기용
		private Logger logger = LoggerFactory.getLogger(this.getClass());
		
		//TODO
		// 이미지 저장 경로
		public final static String FILE_UPLOAD_PATH="C:\\springproject\\projectquiz\\projectQuizWorkspace\\lhcgram\\images/";
		
		// 이미지 저장
		public String saveFile(String userLoginId, MultipartFile file) throws IOException {
			
			// 1. 파일 경로 만들기(폴더) - 안 겹치게. 이름이 겹치는 것도 있을 수 있기 때문
			String directoryName = userLoginId+"_"+System.currentTimeMillis()+"/";
			String filePath = FILE_UPLOAD_PATH + directoryName; // 파일 저장 폴더 위치
			
			File directory = new File(filePath);
			
			if(directory.mkdir()==false) {
				logger.error("######## 에러 발생!!!");
				return null; // 디렉토리 생성 X
			}
			
			// 2. 생성된 폴더에 파일 만들기
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + file.getOriginalFilename());
			Files.write(path, bytes); // 파일 생성
			
			// 파일 URI를 리턴
			return "/images/" + directoryName + file.getOriginalFilename();
			
		}
}
