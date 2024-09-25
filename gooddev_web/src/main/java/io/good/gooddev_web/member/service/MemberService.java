package io.good.gooddev_web.member.service;


import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberService {

    private final MapperUtil mapperUtil;
    private final MemberDAO memberDAO;

    public PageResponseDTO<MemberDTO> getList(PageRequestDTO pageRequestDTO) {
    List<MemberDTO> list = memberDAO.getList(pageRequestDTO).
    stream().map(member -> mapperUtil.map(member, MemberDTO.class)).collect(Collectors.toList());

    return new PageResponseDTO<>(pageRequestDTO, list, memberDAO.getTotalCount(pageRequestDTO));
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

    public MemberDTO getRead_Auto_Login(String auto_Login) {
      MemberVO member = memberDAO.getRead_Auto_Login(auto_Login);
      if(member == null) return null;
      else return mapperUtil.map(member,MemberDTO.class);
    }

    public MemberDTO login(MemberVO inMember,String auto_login_check) {
      MemberVO member = memberDAO.getReadMember_Optional(inMember.getMid()).orElse(null);
      if (member != null && member.getPassword().equals(inMember.getPassword())) {
        if (auto_login_check.equals("on")) {
          String auto_Login = UUID.randomUUID().toString();
          member.setAuto_Login(auto_Login);
          memberDAO.modify_Auto_Login(member);
        } else {
          member.setAuto_Login("");
          memberDAO.modify_Auto_Login(member);
        }
        return mapperUtil.map(member, MemberDTO.class);
      }
		return null;

    }

    public int modify_Auto_Login(MemberVO modify_auto_login) {
        return memberDAO.modify_Auto_Login(modify_auto_login);
    }

}
