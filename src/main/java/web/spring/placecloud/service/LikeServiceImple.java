package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.LikeVO;
import web.spring.placecloud.persistence.LikeMapper;

@Service
@Log4j
public class LikeServiceImple implements LikeService {
	
	@Autowired
	private LikeMapper likeMapper;
	
	@Override
	public int createBoard(LikeVO likeVO) {
		log.info("createBoard()");
		int result = likeMapper.insert(likeVO);
		return result;
	}

	@Override
	public List<LikeVO> getAllBoards() {
		log.info("getAllBoards()");
		return likeMapper.selectList();
	}

	@Override
	public List<LikeVO> getBoardsById(String memberEmail) {
		log.info("getBoardsByEmail");
		return likeMapper.selectListByEmail(memberEmail);
	}
	
	@Override
	public LikeVO getBoardbyId(int placeId, String memberEmail) {
		log.info("getBoardById()");
		return likeMapper.selectOne(placeId, memberEmail);
	}
	
	@Override
	public int deleteBoard(int placeId, String memberEmail) {
		log.info("deleteBoard()");
		return likeMapper.delete(placeId, memberEmail);
	}


}
