package web.spring.placecloud.service;

import web.spring.placecloud.domain.PlaceImageVO;

public interface PlaceImageService {
	int insertImage(PlaceImageVO placeImageVO);
	PlaceImageVO getImageByPlaceId(int placeId);
	int updateImage(PlaceImageVO placeImageVO);
	int deleteImage(int imageId);
}
