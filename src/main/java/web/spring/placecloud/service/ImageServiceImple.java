package web.spring.placecloud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.persistence.ImageMapper;

@Service
@Log4j
public class ImageServiceImple implements ImageService {
	
	@Autowired
	private ImageMapper imageMapper;
	
	@Override
	public int upload(ImageVO imageVO) {
		log.info("upload");
		return imageMapper.uploadImage(imageVO);
	}
	
	@Override
	public ImageVO getImageById(int placeId) {
		log.info("getImageById");
		return imageMapper.selectByPlaceId(placeId);
	}

	@Override
	public int update(ImageVO imageVO) {
		log.info("updateImage");
		return imageMapper.updateImage(imageVO);
	}

	@Override
	public int delete(int placeId) {
		log.info("deleteImage");
		return imageMapper.deleteImage(placeId);
	}
}
