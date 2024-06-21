package web.spring.placecloud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.LikeListVO;
import web.spring.placecloud.persistence.LikeListMapper;

@Service
@Log4j
public class LikeListServiceImple implements LikeListService {
	
	@Autowired
	private LikeListMapper likeListMapper;
	
	
	@Override
	public int createBoard(LikeListVO likeListVO) {
		log.info("createBoard()");
		int result = likeListMapper.insert(likeListVO);
		return result;
	}

	@Override
	public List<LikeListVO> getAllBoards() {
		log.info("getAllBoards()");
		return likeListMapper.selectList();
	}

	@Override
	public int deleteBoard(int likeId) {
		log.info("deleteBoard()");
		return likeListMapper.delete(likeId);
	}

}
