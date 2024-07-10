package web.spring.placecloud.service;

import java.util.List;

import web.spring.placecloud.domain.LikeVO;

public interface LikeService {
	int createBoard(LikeVO likeVO);
	List<LikeVO> getAllBoards();
	LikeVO getBoardbyId(int placeId, String memberEmail);
	int deleteBoard(int placeId, String memberEmail);
}
