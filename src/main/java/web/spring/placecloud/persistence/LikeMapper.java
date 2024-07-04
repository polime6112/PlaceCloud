package web.spring.placecloud.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import web.spring.placecloud.domain.LikeVO;

@Mapper
public interface LikeMapper {
	int insert(LikeVO likeVO); // 관심 장소 등록(찜하기)
	List<LikeVO> selectList(); // 관심 장소 전체 조회(찜목록)
	LikeVO selectOne(@Param("placeId") int placeId, @Param("memberEmail") String memberEmail); // 관심 장소 조회(장소 index, 회원 계정(이메일) 대조)
	int delete(@Param("placeId") int placeId, @Param("memberEmail") String memberEmail); // 관심 장소 해제(찜취소)(장소 index, 회원 계정(이메일) 대조)
} // end LikeMapper
