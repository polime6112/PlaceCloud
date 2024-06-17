package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.PlaceVO;

@Mapper
public interface PlaceMapper {
	int insert(PlaceVO placeVO);
	List<PlaceVO> selectAllPlace();
	List<PlaceVO> selectMyPlace(String memberEmail);
	PlaceVO selectByPlaceId(int placeId);
	PlaceVO selectByPlaceCategory(String placeCategory);
	int update(PlaceVO placeVO);
	int delete(int placeId);
}
