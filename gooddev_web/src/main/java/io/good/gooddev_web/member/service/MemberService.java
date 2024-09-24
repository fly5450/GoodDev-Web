package io.good.gooddev_web.member.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;

//비즈니스로직 처리
@Service
@RequiredArgsConstructor
public class MemberService {

    
	private final MapperUtil mapperUtil;
	private final MemberDAO memberDAO;

	public PageResponseDTO<MemberDTO> getMemberList(PageRequestDTO pageRequestDTO) {
		List<MemberDTO> list = memberDAO.getList(pageRequestDTO).
                                        stream().map(member -> mapperUtil.map(member, MemberDTO.class)).collect(Collectors.toList());
		
		return new PageResponseDTO<MemberDTO>(pageRequestDTO, list, memberDAO.getTotalCount(pageRequestDTO));
	}
	
	
	public MemberDTO getRead(String mid) {
		MemberVO member = memberDAO.getReadMember_Optional(mid).orElse(null);
		return member != null ? mapperUtil.map(member, MemberDTO.class) : null; 
	}
	
	
	public int removeMember(String uid) {
		return memberDAO.removeMember(uid);
	}
	
	public int modifyMember(final MemberVO memberDTO) {
		return memberDAO.modifyMember(memberDTO);  
	}
	
	
	public int registerMember(final MemberVO memberDTO) {
		return memberDAO.registerMember(memberDTO);
	}

    //로그인 , 로그아웃 -> 민철 구현
}
