package io.good.gooddev_web.member.dao;


import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;

@Repository
public interface MemberDAO { 

  public List<MemberVO> getList(PageRequestDTO pageRequestDTO);  //모든 회원정보 조회
  public Optional<MemberVO> getReadMember_Optional(String mid);//회원 상세조회
  public int removeMember(String mid); //회원탈퇴
  public int modifyMember(MemberVO member); //회원정보 수정
  public int registerMember(MemberVO member); //회원가입
  public int getTotalCount(PageRequestDTO pageRequestDTO);
  MemberVO getRead_Auto_Login(String auto_Login);
  int modify_Auto_Login(MemberVO modify_auto_login);

}
