package io.good.gooddev_web.member.dao;


import java.util.List;
import java.util.Optional;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;

public interface MemberDAO { 

  public List<MemberVO> getList(PageRequestDTO pageRequestDTO);  //모든 회원정보 조회
  public Optional<MemberVO> getReadMember_Optional(String mid);//회원 상세조회
  public int removeMember(String mid); //회원탈퇴
  public int modifyMember(MemberVO member); //회원정보 수정
  public int registerMember(MemberVO member); //회원가입
  public int getTotalCount(PageRequestDTO pageRequestDTO);
  public MemberVO getRead_Auto_Login(String auto_Login);  //
  public int modify_Auto_Login(MemberVO modify_auto_login); //자동로그인 -set
  public MemberDTO getLogin(MemberDTO inMember);  //로그인
  public Boolean findpwd(String mid, String email); //비밀번호 찾기
  public String findIdByEmail(String email); //아이디찾기(이메일로)
  public MemberDTO getRead_uuid(); 
  public int modify_uuid(MemberVO modify_uuid);
  public Boolean validateUser(String mid, String email);


}
