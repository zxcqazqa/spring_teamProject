package com.jafa.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.jafa.domain.Criteria;
import com.jafa.domain.MemberVO;

@Mapper
public interface MemberRepository {

	public MemberVO registerCheck(String id);
	public int register(MemberVO mvo);			// 회원등록(성공1, 실패0)
	public MemberVO login(MemberVO mvo);		// 로그인 체크
	public int update(MemberVO mvo);		// 수정
	public MemberVO getMember(String id);	
	public void profileUpdate(MemberVO mvo);
	
	List<MemberVO> getMemberInfo(Criteria criteria);
	public int getTotalCount(Criteria criteria);
	
	
}
