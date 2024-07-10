package web.spring.placecloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import web.spring.placecloud.domain.LikeVO;
import web.spring.placecloud.service.LikeService;

@RestController
@RequestMapping("/like")
@Log4j
public class LikeRESTController {
	
	@Autowired
	private LikeService likeService;
	
	@PostMapping("/insert") // 관심 장소 등록
	public ResponseEntity<Integer> createLike(@RequestBody LikeVO likeVO) {
		log.info("createLike()");
		int result = likeService.createBoard(likeVO);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	
	@GetMapping("/selectOne/{memberEmail}/{placeId}") // 관심 장소 조회
	public ResponseEntity<LikeVO> readLikeOne(@PathVariable("memberEmail") String memberEmail, @PathVariable("placeId") int placeId) {
		log.info("readLikeOne()");
		log.info("memberEmail : " + memberEmail);
		log.info("placeId : " + placeId);
		LikeVO likeVO = likeService.getBoardbyId(placeId, memberEmail);
		return new ResponseEntity<LikeVO>(likeVO, HttpStatus.OK);
	}
	
	@DeleteMapping("/{memberEmail}/{placeId}") // 관심 장소 해체
	public ResponseEntity<Integer> deleteLike(@PathVariable("memberEmail") String memberEmail, @PathVariable("placeId") int placeId) {
		log.info("deleteLike()");
		log.info("memberEmail : " + memberEmail);
		log.info("placeId : " + placeId);
		int result = likeService.deleteBoard(placeId, memberEmail);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	
	
}
