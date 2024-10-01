package io.good.gooddev_web.member.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;

@Repository
public interface MemberDAO { 

  List<MemberVO> getList(PageRequestDTO pageRequestDTO);  // 회원 목록 조회
  Optional<MemberVO> getRead(String mid);  // 특정 회원 조회
  Optional<MemberVO> getRead_uuid(String uuid);  
  int remove(String uid);  // 회원 탈퇴
  int modify(MemberVO member);  // 회원 정보 수정
  int register(MemberVO member);  // 회원 가입
  int getTotalCount(PageRequestDTO pageRequestDTO);  // 회원 수 조회
  MemberVO getRead_Auto_Login(String auto_Login);  // 자동 로그인 회원 조회
  int modify_Auto_Login(MemberVO modify_auto_login);  // 자동 로그인 정보 수정
  MemberDTO getLogin(MemberDTO inMember);  // 로그인 처리
  Boolean findPwdById(String mid, String email);  // 비밀번호 찾기
  String findIdByEmail(String email);  // 이메일로 아이디 찾기
  int modify_uuid(MemberVO modify_uuid);  // UUID 수정
  Boolean validateUser(String mid, String email);  // 사용자 유효성 검사
}
