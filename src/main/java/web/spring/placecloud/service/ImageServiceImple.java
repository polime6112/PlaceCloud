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
	public ImageVO getImageById(int imageId) {
		log.info("getImageById()");
		return imageMapper.selectByImageId(imageId);
	}
}
