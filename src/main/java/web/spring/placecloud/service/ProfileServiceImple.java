package web.spring.placecloud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.ProfileVO;
import web.spring.placecloud.persistence.ProfileMapper;

@Service
@Log4j
public class ProfileServiceImple implements ProfileService{
	
	@Autowired
	private ProfileMapper profileMapper;
	
	@Override
	public int upload(ProfileVO profileVO) {
		log.info("upload");
		return profileMapper.uploadProfile(profileVO);
	}

	@Override
	public ProfileVO getProfileById(int profileId) {
		log.info("getProfileById");
		return profileMapper.selectByProfileId(profileId);
	}

	@Override
	public int delete(int profileId) {
		log.info("delete");
		return profileMapper.deleteProfile(profileId);
	}
	
}
