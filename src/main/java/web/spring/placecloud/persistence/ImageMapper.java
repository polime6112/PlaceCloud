package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.ImageVO;

@Mapper
public interface ImageMapper {
	int uploadImage(ImageVO imageVO);
	List<ImageVO> selectByPlaceId(int placeId);
	ImageVO selectByImageId(int imageId);
	int updateImage(ImageVO imageVO);
	int deleteImage(int placeId);
}
