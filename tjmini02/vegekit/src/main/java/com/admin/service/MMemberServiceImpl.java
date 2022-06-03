package com.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.domain.Criteria;
import com.admin.domain.MMemberVO;
import com.admin.mapper.MMemberMapper;

@Service
public class MMemberServiceImpl implements MMemberService{
	
	@Autowired
	private MMemberMapper memberMapper;
	
	// 회원 리스트
	@Override
	public List<MMemberVO> getList() {
		return memberMapper.getList();
		
	}
	
	// 회원 리스트 페이징처리해서 가져오기 
	@Override
	public List<MMemberVO> getList(Criteria cri) {
		if(cri.getType() != null) {
			if(cri.getType().equals("T")){ 
				 if(cri.getKeyword().equals("씨앗")) {
					 cri.setKeyword("1"); 
				 }else if(cri.getKeyword().equals("새싹")) {
					 cri.setKeyword("2"); 
				 }else if(cri.getKeyword().equals("나무")) {
					 cri.setKeyword("3"); 
				 } 
			 }
		}
		 
		 
		return memberMapper.getListWithPaging(cri);
	}

	//회원리스트 개수 구하기
	@Override
	public int getTotal(Criteria cri) {
		return memberMapper.getTotalCount(cri);
	}

	//글 하나 가져오기
	@Override
	public MMemberVO get(Long mnum, String auth) {
		return memberMapper.read(mnum, auth); 
	}

	// 회원 삭제
	@Override
	public boolean delete(Long mnum) {
		
		return memberMapper.delete(mnum) == 1;
	}
	
	// 회원 수정하기
	@Override
	public boolean modify(MMemberVO member) {
		return memberMapper.update(member) == 1;
	}

	// 회원 관리자권한 부여
	@Override
	public boolean authorize(Long mnum, String auth) {
		return memberMapper.authorize(mnum, auth) == 1;
	}

	@Override
	public int is_authorize(Long mnum, String auth) {
		// TODO Auto-generated method stub
		return memberMapper.authorize(mnum, auth);
	}

	
}
