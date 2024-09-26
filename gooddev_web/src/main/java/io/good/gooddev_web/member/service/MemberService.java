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

    //모든 회원정보 출력
    public PageResponseDTO<MemberDTO> getList(PageRequestDTO pageRequestDTO) {
      List<MemberDTO> list = memberDAO.getList(pageRequestDTO)
          .stream()
          .map(member -> mapperUtil.map(member, MemberDTO.class))
          .collect(Collectors.toList());

      return new PageResponseDTO<>(pageRequestDTO, list, memberDAO.getTotalCount(pageRequestDTO));
    }
    
    public MemberDTO getRead(String mid) {
      MemberVO member = memberDAO.getReadMember_Optional(mid).orElse(null);
      return member != null ? mapperUtil.map(member, MemberDTO.class) : null; 
    }
    //회원 탈퇴
    public int removeMember(String mid) {
      return memberDAO.removeMember(mid);
    }
    // 회원정보 수정
    public int modifyMemberInfo(MemberVO modifyMember) {
      // 먼저 현재 회원 정보를 데이터베이스에서 가져온다.
      MemberVO currentMember = memberDAO.getReadMember_Optional(modifyMember.getMid()).orElse(null);
      
      if (currentMember != null) { //화원정보가 존재하면,
          // 변경할 필드를 체크하고 수정
          if (modifyMember.getPassword() != null) {
              currentMember.setPassword(modifyMember.getPassword());
          }
          if (modifyMember.getMemberName() != null) {
              currentMember.setMemberName(modifyMember.getMemberName());
          }
          if (modifyMember.getNickname() != null) {
              currentMember.setNickname(modifyMember.getNickname());
          }
          if (modifyMember.getPhone() != null) {
              currentMember.setPhone(modifyMember.getPhone());
          }
          if (modifyMember.getEmail() != null) {
              currentMember.setEmail(modifyMember.getEmail());
          }
          // 변경된 정보를 업데이트
          return memberDAO.modifyMember(currentMember); // 데이터베이스에 업데이트
      }
      return 0; // 수정할 회원이 없는 경우 0 반환
    }

    //회원가입
    public int registerMember(final MemberVO Member) {
      return memberDAO.registerMember(Member);
    }
    //아이디찾기
    public String findIdByEmail(String email) {
      return memberDAO.findIdByEmail(email); 
    }
    // 비밀번호 찾기
    public Boolean findPwd(String mid, String email, String newPassword) {
      // 유저 검증
      Boolean isValidUser = memberDAO.validateUser(mid, email); // id, email로 유저가 존재하는지 확인
      if (isValidUser) {
          // 비밀번호 재설정
          MemberVO member = memberDAO.getReadMember_Optional(mid).orElse(null);
          if (member != null) {
              member.setPassword(newPassword); // 새 비밀번호 설정
              memberDAO.modifyMember(member); // 비밀번호 업데이트
              return true; // 비밀번호 찾기 성공
          }
      }
      return false; // 유효하지 않은 사용자
  }

   // 유저 검증
    public Boolean isUserValid(String mid, String email) {
      return memberDAO.validateUser(mid, email);
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
