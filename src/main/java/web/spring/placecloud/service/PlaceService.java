package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.PlaceVO;

public interface PlaceService {
	int createPlace(PlaceVO placeVO);
	List<PlaceVO> getAllPlace();
	List<PlaceVO> getMyPlace(String memberEmail);
	PlaceVO getPlaceById(int placeId); // 특정 장소 조회
	List<PlaceVO> getPlaceByCategory(String placeCategory);
	int updatePlace(PlaceVO placeVO);
	int deletePlace(int placeId);
}
