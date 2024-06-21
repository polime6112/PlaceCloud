package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.LikeListVO;

public interface LikeListService {
	int createBoard(LikeListVO likeListVO);
	List<LikeListVO> getAllBoards();
	int deleteBoard(int likeId);
}
