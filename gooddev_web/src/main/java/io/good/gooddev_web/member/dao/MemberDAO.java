package io.good.gooddev_web.member.dao;


import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;

@Repository
public interface MemberDAO { 

  public List<MemberVO> getList(PageRequestDTO pageRequestDTO);  
  public Optional<MemberVO> getReadMember_Optional(String uid);
  public Optional<MemberVO> getRead_uuid_Optional(String uuid);
  public int removeMember(String uid); 
  public int modifyMember(MemberVO member); 
  public int registerMember(MemberVO member); 
  public int getTotalCount(PageRequestDTO pageRequestDTO);
  public void modify_Uuid(MemberVO member);
  MemberDTO getRead_uuid();

  MemberDTO getLogin(MemberDTO inMember);

  int modify_uuid(MemberVO modify_uuid);

}
