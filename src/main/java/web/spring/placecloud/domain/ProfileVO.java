package web.spring.placecloud.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ProfileVO {
	private int profileId;
	private String memberEmail;
	private String profilePath;
	private String profileRealName;
	private String profileChgName;
	private String profileExtension;
	private MultipartFile profile;
}
