package web.spring.placecloud.service;

import web.spring.placecloud.domain.ImageVO;

public interface ImageService {
	int upload(ImageVO imageVO);
	ImageVO getImageByPlaceId(int placeId);
	int update(ImageVO imageVO);
	int delete(int placeId);
}
