package web.spring.placecloud.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class ProfileUploadUtil {
	/**
	 * 이미지 이름에서 확장자를 제외한 실제 파일 이름 추출
	 * 
	 * @param profileName 	프로필 이름	
	 * @return 				실제 프로필 이름
	 */
	public static String subName(String profileName) {
		// FilenameUtils.normalize() : 파일 이름 정규화 메서드
		String normalizeName = FilenameUtils.normalize(profileName);
		int dotIndex = normalizeName.lastIndexOf('.');
		
		String realName = normalizeName.substring(0, dotIndex);
		return realName;
	}
	
	/**
	 * 이미지 이름에서 확장자를 추출
	 * 
	 * @param profileName 	프로필 이름	
	 * @return 				확장자
	 */
	public static String subExtension(String profileName) {
		// 파일 이름에서 마지막 '.'의 인덱스 추출
		int dotIndex = profileName.lastIndexOf('.');
		
		// '.' 이후의 문자열을 확장자로 추출
		String extension = profileName.substring(dotIndex + 1);
		
		return extension;
	}
	
	/**
	 * 이미지가 저장되는 폴더 이름을 장소 번호 기준으로 생성
	 * 
	 * @return 장소 번호 형식의 폴더 이름
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
        
        String path = "profile" + "/" + datePath.replace(File.separatorChar, '/');
        
        log.info("Path: " + path);
        
        return path;
	}
	
	/**
	 * 이미지 저장
	 * 
	 * @param uploadPath 이미지 업로드 경로	
	 * @param profile 	 업로드된 프로필
	 * @param uuid 		 UUID
	 */
	public static void saveProfile(String uploadPath, MultipartFile profile, String uuid) {
		
		File realUploadPath = new File(uploadPath, makePath());
		if (!realUploadPath.exists()) {
			realUploadPath.mkdirs();
			log.info(realUploadPath.getPath() + " successfully created.");
		} else {
			log.info(realUploadPath.getPath() + " already exists.");
		}
		
		File saveProfile = new File(realUploadPath, uuid);
		try {
			profile.transferTo(saveProfile);
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
	 * @param profileName  저장된 파일 이름
	 */
	public static void deleteProfile(String uploadPath, String path, String profileChgName) {
		// 삭제할 이미지의 전체 경로 생성
		String fullPath = uploadPath + File.separator + path + File.separator + profileChgName;
		
		// 이미지 객체 생성
		File profile = new File(fullPath);
		
		// 이미지가 존재하는지 확인하고 삭제
		if (profile.exists()) {
			if (profile.delete()) {
				System.out.println(fullPath + " profile delete success.");
			} else {
				System.out.println(fullPath + " profile delete failed.");
			}
		} else {
			System.out.println(fullPath + " profile not found.");
		}
	}
}
