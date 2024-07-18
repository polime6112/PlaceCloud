package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.PlaceVO;

@Mapper
public interface PlaceMapper {
	int insert(PlaceVO placeVO);
	List<PlaceVO> selectAllPlace(); // 전체 장소 조회
	List<PlaceVO> selectMyPlace(String memberEmail);
	PlaceVO selectByPlaceId(int placeId);
	List<PlaceVO> selectByCategory(String placeCategory);
	int update(PlaceVO placeVO);
	int delete(int placeId);
}
