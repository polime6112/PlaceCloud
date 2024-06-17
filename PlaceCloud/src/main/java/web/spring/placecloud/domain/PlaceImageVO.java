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
public class PlaceImageVO {
	private int imageId;
	private String imageName;
	private String imageExtension;
	private int placeId;
	private String imagePath;
	private MultipartFile image;
}
