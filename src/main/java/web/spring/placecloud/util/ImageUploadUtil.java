package web.spring.placecloud.util;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class ImageUploadUtil {
	
	/**
	 * 이미지 이름에서 확장자를 제외한 실제 파일 이름 추출
	 * 
	 * @param imageName 이미지 이름	
	 * @return 			실제 이미지 이름
	 */
	public static String subName(String imageName) {
		// FilenameUtils.normalize() : 파일 이름 정규화 메서드
		String normalizeName = FilenameUtils.normalize(imageName);
		int dotIndex = normalizeName.lastIndexOf('.');
		
		String realName = normalizeName.substring(0, dotIndex);
		return realName;
	}
	
	/**
	 * 이미지 이름에서 확장자를 추출
	 * 
	 * @param imageName 이미지 이름	
	 * @return 			확장자
	 */
	public static String subExtension(String imageName) {
		// 파일 이름에서 마지막 '.'의 인덱스 추출
		int dotIndex = imageName.lastIndexOf('.');
		
		// '.' 이후의 문자열을 확장자로 추출
		String extension = imageName.substring(dotIndex + 1);
		
		return extension;
	}
	
	/**
	 * 이미지가 저장되는 폴더 이름을 장소 번호 기준으로 생성
	 * 
	 * @return 날짜 형식의 폴더 이름
	 */
	public static String makePath(int placeId) {
		return Integer.toString(placeId);
	}
	
	/**
	 * 이미지 저장
	 * 
	 * @param uploadPath 이미지 업로드 경로	
	 * @param image 	 업로드된 이미지
	 * @param uuid 		 UUID
	 */
	public static void saveImage(String uploadPath, MultipartFile image, String uuid, int placeId) {
		if (image == null) {
	        log.error("Image 없음");
	        throw new IllegalArgumentException("Image는 null일 수 없음");
	    }
		File realUploadPath = new File(uploadPath, makePath(placeId));
		
		if (!realUploadPath.exists()) {
			realUploadPath.mkdirs();
			log.info(realUploadPath.getPath() + " successfully created.");
		} else {
			log.info(realUploadPath.getPath() + " already exists.");
		}
		
		File saveImage = new File(realUploadPath, uuid);
		try {
			image.transferTo(saveImage);
			log.info("file upload success");
		} catch (IllegalStateException e) {
			log.error(e.getMessage());
		} catch (IOException e) {
			log.error(e.getMessage());
		}
	}
	
	/**
	 * 이미지 삭제
	 * 
	 * @param uploadPath 이미지 업로드 경로
	 * @param path		 파일이 저장된 날짜 경로
	 * @param imageName  저장된 파일 이름
	 */
	public static void deleteImage(String uploadPath, String path, String imageName) {
		// 삭제할 이미지의 전체 경로 생성
		String fullPath = uploadPath + File.separator + path + File.separator + imageName;
		
		// 이미지 객체 생성
		File image = new File(fullPath);
		
		// 이미지가 존재하는지 확인하고 삭제
		if (image.exists()) {
			if (image.delete()) {
				System.out.println(fullPath + " image delete success.");
			} else {
				System.out.println(fullPath + " image delete failed.");
			}
		} else {
			System.out.println(fullPath + " image not found.");
		}
	}
}
