package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.PlaceVO;

@Mapper
public interface PlaceMapper {
	int insert(PlaceVO placeVO);
	List<PlaceVO> selectAllPlace(String memberEmail);
	PlaceVO selectByPlaceId(Integer placeId);
	int update(PlaceVO placeVO);
	int delete(int placeId);
}
