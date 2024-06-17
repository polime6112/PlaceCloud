package web.spring.placecloud.persistence;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.ImageVO;

@Mapper
public interface ImageMapper {
	int insert(ImageVO imageVO);
	ImageVO selectImageByPlaceId(int placeId);
	int update(ImageVO imageVO);
	int delete(int placeId);
}
