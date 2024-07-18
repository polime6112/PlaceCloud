package web.spring.placecloud.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class ImageVO {
	private int imageId;
	private int placeId;
	private String imagePath;
	private String imageRealName;
	private String imageChgName;
	private String imageExtension;
}
