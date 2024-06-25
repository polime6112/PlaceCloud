package web.spring.placecloud.service;

import web.spring.placecloud.domain.ProfileVO;

public interface ProfileService {
	int upload(ProfileVO profileVO);
	
	ProfileVO getProfileByEmail(String memberEmail);
	
	int delete(String memberEmail);
}
