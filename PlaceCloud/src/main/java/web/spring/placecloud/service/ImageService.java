package web.spring.placecloud.service;

import web.spring.placecloud.domain.ImageVO;

public interface ImageService {
	int insertImage(ImageVO imageVO);
	ImageVO getImageByPlaceId(int placeId);
	int updateImage(ImageVO imageVO);
	int deleteImage(int placeId);
}
