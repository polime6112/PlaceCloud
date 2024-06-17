package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.PlaceVO;

public interface PlaceService {
	int createPlace(PlaceVO placeVO);
	List<PlaceVO> getAllPlace(String memberEmail);
	PlaceVO getPlaceById(Integer placeId);
	int updatePlace(PlaceVO placeVO);
	int deletePlace(int placeId);
}
