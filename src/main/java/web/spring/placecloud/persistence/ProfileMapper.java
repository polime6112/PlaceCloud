package web.spring.placecloud.persistence;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.ProfileVO;

@Mapper
public interface ProfileMapper {
	int uploadProfile(ProfileVO profileVO);
	
	ProfileVO selectByMemberEmail(String memberEmail);
	
	int deleteProfile(String memberEmail);
}
