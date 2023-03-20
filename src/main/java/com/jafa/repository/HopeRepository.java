package com.jafa.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jafa.domain.Criteria;
import com.jafa.domain.HopeVO;

public interface HopeRepository {


	//신청현황
	List<HopeVO> getRequestList(Criteria criteria);
	int getTotalCount(Criteria criteria);
	
	//새신청번호
	int getNewRno();
	//신청하기
	void addRequest(HopeVO vo);
	//신청처리중 승인
	void updateGo(int Grno);
	//신청처리중 거절/거절사 유
	void updateNo(@Param("rno") int Xrno,@Param("etc") String etc);
	//'승인대기'자목록
	List<HopeVO> getRequestMaster(Criteria criteria);

	
}
