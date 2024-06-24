package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import web.spring.placecloud.domain.LikeListVO;

@Mapper
public interface LikeListMapper {
	int insert(LikeListVO likeListVO);
	List<LikeListVO> selectList();
	int delete(int likeId);
}
