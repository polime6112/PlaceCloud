package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ImageVO;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.persistence.ImageMapper;
import web.spring.placecloud.persistence.PlaceMapper;

@Service
@Log4j
public class PlaceServiceImple implements PlaceService{

	@Autowired
	private PlaceMapper placeMapper;
	
	@Autowired
	private ImageMapper imageMapper;
	
	@Transactional(value = "transactionManager")
	@Override
	public int createPlace(PlaceVO placeVO) {
		log.info("createPlace()");
		log.info("placeVO = " + placeVO);
		int insertPlaceResult = placeMapper.insert(placeVO);
		log.info(insertPlaceResult + "행 등록");
		
		List<ImageVO> imageList = placeVO.getImageList();
		
		int insertImageResult = 0;
		for (ImageVO imageVO : imageList) {
			insertImageResult += imageMapper.uploadImage(imageVO);
		}
		log.info(insertImageResult + "행 이미지 등록");
		
		return 1;
	}
	
	@Override
	public List<PlaceVO> getAllPlace() {
		log.info("getAllPlace");
		List<PlaceVO> list = placeMapper.selectAllPlace();
		
		return list;
	}
	
	@Override
	public List<PlaceVO> getMyPlace(String memberEmail) {
		log.info("getMyPlace");
		return placeMapper.selectMyPlace(memberEmail);
	}

	@Override
	public PlaceVO getPlaceById(int placeId) {
		log.info("getPlaceById");
		log.info("placeId = " + placeId);
		PlaceVO placeVO = placeMapper.selectByPlaceId(placeId);
		List<ImageVO> list = imageMapper.selectByPlaceId(placeId);

		placeVO.setImageList(list);
		return placeVO;
	}
	
	@Override
	public List<PlaceVO> getPlaceByCategory(String placeCategory) {
		log.info("getPlaceByCategory");
		return placeMapper.selectByCategory(placeCategory);
	}

	@Transactional(value = "transactionManager")
	@Override
	public int updatePlace(PlaceVO placeVO) {
		log.info("updatePlace");
		log.info("placeVO = " + placeVO);
		int updatePlaceResult = placeMapper.update(placeVO);
		log.info(updatePlaceResult + "행 정보 수정");
		
		int deleteImageResult = imageMapper.deleteImage(placeVO.getPlaceId());
		log.info(deleteImageResult + "행 이미지 정보 삭제");
		
		List<ImageVO> imageList = placeVO.getImageList();
		
		int insertImageResult = 0;
		for (ImageVO imageVO : imageList) {
			imageVO.setPlaceId(placeVO.getPlaceId()); // 장소 번호 적용
			insertImageResult += imageMapper.updateImage(imageVO);
		}
		log.info(insertImageResult + "행 이미지 정보 등록");
		return 1;
	}

	@Transactional(value = "transactionManager")
	@Override
	public int deletePlace(int placeId) {
		log.info("deletePlace");
		log.info("placeId = " + placeId);
		int deletePlaceResult = placeMapper.delete(placeId);
		log.info(deletePlaceResult + "행 장소 정보 삭제");
		int deleteImageResult = imageMapper.deleteImage(placeId);
		log.info(deleteImageResult + "행 이미지 정보 삭제");
		return 1;
	}
}
