package web.spring.placecloud.persistence;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.ImageVO;

@Mapper
public interface ImageMapper {
	int insertImage(ImageVO imageVO);
	ImageVO selectImageByPlaceId(int placeId);
	int updateImage(ImageVO imageVO);
	int deleteImage(int placeId);
}
