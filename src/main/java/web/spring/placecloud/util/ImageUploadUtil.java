package web.spring.placecloud.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

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
		
		return extension.toLowerCase();
	}
	
	/**
	 * 이미지가 저장되는 폴더 이름을 장소 번호 기준으로 생성
	 * 
	 * @return 날짜 형식의 폴더 이름
	 */
	public static String makePath() {
		Calendar calendar = Calendar.getInstance();
        
        String yearPath = String.valueOf(calendar.get(Calendar.YEAR));
        log.info("yearPath: " + yearPath);
        
        String monthPath = yearPath
                + File.separator
                + new DecimalFormat("00")
                    .format(calendar.get(Calendar.MONTH) + 1);
        log.info("monthPath: " + monthPath);
        
        
        String datePath = monthPath
                + File.separator
                + new DecimalFormat("00")
                    .format(calendar.get(Calendar.DATE));
        
        String path = datePath.replace(File.separatorChar, '/');
        
        log.info("Path: " + path);
        
        return path;
	}
	
	/**
	 * 이미지 저장
	 * 
	 * @param uploadPath 이미지 업로드 경로	
	 * @param image 	 업로드된 이미지
	 * @param chgName	 UUID
	 */
	public static void saveImage(String uploadPath, MultipartFile image, String chgName) {
		
		File realUploadPath = new File(uploadPath, makePath());
		if (!realUploadPath.exists()) {
			realUploadPath.mkdirs();
			log.info(realUploadPath.getPath() + " successfully created.");
		} else {
			log.info(realUploadPath.getPath() + " already exists.");
		}
		
		log.info("realUploadPath : " + realUploadPath);
		log.info("chgName : " + chgName);
		File saveImage = new File(realUploadPath, chgName);
		log.info("saveImage : " + saveImage);
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
	 * @param path		 파일이 저장된 경로
	 * @param imageName  저장된 파일 이름
	 */
	public static void deleteImage(String uploadPath, String path, String imageChgName) {
		// 삭제할 이미지의 전체 경로 생성
		String fullPath = uploadPath + File.separator + path + File.separator + imageChgName;
		
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
	
	/**
     * 이미지 파일인지 확인
     * 
     * @param file 전송된 파일 객체
     * @return 파일이면 true
     */
    public static boolean isImageFile(MultipartFile image) {
        if (image == null || image.isEmpty()) {
            return false;
        }

        // ContentType 정보 참조
        String contentType = image.getContentType();

        // Content Type이 "image/"로 시작하는지 확인
        return contentType != null && contentType.startsWith("image/");
    }
    
    /**
     * 원본 이미지로 섬네일 파일을 생성
     * 
     * @param uploadPath 업로드된 파일의 기본 경로
     * @param path 업로드된 파일의 상세 경로
     * @param chgName 변경된 파일명
     * @param extension 파일 확장자
     */
    public static void createThumbnail(String uploadPath, String path, 
    		String chgName, String extension) {
    	String realUploadPath = uploadPath + File.separator + path;
    	String thumbnailName = "t_" + chgName; // 섬네일 파일 이름
    	
    	// 섬네일 파일 저장 경로 및 이름
    	File destPath = new File(realUploadPath, thumbnailName); 
    	// 원본 파일 저장 경로 및 이름
        File savePath = new File(realUploadPath, chgName); 
    	try {
			Thumbnails.of(savePath)
			          .size(100, 100) // 썸네일 크기 지정
			          .outputFormat(extension) // 확장자 설정
			          .toFile(destPath); // 저장될 경로와 이름
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
