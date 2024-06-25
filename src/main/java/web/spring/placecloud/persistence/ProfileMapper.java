package web.spring.placecloud.persistence;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.ProfileVO;

@Mapper
public interface ProfileMapper {
	int uploadProfile(ProfileVO profileVO);
	
	ProfileVO selectByProfileId(int profileId);
	
	int deleteProfile(int profileId);
}
