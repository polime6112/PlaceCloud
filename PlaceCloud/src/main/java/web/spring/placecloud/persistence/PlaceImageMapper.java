package web.spring.placecloud.persistence;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.PlaceImageVO;

@Mapper
public interface PlaceImageMapper {
	int insert(PlaceImageVO placeImageVO);
	PlaceImageVO selectImageByPlaceId(int placeId);
	int update(PlaceImageVO placeImageVO);
	int delete(int imageId);
}
