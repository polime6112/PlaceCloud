package web.spring.placecloud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.PlaceImageVO;
import web.spring.placecloud.persistence.PlaceImageMapper;

@Service
@Log4j
public class PlaceImageServiceImple implements PlaceImageService {
	
	@Autowired
	private PlaceImageMapper placeImageMapper;

	@Override
	public int insertImage(PlaceImageVO placeImageVO) {
		log.info("insertImage");
		return placeImageMapper.insert(placeImageVO);
	}

	@Override
	public PlaceImageVO getImageByPlaceId(int placeId) {
		log.info("getImageById");
		return placeImageMapper.selectImageByPlaceId(placeId);
	}

	@Override
	public int updateImage(PlaceImageVO placeImageVO) {
		log.info("updateImage");
		return placeImageMapper.update(placeImageVO);
	}

	@Override
	public int deleteImage(int imageId) {
		log.info("deleteImage");
		return placeImageMapper.delete(imageId);
	}
	
	
	
}
