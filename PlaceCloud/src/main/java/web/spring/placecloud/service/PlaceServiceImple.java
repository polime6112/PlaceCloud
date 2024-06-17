package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.PlaceVO;
import web.spring.placecloud.persistence.PlaceMapper;

@Service
@Log4j
public class PlaceServiceImple implements PlaceService{

	@Autowired
	private PlaceMapper placeMapper;
	
	@Override
	public int createPlace(PlaceVO placeVO) {
		log.info("createPlace");
		return placeMapper.insert(placeVO);
	}
	
	@Override
	public List<PlaceVO> getAllPlace(String memberEmail) {
		log.info("getAllPlace");
		return placeMapper.selectAllPlace(memberEmail);
	}

	@Override
	public PlaceVO getPlaceById(Integer placeId) {
		log.info("getPlaceById");
		return placeMapper.selectByPlaceId(placeId);
	}

	@Override
	public int updatePlace(PlaceVO placeVO) {
		log.info("updatePlace");
		return placeMapper.update(placeVO);
	}

	@Override
	public int deletePlace(int placeId) {
		log.info("deletePlace");
		return placeMapper.delete(placeId);
	}

}
